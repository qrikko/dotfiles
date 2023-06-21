#!/usr/bin/env zsh

#cp -f ./zshrc ~/.zshrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
source ~/.zshrc

sudo pacman -S sxhkd bspwm picom polybar

confdir=~/.config

#cp -rf ./picom.conf $confdir/ 
#cp -rf  ./bspwm $confdir/
#cp -rf  ./sxhkd $confdir/
#cp -rf  ./polybar $confdir/
#cp -rf  ./doom.d ~/.doom.d
#cp -rf  ./emacs.d ~/.emacs.d
#cp -f  ./tmux.conf ~/.tmux.conf

ln -sf ./picom.conf $confdir/ picom.conf
#ln -sf ./bspwm $confdir/
#ln -sf ./sxhkd $confdir/
#ln -sf ./polybar $confdir/
#ln -sf ./tmux.conf ~/.tmux.conf
#ln -sf ./doom.d ~/.doom.d
#ln -sf ./emacs.d ~/.emacs.d

#bspc wm -r
