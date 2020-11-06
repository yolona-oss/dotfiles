#!/bin/sh
xdefaults=$HOME/.Xdefaults
xresources=$HOME/.Xresources

source $HOME/.config/environment

xrdb -load $xresources

exec dwm
