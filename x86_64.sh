#!/bin/bash

set -e
rm -rf build
mkdir build

pushd bootloader
./i686.sh
popd

pushd kernel
./x86_64.sh
popd

# iso / creating

mkisofs -V "BOOTLOADER" -o build/x86_64.raw -b bootloader.bin -no-emul-boot bootloader/build/i686/
dd if=bootloader/build/i686/bootloader.bin of=build/x86_64.raw conv=notrunc

# iso / launching

qemu-system-x86_64 -drive format=raw,file=build/x86_64.raw -net none