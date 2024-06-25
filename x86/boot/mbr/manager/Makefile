WARNINGS_LEVEL =
_DV_WARNINGS_LEVEL := all
_AV_WARNINGS_LEVEL := $(_DV_WARNINGS_LEVEL) none
ifndef WARNINGS_LEVEL
$(warning WARNINGS_LEVEL not defined. Used by default: $(_DV_WARNINGS_LEVEL).)
override WARNINGS_LEVEL := $(_DV_WARNINGS_LEVEL)
endif
ifeq ($(findstring $(WARNINGS_LEVEL), $(_AV_WARNINGS_LEVEL)),)
$(error WARNINGS_LEVEL is incorrectly set to $(WARNINGS_LEVEL). Use: $(_AV_WARNINGS_LEVEL))
endif

MANAGER_IMAGE := manager.img

MANAGER_INCLUDE := ../../../../include ../../../include
MANAGER_SOURCES := $(wildcard *.nasm) $(wildcard *.c)
MANAGER_OBJECTS = $(patsubst %.c, %.o, $(patsubst %.nasm, %.bin, $(MANAGER_SOURCES)))

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(MANAGER_IMAGE)),)
	@echo "Deleting $(MANAGER_IMAGE)..."
	@rm -f $(MANAGER_IMAGE)
endif
	@for OBJECT in $(MANAGER_OBJECTS) ; do \
  		if [ -f "$${OBJECT}" ]; then \
  			echo "Deleting $${OBJECT}..." ; \
  			rm -f "$${OBJECT}" ; \
  		fi ; \
	done
build: $(MANAGER_IMAGE)

NASMC := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

NASMFLAGS := -f elf32
CFLAGS := -std=gnu99 -ffreestanding -Wall -c -O0 $(addprefix -I , $(MANAGER_INCLUDE))
LDFLAGS := -nostdlib -T link.ld
ifeq ($(WARNINGS_LEVEL), all)
NASMFLAGS += -w+all
CFLAGS += -Wall
endif
ifeq ($(WARNINGS_LEVEL), none)
NASMFLAGS += -w-all
CFLAGS += -w
endif

%.bin: %.nasm
	@echo "Compiling $^ in $@..."
	@$(NASMC) $(NASMFLAGS) -o $@ $^
%.o: %.c
	@echo "Compiling $^ in $@..."
	@$(CC) $(CFLAGS) -o $@ $^
$(MANAGER_IMAGE): $(MANAGER_OBJECTS)
	@echo "Linking $@..."
	@$(LD) $(LDFLAGS) -o $@ $^
