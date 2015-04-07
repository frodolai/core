#!/bin/bash

LOCAL_PATH=`pwd`
ARCH=arm
CROSS_COMPILE=$LOCAL_PATH/../fsl/bin/arm-fsl-linux-gnueabi-
JOBS=$1

if [ $1 == "distclean" ]; then
	make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE distclean
	exit;
fi

if [ $1 == "clean" ]; then
	make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE clean
	exit;
fi

if [ $1 == "menuconfig" ]; then
	make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE $1
	exit;
fi

#make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE smarc_defconfig
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE imx_v7_defconfig
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE $1

# build uImage
#${CROSS_COMPILE}objcopy -O binary -R .note -R .comment -S arch/arm/boot/compressed/vmlinux linux.bin
#mkimage -A arm -O linux -T kernel -C none -a 0x10008000 -e 0x10008000 -d linux.bin uImage
#../u-boot/tools/mkimage -A arm -O linux -T kernel -C none -a 0x10008000 -e 0x10008000 -d linux.bin uImage
#rm linux.bin

