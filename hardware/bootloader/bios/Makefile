# GLOBAL VARIABLES

PATH_ROOT = .
PATH_SOURCES = ${PATH_ROOT}/sources
PATH_BUILD = ${PATH_ROOT}/build

# GLOBAL TARGETS

.PHONY: all clean

all: intel64

clean:
	@echo "[clean] Removing a build directory... (${PATH_BUILD})"
	@rm -rf ${PATH_BUILD}

# SHARED VARIABLES

SHARED_TOOL_COMPILE_ASM = nasm
SHARED_TOOL_COMPILE_C = i686-elf-gcc
SHARED_TOOL_COMPILE_CPP = i686-elf-g++
SHARED_TOOL_LINK = i686-elf-ld

SHARED_PATH_SOURCES = ${PATH_SOURCES}/shared
SHARED_PATH_BUILD = ${PATH_BUILD}/shared

SHARED_FLAGS_COMPILE_ASM = -f elf32 -I ${SHARED_PATH_BUILD} -I ${SHARED_PATH_SOURCES}
SHARED_FLAGS_COMPILE_C = -O0 -std=gnu17 -ffreestanding -Wall -I ${SHARED_PATH_BUILD} -I ${SHARED_PATH_SOURCES}
SHARED_FLAGS_COMPILE_CPP = -O0 -std=gnu++17 -ffreestanding -Wall -I ${SHARED_PATH_BUILD} -I ${SHARED_PATH_SOURCES}

SHARED_OBJECTS_ASM = $(patsubst ${SHARED_PATH_SOURCES}/%.asm, ${SHARED_PATH_BUILD}/%.bin, $(shell find ${SHARED_PATH_SOURCES} -name "*.asm"))
SHARED_OBJECTS_C = $(patsubst ${SHARED_PATH_SOURCES}/%.c, ${SHARED_PATH_BUILD}/%.o, $(shell find ${SHARED_PATH_SOURCES} -name "*.c"))
SHARED_OBJECTS_CPP = $(patsubst ${SHARED_PATH_SOURCES}/%.cpp, ${SHARED_PATH_BUILD}/%.obj, $(shell find ${SHARED_PATH_SOURCES} -name "*.cpp"))

# SHARED TARGETS

.PHONY: shared-clean shared-prepare

shared-clean:
	@echo "[shared] [clean] Removing an shared build directory... (${SHARED_PATH_BUILD})"
	@rm -rf ${SHARED_PATH_BUILD}

shared-prepare:
	@echo "[shared] [prepare] Creating an shared build directory... (${SHARED_PATH_BUILD})"
	@mkdir -p ${SHARED_PATH_BUILD}

${SHARED_PATH_BUILD}/%.bin: ${SHARED_PATH_SOURCES}/%.asm
	@echo "[shared] [compile] [asm] Compiling $^ into $@..."
	@${SHARED_TOOL_COMPILE_ASM} ${SHARED_FLAGS_COMPILE_ASM} $^ -o $@

${SHARED_PATH_BUILD}/%.o: ${SHARED_PATH_SOURCES}/%.c
	@echo "[shared] [compile] [c] Compiling $^ into $@..."
	@${SHARED_TOOL_COMPILE_C} ${SHARED_FLAGS_COMPILE_C} -c $^ -o $@

${SHARED_PATH_BUILD}/%.obj: ${SHARED_PATH_SOURCES}/%.cpp
	@echo "[shared] [compile] [cpp] Compiling $^ into $@..."
	@${SHARED_TOOL_COMPILE_CPP} ${SHARED_FLAGS_COMPILE_CPP} -c $^ -o $@

# INTEL64 VARIABLES

INTEL64_TOOL_COMPILE_ASM = nasm
INTEL64_TOOL_COMPILE_C = i686-elf-gcc
INTEL64_TOOL_COMPILE_CPP = i686-elf-g++
INTEL64_TOOL_LINK = i686-elf-ld

INTEL64_PATH_SOURCES = ${PATH_SOURCES}/intel64
INTEL64_PATH_BUILD = ${PATH_BUILD}/intel64

INTEL64_INCLUDE_ASM = ${SHARED_PATH_BUILD}/include.asm

INTEL64_SCRIPT_LINK = ${INTEL64_PATH_SOURCES}/linker.ld

INTEL64_OUTPUT_LINK = ${PATH_BUILD}/intel64.bin

