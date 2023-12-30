cmake_minimum_required(VERSION 3.22)

project(sogeor-platform-hardware-bootloader-bios
        LANGUAGES ASM_NASM C CXX)

set(CMAKE_ASM_COMPILER "nasm")
set(CMAKE_C_COMPILER "i686-elf-gcc")
set(CMAKE_CXX_COMPILER "i686-elf-g++")

set(CMAKE_ASM_FLAGS "-f elf32")
set(CMAKE_C_FLAGS "-O0 -std=gnu11 -ffreestanding") # wtf -std=gnu17 -Wall
set(CMAKE_CXX_FLAGS "-O0 -std=gnu++17 -ffreestanding") # -Wall
set(CMAKE_EXE_LINKER_FLAGS "-T \"${CMAKE_CURRENT_SOURCE_DIR}/sources/${SOGEOR_PLATFORM_TARGET_ARCH}/${SOGEOR_PLATFORM_TARGET_ARCH}.ld\"")
#set(CMAKE_EXE_LINKER_FLAGS "-T \"${CMAKE_CURRENT_SOURCE_DIR}/sources/$CACHE{SOGEOR_PLATFORM_TARGET_ARCH}/$CACHE{SOGEOR_PLATFORM_TARGET_ARCH}.ld\"")

set(INCLUDE_ASM "${CMAKE_BINARY_DIR}/include.asm")

add_executable(sogeor-platform-hardware-bootloader-bios-executable)

set_target_properties(sogeor-platform-hardware-bootloader-bios-executable
                      PROPERTIES
                      OUTPUT_NAME "${SOGEOR_PLATFORM_TARGET_ARCH}"
#                      OUTPUT_NAME "$CACHE{SOGEOR_PLATFORM_TARGET_ARCH}"
                      SUFFIX ".bin")

add_custom_command(TARGET sogeor-platform-hardware-bootloader-bios-executable
                   POST_BUILD
                   COMMAND "printf \"%%define BOOT_SECTORS %s\" (((wc -c < build/i686/asm/bootloader.bin) + 511) / 512) > ${CMAKE_BINARY_DIR}/include.asm"
                   BYPRODUCTS "${CMAKE_BINARY_DIR}/include.asm"
                   WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(sogeor-platform-hardware-bootloader-bios-executable
                           PRIVATE ${CMAKE_BINARY_DIR})

add_subdirectory(sources)