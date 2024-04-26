GPT := ../gpt
MBR := .
SHR := ../shared

IMG := boot.img
INC :=
SRC :=
OBJ = $(patsubst %.c, %.o, $(patsubst %.nasm, %.bin, $(SRC)))

TLP_NASM := nasm
TLP_C := i686-elf-gcc
TLP_LD := i686-elf-ld

FLG_NASM = -f elf32 $(addprefix "-I ", $(INC))
FLG_C = -std=gnu17 -ffreestanding -Wall -c -O0 \
        $(addprefix "-I ", $(INC))
FLG_LD := -nostdlib -T link.ld

include index.mk
include $(SHR)/Makefile

.PHONY: all clean build-step-1 build-step-2 build
all: clean build
clean:
	@rm -f $(IMG)
	@for obj in $(OBJ) ; do \
	    rm -f "$${obj}" ; \
	done
	@rm -f header.bin
build-step-1: $(OBJ)
	@echo "[ld] $^ >> $(IMG)"
	@$(TLP_LD) $(FLG_LD) -o $(IMG) $^
	@echo "[nasm] header.nasm >> header.bin"
build-step-2: build-step-1
	@echo "[img] $(shell expr $(shell expr $(shell expr $(shell wc -c < $(IMG)) + 511) / 512) - 1) >> BOOT_SIZE"
	@$(TLP_NASM) -d BOOT_SIZE=$(shell expr $(shell expr $(shell expr $(shell wc -c < $(IMG)) + 511) / 512) - 1) -f bin -o header.bin header.nasm
	@echo "[img] header.bin >> $(IMG)"
	@dd if=header.bin of=$(IMG) conv=notrunc status=none
build: build-step-2

%.bin: %.nasm
	@echo "[nasm] $^ >> $@"
	@$(TLP_NASM) $(FLG_NASM) -o $@ $^
%.o: %.c
	@echo "[c] $^ >> $@"
	@$(TLP_C) $(FLG_C) -o $@ $^
