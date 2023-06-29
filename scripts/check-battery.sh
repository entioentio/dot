#!/bin/bash
showAtPercent=15

battery_status=$(acpi -b)

# Check if the battery is charging
if echo "$battery_status" | grep -qi "discharging"; then
    is_charging=false
else
    is_charging=true
	exit 0
fi

battery_level=$(acpi -b | awk 'NR==1{print $4}' | sed 's/%,//' | sed 's/%//')
if [[ $battery_level -le $showAtPercent ]]; then
    killall i3-nagbar >/dev/null 2>&1
    i3-nagbar -m "Battery is low! ($battery_level%) Please plug in your charger." -t warning >/dev/null 2>&1 &
fi