#!/bin/bash
# miscellenius utils

printWW() { # print shorted string by ${2} param
	end=${#1}
	begin=$(( ${end} - ${2} ))
	[ ${begin} -ge 1 ] && echo "..$(cut -c$(( ${begin} + 2 ))-${end} <<< "$1")" || echo $1
}

function enru() { #Translate Shell package
    trans -e google -from en -to ru "$*"
}

function ruen() {
    trans -e google -from ru -to en "$*"
}

compress()
{
	return
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

calc() { echo "scale=3;$@" | bc -l ; }

s() {
    if ! (($#)); then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}

mkcd() {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}

bu() {
	[[ -d "${budir:=~/.baskup}" ]] || mkdir "$budir"
	cp "$1" "$budir/$(basename "$1")-$(date +%d.%m.%Y-%H:%M).backup"
}

reassembleaur () {
	updpkgsums && makepkg -Csif --noconfirm
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

# Clipboard monipulation
prim2clip() { xclip -o -selection CLIPBOARD | xclip -i ;}
clip2prim() { xclip -o -selection PRIMARY | xclip -i; }
printclip() { xclip -o -selection CLIPBOARD; }
clip2file() { echo "$(xclip -o -selection CLIPBOARD)" >> "$1"; }

# password generation
passgen() { gpg --gen-random -armor ${2:-2} ${1:-14} ; }
