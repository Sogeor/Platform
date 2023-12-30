cmake_minimum_required(VERSION 3.22)

include(ExternalProject)

if ($CACHE{PLATFORM_BUILD_ARCH} STREQUAL "i386")
    ExternalProject_Add(arch-i386
                        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/i386
                        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/i386
                        BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/i386
                        CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_SOURCE_DIR}/cmake/i386.toolchain.cmake")
endif ()