PTH_BUILD = build
PTH_BUILD_BIN = $(PTH_BUILD)/bin
PTH_BUILD_LIB = $(PTH_BUILD)/lib
PTH_BUILD_OBJ = $(PTH_BUILD)/obj
PTH_BUILD_TMP = $(PTH_BUILD)/tmp

PTH_INCLUDE = ..

PTHLST_MKDIR = $(PTH_BUILD)
PTHLST_MKDIR += $(PTH_BUILD_BIN)
PTHLST_MKDIR += $(PTH_BUILD_LIB)
PTHLST_MKDIR += $(PTH_BUILD_OBJ)
PTHLST_MKDIR += $(PTH_BUILD_TMP)

TOOL_NASM = nasm
FLGS_NASM = -f elf32
EXTI_NASM = .asm
EXTO_NASM = .asm.o

TOOL_C = i686-elf-gcc
FLGS_C = -std=gnu17 -Wall -O0 -ffreestanding -c
EXTI_C = .c
EXTO_C = .c.o

TOOL_CPP = i686-elf-g++
FLGS_CPP = -std=gnu++17 -Wall -O0 -ffreestanding -c
EXTI_CPP = .cpp
EXTO_CPP = .cpp.o

TOOL_LNK = i686-elf-ld
FLGS_LNK = -nostdlib

GRP0_TMPB_IFPTH = $(PTH_BUILD_TMP)/include.asm
GRP0_TOOL = $(TOOL_NASM)
GRP0_FLGS = $(FLGS_NASM) -I $(PTH_BUILD_TMP) -I $(PTH_INCLUDE)
GRP0_EXTI = $(EXTI_NASM)
GRP0_EXTO = $(EXTO_NASM)
GRP0_OBJS =

GRP1_TOOL = $(TOOL_C)
GRP1_FLGS = $(FLGS_C) -I $(PTH_INCLUDE)
GRP1_EXTI = $(EXTI_C)
GRP1_EXTO = $(EXTO_C)
GRP1_OBJS =

GRP2_TOOL = $(TOOL_CPP)
GRP2_FLGS = $(FLGS_CPP) -I $(PTH_INCLUDE)
GRP2_EXTI = $(EXTI_CPP)
GRP2_EXTO = $(EXTO_CPP)
GRP2_OBJS =

GRP3_TOOL = $(TOOL_LNK)
GRP3_FLGS = $(FLGS_LNK) -T linker.ld
GRP3_OBJS = $(patsubst %, $(PTH_BUILD_OBJ)/%$(GRP0_EXTO), $(GRP0_OBJS))
GRP3_OBJS += $(patsubst %, $(PTH_BUILD_OBJ)/%$(GRP1_EXTO), $(GRP1_OBJS))
GRP3_OBJS += $(patsubst %, $(PTH_BUILD_OBJ)/%$(GRP2_EXTO), $(GRP2_OBJS))
GRP3_OPTH = $(PTH_BUILD_BIN)/bootmbr.img

include pm/index.mk
include rm/index.mk
include index.mk

# __bootlibc__

__bootlibc__PTH_BUILD = $(PTH_BUILD_LIB)/bootlibc
__bootlibc__PTH_BUILD_OBJ = $(__bootlibc__PTH_BUILD)/obj
__bootlibc__PTH_BUILD_TMP = $(__bootlibc__PTH_BUILD)/tmp

__bootlibc__PTH = ../bootlibc

PTHLST_MKDIR += $(__bootlibc__PTH_BUILD)
PTHLST_MKDIR += $(__bootlibc__PTH_BUILD_OBJ)
PTHLST_MKDIR += $(__bootlibc__PTH_BUILD_TMP)

__bootlibc__GRP0_TOOL = $(TOOL_NASM)
__bootlibc__GRP0_FLGS = $(FLGS_NASM)
__bootlibc__GRP0_EXTI = $(EXTI_NASM)
__bootlibc__GRP0_EXTO = $(EXTO_NASM)
__bootlibc__GRP0_OBJS =

__bootlibc__GRP1_TOOL = $(TOOL_C)
__bootlibc__GRP1_FLGS = $(FLGS_C)
__bootlibc__GRP1_EXTI = $(EXTI_C)
__bootlibc__GRP1_EXTO = $(EXTO_C)
__bootlibc__GRP1_OBJS =

__bootlibc__GRP2_TOOL = $(TOOL_CPP)
__bootlibc__GRP2_FLGS = $(FLGS_CPP)
__bootlibc__GRP2_EXTI = $(EXTI_CPP)
__bootlibc__GRP2_EXTO = $(EXTO_CPP)
__bootlibc__GRP2_OBJS =

include $(__bootlibc__PTH)/index.mk

GRP3_OBJS += $(patsubst %, $(__bootlibc__PTH_BUILD_OBJ)/%$(__bootlibc__GRP0_EXTO), $(__bootlibc__GRP0_OBJS))
GRP3_OBJS += $(patsubst %, $(__bootlibc__PTH_BUILD_OBJ)/%$(__bootlibc__GRP1_EXTO), $(__bootlibc__GRP1_OBJS))
GRP3_OBJS += $(patsubst %, $(__bootlibc__PTH_BUILD_OBJ)/%$(__bootlibc__GRP2_EXTO), $(__bootlibc__GRP2_OBJS))

#__bootlibc__GRP0_OBJS := $(addprefix $(__bootlibc__PTH)/, $(__bootlibc__GRP0_OBJS))
#__bootlibc__GRP1_OBJS := $(addprefix $(__bootlibc__PTH)/, $(__bootlibc__GRP1_OBJS))
#__bootlibc__GRP2_OBJS := $(addprefix $(__bootlibc__PTH)/, $(__bootlibc__GRP2_OBJS))

# __bootlibc__

GRP0_TMPA_IFPTH = $(GRP0_TMPB_IFPTH)
GRP0_TMPA_TOPTH = $(GRP3_OPTH)
GRP0_TMPA_TFPTH = bootable

GRP4_TOOL = $(GRP3_TOOL)
GRP4_FLGS = $(GRP3_FLGS)
GRP4_OBJS = $(GRP3_OBJS)
GRP4_OPTH = $(GRP3_OPTH)

.PHONY: all clean mkdir build

all: clean build

clean:
	@rm -rf $(PTH_BUILD)

mkdir:
	@for path in $(PTHLST_MKDIR) ; do \
	    mkdir -p "$${path}" ; \
	done

build: mkdir grp4-objs

.PHONY: bootlibc-grp0-objs bootlibc-grp1-objs bootlibc-grp2-objs

bootlibc-grp0-objs:
	@for obj in $(__bootlibc__GRP0_OBJS) ; do \
	    $(__bootlibc__GRP0_TOOL) $(__bootlibc__GRP0_FLGS) -o $(__bootlibc__PTH_BUILD_OBJ)/$${obj}$(__bootlibc__GRP0_EXTO) $(__bootlibc__PTH)/$${obj}$(__bootlibc__GRP0_EXTI) ; \
	done

bootlibc-grp1-objs:
	@for obj in $(__bootlibc__GRP1_OBJS) ; do \
	    $(__bootlibc__GRP1_TOOL) $(__bootlibc__GRP1_FLGS) -o $(__bootlibc__PTH_BUILD_OBJ)/$${obj}$(__bootlibc__GRP1_EXTO) $(__bootlibc__PTH)/$${obj}$(__bootlibc__GRP1_EXTI) ; \
	done

bootlibc-grp2-objs:
	@for obj in $(__bootlibc__GRP2_OBJS) ; do \
	    $(__bootlibc__GRP2_TOOL) $(__bootlibc__GRP2_FLGS) -o $(__bootlibc__PTH_BUILD_OBJ)/$${obj}$(__bootlibc__GRP2_EXTO) $(__bootlibc__PTH)/$${obj}$(__bootlibc__GRP2_EXTI) ; \
	done

.PHONY: grp0-tmpb grp0-objs grp1-objs grp2-objs grp3-objs grp0-tmpa grp4-objs

grp0-tmpb:
	@printf "%%define NUMBER_OF_SECTORS 0" > $(GRP0_TMPB_IFPTH)

grp0-objs: grp0-tmpb
	@for obj in $(GRP0_OBJS) ; do \
	    $(GRP0_TOOL) $(GRP0_FLGS) -o $(PTH_BUILD_OBJ)/$${obj}$(GRP0_EXTO) $${obj}$(GRP0_EXTI) ; \
	done

grp1-objs:
	@for obj in $(GRP1_OBJS) ; do \
	    $(GRP1_TOOL) $(GRP1_FLGS) -o $(PTH_BUILD_OBJ)/$${obj}$(GRP1_EXTO) $${obj}$(GRP1_EXTI) ; \
	done

grp2-objs:
	@for obj in $(GRP2_OBJS) ; do \
	    $(GRP2_TOOL) $(GRP2_FLGS) -o $(PTH_BUILD_OBJ)/$${obj}$(GRP2_EXTO) $${obj}$(GRP2_EXTI) ; \
	done

grp3-objs: bootlibc-grp0-objs bootlibc-grp1-objs bootlibc-grp2-objs grp0-objs grp1-objs grp2-objs
	@$(GRP3_TOOL) $(GRP3_FLGS) -o $(GRP3_OPTH) $(GRP3_OBJS)

grp0-tmpa: grp3-objs
	@printf "%%define NUMBER_OF_SECTORS %s" $(shell expr $(shell expr $(shell wc -c < $(GRP0_TMPA_TOPTH)) + 511) / 512) > $(GRP0_TMPA_IFPTH)
	@$(GRP0_TOOL) $(GRP0_FLGS) -o $(PTH_BUILD_OBJ)/$(GRP0_TMPA_TFPTH)$(GRP0_EXTO) $(GRP0_TMPA_TFPTH)$(GRP0_EXTI)

grp4-objs: grp0-tmpa
	@$(GRP4_TOOL) $(GRP4_FLGS) -o $(GRP4_OPTH) $(GRP4_OBJS)