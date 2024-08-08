ARCH_X86_STAGE2_MACROS ?=
ARCH_X86_PATH := ../..

AS := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := $(addprefix -D , $(ARCH_X86_STAGE2_MACROS))
CFLAGS := $(addprefix -D , $(ARCH_X86_STAGE2_MACROS))
LDFLAGS :=
OBJECTS :=

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(STAGE2_OUTPUT)),)
	@echo "Deleting $(STAGE2_OUTPUT)..."
	@rm -f $(STAGE2_OUTPUT)
endif
	@for OBJECT in $(OBJECTS) ; do \
  		if [ -f "$${OBJECT}" ]; then \
  			echo "Deleting $${OBJECT}..." ; \
  			rm -f "$${OBJECT}" ; \
  		fi ; \
	done
build: $(STAGE2_OUTPUT)

%.bin: %.nasm
	@echo "Compiling $^ to $@..."
	@$(AS) $(ASFLAGS) -o $@ $^
%.o: %.c
	@echo "Compiling $^ to $@..."
	@$(CC) $(CFLAGS) -o $@ $^
$(STAGE2_OUTPUT): $(OBJECTS)
	@echo "Linking $^ to $@..."
	@$(LD) $(LDFLAGS) -o $@ $^
