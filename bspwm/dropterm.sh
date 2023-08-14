#!/bin/sh

#id=$(printf "0x%X" "$(xdotool search --name "dropdown")")
#id=`xdo id -a "dropdown"`
#dropterm

echo "arg: $1"

id=
id_d=$(xdotool search --name "$1")
if [ -n "$id_d" ]; then
	id=$(printf "0x%X" "$id_d")
fi

echo "decimal: $id_d"
echo "hex: $id"

if [ -z "$id" ]; then
	if [ "$1" == "dropdown" ]; then
		alacritty -T dropdown -o "window.dimensions.lines=45" -o "window.dimensions.columns=200" &
	elif [ "$1" == "Doom Emacs" ]; then
		emacs -g 234x61+15+30
	else 
		exit
	fi

	while [ -z "$id" ]; do
		id_d=$(xdotool search --name "$1")
		if [ -n "$id_d" ]; then
			id=$(printf "0x%X" "$id_d")
		fi
		[ -z "$id" ] && sleep 0.2
	done

	bspc node $id -t floating -g sticky=on -d focused.local -f 
	#bspc node $id -g hidden=off -g sticky=on -d focused.local -f -t floating
	exit
fi

hidden=$(bspc query -N -n $id.hidden)
echo "dropdown: $hidden"
if [ $hidden >/dev/null ]; then
	bspc node $id -g hidden=off -g sticky=on -d focused.local -f -t floating
else
	bspc node $id -g hidden=on
fi
	
#while getopts "n:" opt; do
#	case $opt in
#		n) 
#			#id=`xdo id -a $OPTARG`
#			id=$(printf "0x%X" "$(xdotool search --name "$OPTARG")")
#			#id=$(xdotool search --name "$OPTARG")
#			dropterm $OPTARG
#			;;
#	esac
#done

