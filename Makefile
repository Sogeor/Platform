.PHONY: all clean setup intel64-clean intel64-setup intel64-bootloader intel64-kernel intel64-launch intel64

all: intel64

clean:
	rm -rf build
	make -C hdk/bootloader/bios clean
	make -C kernel clean

setup:
	set -e
	mkdir -p build

intel64-clean:
	rm -rf build/intel64

intel64-setup: intel64-clean setup
	mkdir build/intel64

intel64-bootloader:
	make -C hdk/bootloader/bios intel64
#	make -C bootloader/bios build-intel64

intel64-kernel:
	make -C kernel build-intel64

build/intel64/intel64.raw:
	mkisofs -V "BOOTLOADER" -o build/intel64/intel64.raw -b intel64.bin -no-emul-boot "hdk/bootloader/bios/build/"
	dd if=hdk/bootloader/bios/build/intel64.bin of=build/intel64/intel64.raw conv=notrunc
#	mkisofs -V "BOOTLOADER" -o build/intel64/intel64.raw -b intel64.bin -no-emul-boot "bootloader/bios/build/"
#	dd if=bootloader/bios/build/intel64.bin of=build/intel64/intel64.raw conv=notrunc

intel64-launch: build/intel64/intel64.raw
	qemu-system-x86_64 -no-reboot -no-shutdown -drive format=raw,file=build/intel64/intel64.raw -net none

intel64: intel64-clean intel64-setup intel64-bootloader intel64-launch