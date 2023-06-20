# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

export PATH=$PATH:~/bin:~/.emacs.d/bin:

alias ll='ls -l'
alias lla='ls -la'
alias l='ls'
alias la='ls -a'

ans=0
ans_handler() {
	local cmd_regex="^[0-9+*/()-:]+$"
	local buffer=$(echo "$BUFFER" | tr -d '[:space:]')

	if [[ ${#buffer} -eq 1 && $buffer == ":" ]]; then
		BUFFER=": ${anscmd} = ${ans}"
		zle reset-prompt
		zle send-break 
	elif [[ $buffer =~ "^[0-9+*/()-:]+$" ]]; then
		local command=$buffer
		if [[ $buffer = [:]* ]]; then
			command=${ans}${buffer#?}
		else
			print -s "$command"
		fi

		local result=$(echo $(($command)))
		BUFFER="$command = $result"

		anscmd=$command
		ans=$result

		zle reset-prompt
		zle send-break 
	else 
		zle accept-line
	fi
}

zle -N ans_handler
bindkey '^M' ans_handler
