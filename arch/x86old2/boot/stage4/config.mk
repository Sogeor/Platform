STAGE2_NAME := stage2
STAGE2_PATH := .
STAGE2_ASFLAGS := -D STAGE2_DEFINED -f bin
STAGE2_CFLAGS := -std=gnu99 -c -D STAGE2_DEFINED
STAGE2_LDFLAGS := -T binary.ld
STAGE2_OBJECTS = $(patsubst %.nasm, %.bin, $(wildcard $(STAGE2_PATH)/*.nasm)) \
                 $(patsubst %.c, %.o, $(wildcard $(STAGE2_PATH)/*.c))
STAGE2_OUTPUT := $(STAGE2_PATH)/$(STAGE2_NAME).img

ASFLAGS += $(STAGE2_ASFLAGS)
CFLAGS += $(STAGE2_CFLAGS)
LDFLAGS += $(STAGE2_LDFLAGS)
OBJECTS += $(STAGE2_OBJECTS)
