#!/usr/bin/env bash
#
# script for installing some non-packaged programs
#

function check_deps() {
    if [[ -n $(which pacman 2>/dev/null) ]] ; then
        depserr=()
        for dep in $@; do
            msg=$(pacman -Q $dep 2>&1 1>/dev/null)
            msg=${msg#*\'}
            msg=${msg%\'*}
            depserr+=($msg)
            unset msg
        done

        if [[ -n ${depserr[@]} ]]; then
            printf "${depserr[*]}"
        fi
    fi

    printf ""
}

function build() {
    # $1 - copy to dir
    # $2.. - files
    function copy_files() {
        to="$1"
        dir="$2"
        shift 2
        for file in "${@}"
        do
            cp "$start_dir/$dir/$file" "$to/"
        done
    }

    case $1 in
        dusk)
            err=$(check_deps "${DEPENDENCES["dusk"]}")
            if [[ -n "$err" ]]; then
                die "Not statisfied dependences: $err"
            fi

            dusk_build_dir="${build_dir}/dusk"
            # cleanup build dir
            if [[ -d "${dusk_build_dir}" ]]
            then
                rm -rf "${dusk_build_dir}"
                mkdir "${dusk_build_dir}"
            else
                mkdir "${dusk_build_dir}"
            fi

            info_msg "Clonning dusk repo..."
            git clone "${URL["dusk"]}" "${dusk_build_dir}"
            cd "${dusk_build_dir}"
            git reset --hard ${HASH["dusk"]}

            info_msg "Copying files"
            copy_files "${dusk_build_dir}" "dusk" "${FILES["dusk"]}"
            # copy_files "${dusk_build_dir}" "dusk" "${dusk_files}"

            info_msg "Installing dusk..."
            cd "${dusk_build_dir}"
            if [[ $UID == 0 ]]
            then
                make install
            else
                sudo make install
            fi
            ;;

        sxiv)
            sxiv_build_dir="${build_dir}/sxiv"
            # cleanup build dir
            if [[ -d "${sxiv_build_dir}" ]]
            then
                rm -rf "${sxiv_build_dir/*}"
            else
                mkdir "${sxiv_build_dir}"
            fi

            info_msg "Clonning sxiv repo..."
            git clone "${URL["sxiv"]}" "${sxiv_build_dir}"
            cd "${sxiv_build_dir}"
            git reset --hard ${HASH["sxiv"]}

            info_msg "Copying files"
            copy_files "${sxiv_build_dir}" "sxiv" "${FILES["sxiv"]}"

            cd ${sxiv_build_dir}
            info_msg "Installing sxiv..."
            if [[ $UID == 0 ]]
            then
                make install
            else
                sudo make install
            fi
            ;;

        st)
            st_build_dir="${build_dir}/st"
            # cleanup build dir
            if [[ -d "${st_build_dir}" ]]
            then
                rm -rf "${st_build_dir/*}"
            else
                mkdir "${st_build_dir}"
            fi

            info_msg "Clonning st repo..."
            git clone "${URL["st"]}" "${st_build_dir}"
            cd "${st_build_dir}"
            git reset --hard ${HASH["st"]}

            cd "${st_build_dir}"
            info_msg "Copying files"
            copy_files "${st_build_dir}" "st" "${FILES["st"]}"

            info_msg "Installing st..."
            if [[ $UID == 0 ]]
            then
                make install
            else
                sudo make install
            fi
            ;;

        slim-theme-dusk)
            ;;

        all)
            for installer in ${INSTALLERS[@]}
            do
                $0 $installer
            done
            ;;

        *)
            error_msg "No such installer: \"$1\""
            ;;
    esac
}

function help() {
    echo "THIS IS HELP!"
}

# utils
source utils.sh

declare -A FILES # files to copy
declare -A INSTALLERS # installer list
declare -A URL # programms download url
declare -A HASH # git commint hashes
declare -A DEPENDENCES # build dependences

start_dir="$(realpath "$(dirname $0)")"
config="$start_dir/config.json"
build_dir="/tmp/dotfiles_build_$(date +%Y%m%d)"
do_installer=''

TEMP=$(getopt -o i: --long installer:,prefix: \
                  -n 'javawrap' -- "$@")

[ $? != 0 ] && die "getopt error"

# Note the quotes around '$TEMP': they are essential!
eval set -- "$TEMP"

while true; do
    case "$1" in
        -i | --installer) do_installer=$2; shift 2 ;;
        --prefix) DEBUGFILE="$2"; shift 2 ;;
        -h | --help )
            help; shift ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

info_msg "Reading config"
# Reading config
for ((i = 0 ; i < $(jq "length" < "$config") ; i++))
do
    INSTALLERS[$i]=$(jq ".[$i].name" < "$config" | sed 's/\"//g')

    printf "  -> Applying \"${INSTALLERS[$i]}\"\n"

    URL["${INSTALLERS[$i]}"]="$(jq -c ".[$i].url" < "$config" | sed 's/\"//g')"
    HASH["${INSTALLERS[$i]}"]="$(jq -c ".[$i].hash" < "$config" | sed 's/\"//g')"
    DEPENDENCES["${INSTALLERS[$i]}"]="$(jq -c ".[$i].dependences" < "$config" | sed 's/[][]//g' | sed 's/\"//g' | sed 's/,/ /g')"
    FILES["${INSTALLERS[$i]}"]="$(jq -c ".[$i].files" < "$config" | sed 's/[][]//g' | sed 's/\"//g' | sed 's/,/ /g')"

    # eval ${INSTALLERS[$i]}_deps=${DEPENDENCES["${INSTALLERS[$i]}"]}
    # eval ${INSTALLERS[$i]}_files=${FILES["${INSTALLERS[$i]}"]}
done

success_msg "Config reading completed"

go=false
for inst in ${INSTALLERS[@]}
do
    if [[ $inst == $do_installer ]]; then
        go=true
        break
    fi
done

echo ${DEPENDENCES[dusk]}

if [[ $go ]]
then
    build $do_installer
else
    die "No such installer \"$do_installer\""
fi
