#!/usr/bin/env bash
#~/.bash_profile

if [[ -z ${DISPLAY} ]] && [[ ${XDG_VTNR} == 7 ]]; then
    exec startx 2> ~/.local/share/xorg/strtx.log
fi

bashrc="$HOME/.bashrc"
profiled="$HOME/.profile.d"

if [[ -s "$bashrc" ]]; then
	source "$bashrc"
fi

if [[ -d "$profiled" ]]; then
        for profile in "$profiled"/*.sh; do
                source "$profile"
        done
fi

unset bashrc profiled profile
