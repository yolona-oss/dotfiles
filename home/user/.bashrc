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
	# Waka
	# source "$HOME"/.bash/bash-wakatime/bash-wakatime.sh

	for scrpt in "$HOME"/.bash/*.sh
	do
		source $scrpt
	done
	unset scrpt
fi

# XDG variables declaration
export PAGER=less
export EDITOR=vim
# PAGER options
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

# History saving parameters
HISTCONTROL=ignoreboth		# ignore same entries
export HISTIGNORE="&:ls:[bf]g:exit"
HISTSIZE=10000

# Installing BASH options
shopt -s extglob		# extra globing
shopt -s globstar		# "*" globing
shopt -s autocd			# change dirs without cd
shopt -s direxpand		# expanding var values in path
shopt -s histverify		# showing last command before execute it
shopt -s checkwinsize	# check terminal size on each command exec
shopt -s histappend		# history appending, not overwriting
shopt -s dotglob		# globing dot files
shopt -s expand_aliases
#shopt -s nullglob		#
shopt -s cdspell		# auto fix incorect dir names
shopt -s no_empty_cmd_completion #
shopt -s checkjobs		# dont exit if other proceses executing
bind "set bell-style none"
export IGNOREEOF="2"	#

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
if [[ $TERM == dumb ]]; then
    echo
    # dummy
elif [[ $TERM == linux ]]; then
    echo
    # TODO
elif [[ ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    set_prompt
fi


# BEGIN_KITTY_SHELL_INTEGRATION
# if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
