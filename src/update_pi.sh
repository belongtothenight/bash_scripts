#!/bin/bash

# system
sudo apt-get update
sudo apt-get upgrade

# application
sudo apt install vim
sudo apt install htop
sudo apt install git

# python
python -m pip install --upgrade pip
pip install numpy
pip install pandas
pip install matplotlib
pip install seaborn
pip install scikit-learn
#pip install keras
pip install tensorflow
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117
#pip install opencv-python
pip install wandb

