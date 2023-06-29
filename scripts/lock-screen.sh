#!/bin/sh
photos_dir="$HOME/wallpaper"
lockscreen_images=""

# Get the resolutions of all connected screens
resolutions=$(xrandr | awk '/\*/ {print $1}')

# Check the number of screens
num_screens=$(echo "$resolutions" | wc -l)

# Generate a unique identifier based on picked image name, resolutions, and number of screens
picked_random_photo=$(ls "$photos_dir" | shuf -n 1)
identifier=$picked_random_photo;
echo $picked_random_photo;
for resolution in $resolutions; do
  identifier="${identifier}_${resolution}"
done

filename=$(echo -n "$identifier" | md5sum | awk '{print $1}')
echo $identifier;
echo $filename;

lockscreen_image="/tmp/lockscreen_${filename}.png"
echo $lockscreen_image;

# Check if the image exists
if [ ! -f "$lockscreen_image" ]; then
  # Combine lock screen images side by side
  for resolution in $resolutions; do
    convert "$photos_dir/$picked_random_photo" -resize "$resolution^" -gravity center -extent "$resolution" "/tmp/lockscreen_${picked_random_photo}_${resolution}.png"
    temp_single_image="/tmp/lockscreen_${picked_random_photo}_${resolution}.png"
	lockscreen_images="$lockscreen_images $temp_single_image"
  done
  convert $lockscreen_images +append "$lockscreen_image"

  rm $temp_single_image;
fi

# Start i3lock with the combined lock screen image
i3lock -d -n -i "$lockscreen_image"