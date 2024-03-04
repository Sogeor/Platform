AS := nasm
ASFLAGS := -D PLATFORM_X86

CC := i686-elf-gcc
CFLAGS := -std=gnu17 \
          -Wall \
          -c \
          -D PLATFORM_X86

LD := i686-elf-ld
LDFLAGS := -nostdlib
