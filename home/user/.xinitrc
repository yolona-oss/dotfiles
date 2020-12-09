#!/bin/sh
xdefaults=$HOME/.Xdefaults
xresources=$HOME/.Xresources


xrdb -load $xresources

exec dwm
