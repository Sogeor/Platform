PTH_BUILD = build
PTH_BUILD_BIN = $(PTH_BUILD)/bin
PTH_BUILD_OBJ = $(PTH_BUILD)/obj
PTH_BUILD_TMP = $(PTH_BUILD)/tmp

PTHLST_BUILD = $(PTH_BUILD)
PTHLST_BUILD += $(PTH_BUILD_BIN)
PTHLST_BUILD += $(PTH_BUILD_OBJ)
PTHLST_BUILD += $(PTH_BUILD_TMP)

TOOL_NASM = nasm
FLGS_NASM = -f elf32
EXTI_NASM = asm
EXTO_NASM = .asm.o
OBJS_NASM =

TOOL_C = i686-elf-gcc
FLGS_C = -std=gnu17 -Wall -O0 -ffreestanding -c
EXTI_C = c
EXTO_C = .c.o
OBJS_C =

TOOL_CPP = i686-elf-g++
FLGS_CPP = -std=gnu++17 -Wall -O0 -ffreestanding -c
EXTI_CPP = cpp
EXTO_CPP = .cpp.o
OBJS_CPP =

TOOL_LINK = i686-elf-ld
FLGS_LINK = -T linker.ld -nostdlib
PTHO_LINK = $(PTH_BUILD_BIN)/bootmgr.img
OBJS_LINK = $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_NASM), $(OBJS_NASM))
OBJS_LINK += $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_C), $(OBJS_C))
OBJS_LINK += $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_CPP), $(OBJS_CPP))

include index.mk
include pm/index.mk
include rm/index.mk

.PHONY: all clean mkdir build

all: clean mkdir build

clean:
	@rm -rf $(PTH_BUILD)

mkdir:
	@for path in $(PTHLST_BUILD) ; do
	    mkdir -p $(path)
	done

build: objs-nasm objs-c objs-cpp objs-link

.PHONY: objs-nasm objs-c objs-cpp

objs-nasm:
	@for obj in $(OBJS_NASM) ; do
	    $(TOOL_NASM) $(FLGS_NASM) -o $(PTH_BUILD_OBJ)/$(obj)$(EXTO_NASM) $(obj)$(EXTI_NASM)
	done

objs-c:
	@for obj in $(OBJS_C) ; do
	    $(TOOL_C) $(FLGS_C) -o $(PTH_BUILD_OBJ)/$(obj)$(EXTO_C) $(obj)$(EXTI_C)
	done

objs-cpp:
	@for obj in $(OBJS_CPP) ; do
	    $(TOOL_CPP) $(FLGS_CPP) -o $(PTH_BUILD_OBJ)/$(obj)$(EXTO_CPP) $(obj)$(EXTI_CPP)
	done

objs-link:
	$(TOOL_LINK) $(FLGS_LINK) -o $(PTHO_LINK) $(OBJS_LINK)