#!/bin/bash

#install dependencies
apt update && apt -y install build-essential cmake git python3 python3-pip

#clone openfhe source
git clone https://github.com/openfheorg/openfhe-development.git
git clone https://github.com/openfheorg/openfhe-python.git

#install openfhe C++ library
cd openfhe-development
mkdir build
cd build
cmake ..
make
sudo make install
cd ../..

#install openfhe python wrapper
cd openfhe-python
pip install "pybind11[global]"
mkdir build
cd build
cmake ..
make
sudo make install
export PYTHONPATH=(/usr/lib/python3/dist-packages/openfhe.cpython-38-x86_64-linux-gnu.so):$PYTHONPATH
cd ../..


