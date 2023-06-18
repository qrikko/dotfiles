#!/bin/sh
dotdir=~/.dotfiles/dotfiles
confdir=~/.config

ln -s "${dotdir}/picom.conf" $confdir/

bspc wm -r
