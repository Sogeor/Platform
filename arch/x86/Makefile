ARCH_X86_MACROS ?=
ARCH_X86_PATH := .

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(ARCH_OUTPUT)),)
	@echo "Deleting $(ARCH_OUTPUT)..."
	@rm -f $(ARCH_OUTPUT)
endif
build: .
