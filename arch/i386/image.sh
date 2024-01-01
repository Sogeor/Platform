#!/bin/bash

set -e

mkisofs -V "BOOTLOADER" -o build/image.raw -b image.bin -no-emul-boot "bios-bootloader/build/"

dd if=bios-bootloader/build/image.bin of=build/image.raw conv=notrunc