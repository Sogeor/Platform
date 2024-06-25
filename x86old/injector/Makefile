include platform.mk

PLATFORM_X86_BOOT_IMAGE := $(PLATFORM_X86_BOOT)/boot.img
IMAGE := injector.img

include toolkit.mk
LDFLAGS += -T link.ld

OBJECTS :=
include index.mk

.PHONY: all clean build

all: clean build

clean:
	@rm -f $(IMAGE)
	@for object in $(OBJECTS) ; do \
	    rm -f "$${object}" ; \
	done

build: $(OBJECTS)
	@$(LD) $(LDFLAGS) -o $(IMAGE) $(OBJECTS)

%.bin: %.nasm
	@$(AS) $(ASFLAGS) \
    -d BOOT_SIZE=$(shell expr $(shell expr $(shell wc -c < $(PLATFORM_X86_BOOT_IMAGE)) + 511) / 512) \
    -o $@ $^
