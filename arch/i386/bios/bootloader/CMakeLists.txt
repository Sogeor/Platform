cmake_minimum_required(VERSION 3.22)

project(bios-bootloader
        LANGUAGES ASM_NASM C CXX)

# =================== #
# BUILD CONFIGURATION #
# =================== #

# ::::::::: #
# ASSEMBLER #
# ::::::::: #

set(CMAKE_ASM_FLAGS "-f elf32")

if (PLATFORM_BUILD_DISPLAY_WARNINGS EQUAL OFF)
    string(APPEND CMAKE_ASM_FLAGS " -w") # ???
endif ()

# : #
# C #
# : #

set(CMAKE_C_FLAGS "-std=gnu17 -O0 -ffreestanding -m32")

if (PLATFORM_BUILD_ARCH STREQUAL "i386")
    string(APPEND CMAKE_C_FLAGS " -march=i386")
endif ()

if (PLATFORM_BUILD_ARCH STREQUAL "core2")
    string(APPEND CMAKE_C_FLAGS " -march=core2")
endif ()

if (PLATFORM_BUILD_DISPLAY_WARNINGS EQUAL OFF)
    string(APPEND CMAKE_C_FLAGS " -w")
endif ()

# ::: #
# CPP #
# ::: #

set(CMAKE_CXX_FLAGS "-std=gnu++17 -O0 -ffreestanding -m32")

if (PLATFORM_BUILD_ARCH STREQUAL "i386")
    string(APPEND CMAKE_CXX_FLAGS " -march=i386")
endif ()

if (PLATFORM_BUILD_ARCH STREQUAL "core2")
    string(APPEND CMAKE_CXX_FLAGS " -march=core2")
endif ()

if (PLATFORM_BUILD_DISPLAY_WARNINGS EQUAL OFF)
    string(APPEND CMAKE_CXX_FLAGS " -w")
endif ()

# ::::::::::::: #
# CRUTCH LINKER #
# ::::::::::::: #

set(CRUTCH_LINKER ${CMAKE_CXX_COMPILER})
set(CRUTCH_LINKER_FLAGS "-T" "${CMAKE_CURRENT_SOURCE_DIR}/script.ld" "-nostdlib" "-m32")

if (PLATFORM_BUILD_ARCH STREQUAL "i386")
    list(APPEND CRUTCH_LINKER_FLAGS "-march=i386")
endif ()

if (PLATFORM_BUILD_ARCH STREQUAL "core2")
    list(APPEND CRUTCH_LINKER_FLAGS "-march=core2")
endif ()

if (PLATFORM_BUILD_DISPLAY_WARNINGS EQUAL OFF)
    list(APPEND CRUTCH_LINKER_FLAGS "-w")
endif ()

# ::::::::::::: #
# CRUTCH TARGET #
# ::::::::::::: #

set(CRUTCH_TARGET_FILEPATH "\"${CMAKE_CURRENT_BINARY_DIR}/bios-bootloader.bin\"")

# ::::::::::::: #
# CRUTCH PYTHON #
# ::::::::::::: #

set(CRUTCH_PYTHON_INTERPRETER "python")
set(CRUTCH_PYTHON_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/generate.py")
set(CRUTCH_PYTHON_SCRIPT_BYPRODUCT "${CMAKE_CURRENT_BINARY_DIR}/generated.asm")
set(CRUTCH_PYTHON_SCRIPT_FLAGS ${CRUTCH_TARGET_FILEPATH} ${CRUTCH_PYTHON_SCRIPT_BYPRODUCT})

# ====================== #
# BUILD ALGORITHMIZATION #
# ====================== #

# :::::::::::::::: #
# GENERATED TARGET #
# :::::::::::::::: #

add_custom_target(bios-bootloader-generated
                  COMMAND ${CRUTCH_PYTHON_INTERPRETER} ${CRUTCH_PYTHON_SCRIPT} ${CRUTCH_PYTHON_SCRIPT_FLAGS}
                  BYPRODUCTS ${CRUTCH_PYTHON_SCRIPT_BYPRODUCT})

# ::::::: #
# OBJECTS #
# ::::::: #

add_library(bios-bootloader-objects OBJECT)
add_dependencies(bios-bootloader-objects bios-bootloader-generated)
target_include_directories(bios-bootloader-objects PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

if (PLATFORM_BUILD_DISPLAY_WARNINGS EQUAL OFF)
    target_compile_options(bios-bootloader-objects PRIVATE -w)
endif ()

# :::::: #
# TARGET #
# :::::: #

add_custom_target(bios-bootloader-target ALL
                  COMMAND ${CRUTCH_LINKER} ${CRUTCH_LINKER_FLAGS} -o ${CRUTCH_TARGET_FILEPATH} $<TARGET_OBJECTS:bios-bootloader-objects>
                  DEPENDS bios-bootloader-objects
                  BYPRODUCTS ${CRUTCH_TARGET_FILEPATH})

# =============== #
# BUILD BRANCHING #
# =============== #

add_subdirectory(pm)
add_subdirectory(rm)