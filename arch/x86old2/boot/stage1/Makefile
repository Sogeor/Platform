ARCH_X86_STAGE1_MACROS ?=
ARCH_X86_PATH := ../..

AS := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

ASFLAGS := $(addprefix -D , $(ARCH_X86_STAGE1_MACROS))
CFLAGS := $(addprefix -D , $(ARCH_X86_STAGE1_MACROS))
LDFLAGS :=
OBJECTS :=

include config.mk
ASFLAGS += $(STAGE1_ASFLAGS)
CFLAGS += $(STAGE1_CFLAGS)
LDFLAGS += $(STAGE1_LDFLAGS)
OBJECTS += $(STAGE1_OBJECTS)

.PHONY: all clean build

all: clean build
clean:
ifneq ($(wildcard $(STAGE1_OUTPUT)),)
	@echo "Deleting $(STAGE1_OUTPUT)..."
	@rm -f $(STAGE1_OUTPUT)
endif
	@for OBJECT in $(OBJECTS) ; do \
  		if [ -f "$${OBJECT}" ]; then \
  			echo "Deleting $${OBJECT}..." ; \
  			rm -f "$${OBJECT}" ; \
  		fi ; \
	done
build: $(STAGE1_OUTPUT)

%.bin: %.nasm
	@echo "Compiling $^ to $@..."
	@$(AS) $(ASFLAGS) -o $@ $^
%.o: %.c
	@echo "Compiling $^ to $@..."
	@$(CC) $(CFLAGS) -o $@ $^
$(STAGE1_OUTPUT): $(OBJECTS)
	@echo "Linking $^ to $@..."
	@$(LD) $(LDFLAGS) -o $@ $^
