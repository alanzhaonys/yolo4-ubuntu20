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
apt install cuda
rm cuda-repo-ubuntu2004-11-0-local_11.0.2-450.51.05-1_amd64.deb

echo "export PATH=/usr/local/cuda-11.0/bin${PATH:+:${PATH}}" >> ~/.bashrc
source ~/.bashrc

# Reboot

# opencv
apt install libopencv-dev python3-opencv
opencv_version

# cuDNN
# Download 3 files below from https://developer.nvidia.com/rdp/cudnn-archive
# and put them into /cuda directory
# 1. cuDNN Runtime library for Ubuntu 18.04 (Deb)
# 2. cuDNN Developer library for Ubuntu 18.04 (Deb)
# 3. cuDNN Code Samples and User Guide for Ubuntu 1804 (Deb)

dpkg -i cuda/cuda11.0/libcudnn8_8.0.2.39-1+cuda11.0_amd64.deb
dpkg -i cuda/cuda11.0/libcudnn8-dev_8.0.2.39-1+cuda11.0_amd64.deb 
dpkg -i cuda/cuda11.0/libcudnn8-doc_8.0.2.39-1+cuda11.0_amd64.deb

# Verify cuDNN
# cp -r /usr/src/cudnn_samples_v8/ $HOME
# cd  $HOME/cudnn_samples_v8/mnistCUDNN
# make clean && make
# ./mnistCUDNN

# OpenMP (for CPU)
apt install libomp-dev

# YOLO v4
git clone https://github.com/AlexeyAB/darknet
cd darknet

# Modify Makefile

# For CPU
GPU=0
CUDNN=0
CUDNN_HALF=0
OPENCV=1
AVX=1
OPENMP=1
LIBSO=1
ZED_CAMERA=0
ZED_CAMERA_v2_8=0

# For GPU
GPU=1
CUDNN=1
CUDNN_HALF=1
OPENCV=1
AVX=0
OPENMP=0
LIBSO=1
ZED_CAMERA=0
ZED_CAMERA_v2_8=0

Run: make

# Testing YOLO
# Download yolov4.weights https://drive.google.com/file/d/1cewMfusmPjYWbrnuJRuKhPMwRe_b9PaT/view

./darknet detect cfg/yolov4.cfg yolov4.weights data/person.jpg
./darknet detector test cfg/coco.data cfg/yolov4.cfg yolov4.weights data/person.jpg -i 0 -thresh 0.25

# Webcam

./darknet detector demo cfg/coco.data cfg/yolov4.cfg yolov4.weights -c 0
