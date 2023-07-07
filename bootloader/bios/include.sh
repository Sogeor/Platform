#!/bin/bash

set -e
BOOTLOADER_SIZE=$(wc -c < build/i686/asm/bootloader.bin)
if [[ $((BOOTLOADER_SIZE % 512)) == 0 ]]; then
  BOOTLOADER_SIZE-=512
fi
INCLUDE_NUMBER_OF_LATE_SECTORS=$((BOOTLOADER_SIZE / 512))
printf "%%define INCLUDE_NUMBER_OF_LATE_SECTORS %s" $INCLUDE_NUMBER_OF_LATE_SECTORS > build/i686/asm/include.asm