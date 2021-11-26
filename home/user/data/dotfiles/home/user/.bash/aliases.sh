#!/bin/bash

# ls
# alias ls='ls --color=always --group-directories-first -F'
# alias la='ls -AF'
# alias ll='ls -lF'
# alias lg='ls -gF'
# alias lla='ls -lAF'
# logo-ls
alias ls='logo-ls'
alias la='logo-ls -A'
alias ll='logo-ls -al'
# equivalents with Git Status on by Default
alias lsg='logo-ls -D'
alias lag='logo-ls -AD'
alias llg='logo-ls -alD'

# Moving
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bd='cd -'

# trash-cli
alias rm='rm -i'

# cat
alias ccat='pygmentize -g -O style=colorful,linenos=1'

# Get Class, Title of X windows
alias xprop-ident='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias xprop-ict="xprop | awk '/^WM_CLASS/{sub(/.* =/, \"instance:\"); sub(/,/, \"\nclass:\"); print}/^WM_NAME/{sub(/.* =/, \"title:\"); print}'"

# Calculator
alias bc='bc -ql'
alias cal='cal -m'

# Logging
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias seeer="journalctl -p 3 -xb"

# Network
alias p4='ping 4.2.2.2 -c 4'	# Check Internet connection
alias localip=$(ip addr | grep -w inet | gawk '{if (NR==2) {$0=$2; gsub(/\//," "); print $1;}}')
# alias netcat-reciver='netcat -l -p 7000 | pv | tar x'

# System cond
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias halt="sudo systemctl halt"

# Image viewing 
# sxiv
# x=$(xrandr | grep "\*+" | cut -dx -f1 | sed 's/ //g')
# y=$(xrandr | grep "\*+" | cut -dx -f2 | cut -d' ' -f 1)
# w="$(echo "$x * 0.70" | bc -l | cut -d. -f1)"
# h="$(echo "$y * 0.69" | bc -l | cut -d. -f1)"
# alias sxiv="sxiv -a -g ${w}x${h}+$((x/2 - w/2))+$((y/2 - h/2))" # 2>> /tmp/sxiv_log"
alias sxiv="sxiv -a -g"
# unset x y w h

# Pulsemixer
alias pulsemixer="pulsemixer --color 1 --no-mouse"

# Video viewing
# MPV
# alias mpv="mpv --volume=30 --geometry="70%x69%""

# PacMan
# browser for pkgs
alias pacman-browser="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
# list of pkgs
alias pacman-list="pacman -Qqe"
# list of installed packages and sort them by size
alias pacman-list-by-size='LC_ALL=C pacman -Qi | awk '\''/^Name/{name=$3} /^Installed Size/{print $4$5, name}'\'' | sort -h'
# get size of stdin package. Deps: expac
alias pacman-pkg-size='expac -S -H M '\''%k\t%n'\'''
# list of files owned by a pkg
pacman-pkg-files(){ pacman -Qlq ${1} | grep -v '/$' | xargs -r du -h | sort -h ;}
# list of unused pkgs
alias pacman-unused='LC_ALL=C  pacman -Qtdqi | awk '\''/^Name/{name=$3} /^Installed Size/{print $4$5, name}'\'' | sort -h'
# removing unused pkgs
alias pacman-rm-unused="sudo pacman -Qtdq | sudo pacman -Rns -"
# list of dependenses
pacman-deps(){ LC_ALL=C pacman -Si $* | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u ;}
# get modified conf files
alias pacman-get-mod-conf='pacman -Qii | awk '\''/^MODIFIED/ {print $2}'\'''
# reinstall all pkgs
alias pacman-reinstall-all="sudo pacman -Qqn | sudo pacman -S -"

# Transmission-CLI
alias trm="transmission-remote"

# TaskWarrior
alias taskm="task minimal"

# Brightness
alias bright="xbacklight -set"

# hw
alias sysinfo='sudo dmidecode | grep -A 9 "System Information"'

# git
alias gpob='git push origin $(git branch --show-current)'
