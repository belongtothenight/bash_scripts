#!/bin/bash
# This script will be run with systemd service
# This process can be monitored with "${HOME}/Documents/list_dir.sh"
# Ref: https://unix.stackexchange.com/questions/26728/prepending-a-timestamp-to-each-line-of-output-from-a-command
# Req: moreutils
log_file="${HOME}/Documents/update_task.log"
log_format="%Y/%m/%d-%H:%M:%S"
msg_preappend=">>>"
pkg_manager="nala" # default: apt-get
pw_file="${HOME}/Documents/pw.txt"

# pipe message
function pmsg () {
	echo -e "[$(date +${log_format})] ${msg_preappend} $1" &>> $log_file
}

# execute program and pipe output
function epapo () {
	# Method 1: don't use with commmand that taks a long time to execute
	#$1 | awk -v log_format=${log_format} '{print strftime("["log_format"]"), $0}' &>> $log_file
	# Method 2: sudo apt-get install moreutils
	$1 2>&1 | ts "[$log_format]" 2>&1 &>> $log_file
}

# execute shell and pipe output
function esapo () {
	$1 2>&1 | ts "[$log_format]" | tee -a $log_file
}

echo -e "\r" &>> $log_file
pmsg "update_task.sh started!"

# Task 1 => Update System
#pmsg "Updating system"
#epapo "${pkg_manager} update"
#pmsg "Upgrading system"
#epapo "${pkg_manager} upgrade -y"

# Task 2 => Clone all repos
pmsg "Cloning all repos with clone_all_repo.sh"
esapo "${HOME}/Documents/GitHub/clone_all_repo.sh"

# Task 3 => Update all repos
pmsg "Updating all repos with update_all_repo.sh"
esapo "${HOME}/Documents/GitHub/update_all_repo.sh"

pmsg "update_task.sh ended!"
