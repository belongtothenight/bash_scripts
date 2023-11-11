#!/bin/bash

#echo "Generate up-to-date docs"
#doxygen ./Doxyfile

echo "Starting local docs server with python server in new terminal"
command="bash -c \"python3 -m http.server --directory ~/Documents/HT32_STD_Docs/html/\""
gnome-terminal -t "HT32_STD_Docs Local Website" -- bash -c "${command}; exec bash"

echo "Open firefox to corresponding page"
firefox --new-tab -url localhost:8000/
