ARCH_X86_STAGE0_MACROS ?=
ARCH_X86_PATH := ../..

AS := nasm

ASFLAGS := $(addprefix -D , $(ARCH_X86_STAGE0_MACROS))
OBJECTS :=

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(STAGE0_OUTPUT)),)
	@echo "Deleting $(STAGE0_OUTPUT)..."
	@rm -f $(STAGE0_OUTPUT)
endif
build: $(STAGE0_OUTPUT)

$(STAGE0_OUTPUT): $(OBJECT)
	@echo "Compiling $^ to $@..."
	@$(AS) $(ASFLAGS) -o $@ $^
