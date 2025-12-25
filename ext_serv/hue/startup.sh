#!/bin/sh

./build/env/bin/pip install --upgrade pip
./build/env/bin/pip install ksql
./build/env/bin/hue migrate
./build/env/bin/supervisor