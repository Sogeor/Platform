# constants

P_ROOT = $(CURDIR)

P_BUILD = ${P_ROOT}/build

P_BUILD_SHARED = ${P_BUILD}/shared

P_BUILD_AMD64 = ${P_BUILD}/amd64

P_BUILD_INTEL64 = ${P_BUILD}/intel64

F_BUILD_AMD64 = ${P_BUILD}/amd64.bin

F_BUILD_INTEL64 = ${P_BUILD}/intel64.bin

P_INCLUDE = ${P_ROOT}/include

P_INCLUDE_SHARED = ${P_INCLUDE}/shared

P_INCLUDE_AMD64 = ${P_INCLUDE}/amd64

P_INCLUDE_INTEL64 = ${P_INCLUDE}/intel64

F_INCLUDE_ASM = ${P_BUILD_SHARED}/include.asm

F_LINK_SCRIPT_AMD64 = ${P_INCLUDE_AMD64}/amd64.ld

F_LINK_SCRIPT_INTEL64 = ${P_INCLUDE_INTEL64}/intel64.ld

# targets

.PHONY: all

all: build-amd64 build-intel64

.PHONY: clean

clean:
	@echo "[clean] Removing a build directory... (${P_BUILD})"
	@rm -rf ${P_BUILD}

.PHONY: clean-shared

clean-shared:
	@echo "[clean] [shared] Removing a shared build directory... (${P_BUILD_SHARED})"
	@rm -rf ${P_BUILD_SHARED}

.PHONY: clean-amd64

clean-amd64:
	@echo "[clean] [amd64] Removing an amd64 build directory... (${P_BUILD_AMD64})"
	@rm -rf ${P_BUILD_AMD64}

.PHONY: clean-intel64

clean-intel64:
	@echo "[clean] [intel64] Removing an intel64 build directory... (${P_BUILD_INTEL64})"
	@rm -rf ${P_BUILD_INTEL64}

.PHONY: build-shared

build-shared: build-shared-prepare build-shared-compile-asm build-shared-compile-c build-shared-compile-cpp

.PHONY: build-amd64

build-amd64: build-shared build-amd64-prepare

.PHONY: build-intel64

build-intel64: build-shared build-intel64-prepare build-intel64-link

.PHONY: build-shared-prepare

build-shared-prepare: clean-shared
	@echo "[build] [shared] [prepare] Creating a shared build directory... (${P_BUILD_SHARED})"
	@mkdir -p ${P_BUILD_SHARED}

.PHONY: build-amd64-prepare

build-amd64-prepare: clean-amd64
	@echo "[build] [amd64] [prepare] Creating an amd64 build directory... (${P_BUILD_AMD64})"
	@mkdir -p ${P_BUILD_AMD64}

.PHONY: build-intel64-prepare

build-intel64-prepare: clean-intel64
	@echo "[build] [intel64] [prepare] Creating an intel64 build directory... (${P_BUILD_INTEL64})"
	@mkdir -p ${P_BUILD_INTEL64}

.PHONY: build-shared-compile-asm

