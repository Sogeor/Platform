PTH_BUILD = build
PTH_BUILD_BIN = $(PTH_BUILD)/bin
PTH_BUILD_OBJ = $(PTH_BUILD)/obj
PTH_BUILD_TMP = $(PTH_BUILD)/tmp

PTHLST_BUILD = $(PTH_BUILD)
PTHLST_BUILD += $(PTH_BUILD_BIN)
PTHLST_BUILD += $(PTH_BUILD_OBJ)
PTHLST_BUILD += $(PTH_BUILD_TMP)

PTH_LB_BOOTLIBC = ../bootlibc
PTH_LB_BOOTLIBC_BUILD = $(PTH_LB_BOOTLIBC)/build
PTH_LB_BOOTLIBC_BUILD_OBJ = $(PTH_LB_BOOTLIBC_BUILD)/obj
PTH_LB_BOOTLIBC_INCLUDE = $(PTH_LB_BOOTLIBC)/include
EXTO_LB_BOOTLIBC = .o

PTHLST_LB = $(PTH_LB_BOOTLIBC)

TMPB_NASM_IFPTH = $(PTH_BUILD_TMP)/include.asm
TOOL_NASM = nasm
FLGS_NASM = -f elf32 -I $(PTH_BUILD_TMP) -I $(PTH_LB_BOOTLIBC_INCLUDE)
EXTI_NASM = .asm
EXTO_NASM = .asm.o
OBJS_NASM =
TMPA_NASM_IFPTH = $(TMPB_NASM_IFPTH)
TMPA_NASM_TFPTH = bootable

TOOL_C = i686-elf-gcc
FLGS_C = -std=gnu17 -Wall -O0 -ffreestanding -mno-red-zone -c -I $(PTH_LB_BOOTLIBC_INCLUDE)
EXTI_C = .c
EXTO_C = .c.o
OBJS_C =

TOOL_CPP = i686-elf-g++
FLGS_CPP = -std=gnu++17 -Wall -O0 -ffreestanding -mno-red-zone -c -I $(PTH_LB_BOOTLIBC_INCLUDE)
EXTI_CPP = .cpp
EXTO_CPP = .cpp.o
OBJS_CPP =

TOOL_LINK = i686-elf-ld
FLGS_LINK = -T linker.ld -nostdlib
PTHO_LINK = $(PTH_BUILD_BIN)/bootmgr.img
OBJS_LINK = $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_NASM), $(OBJS_NASM))
OBJS_LINK += $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_C), $(OBJS_C))
OBJS_LINK += $(patsubst %, $(PTH_BUILD_OBJ)/%$(EXTO_CPP), $(OBJS_CPP))
OBJS_LINK += $(shell find "$(PTH_LB_BOOTLIBC_BUILD_OBJ)" -name "*$(EXTO_LB_BOOTLIBC)" -type f)

TOOL_RELINK = $(TOOL_LINK)
FLGS_RELINK = $(FLGS_LINK)
PTHO_RELINK = $(PTHO_LINK)
OBJS_RELINK = $(OBJS_LINK)

include index.mk
include pm/index.mk
include rm/index.mk

include $(IDF_LB_BOOTLIBC)

.PHONY: all clean mkdir build

all: clean mkdir build

clean:
	@rm -rf $(PTH_BUILD)

mkdir:
	@for path in $(PTHLST_BUILD) ; do \
	    mkdir -p "$${path}" ; \
	done

build: lb-make objs-relink

.PHONY: lb-make tmpb-nasm objs-nasm objs-c objs-cpp objs-link

lb-make:
	@for path in $(PTHLST_LB) ; do \
	    $(MAKE) -C "$${path}" ; \
	done

tmpb-nasm:
	@printf "%%define NUMBER_OF_SECTORS 0" > $(TMPB_NASM_IFPTH)

objs-nasm: tmpb-nasm
	@for obj in $(OBJS_NASM) ; do \
	    $(TOOL_NASM) $(FLGS_NASM) -o $(PTH_BUILD_OBJ)/$${obj}$(EXTO_NASM) $${obj}$(EXTI_NASM) ; \
	done

objs-c:
	@for obj in $(OBJS_C) ; do \
	    $(TOOL_C) $(FLGS_C) -o $(PTH_BUILD_OBJ)/$${obj}$(EXTO_C) $${obj}$(EXTI_C) ; \
	done

objs-cpp:
	@for obj in $(OBJS_CPP) ; do \
	    $(TOOL_CPP) $(FLGS_CPP) -o $(PTH_BUILD_OBJ)/$${obj}$(EXTO_CPP) $${obj}$(EXTI_CPP) ; \
	done

objs-link: objs-nasm objs-c objs-cpp
	$(TOOL_LINK) $(FLGS_LINK) -o $(PTHO_LINK) $(OBJS_LINK)

.PHONY: tmpa-nasm objs-relink

tmpa-nasm: objs-link
	@printf "%%define NUMBER_OF_SECTORS %s" $(shell expr $(shell expr $(shell wc -c < $(PTHO_LINK)) + 511) / 512) > $(TMPA_NASM_IFPTH)
	@$(TOOL_NASM) $(FLGS_NASM) -o $(PTH_BUILD_OBJ)/$(TMPA_NASM_TFPTH)$(EXTO_NASM) $(TMPA_NASM_TFPTH)$(EXTI_NASM)

objs-relink: tmpa-nasm
	@$(TOOL_RELINK) $(FLGS_RELINK) -o $(PTHO_RELINK) $(OBJS_RELINK)