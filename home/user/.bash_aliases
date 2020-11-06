#!/bin/bash
# Displaying the content of the directories
alias ls='ls --color=always -FU'
alias la='ls -AF'
alias ll='ls -lF'
alias lla='ls -lAF'

# Moving
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bd='cd -'

# Get Class, Title of X windows
alias xprop-ident='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias xprop-ict="xprop | awk '/^WM_CLASS/{sub(/.* =/, \"instance:\"); sub(/,/, \"\nclass:\"); print}/^WM_NAME/{sub(/.* =/, \"title:\"); print}'"


alias bc='bc -ql'
alias cal='cal -m'
alias paclist="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias seeer="journalctl -p 3 -xb"

# Network
alias p4='ping 4.2.2.2 -c 4'	# Check Internet connection
alias localip=$(ip addr | grep -w inet | gawk '{if (NR==2) {$0=$2; gsub(/\//," "); print $1;}}')

# Language translation
# alias enru="crow -e google -s en -t ru"
# alias ruen="crow -e google -s ru -t en"
alias enru="trans -e google -from en -to ru"
alias ruen="trans -e google -from ru -to en"


alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias halt="sudo systemctl halt"

#opts="$(awk '/Exec/ {FS="=*#"; $1=""; print}' ~/.local/share/applications/sxiv.desktop | sed 's/%F//')"
#alias sxiv="sxiv ${opts:--a}"
#unset opts
alias sxiv="sxiv -a -g 1000x560+460+260" # 2>> /tmp/sxiv_log"
alias pulsemixer="pulsemixer --color 1 --no-mouse"
alias mpv="mpv --volume=30 --geometry="70%x69%""

# Clipboard monipulation
alias prim2clip="xclip -o -selection CLIPBOARD | xclip -i"
alias clip2prim="xclip -o -selection PRIMARY | xclip -i"
alias printclip="xclip -o -selection CLIPBOARD"

# pacman
# get installed packages and sort them by size
alias pacman-QWS="LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h"
