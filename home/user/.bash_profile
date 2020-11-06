#~/.bash_profile

if [[ ! ${DISPLAY} && ${XDG_VTNR} == 7 ]] ; then
    exec startx &> /dev/null
fi

test -f ~/.bashrc && . ~/.bashrc

if test -d ~/profile.d; then
        for profile in ~/profile.d/*.sh; do
                test -r "$profile" && . "$profile"
        done
        unset profile
fi
