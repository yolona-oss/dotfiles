#!/usr/bin/env bash
# ~/.bashrc

# BASH interactitity check
[[ $- != *i* ]] && return

# Sourcing enviroment variables
source "$HOME"/.config/environment

# WINEPREFIX path
[[ -d "${HOME}"/games ]] && export WINEPREFIX="${HOME}/games/.wine"

# Appendig PATH
[[ ! "$PATH" =~ "$HOME"/.local/bin ]] && export PATH+=":$HOME/.local/bin"

# Merging another startup scripts
if [[ -d "$HOME"/.bash ]]
then
	for scrpt in "$HOME"/.bash/*.sh
	do
		source $scrpt
	done
	unset scrpt
fi

# XDG variables declaration
export PAGER=less
export EDITOR=vim
export BROWSER=$([[ -n $DISPALY ]] && echo "luakit" || echo "w3m")
# PAGER options
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

# History saving parameters
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit"
HISTSIZE=2069

# Installing BASH options
#shopt -s autocd
shopt -s checkwinsize
shopt -s histappend
shopt -s extglob
shopt -s dotglob
#shopt -s nullglob
shopt -s cdspell
shopt -s no_empty_cmd_completion
bind "set bell-style none"
export IGNOREEOF="2"

# Merging bash-complition scripts
if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	elif [[ -f ~/.bash_completion ]]; then
		source ~/.bash_completion
	fi
fi

# Setting command prompt
if [[ "$TERM" != "dumb" ]]; then
    set_prompt
fi
