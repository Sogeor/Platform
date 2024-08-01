PLATFORM := ../../..
ARCH := $(PLATFORM)/arch
ARCH_X86 := $(ARCH)/x86
ARCH_X86_BOOT := $(ARCH_X86)/boot
ARCH_X86_KERNEL := $(ARCH_X86)/kernel
SHARED := $(PLATFORM)/shared

IMAGE := $(ARCH_X86_KERNEL)/kernel-x86.img

AS := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := -f elf32

CFLAGS := -std=gnu17 \
          -ffreestanding \
          -O0 \
          -Wall \
          -c \
          -I $(X86_DIR)/include

LDFLAGS := -T link.ld \
           -nostdlib

AUTO_OBJECTS :=
AUTO_TARGETS = $(AUTO_OBJECTS)

MANUAL_OBJECTS :=
MANUAL_TARGETS :=

OBJECTS = $(AUTO_OBJECTS) $(MANUAL_OBJECTS)
TARGETS = $(AUTO_TARGETS) $(MANUAL_TARGETS)

include index.mk

.PHONY: all clean build

all: clean build

clean:
	@for object in $(OBJECTS) ; do \
	    rm -f "$${object}" ; \
	done

build: $(TARGETS)
	@$(LD) $(LDFLAGS) -o $(IMAGE) $(OBJECTS)

%.bin: %.asm
	@$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	@$(CC) $(CFLAGS) -o $@ $^
