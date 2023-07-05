#!/bin/bash

set -e
rm -rf build/i686
mkdir -p build/i686

objects="build/i686/bootloader.asm.bin build/i686/bios.c.o build/i686/bootloader.c.o"

# bootloader.asm > bootloader.asm.bin

printf "%%define bootloader_size 512" > build/include.asm
nasm -felf src/asm/bootloader.asm -o build/i686/bootloader.asm.bin

# bios.c > bios.c.o

i686-elf-gcc -c src/c/bios.c -o build/i686/bios.c.o -O0 -std=gnu99 -ffreestanding -Wall

# bootloader.c > bootloader.c.o

i686-elf-gcc -c src/c/bootloader.c -o build/i686/bootloader.c.o -O0 -std=gnu99 -ffreestanding -Wall

# bootloader.asm.bin & bootloader.c.o > bootloader.bin

i686-elf-gcc -T linker.ld $objects -o build/i686/bootloader.bin -nostdlib

# bootloader.asm > bootloader.asm.bin

./include.sh
nasm -felf src/asm/bootloader.asm -o build/i686/bootloader.asm.bin

# bootloader.asm.bin & bootloader.c.o > bootloader.bin

i686-elf-gcc -T linker.ld $objects -o build/i686/bootloader.bin -nostdlib