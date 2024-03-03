#!/bin/sh
WINDOW_CLASS="xdg-desktop-portal-gnome"
INTERVAL=0.1
sleep 1

xdotool keydown ctrl
xdotool keydown s
xdotool keyup ctrl
xdotool keyup s

sleep 0.2 
while true; do
	WINDOW_ID=$(xdotool search --onlyvisible --class "$WINDOW_CLASS" windowactivate | head -1)

	if [ -n "$WINDOW_ID" ]; then
		xdotool windowactivate "$WINDOW_ID"
		exit
	fi

	sleep $INTERVAL
done
