#!/bin/bash

# app list
declare -a app=(
	"vim"\
	"htop"\
	"git"
)
declare -a python_app=(\
	"numpy"\
	"pandas"\
	"matplotlib"\
	"seaborn"\
	# "scikit-learn"\
	"keras"\
	"tensorflow"\
	"torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117"\
	#"opencv-python"\
	"wandb"\
)

# colors
#src: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
dark_gray='\033[1;30m'
light_red='\033[1;31m'
light_green='\033[1;32m'
light_yellow='\033[1;33m'
light_blue='\033[1;34m'
light_purple='\033[1;35m'
light_cyan='\033[1;36m'
light_white='\033[1;37m'
NC='\033[0m' # No Color

# background colors
#src: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
bg_black='\e[40m'
bg_red='\e[41m'
bg_green='\e[42m'
bg_yellow='\e[43m'
bg_blue='\e[44m'
bg_purple='\e[45m'
bg_cyan='\e[46m'
bg_white='\e[47m'
bg_NC='\e[0m'

# screen size
columns=$(tput cols)
lines=$(tput lines)

# find array index
# index=0
# function find_arr_index () {
# 	#$1: array element
# 	#$n: array
# 	local element=$1
# 	shift
# 	local arr=("$@")
# 	local cnt=0
# 	#echo "$element / ${arr[@]}"
# 	for i in "${arr[@]}"; do
# 	    cnt=$((cnt+1))
# 		if [[ "$i" = "${element}" ]]; then
# 			#echo $cnt
#             index=$cnt
#             break
# 		fi
# 	done
# }

# system
#sudo apt-get updatea
#sudo apt-get upgrade

# application
cnt=0
for i in "${app[@]}"
do
    index=$((cnt+1))

	line="${bg_yellow}Progress: $index / ${#app[@]} >> ${app[$cnt]}"
	empty_space=$((columns-${#line}))
	for ((j=0; j<empty_space; j++)) do
		line+=" "
	done
	line+="${bg_NC}\n"
	printf "$line"

	# echo -e "sudo apt install" "$i"
	# printf "sudo apt install ${app[$cnt]}\n"
	sudo apt install "${app[$cnt]}"
	cnt=$((cnt+1))
done

# python
#python -m pip install --upgrade pip
cnt=0
for i in "${python_app[@]}"
do
    index=$((cnt+1))

	line="${bg_yellow}Progress: $index / ${#python_app[@]} >> ${python_app[$cnt]}"
	empty_space=$((columns-${#line}))
	for ((j=0; j<empty_space; j++)) do
		line+=" "
	done
	line+="${bg_NC}\n"
	printf "$line"
	# echo -e "python -m pip install" "$i"
	# printf "python -m pip install ${python_app[$cnt]}\n"
	python -m pip install "${python_app[$cnt]}"
	cnt=$((cnt+1))
done
