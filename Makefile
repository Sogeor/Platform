.PHONY: all clean setup x86_64-clean x86_64-setup x86_64-bootloader x86_64-kernel x86_64-launch x86_64

all: x86_64

clean:
	rm -rf build
	make -C bootloader/bios clean
	make -C kernel clean

setup:
	set -e
	mkdir -p build

x86_64-clean:
	rm -rf build/x86_64

x86_64-setup: x86_64-clean setup
	mkdir build/x86_64

x86_64-bootloader:
	make -C bootloader/bios i686

x86_64-kernel:
	make -C kernel x86_64

build/x86_64/x86_64.raw:
	mkisofs -V "BOOTLOADER" -o build/x86_64/x86_64.raw -b bootloader.bin -no-emul-boot "bootloader/bios/build/i686/"
	dd if=bootloader/bios/build/i686/bootloader.bin of=build/x86_64/x86_64.raw conv=notrunc

x86_64-launch: build/x86_64/x86_64.raw
	qemu-system-x86_64 -drive format=raw,file=build/x86_64/x86_64.raw -net none

x86_64: x86_64-clean x86_64-setup x86_64-bootloader x86_64-kernel x86_64-launch