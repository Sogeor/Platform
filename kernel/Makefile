.PHONY: clean i686-clean i686-setup i686-compile-asm i686-compile-c i686-link i686-include i686 x86_64-clean x86_64-setup x86_64-compile-asm x86_64-compile-c x86_64-link x86_64-include x86_64

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

i686-compile-asm:
	$(foreach name, $(patsubst src/asm/%.asm, %, $(wildcard src/asm/*.asm)), \
	nasm -felf src/asm/$(name).asm -o build/i686/asm/$(name).bin;)

i686-compile-c:
	$(foreach name, $(patsubst src/c/%.c, %, $(wildcard src/c/*.c)), \
	i686-elf-gcc -c src/c/$(name).c -o build/i686/c/$(name).o -O0 -std=gnu99 -ffreestanding -Wall;)

i686-link:
	i686-elf-gcc -T i686.ld $(wildcard build/i686/asm/*.bin) $(wildcard build/i686/c/*.o) -o build/i686/bootloader.bin -nostdlib

i686: i686-setup i686-compile-asm i686-compile-c i686-link

x86_64-clean:
	rm -rf build/x86_64

x86_64-setup: x86_64-clean setup
	mkdir build/x86_64
	mkdir build/x86_64/asm
	mkdir build/x86_64/c

x86_64-compile-asm:
	$(foreach name, $(patsubst src/asm/%.asm, %, $(wildcard src/asm/*.asm)), \
	nasm -felf src/asm/$(name).asm -o build/x86_64/asm/$(name).bin;)

x86_64-compile-c:
	$(foreach name, $(patsubst src/c/%.c, %, $(wildcard src/c/*.c)), \
	x86_64-elf-gcc -c src/c/$(name).c -o build/x86_64/c/$(name).o -O0 -std=gnu99 -ffreestanding -Wall;)

x86_64-link:
	x86_64-elf-gcc -T x86_64.ld $(wildcard build/x86_64/asm/*.bin) $(wildcard build/x86_64/c/*.o) -o build/x86_64/bootloader.bin -nostdlib

x86_64: x86_64-setup x86_64-compile-asm x86_64-compile-c x86_64-link