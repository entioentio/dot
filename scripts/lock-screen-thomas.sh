#!/bin/bash

revert() {
	#xset dpms 0 0 0
    cmmk-profile 1

    # resume notification display
    dunstctl set-paused false
}

trap revert SIGHUP SIGINT SIGTERM

cmmk-profile 3
#xset dpms 5 5 5

image_file=/tmp/screen_lock.png
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
filters='noise=alls=10,scale=iw*.03125:-1,scale=iw*32:-1:flags=neighbor' 
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
	  -vf "$filters" "$image_file"

# suspend notification display
dunstctl set-paused true

# clear unlocked gpg keys
#echo RELOADAGENT | gpg-connect-agent

i3lock -ntef -i "$image_file"

revert