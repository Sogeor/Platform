ARCH_X86_BOOT_MACROS ?=
ARCH_X86_PATH := ..

include config.mk

STAGE1_NAME = stage1
STAGE1_PATH = $(BOOT_PATH)/$(STAGE1_NAME)
STAGE1_OUTPUT = $(STAGE1_PATH)/$(STAGE1_NAME).img

STAGE0_NAME = stage0
STAGE0_PATH = $(BOOT_PATH)/$(STAGE0_NAME)
STAGE0_OUTPUT = $(STAGE0_PATH)/$(STAGE0_NAME).img

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(BOOT_OUTPUT)),)
	@echo "Deleting $(BOOT_OUTPUT)..."
	@rm -f $(BOOT_OUTPUT)
endif
	$(MAKE) -C $(STAGE1_PATH) clean
	$(MAKE) -C $(STAGE0_PATH) clean
build: build-stage0
	@cat $(STAGE0_OUTPUT) $(STAGE1_OUTPUT) > $(BOOT_OUTPUT)

build-stage1:
	$(MAKE) -C $(STAGE1_PATH) build ARCH_X86_STAGE1_MACROS="$(ARCH_X86_BOOT_MACROS)"
build-stage0: build-stage1
	$(MAKE) -C $(STAGE0_PATH) build ARCH_X86_STAGE0_MACROS="$(ARCH_X86_BOOT_MACROS);STAGE1_SIZE=$(shell wc -c < $(STAGE1_OUTPUT))"
