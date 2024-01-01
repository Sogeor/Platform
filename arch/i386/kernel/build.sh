#!/bin/bash

set -e

mkdir -p build
mkdir -p build/objects

pushd include
find . -type f -name '*.asm' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [kernel] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
nasm -f elf32 -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
find . -type f -name '*.c' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [kernel] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
i686-elf-gcc -std=gnu17 -Wall -O0 -ffreestanding -c -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
find . -type f -name '*.cpp' -exec bash -c '
mkdir -p ../build/objects/$(dirname $1)
echo "[i386] [kernel] [compiling] ../build/objects/$(dirname $1)/$(basename $1).o"
i686-elf-g++ -std=gnu++17 -Wall -O0 -ffreestanding -c -o ../build/objects/$(dirname $1)/$(basename $1).o $1
' shell {} \;
popd

objects=$(find build/objects -type f -name '*.o')
objects=${objects//
/ }

echo "[i386] [kernel] [linking] build/image.bin"
# shellcheck disable=SC2086
i686-elf-ld -T linker.ld -nostdlib -o build/image.bin $objects
