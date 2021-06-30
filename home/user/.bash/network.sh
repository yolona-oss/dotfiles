#!/bin/bash
# network utils

getLocalIP() { nmap -sn 192.168.1.0/24 -oG - | awk -v name="${1}" ' /name/ {print $2}' ; }

ipif() { 
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
		curl ipinfo.io/"$1"
    else
		ipawk=($(host "$1" | awk '/address/ { print $NF }'))
		curl ipinfo.io/${ipawk[1]}
    fi
    echo
}

netcat-send()
{
	tar cf - $1 | pv | netcat 192.168.1.${2} ${3}
}

netcat-reciver()
{
	echo "netcat revicer started"
	netcat -l -p ${1} | pv | tar x
}
