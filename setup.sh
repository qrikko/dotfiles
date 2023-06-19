#!/bin/sh
dotdir=$PWD
confdir=~/.config

ln -sf "${dotdir}/picom.conf" $confdir/ 
ln -sf "${dotdir}/bspwm" $confdir/
ln -sf "${dotdir}/sxhkd" $confdir/
ln -sf "${dotdir}/polybar" $confdir/
ln -sf "${dotdir}/tmux.conf" ~/.tmux.conf
ln -sf "${dotdir}/doom.d" ~/.doom.d
ln -sf "${dotdir}/emacs.d" ~/.emacs.d

bspc wm -r
