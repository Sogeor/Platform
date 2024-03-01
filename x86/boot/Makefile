PLATFORM := ../..
X86 := $(PLATFORM)/x86
X86_BOOT := $(X86)/boot
X86_INCLUDE := $(X86)/include
X86_KERNEL := $(X86)/kernel
SHARED := $(PLATFORM)/shared
SHARED_INCLUDE := $(SHARED)/include

IMAGE := $(X86_BOOT)/boot-x86.img

AS := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := -f elf32 \
           -D X86

CFLAGS := -std=gnu17 \
          -std=gnu++17 \
          -Wall \
          -O0 \
          -ffreestanding \
          -c \
          -I $(X86_INCLUDE) \
          -I $(SHARED_INCLUDE) \
          -D X86

LDFLAGS := -T link.ld \
           -nostdlib

AUTO_OBJECTS :=
AUTO_TARGETS = $(AUTO_OBJECTS)

MANUAL_OBJECTS :=
MANUAL_TARGETS :=

OBJECTS = $(AUTO_OBJECTS) $(MANUAL_OBJECTS)
TARGETS = $(AUTO_TARGETS) $(MANUAL_TARGETS)

include config.mk
include index.mk

REBUILD_DEFINE_NAME := BOOT_SIZE
REBUILD_OBJECT_SOURCE := header.nasm
REBUILD_OBJECT_BINARY := header.bin

.PHONY: all clean build rebuild

all: clean rebuild

clean:
	@rm -f $(IMAGE)
	@for object in $(OBJECTS) ; do \
	    rm -f "$${object}" ; \
	done

build: $(TARGETS)
	@$(LD) $(LDFLAGS) -o $(IMAGE) $(OBJECTS)

rebuild: build
	@$(AS) $(ASFLAGS) \
	-d $(REBUILD_DEFINE_NAME)=$(shell expr $(shell expr $(shell expr $(shell wc -c < $(IMAGE)) + 511) / 512) - 1) \
	-o $(REBUILD_OBJECT_BINARY) $(REBUILD_OBJECT_SOURCE)
	@$(LD) $(LDFLAGS) -o $(IMAGE) $(OBJECTS)

%.bin: %.nasm
	@$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	@$(CC) $(CFLAGS) -o $@ $^

%.obj: %.cpp
	@$(CC) $(CFLAGS) -o $@ $^
