PLATFORM := ..
X86 := $(PLATFORM)/x86
X86_BOOT := $(X86)/boot
X86_INCLUDE := $(X86)/include
X86_KERNEL := $(X86)/kernel
SHARED := $(PLATFORM)/shared
SHARED_INCLUDE := $(SHARED)/include

IMAGE := $(X86)/x86.img

BOOT_IMAGE := $(X86_BOOT)/boot-x86.img
KERNEL_IMAGE := $(X86_KERNEL)/kernel-x86.img

IMGT := mkisofs
CPYT := dd
EMUL := qemu-system-x86_64

IFLAGS := -V "BOOTLOADER" \
          -b "boot-x86.img" \
          -no-emul-boot \
          "$(X86_BOOT)"

CFLAGS := conv=notrunc

EFLAGS := -no-reboot \
          -no-shutdown \
          -net none

.PHONY: all clean build image emulate

all: clean emulate

clean:
	@rm -f $(IMAGE)
	@$(MAKE) -C $(X86_BOOT) clean
	@$(MAKE) -C $(X86_KERNEL) clean

build:
	@$(MAKE) -C $(X86_BOOT)
#	@$(MAKE) -C $(X86_KERNEL)

image: build
	@$(IMGT) -o $(IMAGE) $(IFLAGS)
	@$(CPYT) if=$(BOOT_IMAGE) of=$(IMAGE) $(CFLAGS)

emulate: image
	@$(EMUL) $(EFLAGS) -drive format=raw,file=$(IMAGE)
