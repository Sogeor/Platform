cmake_minimum_required(VERSION 3.22)

set(SOGEOR_PLATFORM_TARGET_ARCH "intel64"
    CACHE STRING "" FORCE)

project(sogeor-platform)

add_subdirectory(hardware)
add_subdirectory(hdk)
#add_subdirectory(sdk)
#add_subdirectory(software)