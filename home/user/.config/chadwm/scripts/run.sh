#!/bin/bash

# "xbacklight -set 10 &"
# "picom --config ~/.config/picom.conf"
APPS=(
        "xrdb merge ~/.Xresources"
        "/home/xewii/.fehbg"
        "xset r rate 400 30"
        "picom"
        "qutebrowser"
        "telegram-desktop"
        "dunst"
        "st -c IDE -e nvim"
        "notmon"
        "xbanish"
        "autocutsel"
        "autocutsel -selection PRIMARY"
        "clipmenud"
        "slstatus"
)

for (( i=0; i < ${#APPS[@]}; i++ )); do
        ${APPS[$i]} &
done

while type dwm >/dev/null; do dwm && continue || break; done
