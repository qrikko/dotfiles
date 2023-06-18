#!/bin/sh

dbus_name=$(dbus-send --session --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep -oP 'org\.mpris\.MediaPlayer2\.brave\.instance\d+')

dbus_cmd() {
	local dbus_object="/org/mpris/MediaPlayer2"
	local dbus_interface="org.mpris.MediaPlayer2.Player"

	echo "dbus-send --session --dest=$dbus_name --type=method_call --print-reply $dbus_object $dbus_interface.$1"

}

options=$(getopt -o pb:f: --long help -- "$@")
eval set -- "$options"

while true; do
	case "$1" in
		-p)
			dbus_cmd "PlayPause"
			shift
			;;
		-b)
			shift
			dbus_cmd "Seek int64:-$1"
			shift 
			;;
		-f)
			shift
			dbus_cmd "Seek int64:$10000000"
			shift
			;;
		--)
			shift
			break
			;;
		*)
			shift
			;;
	esac
done
