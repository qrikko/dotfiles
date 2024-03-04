#!/bin/zsh

# the way to run it is to send one parameter containing an identifiable
# part of the window name
#
# example:
# sh toggle.sh "Doom Emacs" 

log() {
	echo $1 >> ~/tmp/toggle.loggel.log
}

sessionstr="~~ Using: $XDG_SESSION_TYPE ~~"
rowlen=${#sessionstr}
header_tilde=$(printf "%0.s~" $(seq 1 $rowlen))
log $header_tilde
log $sessionstr
log $header_tilde

if [[ "$1" == "-l" ]]; then
	log "Show log mode active"
	watch -n 2 cat ~/tmp/toggle.loggel.log
	exit
fi

pwd=$(dirname $(readlink -f $0))

app=$(echo "$1" | awk '{print $1}')
args=$(echo "$1" | awk '{$1=""; print $0}')

echo "app: [$app] args: [$args]" > /tmp/toggle.log

win_state=$2
[[ "$2" == "maximized" ]] || [[ -z "$2" ]] && win_state="-b add,maximized_vert,maximized_horz"
[[ "$2" == "fullscreen" ]] && win_state="-b add,fullscreen"

windowid=''
focus_id=$(xdo id)


log ""
log ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
log ">>> Toggle: $app $args"

if [[ -z $(pgrep $app) ]]; then
	$app $args &
	timeout=30.0
	interval=0.2
	app_id=$(xdo id)

	while [ -z "$app_id" ] || [ "$app_id" == "$focus_id" ]; do
		sleep $interval
		app_id=$(xdo id)

		if [[ -n $(xprop -id "$app_id" _NET_WM_WINDOW_TYPE | grep -i 'splash') ]]; then
			app_id=''
		fi

		(( timeout = timeout - interval ))

		if (( timeout <= 0 )); then
			log "$app failed to start"
			exit 1
		fi
	done
	xprop -id $app_id > ~/tmp/dbg.log

	#wmctrl -i -r $app_id -b add,fullscreen
	wmctrl -i -r $app_id $win_state
	
	xprop -id "$app_id" -f APP_TOGGLE_NAME 8s -set APP_TOGGLE_NAME "$app"
	xprop -id "$app_id" -f APP_WIN_ID 32i -set APP_WIN_ID $app_id

	sed -i "/$app/d" $pwd/wid
	echo "$app_id $app" >> $pwd/wid
else
	app_id=$(cat $pwd/wid | grep "$app" | awk '{print $1}')
	focus_id=$(xdo id)

	if [[ "$app_id" == "$focus_id" ]]; then
		log "<<<hide window id: $app_id"
		xdo hide $app_id
		sleep 0.5
	else
		wmctrl -R $app_id 
		log ">>>show window id: $app_id"
		#xdo show $app_id && xdo activate $app_id && wmctrl -i -r $app_id -b add,fullscreen
		xdo show $app_id && xdo activate $app_id && wmctrl -i -r $app_id $win_state
		sleep 0.2
		if [[ -z $(xprop -id "$app_id" _NET_WM_STATE | grep -q '_NET_WM_STATE_FULLSCREEN') ]]; then
			#wmctrl -i -r $app_id -b add,fullscreen
			wmctrl -i -r $app_id $win_state
		fi
		while [[ "$(xdo id)" != "$app_id" ]]; do
			xdo activate $app_id
		done
	fi
fi

	log "------------------------------------------------"
	log "APP_TOGGLE_NAME: [$app]"
	log "APP_WIN_NAME: [$app_id]"
	log "Active Window: [$focus_id]"
	log "------------------------------------------------"

	log " Comparing [app: $app_id] with [focus: $focus_id]"

	log "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
exit
