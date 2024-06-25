include project.mk

AUTO_OBJECTS :=
AUTO_TARGETS = $(AUTO_OBJECTS)

MANUAL_OBJECTS :=
MANUAL_TARGETS :=

OBJECTS = $(AUTO_OBJECTS) $(MANUAL_OBJECTS)
TARGETS = $(AUTO_TARGETS) $(MANUAL_TARGETS)

include index.mk

.PHONY: all clean build

all: clean build

clean:
	@rm -f $(PROJECT_IMAGE_PATH)
	@for object in $(OBJECTS) ; do \
	    rm -f "$${object}" ; \
	done

build: $(TARGETS)
	@$(LD) $(LDFLAGS) -o $(PROJECT_IMAGE_PATH) $(OBJECTS)

%.bin: %.nasm
	@$(AS) $(ASFLAGS) -o $@ $^

%.o: %.c
	@$(CC) $(CFLAGS) -o $@ $^
