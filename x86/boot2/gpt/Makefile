GPT := .
MBR := ../mbr
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

.PHONY: all clean build
all: clean build
clean:
	@rm -f $(IMG)
	@for obj in $(OBJ) ; do \
	    rm -f "$${obj}" ; \
	done
build: $(OBJ)
	@echo "[ld] $^ >> $(IMG)"
	@$(TLP_LD) $(FLG_LD) -o $(IMG) $^

%.bin: %.nasm
	@echo "[nasm] $^ >> $@"
	@$(TLP_NASM) $(FLG_NASM) -o $@ $^
%.c: %.c
	@echo "[c] $^ >> $@"
	@$(TLP_C) $(FLG_C) -o $@ $^
