#!/bin/sh
#
# $Header: /etc/acpi/default.sh                          Exp $
# $Author: (c) 2012-2014 -tclover <tokiclover@dotfiles.> Exp $
# $License: MIT (or 2-clause/new/simplified BSD)         Exp $
# $Version: 2014/12/24 21:09:26                          Exp $
#
 
log() { logger -p daemon "ACPI: $*"; }
uhd() { log "event unhandled: $*"; }
 
set $*
group=${1%/*}
action=${1#*/}
device=$2
id=$3
value=$4
 
[ -d /dev/snd ] && alsa=true || alsa=false
[ -d /dev/oss ] && oss=true || oss=false
amixer="amixer -q set Master"
ossmix="ossmix -- vmix0-outvol"
 
case $group in
    ac_adapter)
        case "$device" in
            AC*|ACAD|ADP0)
				backlight_name="intel_backlight"
				max_bri=$(cat /sys/class/backlight/${backlight_name}/max_brightness)
                case "$value" in
                    00000000)
						log "switching to power.bat power profile"
						bri=$(( max_bri * 4 / 5 ))
						echo -n ${bri} > "/sys/class/backlight/${backlight_name}/brightness"
                        ;;
                    00000001)
						log "switching to power.adp power profile"
						echo -n ${max_bri} > "/sys/class/backlight/${backlight_name}/brightness"
                        ;;
					*) uhd $*;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
		;;
	battery)
		case $value in
			*0) log "switching to power.adp power profile"
				#	hprofile power.adp
				;;
			*1) log "switching to power.adp power profile"
				#	hprofile power.adp;;
				;;
			*) uhd $*;;
		esac
		;;
	button)
		case $action in
			lid)
				case "$id" in
					close) hibernate-ram;;
					open) :;;
					*) uhd $*;;
				esac
				;;
			power) shutdown -H now;;
			sleep) hibernate-ram;;
			#mute) 
			#	$alsa && $amixer toggle;;
			#volumeup) 
			#	$alsa && $amixer 3dB+
			#	$oss && $ossmix +3;;
			#volumedown) 
			#	$alsa && $amixer 3dB-
			#	$oss && $ossmix -3;;
			*) uhd $*;;
		esac
		;;
	cd)
		case $action in
			play) :;;
			stop) :;;
			prev) :;;
			next) :;;
			*) uhd $*;;
		esac
		;;
	jack)
		case $id in
			*plug) :;;
			*) uhd $*;;
		esac
		;;
	video)
		case $action in
			displayoff) :;;
			*) uhd $*;;
		esac
		;;
	*) uhd $*;;
esac
 
unset alsa oss amixer ossmix group action device id
 
# vim:fenc=utf-8:ft=sh:ci:pi:sts=4:sw=4:ts=4:
