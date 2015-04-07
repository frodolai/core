#!/bin/bash

LOCAL_PATH=`pwd`
ARCH=arm
CROSS_COMPILE=$LOCAL_PATH/../fsl/bin/arm-fsl-linux-gnueabi-

if [ $1 == "distclean" ]; then
	make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE distclean
	rm -f imxcfg.imx
	rm -f u-boot-6*
	exit;
fi

if [ $1 == "sabresd" ]; then
	PLATFORM=mx6qsabresd_config
fi

if [ $1 == "quad" ]; then
	PLATFORM=mx6qsmarc_config
fi

if [ $1 == "solo" ]; then
	PLATFORM=mx6solosmarc_config
fi

JOBS=$2

make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE $PLATFORM
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE $JOBS

