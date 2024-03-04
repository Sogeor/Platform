PLATFORM_PATH := ../..
PLATFORM_TOOLS_PATH := $(PLATFORM_PATH)/tools
PLATFORM_TOOLS_ASSEMBLER_PATH := $(PLATFORM_TOOLS_PATH)/assembler

IMAGE := $(PLATFORM_TOOLS_ASSEMBLER_PATH)/assembler

AS := nasm
CC := cc
CPPC := g++
LD := gcc

ASFLAGS :=

CFLAGS := -std=gnu17 \
          -std=gnu++17 \
          -Wall \
          -c

LDFLAGS :=

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

all: clean build

clean:
	@rm -f $(IMAGE)
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
