LIBB_NAME := libb
LIBB_PATH := $(ARCH_X86_PATH)/$(LIBB_NAME)
LIBB_ASFLAGS := -D LIBB_DEFINED -I $(LIBB_PATH)
LIBB_CFLAGS := -D LIBB_DEFINED -I $(LIBB_PATH) -ffreestanding
LIBB_LDFLAGS := -nostdlib
LIBB_OBJECTS = $(patsubst %.S, %.bin, $(wildcard $(LIBB_PATH)/*.S)) \
               $(patsubst %.c, %.o, $(wildcard $(LIBB_PATH)/*.c))

ASFLAGS += $(LIBB_ASFLAGS)
CFLAGS += $(LIBB_CFLAGS)
LDFLAGS += $(LIBB_LDFLAGS)
OBJECTS += $(LIBB_OBJECTS)
