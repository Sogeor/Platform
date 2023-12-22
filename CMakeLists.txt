cmake_minimum_required(VERSION 3.22)

project(sogeor-platform)

# CRUTCH_GLOBAL

# CRUTCH_GLOBAL_ARCH

set(ENV{CRUTCH_GLOBAL_ARCH} INTEL64)
set(ENV{CRUTCH_GLOBAL_ARCH_ALIAS} intel64)

# CRUTCH_GLOBAL_EXTENSION

set(CRUTCH_GLOBAL_EXTENSION_BINARY "bin")
set(CRUTCH_GLOBAL_EXTENSION_LINKER_SCRIPT "ld")

add_subdirectory(hardware)
add_subdirectory(hdk)