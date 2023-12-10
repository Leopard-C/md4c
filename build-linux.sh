#!/bin/bash

set -e

if [ ! -d build ]; then mkdir build; fi
if [ ! -d lib/linux ]; then mkdir -p lib/linux; fi
cd build
cmake ..
make -j
cp src/*.a ../lib/linux

cd ..
echo '-----------------------------'
echo 'ls -l lib/linux'
ls -l lib/linux

