#!/bin/bash

git clone https://github.com/tzutalin/labelImg.git
pip3 install pyqt5 lxml

cd labelImg

make qt5py3
python3 labelImg.py
python3 labelImg.py [IMAGE_PATH] [PRE-DEFINED CLASS FILE]