BUILD_SHARED_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.asm, %, $(wildcard ${P_INCLUDE_SHARED}/*.asm))

BUILD_SHARED_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.asm
BUILD_SHARED_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.bin

build-shared-compile-asm:
	@for filename in ${BUILD_SHARED_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [shared] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_SHARED_COMPILE_ASM_LIST_FLAG} ${BUILD_SHARED_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-shared-compile-c

BUILD_SHARED_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.c, %, $(wildcard ${P_INCLUDE_SHARED}/*.c))

BUILD_SHARED_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.c
BUILD_SHARED_COMPILE_C_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.o

build-shared-compile-c:
	@for filename in ${BUILD_SHARED_COMPILE_C_LIST_F} ; do \
		echo "[build] [shared] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_SHARED_COMPILE_C_LIST_FLAG} -c ${BUILD_SHARED_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-shared-compile-cpp

BUILD_SHARED_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.cpp, %, $(wildcard ${P_INCLUDE_SHARED}/*.cpp))

BUILD_SHARED_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.cpp
BUILD_SHARED_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.o

build-shared-compile-cpp:
	@for filename in ${BUILD_SHARED_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [shared] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_SHARED_COMPILE_CPP_LIST_FLAG} -c ${BUILD_SHARED_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-compile-asm

BUILD_AMD64_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.asm, %, $(wildcard ${P_INCLUDE_AMD64}/*.asm))

BUILD_AMD64_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_AMD64} -I ${P_BUILD_AMD64}

BUILD_AMD64_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.asm
BUILD_AMD64_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.bin

build-amd64-compile-asm: build-shared-compile-asm
	@for filename in ${BUILD_AMD64_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [amd64] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_AMD64_COMPILE_ASM_LIST_FLAG} ${BUILD_AMD64_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-compile-c

BUILD_AMD64_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.c, %, $(wildcard ${P_INCLUDE_AMD64}/*.c))

BUILD_AMD64_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED} -I ${P_INCLUDE_AMD64} -I ${P_BUILD_AMD64}

BUILD_AMD64_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.c
BUILD_AMD64_COMPILE_C_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.o

build-amd64-compile-c: build-shared-compile-c
	@for filename in ${BUILD_AMD64_COMPILE_C_LIST_F} ; do \
		echo "[build] [amd64] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_AMD64_COMPILE_C_LIST_FLAG} -c ${BUILD_AMD64_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-compile-cpp

BUILD_AMD64_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.cpp, %, $(wildcard ${P_INCLUDE_AMD64}/*.cpp))

BUILD_AMD64_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_AMD64}

BUILD_AMD64_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.cpp
BUILD_AMD64_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.o

build-amd64-compile-cpp: build-shared-compile-cpp
	@for filename in ${BUILD_AMD64_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [amd64] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_AMD64_COMPILE_CPP_LIST_FLAG} -c ${BUILD_AMD64_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-link

BUILD_AMD64_LINK_LIST_F = $(wildcard ${P_BUILD_SHARED}/*.bin) $(wildcard ${P_BUILD_AMD64}/*.bin) $(wildcard ${P_BUILD_SHARED}/*.o) $(wildcard ${P_BUILD_AMD64}/*.o)

BUILD_AMD64_LINK_LIST_FLAG = -T ${F_LINK_SCRIPT_AMD64} -nostdlib

BUILD_AMD64_LINK_F = ${F_BUILD_AMD64}

build-amd64-link: build-amd64-compile-asm build-amd64-compile-c build-amd64-compile-cpp
	@echo "[build] [amd64] [link] Linking into an amd64 build file... (${BUILD_AMD64_LINK_F})"
	@i686-elf-ld ${BUILD_AMD64_LINK_LIST_FLAG} ${BUILD_AMD64_LINK_LIST_F} -o ${BUILD_AMD64_LINK_F}

.PHONY: build-intel64-compile-asm

BUILD_INTEL64_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.asm, %, $(wildcard ${P_INCLUDE_INTEL64}/*.asm))

BUILD_INTEL64_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_INTEL64} -I ${P_BUILD_INTEL64}

BUILD_INTEL64_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.asm
BUILD_INTEL64_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.bin

build-intel64-compile-asm: build-shared-compile-asm
	@for filename in ${BUILD_INTEL64_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [intel64] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_INTEL64_COMPILE_ASM_LIST_FLAG} ${BUILD_INTEL64_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-compile-c

BUILD_INTEL64_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.c, %, $(wildcard ${P_INCLUDE_INTEL64}/*.c))

BUILD_INTEL64_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED} -I ${P_INCLUDE_INTEL64} -I ${P_BUILD_INTEL64}

BUILD_INTEL64_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.c
BUILD_INTEL64_COMPILE_C_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.o

build-intel64-compile-c: build-shared-compile-c
	@for filename in ${BUILD_INTEL64_COMPILE_C_LIST_F} ; do \
		echo "[build] [intel64] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_INTEL64_COMPILE_C_LIST_FLAG} -c ${BUILD_INTEL64_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-compile-cpp

BUILD_INTEL64_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.cpp, %, $(wildcard ${P_INCLUDE_INTEL64}/*.cpp))

BUILD_INTEL64_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_INTEL64}

BUILD_INTEL64_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.cpp
BUILD_INTEL64_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.o

build-intel64-compile-cpp: build-shared-compile-cpp
	@for filename in ${BUILD_INTEL64_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [intel64] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_INTEL64_COMPILE_CPP_LIST_FLAG} -c ${BUILD_INTEL64_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-link

BUILD_INTEL64_LINK_LIST_F = $(wildcard ${P_BUILD_SHARED}/*.bin) $(wildcard ${P_BUILD_INTEL64}/*.bin) $(wildcard ${P_BUILD_SHARED}/*.o) $(wildcard ${P_BUILD_INTEL64}/*.o)

BUILD_INTEL64_LINK_LIST_FLAG = -T ${F_LINK_SCRIPT_INTEL64} -nostdlib

BUILD_INTEL64_LINK_F = ${F_BUILD_INTEL64}

build-intel64-link: build-intel64-compile-asm build-intel64-compile-c build-intel64-compile-cpp
	@echo "[build] [intel64] [link] Linking into an intel64 build file... (${BUILD_INTEL64_LINK_F})"
	@i686-elf-ld ${BUILD_INTEL64_LINK_LIST_FLAG} ${BUILD_INTEL64_LINK_LIST_F} -o ${BUILD_INTEL64_LINK_F}