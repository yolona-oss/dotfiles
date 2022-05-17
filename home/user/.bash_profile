#!/usr/bin/env bash
#~/.bash_profile

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
