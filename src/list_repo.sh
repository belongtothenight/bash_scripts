#!/bin/bash
delay=1 #seconds
cnt=0
while :
do
	clear
	cnt=$((cnt+1))
	echo "Keep listing tree of current directory. (ctrl+c to quit)"
	echo "${cnt}th run!"
	tree -L 3
	sleep $delay
done
