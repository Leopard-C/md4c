#!/bin/bash

set -e

if [ ! -d build ]; then mkdir build; fi
if [ ! -d lib/linux ]; then mkdir -p lib/linux; fi
if [ ! -d include/md4c ]; then mkdir -p include/md4c; fi

cd build
cmake ..
make -j
cp src/*.a ../lib/linux

cd ..
cp src/entity.h src/md4c-html.h src/md4c.h include/md4c

echo 'Success!'

