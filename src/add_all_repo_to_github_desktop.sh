#!/bin/bash

cd ~/Documents/GitHub
find . -maxdepth 2 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && echo 'Adding directory ...' && github . && sleep 2" \;
