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

build-amd64: build-shared build-amd64-prepare build-intel64-relink

.PHONY: build-intel64

build-intel64: build-shared build-intel64-prepare build-intel64-relink

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

.PHONY: build-shared-generate-include-asm

BUILD_SHARED_GENERATE_INCLUDE_ASM_F = ${F_INCLUDE_ASM}

build-shared-generate-include-asm:
	@echo "[build] [shared] [generate-include-asm] Generating an include file... (${BUILD_SHARED_GENERATE_INCLUDE_ASM_F})"
	@printf "%%define NUMBER_OF_SECTORS 0" > ${BUILD_SHARED_GENERATE_INCLUDE_ASM_F}

.PHONY: build-shared-compile-asm

BUILD_SHARED_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.asm, %, $(shell find ${P_INCLUDE_SHARED} -name *.asm -type f))

BUILD_SHARED_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.asm
BUILD_SHARED_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.bin

build-shared-compile-asm: build-shared-generate-include-asm
	@for filename in ${BUILD_SHARED_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [shared] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_SHARED_COMPILE_ASM_LIST_FLAG} ${BUILD_SHARED_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-shared-compile-c

BUILD_SHARED_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.c, %, $(shell find ${P_INCLUDE_SHARED} -name *.c -type f))

BUILD_SHARED_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.c
BUILD_SHARED_COMPILE_C_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.o

build-shared-compile-c:
	@for filename in ${BUILD_SHARED_COMPILE_C_LIST_F} ; do \
		echo "[build] [shared] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_SHARED_COMPILE_C_LIST_FLAG} -c ${BUILD_SHARED_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-shared-compile-cpp

BUILD_SHARED_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_SHARED}/%.cpp, %, $(shell find ${P_INCLUDE_SHARED} -name *.cpp -type f))

BUILD_SHARED_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED}

BUILD_SHARED_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_SHARED}/$${filename}.cpp
BUILD_SHARED_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_SHARED}/$${filename}.o

build-shared-compile-cpp:
	@for filename in ${BUILD_SHARED_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [shared] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_SHARED_COMPILE_CPP_LIST_FLAG} -c ${BUILD_SHARED_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_SHARED_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-shared-regenerate-include-asm

BUILD_SHARED_REGENERATE_INCLUDE_ASM_BUILD_F = ${F_BUILD_INTEL64}

BUILD_SHARED_REGENERATE_INCLUDE_ASM_F = ${BUILD_SHARED_GENERATE_INCLUDE_ASM_F}

build-shared-regenerate-include-asm:
	@echo "[build] [shared] [regenerate-include-asm] Regenerating an include file... (${BUILD_SHARED_REGENERATE_INCLUDE_ASM_F})"
	@printf "%%define NUMBER_OF_SECTORS %s" $(shell expr $(shell expr $(shell wc -c < ${BUILD_SHARED_REGENERATE_INCLUDE_ASM_BUILD_F}) + 511) / 512) > ${BUILD_INTEL64_REGENERATE_INCLUDE_ASM_F}

.PHONY: build-shared-recompile-asm

BUILD_SHARED_RECOMPILE_ASM_LIST_F = ${BUILD_SHARED_COMPILE_ASM_LIST_F}

BUILD_SHARED_RECOMPILE_ASM_LIST_FLAG = ${BUILD_SHARED_COMPILE_ASM_LIST_FLAG}

BUILD_SHARED_RECOMPILE_ASM_PATTERN_SOURCE = ${BUILD_SHARED_COMPILE_ASM_PATTERN_SOURCE}
BUILD_SHARED_RECOMPILE_ASM_PATTERN_BUILD = ${BUILD_SHARED_COMPILE_ASM_PATTERN_BUILD}

build-shared-recompile-asm: build-shared-regenerate-include-asm
	@for filename in ${BUILD_SHARED_RECOMPILE_ASM_LIST_F} ; do \
		echo "[build] [shared] [recompile-asm] Recompiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_SHARED_RECOMPILE_ASM_LIST_FLAG} ${BUILD_SHARED_RECOMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_SHARED_RECOMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-generate-include-asm

BUILD_AMD64_GENERATE_INCLUDE_ASM_F = ${F_INCLUDE_ASM}

build-amd64-generate-include-asm:
	@echo "[build] [amd64] [generate-include-asm] Generating an include file... (${BUILD_AMD64_GENERATE_INCLUDE_ASM_F})"

.PHONY: build-amd64-compile-asm

BUILD_AMD64_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.asm, %, $(shell find ${P_INCLUDE_AMD64} -name *.asm -type f))