INTEL64_FLAGS_COMPILE_ASM = -f elf32 -I ${INTEL64_PATH_BUILD} -I ${SHARED_PATH_BUILD} -I ${INTEL64_PATH_SOURCES} -I ${SHARED_PATH_SOURCES}
INTEL64_FLAGS_COMPILE_C = -O0 -std=gnu17 -ffreestanding -Wall -I ${INTEL64_PATH_BUILD} -I ${SHARED_PATH_BUILD} -I ${INTEL64_PATH_SOURCES} -I ${SHARED_PATH_SOURCES}
INTEL64_FLAGS_COMPILE_CPP = -O0 -std=gnu++17 -ffreestanding -Wall -I ${INTEL64_PATH_BUILD} -I ${SHARED_PATH_BUILD} -I ${INTEL64_PATH_SOURCES} -I ${SHARED_PATH_SOURCES}
INTEL64_FLAGS_LINK = -T ${INTEL64_SCRIPT_LINK} -nostdlib

INTEL64_OBJECTS_ASM = $(patsubst ${INTEL64_PATH_SOURCES}/%.asm, ${INTEL64_PATH_BUILD}/%.bin, $(shell find ${INTEL64_PATH_SOURCES} -name "*.asm"))
INTEL64_OBJECTS_C = $(patsubst ${INTEL64_PATH_SOURCES}/%.c, ${INTEL64_PATH_BUILD}/%.o, $(shell find ${INTEL64_PATH_SOURCES} -name "*.c"))
INTEL64_OBJECTS_CPP = $(patsubst ${INTEL64_PATH_SOURCES}/%.cpp, ${INTEL64_PATH_BUILD}/%.obj, $(shell find ${INTEL64_PATH_SOURCES} -name "*.cpp"))

# INTEL64 TARGETS

.PHONY: intel64 intel64-clean intel64-prepare intel64-generate-include-asm intel64-link

intel64: intel64-clean intel64-prepare intel64-generate-include-asm intel64-link

intel64-clean: shared-clean
	@echo "[intel64] [clean] Removing an intel64 build directory... (${INTEL64_PATH_BUILD})"
	@rm -rf ${INTEL64_PATH_BUILD}

intel64-prepare: shared-prepare
	@echo "[intel64] [prepare] Creating an intel64 build directory... (${INTEL64_PATH_BUILD})"
	@mkdir -p ${INTEL64_PATH_BUILD}

intel64-generate-include-asm:
	@echo "[intel64] [generate] [include] [asm] Generating an asm include file... (${INTEL64_INCLUDE_ASM})"
	@printf "%%define NUMBER_OF_SECTORS %s" $(shell expr $(shell expr $(shell wc -c < ${INTEL64_OUTPUT_LINK}) + 511) / 512) > ${INTEL64_INCLUDE_ASM}

intel64-link: $(SHARED_OBJECTS_ASM) $(SHARED_OBJECTS_C) $(SHARED_OBJECTS_CPP) $(INTEL64_OBJECTS_ASM) $(INTEL64_OBJECTS_C) $(INTEL64_OBJECTS_CPP)
	@echo "[intel64] [link] Linking into an intel64 build file... (${INTEL64_OUTPUT_LINK})"
	@${INTEL64_TOOL_LINK} ${INTEL64_FLAGS_LINK} -o ${INTEL64_OUTPUT_LINK} $^

${INTEL64_PATH_BUILD}/%.bin: ${INTEL64_PATH_SOURCES}/%.asm
	@echo "[intel64] [compile] [asm] Compiling $^ into $@..."
	@${INTEL64_TOOL_COMPILE_ASM} ${INTEL64_FLAGS_COMPILE_ASM} $^ -o $@

${INTEL64_PATH_BUILD}/%.o: ${INTEL64_PATH_SOURCES}/%.c
	@echo "[intel64] [compile] [c] Compiling $^ into $@..."
	@${INTEL64_TOOL_COMPILE_C} ${INTEL64_FLAGS_COMPILE_C} -c $^ -o $@

${INTEL64_PATH_BUILD}/%.obj: ${INTEL64_PATH_SOURCES}/%.cpp
	@echo "[intel64] [compile] [cpp] Compiling $^ into $@..."
	@${INTEL64_TOOL_COMPILE_CPP} ${INTEL64_FLAGS_COMPILE_CPP} -c $^ -o $@