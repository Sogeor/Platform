#!/bin/bash

set -e

mkdir -p build
mkdir -p build/include
mkdir -p build/objects

printf "%%define NUMBER_OF_SECTORS 0" > build/include/include.asm

pushd include
find . -type f -name '*.asm' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [bios-bootloader] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
nasm -I ../build/include -f elf32 -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
find . -type f -name '*.c' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [bios-bootloader] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
i686-elf-gcc -I ../build/include -std=gnu17 -Wall -O0 -ffreestanding -c -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
find . -type f -name '*.cpp' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [bios-bootloader] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
i686-elf-g++ -I ../build/include -std=gnu++17 -Wall -O0 -ffreestanding -c -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
popd

objects=$(find build/objects -type f -name '*.o')
objects=${objects//
/ }

echo "[i386] [bios-bootloader] [linking] build/image.bin"
# shellcheck disable=SC2086
i686-elf-ld -T linker.ld -nostdlib -o build/image.bin $objects

printf "%%define NUMBER_OF_SECTORS %s" $((($(wc -c < build/image.bin) + 511) / 512)) > build/include/include.asm

echo "[i386] [bios-bootloader] [recompiling] build/objects/bootable.asm.o"
nasm -f elf32 -I build/include include/bootable.asm -o build/objects/bootable.asm.o

echo "[i386] [bios-bootloader] [relinking] build/image.bin"
# shellcheck disable=SC2086
i686-elf-ld -T linker.ld -nostdlib -o build/image.bin $objects
