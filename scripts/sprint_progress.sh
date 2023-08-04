#!/bin/bash

start_date="2023-05-16"
end_date=$(date +%F)  # Fetches the current date in YYYY-MM-DD format
sprint_duration=10

#icon_filled="󰨓"
#icon_empty="󰆢"
# 󱋯
output='';

#squares
icon_filled="󰝤"
icon_filled="-"
icon_empty="󰝣"
icon_empty="-"
icon_current="󱔀"
icon_current="+"
spacer=" "
spacer=""

#eggs
# icon_filled="󰪯"
# icon_empty="󱏲"
# icon_current="󱡊"
# spacer=" "


# Convert start and end dates to Unix timestamps
start_timestamp=$(date -d "$start_date" +%s)
end_timestamp=$(date -d "$end_date" +%s)

# Count the number of business days
business_days=0
current_timestamp=$start_timestamp

while [ $current_timestamp -le $end_timestamp ]
do
    # Get the day of the week (1-7, where 1 represents Monday)
    day_of_week=$(date -d @"$current_timestamp" +%u)

    # Check if the current day is a business day (Monday to Friday)
    if [ $day_of_week -le 5 ]; then
        business_days=$(expr $business_days + 1)
    fi

    # Move to the next day
    current_timestamp=$((current_timestamp + 86400))
done

sprint_day=$((((business_days - 1) % sprint_duration) + 1))

for i in $(seq 1 $sprint_duration)
do
	if [ $i -lt $sprint_day ];
	then
  		output+=$icon_filled
	elif [ $i -eq $sprint_day ];
	then
		output+=$icon_current
	else
		output+=$icon_empty
	fi

	if [ $i -lt $sprint_duration ];
	then
	output+=$spacer
		fi
done

echo $output