#!/bin/bash
# Usage: export a list of file directory with specified filetype only
# Author: belongtothenight
# --------------------------------------------------------------------------

# start program

# get user input
echo "Input filetype to list: "
read filetype
echo "Input export filename (with .txt): "
read filename
echo "Mode: multi-layer/single-layer (m/s/[n]): "
read mode

# variable
# search_dir="/run/media/cdc/Transcend/Note_Database/YouTube/YT Database/YTD File Video/YTDFV Output-DDMS/"
# search_dir="/run/media/cdc/Transcend/Note_Database/YouTube/YT Database/YTD File Video/"
search_dir="/run/media/cdc/Transcend/"
export_dir="/home/cdc/Documents/bash_scripts/record/$filename"
# --------------------------------------------------------------------------

# function
function single_layer_list(){
	for file in "$1"/*; do
		ext="${file##*.}"
		# echo $ext
		if [[ $ext == $filetype ]]; then
			printf '\r%s' "$file"
			echo "$file" >> "$export_dir"
		fi
	done
}
	function multi_layer_list(){
	for path in "$1"/*; do
		if [ -d "$path" ]; then
			printf '\r%s' "${path#$search_dir}"
			multi_layer_list "$path"
		elif [ -f "$path" ]; then
			ext="${path##*.}"
			if [[ $ext == $filetype ]]; then
				# echo "$path"
				echo "$path" >> "$export_dir"
			fi
		fi
	done
}
# --------------------------------------------------------------------------

# main
if [[ $mode == s ]]; then
	echo "executing single-layer listing"
	single_layer_list "$search_dir"
elif [[ $mode == m ]]; then
	echo "executing multi-layer listing"
	multi_layer_list "$search_dir"
elif [[ $mode == n ]]; then
	echo "exiting..."
else
	echo "invalid mode, exiting..."
fi
