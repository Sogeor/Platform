cmake_minimum_required(VERSION 3.22)

if ($CACHE{PLATFORM_ARCH} STREQUAL "i386")
    add_subdirectory(i386)
endif ()