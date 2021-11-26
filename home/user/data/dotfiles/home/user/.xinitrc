#!/bin/sh
xdefaults=$HOME/.Xdefaults
xresources=$HOME/.Xresources

xrdb -load $xresources

# exec dwm
# dbus-launch --exit-with-session dusk
dbus-launch dusk
