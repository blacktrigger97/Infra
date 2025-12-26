#!/bin/sh

# export PYTHON_VER=python3.11
# export ROOT=/usr/share/hue/
# ./build/env/bin/pip3.11 install --upgrade pip
# ./build/env/bin/pip3.11 install ksql
./build/env/bin/hue migrate
./build/env/bin/supervisor