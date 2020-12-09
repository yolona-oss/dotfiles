#!/bin/bash

set_prompt() {
	_hacker_prompt
}

_hacker_prompt(){
    local HISTORYC='\e[1;38;5;214m'
    local SEPARATORC='\e[0;38;5;31m'
    local TIMEC='\e[0;38;5;75m'
    local DATEC='\e[1;38;5;111m'
    local USERC='\e[1;38;5;196m'
    local TTYC='\e[0;38;5;51m'
    local BASHSC='\e[1;38;5;40m'

    case `hostname` in
	nba)
	    local HOSTC="$USERC"
	    ;;
	*) local HOSTC=$White
	    ;;
    esac    
    
    export PS1='\n\e[1;30m[\j:\!\e[1;30m] [\e[1;34m\u@\H\e[1;30m:\e[0;37m`tty 2>/dev/null` \e[0;32m+${SHLVL}\e[1;30m] \e[1;37m \w \e[0;37m \n\$ '
}


_classy_prompt(){
	CNormal="\[$(tput sgr0)\]"
	CBold="\[$(tput bold)\]"
	Bracket="\[$(tput setaf 1)\]"

	if [ -n "$SSH_CONNECTION" ]; then
		export PS1="\[$(tput setaf 1)\]┌─╼ [$(tput setaf 7)\] \u \[$(tput setaf 1)\]╺─╸\[$(tput setaf 7)\] \H \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼ \[$(tput setaf 7)\][ssh]\"; else echo \"\[$(tput setaf 1)\]└╼ \[$(tput setaf 7)\][ssh]\"; fi) \[$(tput setaf 7)\]"
	else
		export PS1="\[$(tput setaf 10)\]┌─╼\[$(tput setaf 4)\]${CBold} \u ${CNormal}\[$(tput setaf 10)\]╺─╸\[$(tput setaf 12)\] \H \[$(tput setaf 7)\][\[$(tput setaf 7)\]\[$(tput bold)\]\w\[$(tput sgr0)\]\[$(tput setaf 7)\]]\n\[$(tput setaf 7)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 10)\]└────╼\"; else echo \"\[$(tput setaf 10)\]└╼\"; fi) \[$(tput setaf 7)\]"
	fi
}

classyTouch_prmpt(){
	# Colored prompt
	force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
			color_prompt=yes
		else
			color_prompt=
		fi
	fi

	# Prompt
	if [ -n "$SSH_CONNECTION" ]; then
		export PS1="\[$(tput setaf 1)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼ \[$(tput setaf 7)\][ssh]\"; else echo \"\[$(tput setaf 1)\]└╼ \[$(tput setaf 7)\][ssh]\"; fi) \[$(tput setaf 7)\]"
	else
		export PS1="\[$(tput setaf 1)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼\"; else echo \"\[$(tput setaf 1)\]└╼\"; fi) \[$(tput setaf 7)\]"
	fi
}
