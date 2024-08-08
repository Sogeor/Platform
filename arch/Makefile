include config.mk

.PHONY: all clean build
all: clean build
clean: .
build: .

.PHONY: all/x86 clean/x86 build/x86
all/x86: clean/x86 build/x86
clean/x86: clean/x86/mbr
build/x86: build/x86/mbr

.PHONY: all/x86/mbr clean/x86/mbr build/x86/mbr
all/x86/mbr: clean/x86/mbr build/x86/mbr
clean/x86/mbr:
	@$(MAKE) -C $(ARCH_PATH) clean/mbr ARCH_X86_MACROS="$(ARCH_X86_MACROS)"
build/x86/mbr:
	@$(MAKE) -C $(ARCH_PATH) build/mbr ARCH_X86_MACROS="$(ARCH_X86_MACROS)"
