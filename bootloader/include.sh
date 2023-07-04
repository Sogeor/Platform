#!/bin/bash

set -e

bootloader_size=$(wc -c < build/i686/bootloader.bin)
if [[ $((bootloader_size % 512)) != 0 ]]; then
  bootloader_size=$((bootloader_size + 512))
fi
printf "%%define bootloader_size %s" $bootloader_size > build/include.asm