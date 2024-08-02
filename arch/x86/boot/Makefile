ARCH_X86_BOOT_MACROS ?=
ARCH_X86_PATH := ..

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(BOOT_OUTPUT)),)
	@echo "Deleting $(BOOT_OUTPUT)..."
	@rm -f $(BOOT_OUTPUT)
endif
build: .
