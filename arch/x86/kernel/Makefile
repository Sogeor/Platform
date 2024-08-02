ARCH_X86_KERNEL_MACROS ?=
ARCH_X86_PATH := ..

AS := i686-elf-as
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := $(addprefix -D , $(ARCH_X86_KERNEL_MACROS))
CFLAGS := $(addprefix -D , $(ARCH_X86_KERNEL_MACROS))
LDFLAGS :=
OBJECTS :=

include config.mk

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(KERNEL_OUTPUT)),)
	@echo "Deleting $(KERNEL_OUTPUT)..."
	@rm -f $(KERNEL_OUTPUT)
endif
	@for OBJECT in $(OBJECTS) ; do \
  		if [ -f "$${OBJECT}" ]; then \
  			echo "Deleting $${OBJECT}..." ; \
  			rm -f "$${OBJECT}" ; \
  		fi ; \
	done
build: $(KERNEL_OUTPUT)

%.bin: %.S
	@echo "Compiling $^ to $@..."
	@$(AS) $(ASFLAGS) -o $@ $^
%.o: %.c
	@echo "Compiling $^ to $@..."
	@$(CC) $(CFLAGS) -o $@ $^
$(KERNEL_OUTPUT): $(OBJECTS)
	@echo "Linking $^ to $@..."
	@$(LD) $(LDFLAGS) -o $@ $^
