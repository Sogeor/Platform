.PHONY: clean i686-clean i686-setup i686-compile-s i686-compile-c i686-link i686-include i686 x86_64-clean x86_64-setup x86_64-compile-s x86_64-compile-c x86_64-link x86_64-include x86_64

clean:
	rm -rf build

setup:
	set -e
	mkdir -p build

i686-clean:
	rm -rf build/i686

i686-setup: i686-clean setup
	mkdir build/i686
	mkdir build/i686/s
	mkdir build/i686/c

i686-compile-s:
	$(foreach name, $(patsubst src/s/%.s, %, $(wildcard src/s/*.s)), \
	i686-elf-as src/s/$(name).s build/i686/s/$(name).o;)

i686-compile-c:
	$(foreach name, $(patsubst src/c/%.c, %, $(wildcard src/c/*.c)), \
	i686-elf-gcc -c src/c/$(name).c -o build/i686/c/$(name).o -O0 -std=gnu99 -ffreestanding -Wall;)

i686-link:
	i686-elf-gcc -T i686.ld $(wildcard build/i686/s/*.bin) $(wildcard build/i686/c/*.o) -o build/i686/bootloader.bin -nostdlib

i686: i686-setup i686-compile-s i686-compile-c i686-link

x86_64-clean:
	rm -rf build/x86_64

x86_64-setup: x86_64-clean setup
	mkdir build/x86_64
	mkdir build/x86_64/s
	mkdir build/x86_64/c

x86_64-compile-s:
	$(foreach name, $(patsubst src/s/%.s, %, $(wildcard src/s/*.s)), \
	x86_64-elf-as src/s/$(name).s build/x86_64/s/$(name).o;)

x86_64-compile-c:
	$(foreach name, $(patsubst src/c/%.c, %, $(wildcard src/c/*.c)), \
	x86_64-elf-gcc -c src/c/$(name).c -o build/x86_64/c/$(name).o -O0 -std=gnu99 -ffreestanding -Wall;)

x86_64-link:
	x86_64-elf-gcc -T x86_64.ld $(wildcard build/x86_64/s/*.bin) $(wildcard build/x86_64/c/*.o) -o build/x86_64/bootloader.bin -nostdlib

x86_64: x86_64-setup x86_64-compile-s x86_64-compile-c x86_64-link