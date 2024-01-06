#!/bin/bash
# This script will be run with systemd service
# This process can be monitored with "${HOME}/Documents/list_dir.sh"
# Ref: https://unix.stackexchange.com/questions/26728/prepending-a-timestamp-to-each-line-of-output-from-a-command
# Req: moreutils
script_date="2023/12/30-01:11"

# Settings
base_dir="${HOME}/Documents"
repo_dir="${base_dir}/GitHub"
log_file="${base_dir}/update_task.log"
log_format="%Y/%m/%d-%H:%M:%S"
msg_preappend=">>>"
pkg_manager="nala" # default: apt-get

# Tasks (1=Active)
# --> show param
t0=1
# --> update sys
t1=0
# --> clone repo
t2=1
# --> update repo
t3=1
# --> tree repo
t4=1
# --> size repo
t5=1
# --> size disk
t6=1
# --> size log
t7=1
# --> uptime
t8=1

active=1

# pipe message
function pmsg () {
	echo -e "[$(date +${log_format})] ${msg_preappend} $1" &>> $log_file
}

# pipe message without preappending
function pmsgwp () {
	echo -e "[$(date +${log_format})] $1" &>> $log_file
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
	$1 2>&1 | ts "[$log_format]" | tee -a $log_file > /dev/null
}

echo -e "\r" &>> $log_file
pmsg "update_task.sh started!"

# Task 0 => Parameters
if [ $t0 -eq $active ]; then
	pmsg "Task 0: List out parameters!"
	pmsgwp "Script coded on $script_date"
	pmsgwp "Settings ==="
	pmsgwp "base_dir:       $base_dir"
	pmsgwp "repo_dir:       $repo_dir"
	pmsgwp "log_file:       $log_file"
	pmsgwp "log_format:     $log_format"
	pmsgwp "msg_preappend:  $msg_preappend"
	pmsgwp "pkg_manager:    $pkg_manager"
	pmsgwp "Tasks ======"
	if [ $t0 -eq $active ]; then
		pmsgwp "Task 0: Activated"
	else
		pmsgwp "Task 0: Deactivated"
	fi
	if [ $t1 -eq $active ]; then
		pmsgwp "Task 1: Activated"
	else
		pmsgwp "Task 1: Deactivated"
	fi
	if [ $t2 -eq $active ]; then
		pmsgwp "Task 2: Activated"
	else
		pmsgwp "Task 2: Deactivated"
	fi
	if [ $t3 -eq $active ]; then
		pmsgwp "Task 3: Activated"
	else
		pmsgwp "Task 3: Deactivated"
	fi
	if [ $t4 -eq $active ]; then
		pmsgwp "Task 4: Activated"
	else
		pmsgwp "Task 4: Deactivated"
	fi
	if [ $t5 -eq $active ]; then
		pmsgwp "Task 5: Activated"
	else
		pmsgwp "Task 5: Deactivated"
	fi
	if [ $t6 -eq $active ]; then
		pmsgwp "Task 6: Activated"
	else
		pmsgwp "Task 6: Deactivated"
	fi
	if [ $t7 -eq $active ]; then
		pmsgwp "Task 7: Activated"
	else
		pmsgwp "Task 7: Deactivated"
	fi
	if [ $t8 -eq $active ]; then
		pmsgwp "Task 8: Activated"
	else
		pmsgwp "Task 8: Deactivated"
	fi
fi

# Task 1 => Update System
if [ $t1 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 1: Update system"
	pmsg "Updating system"
	epapo "${pkg_manager} update"
	pmsg "Upgrading system"
	epapo "${pkg_manager} upgrade -y"
fi

# Task 2 => Clone all repos
if [ $t2 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 2: Clone all repos"
	pmsg "Cloning all repos with clone_all_repo.sh"
	esapo "${repo_dir}/clone_all_repo.sh"
fi

# Task 3 => Update all repos
if [ $t3 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 3: Update all repos"
	pmsg "Updating all repos with update_all_repo.sh"
	esapo "${repo_dir}/update_all_repo.sh"
fi

# Task 4 => Print out repo tree
if [ $t4 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 4: Print out repo tree, directory only"
	pmsg "Printing local repo tree at ${repo_dir}"
	epapo "tree ${repo_dir} -L 2 -d"
fi

# Task 5 => Get total repo size
if [ $t5 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 5: Get total repo size"
	pmsg "Getting total repo size locally at ${repo_dir}"
	epapo "du ${repo_dir} -h -s"
fi

# Task 6 => Get system available disk size
if [ $t6 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 6: Get available system disk size"
	pmsg "Getting system disk usage"
	epapo "df -h -x tmpfs"
fi

# Task 7 => Get log size
if [ $t7 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 7: Get log file size"
	pmsg "Getting log file size at $log_file"
	epapo "du $log_file -h"
fi

# Task 8 => Get uptime
if [ $t8 -eq $active ]; then
	pmsgwp ""
	pmsg "Task 8: Get uptime"
	pmsg "Getting uptime"
	epapo "uptime"
fi

pmsg "update_task.sh ended!"
