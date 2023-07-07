.PHONY: all clean setup i686-clean i686-setup i686-compile-asm i686-compile-c i686-compile i686-link i686-include i686 x86_64-clean x86_64-setup x86_64-compile-asm x86_64-compile-c x86_64-compile x86_64-link x86_64-include x86_64
# [ PATH ]

PATH_SOURCE = src
PATH_BUILD = build

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

# [ I686_FLAGS_COMPILE ]

I686_FLAGS_COMPILE_ASM = -f elf32
I686_FLAGS_COMPILE_C = -O0 -std=gnu99 -ffreestanding -Wall

# [ I686_PATHS_INCLUDE ]

I686_PATHS_INCLUDE_ASM = ${PATHS_INCLUDE_ASM}
I686_PATHS_INCLUDE_C = ${PATHS_INCLUDE_C}

# [ I686_PATH ]

I686_PATH_LINKER = i686.ld

# [ I686_PATH_BUILD ]

I686_PATH_BUILD = ${PATH_BUILD}/i686

I686_PATH_BUILD_ASM = ${I686_PATH_BUILD}/asm
I686_PATH_BUILD_C = ${I686_PATH_BUILD}/c

# [ I686_PATH_BUILD_ASM ]

I686_PATH_BUILD_ASM_BOOTLOADER = ${I686_PATH_BUILD_ASM}/bootloader.bin

# [ I686_LINK ]

I686_LINK_PATH = ${I686_PATH_BUILD_C}/*.o

# [ X86_64_FLAGS_COMPILE ]

X86_64_FLAGS_COMPILE_ASM = -f elf64
X86_64_FLAGS_COMPILE_C = -O0 -std=gnu99 -ffreestanding -Wall

# [ I686_FLAGS_INCLUDE ]

I686_FLAGS_INCLUDE_ASM = $(addprefix -I , $(wordlist 1, $(words ${I686_PATHS_INCLUDE_ASM}), ${I686_PATHS_INCLUDE_ASM}))
I686_FLAGS_INCLUDE_C = $(addprefix -I , $(wordlist 1, $(words ${I686_PATHS_INCLUDE_C}), ${I686_PATHS_INCLUDE_C}))

# [ X86_64_PATHS_INCLUDE ]

X86_64_PATHS_INCLUDE_ASM = ${PATHS_INCLUDE_ASM}
X86_64_PATHS_INCLUDE_C = ${PATHS_INCLUDE_C}

# [ X86_64_PATH ]

X86_64_PATH_LINKER = x86_64.ld

# [ X86_64_PATH_BUILD ]

X86_64_PATH_BUILD = ${PATH_BUILD}/x86_64

X86_64_PATH_BUILD_ASM = ${X86_64_PATH_BUILD}/asm
X86_64_PATH_BUILD_C = ${X86_64_PATH_BUILD}/c

# [ X86_64_PATH_BUILD_ASM ]

X86_64_PATH_BUILD_ASM_BOOTLOADER = ${X86_64_PATH_BUILD_ASM}/bootloader.bin

# [ X86_64_LINK ]

X86_64_LINK_PATH = ${X86_64_PATH_BUILD_C}/*.o

# [ X86_64_FLAGS_INCLUDE ]

X86_64_FLAGS_INCLUDE_ASM = $(addprefix -I , $(wordlist 1, $(words ${X86_64_PATHS_INCLUDE_ASM}), ${X86_64_PATHS_INCLUDE_ASM}))
X86_64_FLAGS_INCLUDE_C = $(addprefix -I , $(wordlist 1, $(words ${X86_64_PATHS_INCLUDE_C}), ${X86_64_PATHS_INCLUDE_C}))

all: i686 x86_64

clean:
	rm -rf ${PATH_BUILD}

setup:
	set -e
	mkdir -p ${PATH_BUILD}

i686-clean:
	rm -rf ${I686_PATH_BUILD}

i686-setup: i686-clean setup
	mkdir ${I686_PATH_BUILD}
	mkdir ${I686_PATH_BUILD_ASM}
	mkdir ${I686_PATH_BUILD_C}

i686-compile-asm:
	$(foreach name, $(patsubst ${PATH_SOURCE_ASM}/%.asm, %, $(wildcard ${PATH_SOURCE_ASM}/*.asm)), \
	nasm ${I686_FLAGS_COMPILE_ASM} ${I686_FLAGS_INCLUDE_ASM} ${PATH_SOURCE_ASM}/${name}.asm -o ${I686_PATH_BUILD_ASM}/${name}.o;)

i686-compile-c:
	$(foreach name, $(patsubst ${PATH_SOURCE_C}/%.c, %, $(wildcard ${PATH_SOURCE_C}/*.c)), \
	i686-elf-gcc -c ${PATH_SOURCE_C}/${name}.c -o ${I686_PATH_BUILD_C}/${name}.o ${I686_FLAGS_COMPILE_C} ${I686_FLAGS_INCLUDE_C};)

i686-compile: i686-compile-asm i686-compile-c

i686-link:
	i686-elf-gcc -T ${I686_PATH_LINKER} $(wildcard ${I686_LINK_PATH}) -o ${I686_PATH_BUILD_BOOTLOADER} ${FLAGS_LINK}

i686-include:
	./include.sh

i686: i686-setup i686-compile i686-link i686-include
	make i686-compile-asm
	make i686-link

x86_64-clean:
	rm -rf ${X86_64_PATH_BUILD}

x86_64-setup: x86_64-clean setup
	mkdir ${X86_64_PATH_BUILD}
	mkdir ${X86_64_PATH_BUILD_ASM}
	mkdir ${X86_64_PATH_BUILD_C}

x86_64-compile-asm:
	$(foreach name, $(patsubst ${PATH_SOURCE_ASM}/%.asm, %, $(wildcard ${PATH_SOURCE_ASM}/*.asm)), \
	nasm ${X86_64_FLAGS_COMPILE_ASM} ${X86_64_FLAGS_INCLUDE_ASM} ${PATH_SOURCE_ASM}/${name}.asm -o ${X86_64_PATH_BUILD_ASM}/${name}.o)

x86_64-compile-c:
	$(foreach name, $(patsubst ${PATH_SOURCE_C}/%.c, %, $(wildcard ${PATH_SOURCE_C}/*.c)), \
	x86_64-elf-gcc -c ${PATH_SOURCE_C}/${name}.c -o ${X86_64_PATH_BUILD_C}/${name}.o ${X86_64_FLAGS_COMPILE_C} ${X86_64_FLAGS_INCLUDE_C};)

x86_64-compile: x86_64-compile-asm x86_64-compile-c

x86_64-link:
	x86_64-elf-gcc -T ${X86_64_PATH_LINKER} $(wildcard ${X86_64_LINK_PATH}) -o ${X86_64_PATH_BUILD_BOOTLOADER} ${FLAGS_LINK}

x86_64-include:
	./include.sh

x86_64: x86_64-setup x86_64-compile x86_64-link x86_64-include
	make x86_64-compile-asm
	make x86_64-link