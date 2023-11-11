#!/bin/bash

#Ref: https://stackoverflow.com/questions/7470165/how-to-go-to-each-directory-and-execute-a-command
cd ~/Documents/GitHub
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && echo 'Pulling from source ...' && git pull" \;
