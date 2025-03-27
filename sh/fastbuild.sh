#!/bin/bash

CBIN=$PWD/bin
export CCACHE_BASEDIR=$PWD
#export CCACHE_HARDLINK=1
export PATH=$CBIN:$PWD/build/tools/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin:$PATH:$PWD/boot/uboot/tools/
export CPU_NUM=`getconf _NPROCESSORS_ONLN`
NCCC=`which ccache`

make -C application/reference_ui/spLauncher/ 

RET=$?
echo $RET
if [ $RET != 0 ]; then
	echo "build app error!"
	exit $RET
fi

cp -rf ./application/reference_ui/spLauncher/out/bin ./application/out/system
cp -rf ./application/reference_ui/spLauncher/out/lib ./application/out/system

./build/tools/mksquashfs ./application/out/system ./application/out/app.sqfs -all-root -noappend -comp lzo -Xcompression-level 9 -b 32K

cp -rf ./application/out/app.sqfs ./out/

./mk8368P.sh rom
