#!/bin/sh
dotdir=~/.dotfiles/dotfiles
confdir=~/.config

ln -sf "${dotdir}/picom.conf" $confdir/ 
ln -sf "${dotdir}/bspwm" $confdir/
ln -sf "${dotdir}/sxhkd" $confdir/
ln -sf "${dotdir}/polybar" $confdir/

bspc wm -r
