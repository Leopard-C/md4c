#!/bin/bash

set -e

PrintUsage()
{
    echo "usage:"
    echo "  ./build-linux.sh [architecture]"
    echo ""
    echo "for example:"
    echo "  ./build-linux.sh"
    echo "  ./build-linux.sh x86_64"
    echo "  ./build-linux.sh aarch64"
}

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)

arch=`uname -m`

if [ $# -eq 1 ]; then
    arch=$1
elif [ $# -gt 1 ]; then
    PrintUsage
    exit 1
fi

echo "Architecture: $arch"

toolchain_file="$script_dir/cmake/toolchain.$arch.cmake"
if [ ! -e "$toolchain_file" ]; then
    echo "ERROR: not found file '$toolchain_file'"
    PrintUsage
    exit 2
fi

build_dir=$script_dir/build/$arch
out_inc_dir=$script_dir/include/md4c
out_lib_dir=$script_dir/lib/linux/$arch

if [ ! -e $build_dir ];   then mkdir -p $build_dir; fi
if [ ! -e $out_lib_dir ]; then mkdir -p $out_lib_dir; fi
if [ ! -d $out_inc_dir ]; then mkdir -p $out_inc_dir; fi

cd $build_dir
cmake $script_dir -DCMAKE_TOOLCHAIN_FILE=$toolchain_file
make -j

cp src/*.a $out_lib_dir

cd $script_dir
cp src/entity.h src/md4c-html.h src/md4c.h $out_inc_dir

echo 'Success!'
