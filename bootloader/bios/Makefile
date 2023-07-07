.PHONY: all clean setup i686-clean i686-setup i686-compile-asm i686-compile-c i686-compile i686-link i686-include i686

# [ PATH ]

PATH_SOURCE = src
PATH_BUILD = build

PATH_LINKER = linker.ld

# [ PATH_SOURCE ]

PATH_SOURCE_ASM = ${PATH_SOURCE}/asm
PATH_SOURCE_C = ${PATH_SOURCE}/c

# [ PATH_SOURCE_ASM ]

PATH_SOURCE_ASM_BOOTLOADER = ${PATH_SOURCE_ASM}/bootloader.asm

# [ PATHS_INCLUDE ]

PATHS_INCLUDE_ASM = ${PATH_SOURCE_ASM}
PATHS_INCLUDE_C = ${PATH_SOURCE_C}

# [ FLAGS_COMPILE ]

FLAGS_COMPILE_ASM = -f elf32
FLAGS_COMPILE_C = -O0 -std=gnu99 -ffreestanding -Wall

# [ FLAGS_INCLUDE ]

FLAGS_INCLUDE_ASM = $(addprefix -I , $(wordlist 1, $(words ${PATHS_INCLUDE_ASM}), ${PATHS_INCLUDE_ASM}))
FLAGS_INCLUDE_C = $(addprefix -I , $(wordlist 1, $(words ${PATHS_INCLUDE_C}), ${PATHS_INCLUDE_C}))

# [ FLAGS ]

FLAGS_LINK = -nostdlib

# [ I686_PATHS_INCLUDE ]

I686_PATHS_INCLUDE_ASM = ${PATHS_INCLUDE_ASM} ${I686_PATH_BUILD_ASM}
I686_PATHS_INCLUDE_C = ${PATHS_INCLUDE_C} ${I686_PATH_BUILD_C}

# [ I686_PATH_BUILD ]

I686_PATH_BUILD = ${PATH_BUILD}/i686

I686_PATH_BUILD_ASM = ${I686_PATH_BUILD}/asm
I686_PATH_BUILD_C = ${I686_PATH_BUILD}/c

I686_PATH_BUILD_INCLUDE = ${I686_PATH_BUILD_ASM}/include.asm

I686_PATH_BUILD_BOOTLOADER = ${I686_PATH_BUILD}/bootloader.bin

# [ I686_PATH_BUILD_ASM ]

I686_PATH_BUILD_ASM_BOOTLOADER = ${I686_PATH_BUILD_ASM}/bootloader.bin

# [ I686_LINK ]

I686_LINK_PATH = ${I686_PATH_BUILD_C}/*.o

# [ I686_FLAGS_COMPILE ]

I686_FLAGS_COMPILE_ASM = ${FLAGS_COMPILE_ASM}
I686_FLAGS_COMPILE_C = ${FLAGS_COMPILE_C}

# [ I686_FLAGS_INCLUDE ]

I686_FLAGS_INCLUDE_ASM = $(addprefix -I , $(wordlist 1, $(words ${I686_PATHS_INCLUDE_ASM}), ${I686_PATHS_INCLUDE_ASM}))
I686_FLAGS_INCLUDE_C = $(addprefix -I , $(wordlist 1, $(words ${I686_PATHS_INCLUDE_C}), ${I686_PATHS_INCLUDE_C}))

all: i686

clean:
	rm -rf ${PATH_BUILD}

setup:
	set -e
	mkdir -p ${PATH_BUILD}

${I686_PATH_BUILD_INCLUDE}:
	printf "%%define INCLUDE_NUMBER_OF_LATE_SECTORS 0" > ${I686_PATH_BUILD_INCLUDE}

i686-clean:
	rm -rf ${I686_PATH_BUILD}

i686-setup: i686-clean setup
	mkdir ${I686_PATH_BUILD}
	mkdir ${I686_PATH_BUILD_ASM}
	mkdir ${I686_PATH_BUILD_C}

i686-compile-asm:
	nasm ${I686_FLAGS_COMPILE_ASM} ${I686_FLAGS_INCLUDE_ASM} ${PATH_SOURCE_ASM_BOOTLOADER} -o ${I686_PATH_BUILD_ASM_BOOTLOADER}

i686-compile-c:
	$(foreach name, $(patsubst ${PATH_SOURCE_C}/%.c, %, $(wildcard ${PATH_SOURCE_C}/*.c)), \
	i686-elf-gcc -c ${PATH_SOURCE_C}/${name}.c -o ${I686_PATH_BUILD_C}/${name}.o ${I686_FLAGS_COMPILE_C} ${I686_FLAGS_INCLUDE_C};)

i686-compile: i686-compile-asm i686-compile-c

i686-link:
	i686-elf-gcc -T ${PATH_LINKER} ${I686_PATH_BUILD_ASM_BOOTLOADER} $(wildcard ${I686_LINK_PATH}) -o ${I686_PATH_BUILD_BOOTLOADER} ${FLAGS_LINK}

i686-include:
	./include.sh

i686: i686-setup ${I686_PATH_BUILD_INCLUDE} i686-compile i686-link i686-include
	make i686-compile-asm
	make i686-link