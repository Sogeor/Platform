KERNEL_NAME := kernel
KERNEL_PATH := .
KERNEL_ASFLAGS := -D KERNEL_DEFINED
KERNEL_CFLAGS := -std=gnu99 -c -D KERNEL_DEFINED
KERNEL_LDFLAGS :=
KERNEL_OBJECTS = $(patsubst %.nasm, %.bin, $(wildcard $(KERNEL_PATH)/*.nasm)) \
                 $(patsubst %.c, %.o, $(wildcard $(KERNEL_PATH)/*.c))
KERNEL_OUTPUT := $(KERNEL_PATH)/$(KERNEL_NAME).img

ifneq ($(findstring ARCH_X86_FEATURE_X86_64, $(ARCH_X86_KERNEL_MACROS)),)
KERNEL_ASFLAGS += -f elf32
KERNEL_LDFLAGS += -T elf32.ld
else
KERNEL_ASFLAGS += -f elf64
KERNEL_LDFLAGS += -T elf64.ld
endif

ASFLAGS += $(KERNEL_ASFLAGS)
CFLAGS += $(KERNEL_CFLAGS)
LDFLAGS += $(KERNEL_LDFLAGS)
OBJECTS += $(KERNEL_OBJECTS)

include $(ARCH_X86_PATH)/shared/config.mk
include $(ARCH_X86_PATH)/libk/config.mk
