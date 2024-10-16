include config.mk

.PHONY: all clean build
all: clean build
clean: clean/mbr
ifneq ($(wildcard $(ARCH_X86_OUTPUT)),)
	@echo "Deleting $(ARCH_X86_OUTPUT)..."
	@rm -f $(ARCH_X86_OUTPUT)
endif
build: build/mbr

.PHONY: all/mbr clean/mbr build/mbr
all/mbr: clean/mbr build/mbr
clean/mbr: .
build/mbr: .
