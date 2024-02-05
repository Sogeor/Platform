REPO_DIR := ../../..
ARCH_DIR := ..

BUILD_DIR := build
BUILD_FILE := $(BUILD_DIR)/bootx86.bin

BSEC_INCLUDE_FILE := $(BUILD_DIR)/include.asm

LD_SCRIPT := linker.ld

NASMC := nasm
CC := i686-elf-gcc
CPPC := i686-elf-g++
LD := i686-elf-ld

NASMFLAGS := -f elf32 \
             -I $(ARCH_DIR)/include \
             -I $(REPO_DIR)/shared/include
# -masm=intel
CFLAGS := -std=gnu17 -Wall -O0 -ffreestanding -c -mno-red-zone -fno-stack-protector \
          -I $(ARCH_DIR)/include \
          -I $(REPO_DIR)/shared/include
# -masm=intel
CPPFLAGS := -std=gnu++17 -Wall -O0 -ffreestanding -c -mno-red-zone -fno-stack-protector \
            -I $(ARCH_DIR)/include \
            -I $(REPO_DIR)/shared/include
LDFLAGS := -T $(LD_SCRIPT) -nostdlib

# define current project objects
objects := $(BUILD_DIR)/bsec.bin \
           $(BUILD_DIR)/msec.bin \
           $(BUILD_DIR)/a20.bin \
           $(BUILD_DIR)/gdt.bin \
           $(BUILD_DIR)/mmap.bin \
           $(BUILD_DIR)/mmap.o \
           $(BUILD_DIR)/nmi.bin \
           $(BUILD_DIR)/pm.bin \
           $(BUILD_DIR)/main.o \
           $(BUILD_DIR)/print.o

# add current arch shared objects
objects += $(BUILD_DIR)/arch/shared/ioport.bin

.PHONY: all clean setup build configure

all: clean configure

clean:
	@rm -rf $(BUILD_DIR)

setup:
	@mkdir -p $(BUILD_DIR)

build: setup
	# generate bsec include file stub
	@printf "%%define SEC_NUM 0" > $(BSEC_INCLUDE_FILE)
	# compile current project files
	@$(NASMC) $(NASMFLAGS) -I $(BUILD_DIR) -o $(BUILD_DIR)/bsec.bin bsec.asm
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/msec.bin msec.asm
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/a20.bin a20.asm
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/gdt.bin gdt.asm
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/mmap.bin mmap.asm
	@$(CC) $(CFLAGS) -o $(BUILD_DIR)/mmap.o mmap.c
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/nmi.bin nmi.asm
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/pm.bin pm.asm
	@$(CC) $(CFLAGS) -o $(BUILD_DIR)/main.o main.c
	@$(CC) $(CFLAGS) -o $(BUILD_DIR)/print.o print.c
	# compile current arch shared files
	@mkdir -p $(BUILD_DIR)/arch/shared
	@$(NASMC) $(NASMFLAGS) -o $(BUILD_DIR)/arch/shared/ioport.bin $(ARCH_DIR)/shared/ioport.asm
	# link
	@$(LD) $(LDFLAGS) -o $(BUILD_FILE) $(objects)

configure: build
	# generate bsec include file
	@printf "%%define SEC_NUM %s" $(shell expr $(shell expr $(shell expr $(shell wc -c < $(BUILD_FILE)) + 511) / 512) - 1) > $(BSEC_INCLUDE_FILE)
	# recompile bsec file
	@$(NASMC) $(NASMFLAGS) -I $(BUILD_DIR) -o $(BUILD_DIR)/bsec.bin bsec.asm
	# relink
	@$(LD) $(LDFLAGS) -o $(BUILD_FILE) $(objects)
