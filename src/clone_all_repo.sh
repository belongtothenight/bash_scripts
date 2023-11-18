#!/bin/bash

# Ref
# 1. https://github.com/cli/cli
# 2. https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# 3. https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github

#account="CYCU-AIoT-System-Lab"
account="belongtothenight"

cd ~/Documents/GitHub

gh repo list $account --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done

