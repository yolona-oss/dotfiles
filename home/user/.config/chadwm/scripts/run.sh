#!/bin/sh

xrdb merge ~/.Xresources 
# xbacklight -set 10 &
/home/xewii/.fehbg &
xset r rate 400 30 &
picom --config ~/.config/picom.conf &
qutebrowser &
telegram-desktop &
dunst &
st -c IDE -e nvim &
notmon &
xbanish &
autocutsel &
autocutsel -selection PRIMARY &
clipmenud &

~/.config/chadwm/scripts/./bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
