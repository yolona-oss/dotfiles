#!/bin/sh
xdefaults=$HOME/.Xdefaults
xresources=$HOME/.Xresources

xrdb -load $xresources

unset xdefaults
unset xresources

#exec dbus-launch --exit-with-session i3 --force-xinerama
exec dbus-launch --exit-with-session dusk
