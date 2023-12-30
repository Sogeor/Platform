cmake_minimum_required(VERSION 3.22)

project(i386)

if (PLATFORM_BUILD_BOOT_TYPE STREQUAL "elf32")
    include(cmake/elf32.toolchain.cmake)
elseif (PLATFORM_BUILD_BOOT_TYPE STREQUAL "efi")
    include(cmake/efi.toolchain.cmake)
else ()
    message(FATAL_ERROR "[i386] INVALID <PLATFORM_BUILD_BOOT_TYPE> VALUE ($CACHE{PLATFORM_BUILD_BOOT_TYPE})")
endif ()

add_subdirectory(bios)