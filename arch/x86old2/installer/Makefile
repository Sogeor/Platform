ARCH_X86_INSTALLER_MACROS ?=
ARCH_X86_PATH := ../

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(INSTALLER_OUTPUT)),)
	@echo "Deleting $(INSTALLER_OUTPUT)..."
	@rm -f $(INSTALLER_OUTPUT)
endif
build: .
