STAGE1_NAME := stage1
STAGE1_PATH := .
STAGE1_ASFLAGS := -D STAGE1_DEFINED -f elf32
STAGE1_CFLAGS := -std=gnu99 -c -D STAGE1_DEFINED
STAGE1_LDFLAGS := -T binary.ld
STAGE1_OBJECTS = $(patsubst %.nasm, %.bin, $(wildcard $(STAGE1_PATH)/*.nasm)) \
                 $(patsubst %.c, %.o, $(wildcard $(STAGE1_PATH)/*.c))
STAGE1_OUTPUT := $(STAGE1_PATH)/$(STAGE1_NAME).img

include $(ARCH_X86_PATH)/libb/config.mk
