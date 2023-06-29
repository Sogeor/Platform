#!/bin/bash

# bootloader > other

set -e
rm -rf build
mkdir build

# vars

binaries="build/bootloader.asm.bin build/bootloader.o"

# bootloader > compile > bootloader.asm

printf "%%define bootloader_size 512\n" > build/include.asm
nasm -felf bootloader.asm -o build/bootloader.asm.bin

# bootloader > compile > bootloader.c

i686-elf-gcc -c bootloader.c -o build/bootloader.o -O0 -std=gnu99 -ffreestanding -Wall

# bootloader > link > bootloader.asm.bin & bootloader.o

i686-elf-gcc -T linker.ld $binaries -o build/bootloader.bin -nostdlib

# bootloader > other > include.asm

bootloader_size=$(wc -c < build/bootloader.bin)
if [[ $((bootloader_size % 512)) != 0 ]]; then
  bootloader_size=$((bootloader_size + 512))
fi

# bootloader > compile > bootloader.asm

printf "%%define bootloader_size %s\n%%define bootloader_disk_reading_requirement\n" $bootloader_size > build/include.asm
nasm -felf bootloader.asm -o build/bootloader.asm.bin

# bootloader > link > bootloader.asm.bin & bootloader.o

i686-elf-gcc -T linker.ld $binaries -o build/bootloader.bin -nostdlib

# iso > other

mkdir build/contents
cp -f build/bootloader.bin build/contents/bootloader.bin

# iso > creating

mkisofs -V "BOOTLOADER" -o build/bootloader.raw -b bootloader.bin -no-emul-boot build/contents/
dd if=build/bootloader.bin of=build/bootloader.raw conv=notrunc
