#!/bin/bash

nasm -f elf32 -o bsec.bin bsec.asm
nasm -f elf32 -o msec.bin msec.asm
i686-elf-ld -T linker.ld bsec.bin msec.bin -o bootx86.bin -nostdlib
cd ../../..
make ARCH=i386
cd arch/x86/boot
