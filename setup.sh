#!/usr/bin/env zsh

#cp -f ./zshrc ~/.zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
source ~/.zshrc

confdir=~/.config
echo -n "Install (super-user needed!)  [s]xhkd, [b]spwm, [p]icom, poly[b]ar, [d]oom-emacs,  [a]ll or [n]one? [s,b,p,b, a/n]: "
install=""
read input
len=${#input}

for ((i=0; i<$len; i++)); do
	#char="${input:i:1}"
	char=$(echo "$input" | cut -c $((i+1)))

	[[ $char == 's' ]] && install+="sxhkd " 
	[[ $char == 'b' ]] && install+="bspwm "
	[[ $char == 'p' ]] && install+="picom "
	[[ $char == 'b' ]] && install+="polybar "
	[[ $char == 'd' ]] && install+="emacs " && install_doom=true
	[[ $char == 'a' ]] && install="sxhkd bspwm picom polybar emacs" && install_doom=true
done

if [[ -n $install ]]; then
	sudo pacman -S $install
fi

if [[ $install_doom == true ]]; then
	git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs 
	~/.config/emacs/bin/doom install
fi

ln -sf ./picom.conf $confdir/ picom.conf
#ln -sf ./bspwm $confdir/
#ln -sf ./sxhkd $confdir/
#ln -sf ./polybar $confdir/
#ln -sf ./tmux.conf ~/.tmux.conf
#ln -sf ./doom.d ~/.doom.d
#ln -sf ./emacs.d ~/.emacs.d

#bspc wm -r
