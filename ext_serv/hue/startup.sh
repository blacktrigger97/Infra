#!/bin/sh

export PYTHON_VER=python3.11
export ROOT=/usr/share/hue/
./build/env/bin/pip install --upgrade pip
./build/env/bin/pip install ksql
./build/env/bin/hue migrate
./build/env/bin/supervisor