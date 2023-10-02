#!/bin/bash

###################################################################################
# Install script for roboflow service
###################################################################################
echo "Plz enter su mode before executing"

###################################################################################
# System update
###################################################################################
apt-get update
apt-get upgrade -y

###################################################################################
# Install tools
###################################################################################
apt-get install git curl wget htop iftop neovim -y
# python package
pip install matplotlib roboflow opencv-python "picamera[array]"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
# test docker installation
docker
# roboflow inference server
docker run -it --rm -p 9001:9001 roboflow/roboflow-inference-server-arm-cpu &

