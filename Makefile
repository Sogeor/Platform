.PHONY: all clean setup intel64-clean intel64-setup intel64-bootloader intel64-kernel intel64-launch intel64

all: intel64

clean:
	rm -rf build
	make -C bootloader/bios clean
	make -C kernel clean

setup:
	set -e
	mkdir -p build

intel64-clean:
	rm -rf build/intel64

intel64-setup: intel64-clean setup
	mkdir build/intel64

intel64-bootloader:
	make -C bootloader/bios intel64

intel64-kernel:
	make -C kernel x86_64

build/intel64/intel64.raw:
	mkisofs -V "BOOTLOADER" -o build/intel64/intel64.raw -b bootloader.bin -no-emul-boot "bootloader/bios/build/intel64/bin/"
	dd if=bootloader/bios/build/intel64/bin/bootloader.bin of=build/intel64/intel64.raw conv=notrunc

intel64-launch: build/intel64/intel64.raw
	qemu-system-x86_64 -drive format=raw,file=build/intel64/intel64.raw -net none

intel64: intel64-clean intel64-setup intel64-bootloader intel64-kernel intel64-launch