#!/bin/bash

set -e

#mkisofs -V "BOOTLOADER" -o build/image.raw -b bootmbr.img -no-emul-boot "bootmbr/build/bin/"

dd if=bootmgr/build/bin/bootmbr.img of=build/image.raw conv=notrunc