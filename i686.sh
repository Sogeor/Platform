#!/bin/bash

set -e
rm -rf build
mkdir build

pushd bootloader
./i686.sh
popd

pushd kernel
./i686.sh
popd

# iso / creating

mkisofs -V "BOOTLOADER" -o build/i686.raw -b bootloader.bin -no-emul-boot bootloader/build/i686/
dd if=bootloader/build/i686/bootloader.bin of=build/i686.raw conv=notrunc

# iso / launching

qemu-system-i386 -drive format=raw,file=build/i686.raw -net none