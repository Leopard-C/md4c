#!/bin/bash

set -e

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)

build_dir=$script_dir/build/$arch
out_inc_dir=$script_dir/include/md4c
out_lib_dir=$script_dir/lib/linux/$arch

if [ ! -e $build_dir ];   then mkdir -p $build_dir; fi
if [ ! -e $out_lib_dir ]; then mkdir -p $out_lib_dir; fi
if [ ! -d $out_inc_dir ]; then mkdir -p $out_inc_dir; fi

cd $build_dir
cmake $script_dir
make -j

cp src/*.a $out_lib_dir

cd $script_dir
cp src/entity.h src/md4c-html.h src/md4c.h $out_inc_dir

echo 'Success!'

