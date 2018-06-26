#!/bin/bash

UBOOT_IMAGE="/usr/lib/u-boot/chromebook_jerry/u-boot.SPI"
SPI_DEV="/dev/spidev2.0"

UBOOT=${1:-$UBOOT_IMAGE}

if ! hash flashrom 2>/dev/null; then
	echo "flashrom not found. Bailing out."
	exit 1
fi

if [ ! -f "${UBOOT}" ]; then
	echo "U-Boot image not found"
	exit 1
fi

if [ ! -e "${SPI_DEV}" ]; then
	echo "SPI device file not found"
	exit 1
fi

/usr/sbin/flashrom -p linux_spi:dev="${SPI_DEV}" -w "${UBOOT}"
