#!/bin/sh

./build/env/bin/pip3.11 install --upgrade pip
./build/env/bin/pip3.11 install ksql
./build/env/bin/hue migrate
./build/env/bin/supervisor