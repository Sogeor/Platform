PLATFORM := ..
X86 := $(PLATFORM)/x86
X86_BOOT := $(X86)/boot
X86_INCLUDE := $(X86)/include
X86_INJECTOR := $(X86)/injector
X86_KERNEL := $(X86)/kernel
SHARED := $(PLATFORM)/shared
SHARED_INCLUDE := $(SHARED)/include

IMAGE := $(X86)/x86.img

BOOT_IMAGE := $(X86_BOOT)/boot.img
KERNEL_IMAGE := $(X86_KERNEL)/kernel-x86.img
INJECTOR_IMAGE := $(X86_INJECTOR)/injector.img

IMGT := mkisofs
CPYT := dd
EMUL := qemu-system-x86_64

IFLAGS := -V "Sogeor Platform" \
          -b "injector.img" \
          -no-emul-boot \
          "$(INJECTOR_IMAGE)"

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
	@$(MAKE) -C $(X86_INJECTOR) clean

build:
	@$(MAKE) -C $(X86_BOOT)
	@$(MAKE) -C $(X86_KERNEL)
	@$(MAKE) -C $(X86_INJECTOR)

image: build
	@#$(IMGT) -o $(IMAGE) $(IFLAGS)
	@$(CPYT) if=$(INJECTOR_IMAGE) of=$(IMAGE) $(CFLAGS)
	@$(CPYT) seek=1 if=$(BOOT_IMAGE) of=$(IMAGE) $(CFLAGS)

emulate: image
	@$(EMUL) $(EFLAGS) -drive format=raw,file=$(IMAGE)
