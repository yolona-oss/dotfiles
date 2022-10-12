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
        source "$HOME"/.bash/bash-wakatime/bash-wakatime.sh

        for script in "$HOME"/.bash/*.sh
        do
                source "${script}"
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
shopt -s checkwinsize   	# check terminal size on each command exec
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
        printf ""
elif [[ $TERM == linux ]]; then
        printf ""
elif [[ ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        printf ""
        # set_prompt
fi


# BEGIN_KITTY_SHELL_INTEGRATION
# if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# If not running interactively, don't do anything
case $- in
        *i*) ;;
        *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/xewii/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='oh-my-posh'
POSH_THEME="~/.poshthemes/clean-detailed.omp.json"

# Some themes can show whether `sudo` has a current token or not.
# Set `$THEME_CHECK_SUDO` to `true` to check every prompt:
THEME_CHECK_SUDO='true'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to the location of your work or project folders
#BASH_IT_PROJECT_PATHS="${HOME}/Projects:/Volumes/work/src"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
