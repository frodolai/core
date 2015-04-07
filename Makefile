ARCH := arm
CROSS_COMPILE := $(shell pwd)/fsl/bin/arm-fsl-linux-gnueabi-

############
# MAINCAR  #
############
rev-sa01: rev-sa01-uboot rev-sa01-kernel
rev-sa01-uboot: rev-sa01-uboot.bin
rev-sa01-kernel: rev-sa01-kernel.bin

##########
# Kernel #
##########
rev-sa01-kernel.bin: cleankernel
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C kernel/ imx_v7_defconfig
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C kernel/
	mkdir -p out
	install kernel/arch/arm/boot/zImage out/zImage
	install kernel/arch/arm/boot/dts/imx6q-rev-sa01.dtb out/imx6q-rev-sa01.dtb
	install kernel/arch/arm/boot/dts/imx6solo-rev-sa01.dtb out/imx6solo-rev-sa01.dtb

##########
# U-Boot #
##########
rev-sa01-uboot.bin: cleanuboot
	mkdir -p out
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/ distclean
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/ mx6qsmarc_config
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/
	install u-boot/u-boot.imx out/u-boot-6q.imx
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/ distclean
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/ mx6solosmarc_config
	$(MAKE) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/
	install u-boot/u-boot.imx out/u-boot-6solo.imx

clean:
	$(MAKE) CROSS_COMPILE=$(CROSS_COMPILE) -C u-boot/ distclean
	$(MAKE) CROSS_COMPILE=$(CROSS_COMPILE) -C kernel/ distclean
	rm -rf out \
		kernel/arch/arm/boot/compressed/lib1funcs.S \
		kernel/arch/arm/boot/compressed/piggy.gzip \
		kernel/arch/arm/boot/compressed/vmlinux \
		kernel/arch/arm/boot/compressed/vmlinux.lds \
		kernel/arch/arm/boot/dts/mx6q-rev-sa01.dtb \
		kernel/arch/arm/boot/dts/imx6solo-rev-sa01.dtb \
		kernel/arch/arm/kernel/vmlinux.lds \
		u-boot/imxcfg.imx

cleankernel:
	rm -f out/zImage
	rm -f out/*.dtb

cleanuboot:
	rm -f out/*.imx