BUILD_AMD64_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_AMD64} -I ${P_BUILD_AMD64}

BUILD_AMD64_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.asm
BUILD_AMD64_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.bin

build-amd64-compile-asm: build-amd64-generate-include-asm build-shared-compile-asm
	@for filename in ${BUILD_AMD64_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [amd64] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_AMD64_COMPILE_ASM_LIST_FLAG} ${BUILD_AMD64_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-compile-c

BUILD_AMD64_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.c, %, $(shell find ${P_INCLUDE_AMD64} -name *.c -type f))

BUILD_AMD64_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED} -I ${P_INCLUDE_AMD64} -I ${P_BUILD_AMD64}

BUILD_AMD64_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.c
BUILD_AMD64_COMPILE_C_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.o

build-amd64-compile-c: build-shared-compile-c
	@for filename in ${BUILD_AMD64_COMPILE_C_LIST_F} ; do \
		echo "[build] [amd64] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_AMD64_COMPILE_C_LIST_FLAG} -c ${BUILD_AMD64_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-compile-cpp

BUILD_AMD64_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_AMD64}/%.cpp, %, $(shell find ${P_INCLUDE_AMD64} -name *.cpp -type f))

BUILD_AMD64_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_AMD64}

BUILD_AMD64_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_AMD64}/$${filename}.cpp
BUILD_AMD64_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_AMD64}/$${filename}.o

build-amd64-compile-cpp: build-shared-compile-cpp
	@for filename in ${BUILD_AMD64_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [amd64] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_AMD64_COMPILE_CPP_LIST_FLAG} -c ${BUILD_AMD64_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_AMD64_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-link

BUILD_AMD64_LINK_LIST_F = $(shell find ${P_BUILD_SHARED} -name *.bin -type f) $(shell find ${P_BUILD_AMD64} -name *.bin -type f) $(shell find ${P_BUILD_SHARED} -name *.o -type f) $(shell find ${P_BUILD_AMD64} -name *.o -type f)

BUILD_AMD64_LINK_LIST_FLAG = -T ${F_LINK_SCRIPT_AMD64} -nostdlib

BUILD_AMD64_LINK_F = ${F_BUILD_AMD64}

build-amd64-link: build-amd64-compile-asm build-amd64-compile-c build-amd64-compile-cpp
	@echo "[build] [amd64] [link] Linking into an amd64 build file... (${BUILD_AMD64_LINK_F})"
	@i686-elf-ld ${BUILD_AMD64_LINK_LIST_FLAG} ${BUILD_AMD64_LINK_LIST_F} -o ${BUILD_AMD64_LINK_F}

.PHONY: build-amd64-regenerate-include-asm

BUILD_AMD64_REGENERATE_INCLUDE_ASM_F = ${BUILD_AMD64_GENERATE_INCLUDE_ASM_F}

build-amd64-regenerate-include-asm:
	@echo "[build] [amd64] [regenerate-include-asm] Regenerating an include file... (${BUILD_AMD64_REGENERATE_INCLUDE_ASM_F})"

.PHONY: build-amd64-recompile-asm

BUILD_AMD64_RECOMPILE_ASM_LIST_F = ${BUILD_AMD64_COMPILE_ASM_LIST_F}

BUILD_AMD64_RECOMPILE_ASM_LIST_FLAG = ${BUILD_AMD64_COMPILE_ASM_LIST_FLAG} -I ${P_BUILD_SHARED} -I ${P_BUILD_AMD64}

BUILD_AMD64_RECOMPILE_ASM_PATTERN_SOURCE = ${BUILD_AMD64_COMPILE_ASM_PATTERN_SOURCE}
BUILD_AMD64_RECOMPILE_ASM_PATTERN_BUILD = ${BUILD_AMD64_COMPILE_ASM_PATTERN_BUILD}

build-amd64-recompile-asm: build-amd64-regenerate-include-asm build-shared-recompile-asm
	@for filename in ${BUILD_AMD64_RECOMPILE_ASM_LIST_F} ; do \
		echo "[build] [amd64] [recompile-asm] Recompiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_AMD64_RECOMPILE_ASM_LIST_FLAG} ${BUILD_AMD64_RECOMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_AMD64_RECOMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-amd64-relink

BUILD_AMD64_RELINK_LIST_F = ${BUILD_AMD64_LINK_LIST_F}

BUILD_AMD64_RELINK_LIST_FLAG = ${BUILD_AMD64_LINK_LIST_FLAG}

BUILD_AMD64_RELINK_F = ${BUILD_AMD64_LINK_F}

build-amd64-relink: build-amd64-link build-shared-recompile-asm build-amd64-recompile-asm
	@echo "[build] [amd64] [relink] Relinking into an amd64 build file... (${BUILD_AMD64_RELINK_F})"
	@i686-elf-ld ${BUILD_AMD64_RELINK_LIST_FLAG} ${BUILD_AMD64_RELINK_LIST_F} -o ${BUILD_AMD64_RELINK_F}

.PHONY: build-intel64-generate-include-asm

BUILD_INTEL64_GENERATE_INCLUDE_ASM_F = ${F_INCLUDE_ASM}

build-intel64-generate-include-asm:
	@echo "[build] [intel64] [generate-include-asm] Generating an include file... (${BUILD_INTEL64_GENERATE_INCLUDE_ASM_F})"

.PHONY: build-intel64-compile-asm

BUILD_INTEL64_COMPILE_ASM_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.asm, %, $(shell find ${P_INCLUDE_INTEL64} -name *.asm -type f))

