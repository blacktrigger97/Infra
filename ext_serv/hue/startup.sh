#!/bin/sh

./build/env/bin/pip3.11 install --upgrade pip
./build/env/bin/pip3.11 install ksql trino[iceberg,s3]
./build/env/bin/hue migrate
./build/env/bin/supervisor