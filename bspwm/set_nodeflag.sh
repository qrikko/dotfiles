#!/bin/sh

winid=$(bspc query -N -n focused.window)
bspc node -g $1

flags=()
if [ $(bspc query -n focused.sticky -N) ]; then
	flags+=(sticky)
fi
if [ $(bspc query -n focused.private -N) ]; then
	flags+=(private)
fi
if [ $(bspc query -n focused.locked -N) ]; then
	flags+=(locked)
fi
if [ $(bspc query -n focused.marked -N) ]; then
	flags+=(marked)
fi
 
flagstr="${flags[*]}"
xdotool set_window --class "$(echo $flagstr)" $winid


if [ $1 = "locked" ]; then
	if [[ $flagstr == *"locked"* ]]; then
		opacity=$((0xffffffff * 98/100))
		xprop -f -id $winid _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $opacity
		chwb -c 0x8064cc $winid
	else 
		xprop -id "$winid" -remove _NET_WM_WINDOW_OPACITY 2>/dev/null
	fi
fi