BUILD_INTEL64_COMPILE_ASM_LIST_FLAG = -f elf32 -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_INTEL64} -I ${P_BUILD_INTEL64}

BUILD_INTEL64_COMPILE_ASM_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.asm
BUILD_INTEL64_COMPILE_ASM_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.bin

build-intel64-compile-asm: build-intel64-generate-include-asm build-shared-compile-asm
	@for filename in ${BUILD_INTEL64_COMPILE_ASM_LIST_F} ; do \
		echo "[build] [intel64] [compile-asm] Compiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_INTEL64_COMPILE_ASM_LIST_FLAG} ${BUILD_INTEL64_COMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-compile-c

BUILD_INTEL64_COMPILE_C_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.c, %, $(shell find ${P_INCLUDE_INTEL64} -name *.c -type f))

BUILD_INTEL64_COMPILE_C_LIST_FLAG = -O0 -std=gnu17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_BUILD_SHARED} -I ${P_INCLUDE_INTEL64} -I ${P_BUILD_INTEL64}

BUILD_INTEL64_COMPILE_C_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.c
BUILD_INTEL64_COMPILE_C_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.o

build-intel64-compile-c: build-shared-compile-c
	@for filename in ${BUILD_INTEL64_COMPILE_C_LIST_F} ; do \
		echo "[build] [intel64] [compile-c] Compiling $${filename}.c into $${filename}.o..." ; \
		i686-elf-gcc ${BUILD_INTEL64_COMPILE_C_LIST_FLAG} -c ${BUILD_INTEL64_COMPILE_C_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_C_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-compile-cpp

BUILD_INTEL64_COMPILE_CPP_LIST_F = $(patsubst ${P_INCLUDE_INTEL64}/%.cpp, %, $(shell find ${P_INCLUDE_INTEL64} -name *.cpp -type f))

BUILD_INTEL64_COMPILE_CPP_LIST_FLAG = -O0 -std=gnu++17 -ffreestanding -Wall -I ${P_INCLUDE_SHARED} -I ${P_INCLUDE_INTEL64}

BUILD_INTEL64_COMPILE_CPP_PATTERN_SOURCE = ${P_INCLUDE_INTEL64}/$${filename}.cpp
BUILD_INTEL64_COMPILE_CPP_PATTERN_BUILD = ${P_BUILD_INTEL64}/$${filename}.o

build-intel64-compile-cpp: build-shared-compile-cpp
	@for filename in ${BUILD_INTEL64_COMPILE_CPP_LIST_F} ; do \
		echo "[build] [intel64] [compile-cpp] Compiling $${filename}.cpp into $${filename}.o..." ; \
		i686-elf-g++ ${BUILD_INTEL64_COMPILE_CPP_LIST_FLAG} -c ${BUILD_INTEL64_COMPILE_CPP_PATTERN_SOURCE} -o ${BUILD_INTEL64_COMPILE_CPP_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-link

BUILD_INTEL64_LINK_LIST_F = $(shell find ${P_BUILD_SHARED} -name *.bin -type f) $(shell find ${P_BUILD_INTEL64} -name *.bin -type f) $(shell find ${P_BUILD_SHARED} -name *.o -type f) $(shell find ${P_BUILD_INTEL64} -name *.o -type f)

BUILD_INTEL64_LINK_LIST_FLAG = -T ${F_LINK_SCRIPT_INTEL64} -nostdlib

BUILD_INTEL64_LINK_F = ${F_BUILD_INTEL64}

build-intel64-link: build-intel64-compile-asm build-intel64-compile-c build-intel64-compile-cpp
	@echo "[build] [intel64] [link] Linking into an intel64 build file... (${BUILD_INTEL64_LINK_F})"
	@i686-elf-ld ${BUILD_INTEL64_LINK_LIST_FLAG} ${BUILD_INTEL64_LINK_LIST_F} -o ${BUILD_INTEL64_LINK_F}

.PHONY: build-intel64-regenerate-include-asm

BUILD_INTEL64_REGENERATE_INCLUDE_ASM_F = ${BUILD_INTEL64_GENERATE_INCLUDE_ASM_F}

build-intel64-regenerate-include-asm:
	@echo "[build] [intel64] [regenerate-include-asm] Regenerating an include file... (${BUILD_INTEL64_REGENERATE_INCLUDE_ASM_F})"

.PHONY: build-intel64-recompile-asm

BUILD_INTEL64_RECOMPILE_ASM_LIST_F = ${BUILD_INTEL64_COMPILE_ASM_LIST_F}

BUILD_INTEL64_RECOMPILE_ASM_LIST_FLAG = ${BUILD_INTEL64_COMPILE_ASM_LIST_FLAG} -I ${P_BUILD_SHARED} -I ${P_BUILD_INTEL64}

BUILD_INTEL64_RECOMPILE_ASM_PATTERN_SOURCE = ${BUILD_INTEL64_COMPILE_ASM_PATTERN_SOURCE}
BUILD_INTEL64_RECOMPILE_ASM_PATTERN_BUILD = ${BUILD_INTEL64_COMPILE_ASM_PATTERN_BUILD}

build-intel64-recompile-asm: build-intel64-regenerate-include-asm build-shared-recompile-asm
	@for filename in ${BUILD_INTEL64_RECOMPILE_ASM_LIST_F} ; do \
		echo "[build] [intel64] [recompile-asm] Recompiling $${filename}.asm into $${filename}.bin..." ; \
		nasm ${BUILD_INTEL64_RECOMPILE_ASM_LIST_FLAG} ${BUILD_INTEL64_RECOMPILE_ASM_PATTERN_SOURCE} -o ${BUILD_INTEL64_RECOMPILE_ASM_PATTERN_BUILD} ; \
	done

.PHONY: build-intel64-relink

BUILD_INTEL64_RELINK_LIST_F = ${BUILD_INTEL64_LINK_LIST_F}

BUILD_INTEL64_RELINK_LIST_FLAG = ${BUILD_INTEL64_LINK_LIST_FLAG}

BUILD_INTEL64_RELINK_F = ${BUILD_INTEL64_LINK_F}

build-intel64-relink: build-intel64-link build-shared-recompile-asm build-intel64-recompile-asm
	@echo "[build] [intel64] [relink] Relinking into an intel64 build file... (${BUILD_INTEL64_RELINK_F})"
	@i686-elf-ld ${BUILD_INTEL64_RELINK_LIST_FLAG} ${BUILD_INTEL64_RELINK_LIST_F} -o ${BUILD_INTEL64_RELINK_F}