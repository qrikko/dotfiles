#!/bin/sh

pre="$(tmux show-options -g | grep -E 'prefix\s+' | awk '{print $2}')"
if [ $pre = "C-w" ]; then pre="C-b"; else pre="C-w"; fi
tmux set-option -g prefix $pre
tmux set-option -g status-left "#[fg=bold]{$pre} #{t/f/%%H#:%%M:window_activity} - #[fg=orange,bold,underscore]#{active_window_index}:#{pane_current_command}#[default]   "

