#!/bin/bash

# Ref
# 1. https://github.com/cli/cli
# 2. https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# 3. https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github

function request () {
	gh repo list $1 --limit 1000 | while read -r repo _; do
	gh repo clone "$repo" "$repo"
	done
}

cd ~/Documents/GitHub
request "CYCU-AIoT-System-Lab"
request "belongtothenight"



