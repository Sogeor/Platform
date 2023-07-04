.PHONY: clean i686-clean i686-setup i686-compile-asm i686-compile-c i686-link i686-include i686

CURRENT_MAKEFILE = $(lastword $(MAKEFILE_LIST))

clean:
	rm -rf build

setup:
	set -e
	mkdir -p build

i686-clean:
	rm -rf build/i686

i686-setup: i686-clean setup
	mkdir build/i686
	mkdir build/i686/asm
	mkdir build/i686/c

build/include.asm:
	printf "%%define bootloader_size 512" > build/include.asm

i686-compile-asm:
	nasm -felf src/asm/bootloader.asm -o build/i686/asm/bootloader.bin

i686-compile-c:
	$(foreach name, $(patsubst src/c/%.c, %, $(wildcard src/c/*.c)), \
	i686-elf-gcc -c src/c/$(name).c -o build/i686/c/$(name).o -O0 -std=gnu99 -ffreestanding -Wall;)

i686-link:
	i686-elf-gcc -T linker.ld build/i686/asm/bootloader.bin $(wildcard build/i686/c/*.o) -o build/i686/bootloader.bin -nostdlib

i686-include:
	./include.sh

i686: i686-setup build/include.asm i686-compile-asm i686-compile-c i686-link i686-include
	make -f $(CURRENT_MAKEFILE) i686-compile-asm
	make -f $(CURRENT_MAKEFILE) i686-link
