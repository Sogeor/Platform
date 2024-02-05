IMG := bootx86.img

AS := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := -f elf32

CFLAGS := -std=gnu23 \
          -ffreestanding \
          -O0 \
          -Wall \
          -c

LDFLAGS := -T linker.ld \
           -nostdlib

ROOT_DIR = ../../..
ARCH_DIR = $(ROOT_DIR)/arch
SHARED_DIR = $(ROOT_DIR)/shared

OBJECTS :=

include index.mk

.PHONY: all clean build

all: clean build

clean:
	for object in OBJECTS ; do
	    @rm -f $object
	done

build: $(OBJECTS)
	@$(LD) $(LDFLAGS) -o $(IMG) $(OBJECTS)
	@$(AS) $(ASFLAGS) -d BOOT_SIZE=$(shell wc -c < $(IMG)) -o bsec.bin bsec.asm
	@$(LD) $(LDFLAGS) -o $(IMG) $(OBJECTS)

%.bin: %.asm
	$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ $^