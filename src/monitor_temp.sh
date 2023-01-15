#!/bin/bash

# src1: https://linuxhint.com/raspberry_pi_temperature_monitor/
# src2: https://www.cyberciti.biz/faq/linux-find-out-raspberry-pi-gpu-and-arm-cpu-temperature-command/

#single liner
#temp=$(vcgencmd measure_temp | egrep -o '[0-9]\.[0-9]*')
#echo "The temperature is $temp degrees celsius."

#continuous monitoring
printf "%-15s%5s\n" "TIMESTAMP" "TEMP(degC)"
printf "%20s\n" "--------------------------"

while true
do
	temp=$(vcgencmd measure_temp | egrep -o '[[:digit:]].*')
	timestamp=$(date +'%s')
	printf "%-15s%5s\n" "$timestamp" "$temp"
	sleep 1
done

