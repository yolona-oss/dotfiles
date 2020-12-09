#~/.bash_profile

if [[ -z ${DISPLAY} && ${XDG_VTNR} == 7 ]] ; then
    exec startx &> /dev/null
fi

if test -d ~/.profile.d; then
        for profile in ~/.profile.d/*.sh; do
                . "$profile"
        done
        unset profile
fi
