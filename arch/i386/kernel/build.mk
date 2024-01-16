ROOT_PATH = ../../..
PROJ_PATH = $(ROOT_PATH)/arch/i386/bootmgr
BUILD_PATH = build
BUILD_BIN_PATH = $(BUILD_PATH)/bin
BUILD_OBJ_PATH = $(BUILD_PATH)/obj
BUILD_TMP_PATH = $(BUILD_PATH)/tmp

BUILD_PATHS = $(BUILD_PATH)
BUILD_PATHS += $(BUILD_BIN_PATH)
BUILD_PATHS += $(BUILD_OBJ_PATH)
BUILD_PATHS += $(BUILD_TMP_PATH)

TMP_B_0_PATH = $(BUILD_TMP_PATH)/include.asm
OBJS_0 =
FLGS_0 = -f elf32 -I $(BUILD_TMP_PATH)
TOOL_0 = nasm
SFX_I_0 = asm
SFX_O_0 = bin

OBJS_1 =
FLGS_1 = -std=gnu17 -Wall -O0 -ffreestanding -c
TOOL_1 = i686-elf-gcc
SFX_I_1 = c
SFX_O_1 = o

OBJS_2 =
FLGS_2 = -std=gnu++17 -Wall -O0 -ffreestanding -c
TOOL_2 = i686-elf-g++
SFX_I_2 = cpp
SFX_O_2 = obj

OUT_L = $(BUILD_BIN_PATH)/bootmgr.bin
OBJS_L = $(patsubst %, $(BUILD_OBJ_PATH)/%.$(SFX_O_0), $(OBJS_0))
OBJS_L += $(patsubst %, $(BUILD_OBJ_PATH)/%.$(SFX_O_1), $(OBJS_1))
OBJS_L += $(patsubst %, $(BUILD_OBJ_PATH)/%.$(SFX_O_2), $(OBJS_2))
FLGS_L = -T linker.ld -nostdlib
TOOL_L = i686-elf-ld
TRGS_L = objs-0
TRGS_L += objs-1
TRGS_L += objs-2

include index.mk
include pm/index.mk
include rm/index.mk

.PHONY: all clean setup build

all: clean build

clean:
	@rm -rf $(BUILD_PATH)

setup:
	@for path in $(BUILD_PATHS) ; do
	    mkdir -p $(path)
	done

build: setup

.PHONY: tmps-before-0 tmps-after-0 objs-0 objs-1 objs-2 link

tmps-before-0:
	@printf "%%define NUMBER_OF_SECTORS 0" > $(TMP_B_0_PATH)

tmps-after-0:
	printf "%%define NUMBER_OF_SECTORS %s" $(shell expr $(shell expr $(shell wc -c < $(OUT_L)) + 511) / 512) > $(TMP_B_0_PATH)
	$(TOOL_0) $(FLGS_0) -o $(BUILD_OBJ_PATH)/bootable.$(SFX_O_0) bootable.$(SFX_I_0)
	$(TOOL_L) $(FLGS_L) -o $(OUT_L) $(OBJS_L)

objs-0: tmps-before-0
	@for obj in $(OBJS_0) ; do
	    $(TOOL_0) $(FLGS_0) -o $(BUILD_OBJ_PATH)/$(obj).$(SFX_O_0) $(obj).$(SFX_I_0)
	done

objs-1:
	@for obj in $(OBJS_1) ; do
	    $(TOOL_1) $(FLGS_1) -o $(BUILD_OBJ_PATH)/$(obj).$(SFX_O_1) $(obj).$(SFX_I_1)
	done

objs-2:
	@for obj in $(OBJS_2) ; do
	    $(TOOL_2) $(FLGS_2) -o $(BUILD_OBJ_PATH)/$(obj).$(SFX_O_2) $(obj).$(SFX_I_2)
	done

link: $(TRGS_L)
	$(TOOL_L) $(FLGS_L) -o $(OUT_L) $(OBJS_L)