cmake_minimum_required(VERSION 3.22)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1.0.0-alpha)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(CMAKE_ASM_COMPILER nasm)
set(CMAKE_C_COMPILER i686-elf-gcc)
set(CMAKE_CXX_COMPILER i686-elf-g++)

project(sogeor-platform)

set(PLATFORM_ARCH "i386"
    CACHE STRING "" FORCE) # deprecated

# ============================ #
# PLATFORM BUILD CONFIGURATION #
# ============================ #

# ::::::::::::::: #
# EXPECTED VALUES #
# ::::::::::::::: #
# i386            #
# core2           #
# ::::::::::::::: #
set(PLATFORM_BUILD_ARCH "i386" CACHE STRING "" FORCE)

# ::::::::::::::: #
# EXPECTED VALUES #
# ::::::::::::::: #
# ON              #
# OFF             #
# ::::::::::::::: #
set(PLATFORM_BUILD_DISPLAY_WARNINGS OFF CACHE BOOL "" FORCE)

add_subdirectory(arch)
#add_subdirectory(hardware)
#add_subdirectory(hdk)
#add_subdirectory(sdk)
#add_subdirectory(software)