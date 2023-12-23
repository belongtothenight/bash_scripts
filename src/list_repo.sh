#!/bin/bash
delay=1 #seconds
tree_level=3

cnt=0
while :
do
	clear
	cnt=$((cnt+1))
	echo "Keep listing tree of current directory. (ctrl+c to quit)"
	echo "${cnt}th run!"
	tree -L $tree_level
	sleep $delay
done
