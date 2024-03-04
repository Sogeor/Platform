include $(PLATFORM_X86_PATH)/toolkit.mk

ASFLAGS += -f elf32

CFLAGS += -O0 \
          -ffreestanding

LDFLAGS += -T link.ld
