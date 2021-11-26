#!/bin/sh

for pid in $(pidof -x "status_updater.sh"); do
	if [ $pid != $$ ]; then
		echo "$(date +"%F %T"): status_updater.sh is already running with PID $pid, killing"
		kill $pid
	fi
done

# Add an artificial sleep to wait for the IPC handler to be ready to process requests
sleep 0.2

SETSTATUS="duskc --ignore-reply run_command setstatus"

# $SETSTATUS 7 "$(~/bin/statusbar/statusbutton)" &

secs=0
while true; do
	$SETSTATUS 8 "$(date +%T)"
	# $SETSTATUS 0 "$(~/.local/bin/statusbar/clock)" &
	# $SETSTATUS 2 "$(~/.local/bin/statusbar/mem)" &
	# $SETSTATUS 3 "$(~/.local/bin/statusbar/cpu)" &

	# if [ $((secs % 60)) = 0 ]; then
	# 	$SETSTATUS 5 "$(~/.local/bin/statusbar/mouse_battery)" &
	# 	$SETSTATUS 1 "$(~/.local/bin/statusbar/volume)" &
	# fi

	# if [ $((secs % 3600)) = 0 ]; then
	# 	$SETSTATUS 4 "$(~/.local/bin/statusbar/sysupdates_paru)" &
	# fi

	((secs+=1))
	sleep 1
done
