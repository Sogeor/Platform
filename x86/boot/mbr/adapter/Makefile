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

ADAPTER_IMAGE := adapter.img

ADAPTER_INCLUDE := ../../../../include ../../../include
ADAPTER_SOURCES = $(wildcard *.nasm) \
                  $(wildcard *.c) \
                  $(foreach PATH, $(MANAGER_INCLUDE), \
                  $(wildcard $(PATH)/*.nasm) \
                  $(wildcard $(PATH)/*/*.nasm) \
                  $(wildcard $(PATH)/*/*/*.nasm) \
                  $(wildcard $(PATH)/*/*/*/*.nasm) \
                  $(wildcard $(PATH)/*.c) \
                  $(wildcard $(PATH)/*/*.c) \
                  $(wildcard $(PATH)/*/*/*.c) \
                  $(wildcard $(PATH)/*/*/*/*.c))
ADAPTER_OBJECTS = $(patsubst %.c, %.o, $(patsubst %.nasm, %.bin, $(ADAPTER_SOURCES)))

.PHONY: all clean build
all: clean build
clean:
ifneq ($(wildcard $(ADAPTER_IMAGE)),)
	@echo "Deleting $(ADAPTER_IMAGE)..."
	@rm -f $(ADAPTER_IMAGE)
endif
	@for OBJECT in $(ADAPTER_OBJECTS) ; do \
  		if [ -f "$${OBJECT}" ]; then \
  			echo "Deleting $${OBJECT}..." ; \
  			rm -f "$${OBJECT}" ; \
  		fi ; \
	done
build: $(ADAPTER_IMAGE)

NASMC := nasm
CC := i686-elf-gcc
LD := i686-elf-ld

NASMFLAGS := -f elf32 -D M32
CFLAGS := -std=gnu99 -ffreestanding -Wall -c -O0 -m32 -D M32 $(addprefix -I , $(ADAPTER_INCLUDE))
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
$(ADAPTER_IMAGE): $(ADAPTER_OBJECTS)
	@echo "Linking $@..."
	@$(LD) $(LDFLAGS) -o $@ $^
