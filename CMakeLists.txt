cmake_minimum_required(VERSION 3.22)

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