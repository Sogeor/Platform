include config.mk
include arch/config.mk

.PHONY: all clean build
all: clean build
clean: clean/arch
build: build/arch

.PHONY: all/arch clean/arch build/arch
all/arch: clean/arch build/arch
clean/arch: clean/arch/x86
build/arch: build/arch/x86

.PHONY: all/arch/x86 clean/arch/x86 build/arch/x86
all/arch/x86: clean/arch/x86 build/arch/x86
clean/arch/x86: clean/arch/x86/mbr clean/arch/x86/mbr
build/arch/x86: build/arch/x86/mbr build/arch/x86/gpt

.PHONY: all/arch/x86/mbr clean/arch/x86/mbr build/arch/x86/mbr
all/arch/x86/mbr: clean/arch/x86/mbr build/arch/x86/mbr
clean/arch/x86/mbr:
	@$(MAKE) -C $(ARCH_PATH) clean/x86/mbr ARCH_MACROS="$(ARCH_MACROS)"
build/arch/x86/mbr:
	@$(MAKE) -C $(ARCH_PATH) build/x86/mbr ARCH_MACROS="$(ARCH_MACROS)"

.PHONY: all/arch/x86/gpt clean/arch/x86/gpt build/arch/x86/gpt
all/arch/x86/gpt: clean/arch/x86/gpt build/arch/x86/gpt
clean/arch/x86/gpt:
	@$(MAKE) -C $(ARCH_PATH) clean/x86/gpt ARCH_MACROS="$(ARCH_MACROS)"
build/arch/x86/gpt:
	@$(MAKE) -C $(ARCH_PATH) build/x86/gpt ARCH_MACROS="$(ARCH_MACROS)"
