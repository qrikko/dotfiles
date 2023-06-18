#!/bin/sh
dotdir=~/.dotfiles/dotfiles
confdir=~/.config

ln -s "${dotdir}/picom.conf" $confdir/
ln -s "${dotdir}/bspwm" $confdir/

bspc wm -r
