.PHONY: clean setup i686-clean i686-setup i686-bootloader i686-kernel i686-launch i686 x86_64-clean x86_64-setup x86_64-bootloader x86_64-kernel x86_64-launch x86_64

clean:
	rm -rf build
	make -C bootloader/bios clean
	make -C kernel clean

setup:
	set -e
	mkdir -p build
	make -C bootloader/bios setup
	make -C kernel setup

i686-clean:
	rm -rf build/i686

i686-setup: i686-clean setup
	mkdir build/i686

i686-bootloader:
	make -C bootloader/bios i686

i686-kernel:
	make -C bootloader/bios i686

build/i686/i686.raw:
	mkisofs -V "BOOTLOADER" -o build/i686/i686.raw -b bootloader.bin -no-emul-boot "bootloader/bios/build/i686/"
	dd if=bootloader/bios/build/i686/bootloader.bin of=build/i686/i686.raw conv=notrunc

i686-launch: build/i686/i686.raw
	qemu-system-i386 -drive format=raw,file=build/i686/i686.raw -net none

i686: i686-setup i686-bootloader i686-kernel i686-launch

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