_NORMAL=$(tput setaf 7)
red() { printf "$(tput setaf 1)${*}${_NORMAL}"; }
green() { printf "$(tput setaf 2)${*}${_NORMAL}"; }
blue() { printf "$(tput setaf 4)${*}${_NORMAL}"; }
yellow() { printf "$(tput setaf 3)${*}${_NORMAL}"; }
cyan() { printf "$(tput setaf 6)${*}${_NORMAL}"; }

die()
{
	if [[ -z $1 ]]
	then
		varn "Terminating"
	else
		varn "$@" "Terminating"
	fi

	cleanup
	exit 1
}

error_msg()
{
	for msg in "$@"
	do
		printf "[$(red 'EE')] $msg\n"
		shift
	done
}

varn_msg()
{
	for msg in "$@"
	do
		printf "[$(yellow "VV")] $1\n"
		shift
	done
}

info_msg() { printf "[$(blue "II")] $*\n"; }

success_msg() { printf "[$(green "SS")] $*\n"; }
