PLATFORM := ../..
X86 := $(PLATFORM)/x86
X86_BOOT := $(X86)/boot
X86_INCLUDE := $(X86)/include
X86_KERNEL := $(X86)/kernel
SHARED := $(PLATFORM)/shared
SHARED_INCLUDE := $(SHARED)/include

IMAGE := $(X86_KERNEL)/kernel-x86.img

AS := nasm
CC := x86_64-elf-gcc
LD := x86_64-elf-ld

ASFLAGS := -f elf64

CFLAGS := -std=gnu17 \
          -std=gnu++17 \
          -Wall \
          -O0 \
          -ffreestanding \
          -c \
          -I $(X86_INCLUDE) \
          -I $(SHARED_INCLUDE)

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

%.bin: %.nasm
	@$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	@$(CC) $(CFLAGS) -o $@ $^

%.obj: %.cpp
	@$(CC) $(CFLAGS) -o $@ $^
