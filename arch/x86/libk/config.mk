LIBK_NAME := libk
LIBK_PATH := $(ARCH_X86_PATH)/$(LIBK_NAME)
LIBK_ASFLAGS := -D LIBK_DEFINED -I $(LIBK_PATH)
LIBK_CFLAGS := -D LIBK_DEFINED -I $(LIBK_PATH) -ffreestanding
LIBK_LDFLAGS := -nostdlib
LIBK_OBJECTS = $(patsubst %.S, %.bin, $(wildcard $(LIBK_PATH)/*.S)) \
               $(patsubst %.c, %.o, $(wildcard $(LIBK_PATH)/*.c))

ASFLAGS += $(LIBK_ASFLAGS)
CFLAGS += $(LIBK_CFLAGS)
LDFLAGS += $(LIBK_LDFLAGS)
OBJECTS += $(LIBK_OBJECTS)
