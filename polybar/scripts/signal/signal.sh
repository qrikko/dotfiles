#!/bin/sh

#while read -r pid; do
	#kill "$pid"
#done < <(pgrep "signal-cli")

mypid=$$
script_name=$(basename "$0")
while read -r pid; do
	if [ "$pid" != "$mypid" ]; then
		kill "$pid"
	fi
done < <(pgrep "$script_name")

#echo "%{F#ff0000}●"
new_msg_cnt=0
msg_file=~/.config/polybar/scripts/signal/msg_file.json

if [ ! -e "$msg_file" ]; then
	touch $msg_file
fi

stdbuf -oL signal-cli -u +46706859666 -o json daemon > >(cat > "$msg_file") 2>&1 &

while true; do
	inotifywait -q -e modify "$msg_file" > /dev/null
	read -r msg < "$msg_file"
	((new_msg_cnt++))
	echo $new_msg_cnt
	: > $msg_file
done

#sleep 5

#function handle_message() {
#	#local msg=$(cat "$1")
#	new_msg_cnt=new_msg_cnt+1;
#	echo -n "%{F#ff0000}●1"
#	#echo "%{F#ff0000}●Signal%{F-}"
#}

