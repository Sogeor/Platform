ARCH_X86_STAGE1_MACROS ?=
ARCH_X86_PATH := ../..

AS := nasm

ASFLAGS := $(addprefix -D , $(ARCH_X86_STAGE1_MACROS))
OBJECTS :=

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(STAGE1_OUTPUT)),)
	@echo "Deleting $(STAGE1_OUTPUT)..."
	@rm -f $(STAGE1_OUTPUT)
endif
build: $(STAGE1_OUTPUT)

$(STAGE1_OUTPUT): $(OBJECT)
	@echo "Compiling $^ to $@..."
	@$(AS) $(ASFLAGS) -o $@ $^
