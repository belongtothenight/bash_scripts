#!/bin/bash
# Usage: export a list of file directory with specified filetype only
# Author: belongtothenight

search_dir="/run/media/cdc/Transcend/Note_Database/YouTube/YT Database/YTD File Video/YTDFV Output-DDMS/"
export_dir="/home/cdc/Documents/bash_scripts/record/mp4_files.txt"

# single layer
function single_layer(){
	echo "executing single layer function"
	for file in "$search_dir"/*; do
		ext="${file##*.}"
		# echo $ext
		if [[ $ext == mp4 ]]; then
			echo "$file"
			echo "$file" >> $export_dir
		fi
	done
}

single_layer
