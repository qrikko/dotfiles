#!/bin/sh

cleanup() {
	kill $(pgrep xinput)
	exit
}

keysym() {
	return $(printf '%03o' '$1')
}

evdev_event() {
	for device in /dev/input/event*; do
		capabilities=$(sudo evtest --query "$device" | grep "Name:.*keyboard")
		if [[ -n $capabilities ]]; then
			keyboard_device="$device"
			break
		fi
	done
}

#keyboard_device=$(evdev_event)
#echo "use: $keyboard_device"
#exit

trap cleanup SIGINT

#keyfile="$(dirname $(readlink -f "$0"))/keyfile"
#if [ ! -e "$keyfile" ]; then
#	touch $keyfile
#fi


#xinput_keys=/tmp/xinputkeys
#deviceid=$(xinput --list --long | grep XIKeyClass | head -n 1 | grep -E -o '[0-9]+')
#xinput test $deviceid > $xinput_keys&

keyfile=/tmp/keys
while true; do
	inotifywait -q -e modify "$keyfile" > /dev/null
		read -r key < "$keyfile"
#		action="${string%%[0-9]*}"
#		keycode="${string#*[!0-9]}"
		echo $key
		
		echo -n > $keyfile
	: > $keyfile
done
