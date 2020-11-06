# ~/.bashrc
#20:рояль162071

_set_prompt() {
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

extract() {
    local c e i

    (( $# )) || return

    for i; do
        c=''
        e=1
	
        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            #*.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
	    *.tgz|*.tlz|*.txz|*.tb2|*.tbz|*.tbz2|*.taz|*.tar|*.tar.Z|*.tar.bz|*.tar.bz2|*.tar.gz|*.tar.lzma|*.tar.xz)
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        (( e = e || $? ))
    done
    return "$e"
}

todo () {
    [[ -z $LINES ]] && echo "Variable: \"\$LINES\" not specifed, exit" && exit 1
    XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:=$HOME/documents}
    todofile=$XDG_DOCUMENTS_DIR/.notes

    if [[ ! -f "$todofile" ]]; then
        touch "$todofile"
    fi

    if ! (($#)); then
        cat "$todofile"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

note () {
    [[ -z $LINES ]] && echo "Variable: \"\$LINES\" not specifed, exit" && exit 1
    XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:=$HOME/documents}
    notefile=$XDG_DOCUMENTS_DIR/.notes

    if [[ ! -f $notefile ]]; then
        touch "$notefile"
    fi

    if [[ "$1" == "-e" ]]; then
	vim "$notefile"
    elif [[ "$1" == "-d" ]]; then
	temp=$(mktemp)
	sed ${2}d "$notefile" > $temp && mv $temp "$notefile"
    elif ! (($#)); then #If number of lines in $notefile grate than console lines, then pipe to pager
	(( $(< "$notefile" | wc -l) > $LINES )) && nl "$notefile" | ${PAGER:-less} || nl "$notefile"
    else
	printf "%s\n" "$*" >> "$notefile"
    fi
}
 
calc() { echo "scale=3;$@" | bc -l ; }

ipif() { 
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
	 curl ipinfo.io/"$1"
    else
	ipawk=($(host "$1" | awk '/address/ { print $NF }'))
	curl ipinfo.io/${ipawk[1]}
    fi
    echo
}  

s () {
    if ! (($#)); then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

mkcd () {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}

bu () {
	[[ -d "$budir" ]] || mkdir "$budir"
	cp $1 "$budir/"`basename $1`-`date +%Y%m%d%H%M`.backup
}

my_phone_ip() { nmap -sn 192.168.1.0/24 -oG - | awk ' /Honor_8/ {print $2}' ; }

reassembleaur () {
	 makepatch.sh ; updpkgsums && makepkg -Csif --noconfirm
}

dmv() {
	if [[ "$1" == -s ]]; then
		shift
		_DMVDST="$@"
	else
		[[ -z ${_DMVDST} ]] && echo "before declare destanation" && exit
		mv $1 ${_DMVDST}
	fi
}

#BASH interactitity check
[[ $- != *i* ]] && return

#XDG variables declaration
export PAGER=less
export EDITOR=vim
#export BROWSER=$([[ -n $DISPALY ]] && echo "luakit" || echo "w3m")
export BROWSER=luakit
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

##History saving parameters
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:exit"
HISTSIZE=4096

##Installing BASH options
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

##Merging bash-complition scripts
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

##Mergin color variables
test -f $HOME/.colors.sh && source $HOME/.colors.sh

##Mergin aliases
source ~/.bash_aliases

#Setting command prompt
if [[ "$TERM" != "dumb" ]]; then
    _set_prompt
fi

[[ -d "${HOME}/games" ]] && WINEPREFIX="${HOME}/games/.wine"
