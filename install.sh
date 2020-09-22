#!/bin/bash


# https://robocademy.com/2020/05/01/a-gentle-introduction-to-yolo-v4-for-object-detection-in-ubuntu-20-04/
# https://bitbucket.org/!api/2.0/snippets/RobotAndCode/Eb7dke/309e3e0cd9e97a7293597bfcbf1583e08ccdbcd4/files/easy-install-yolo-darknet.sh
# https://www.youtube.com/channel/UCQam-u9KZaMSelXoJDRrYJA

# misc
apt install vim net-tools openssh-server git g++

# cmake
apt update
apt install cmake
cmake --version

# CUDA
#apt install nvidia-cuda-toolkit
#nvcc --version

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda-repo-ubuntu2004-11-0-local_11.0.2-450.51.05-1_amd64.deb
apt install ./cuda-repo-ubuntu2004-11-0-local_11.0.2-450.51.05-1_amd64.deb
apt-key add /var/cuda-repo-ubuntu2004-11-0-local/7fa2af80.pub
apt-get -y install cuda

#wget -O /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
#apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
#add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"

# Reboot

#echo "export PATH=/usr/lib/cuda/bin${PATH:+:${PATH}}" >> ~/.bashrc
source ~/.bashrc

# opencv
apt install libopencv-dev python3-opencv
opencv_version

# cuDNN
# Download 3 files below from https://developer.nvidia.com/rdp/cudnn-archive
# and put them into /cuda directory
# 1. cuDNN Runtime library for Ubuntu 18.04 (Deb)
# 2. cuDNN Developer library for Ubuntu 18.04 (Deb)
# 3. cuDNN Code Samples and User Guide for Ubuntu 1804 (Deb)
dpkg -i cuda/libcudnn8_8.0.2.39-1+cuda10.1_amd64.deb
dpkg -i cuda/libcudnn8-dev_8.0.2.39-1+cuda10.1_amd64.deb
dpkg -i libcudnn8-doc_8.0.2.39-1+cuda10.1_amd64.deb
