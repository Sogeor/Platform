include project.mk

AUTO_OBJECTS :=
AUTO_TARGETS = $(AUTO_OBJECTS)

MANUAL_OBJECTS :=
MANUAL_TARGETS :=

OBJECTS = $(AUTO_OBJECTS) $(MANUAL_OBJECTS)
TARGETS = $(AUTO_TARGETS) $(MANUAL_TARGETS)

include index.mk

POSTBUILD_MACROS_NAME := BOOT_SIZE
POSTBUILD_TARGET := header.nasm
POSTBUILD_OBJECT := header.bin

.PHONY: all clean prebuild postbuild build

all: clean build

clean:
	@rm -f $(PROJECT_IMAGE_PATH)
	@for object in $(OBJECTS) ; do \
	    rm -f "$${object}" ; \
	done

prebuild: $(TARGETS)
	@$(LD) $(LDFLAGS) -o $(PROJECT_IMAGE_PATH) $(OBJECTS)

postbuild: prebuild
	@$(AS) $(ASFLAGS) \
	-d $(POSTBUILD_MACROS_NAME)=$(shell expr $(shell expr $(shell expr $(shell wc -c < $(PROJECT_IMAGE_PATH)) + 511) / 512) - 1) \
	-o $(POSTBUILD_OBJECT) $(POSTBUILD_TARGET)

build: postbuild
	@$(LD) $(LDFLAGS) -o $(PROJECT_IMAGE_PATH) $(OBJECTS)

%.bin: %.nasm
	@$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	@$(CC) $(CFLAGS) -o $@ $^
