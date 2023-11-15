#!/bin/bash

#Ref: https://github.com/clnhub/rtl8192eu-linux

apt install linux-headers-generic build-essential dkms git
git clone git@github.com:clnhub/rtl8192eu-linux.git
cd rtl8192eu-linux
bash install_wifi.sh
