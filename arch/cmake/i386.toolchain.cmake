cmake_minimum_required(VERSION 3.22)

include(../../cmake/configure.cmake)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i386)

find_program(PLATFORM_ARCH_I386_ASM_COMPILER NAMES i686-elf-as)
if (PLATFORM_ARCH_I386_ASM_COMPILER)
    message(STATUS "<PLATFORM_ARCH_I386_ASM_COMPILER> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_ASM_COMPILER})")
    set(CMAKE_ASM_COMPILER ${PLATFORM_ARCH_I386_ASM_COMPILER})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_ASM_COMPILER> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_C_COMPILER NAMES i686-elf-gcc)
if (PLATFORM_ARCH_I386_C_COMPILER)
    message(STATUS "<PLATFORM_ARCH_I386_C_COMPILER> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_C_COMPILER})")
    set(CMAKE_C_COMPILER ${PLATFORM_ARCH_I386_C_COMPILER})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_C_COMPILER> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_CXX_COMPILER NAMES i686-elf-g++)
if (PLATFORM_ARCH_I386_CXX_COMPILER)
    message(STATUS "<PLATFORM_ARCH_I386_CXX_COMPILER> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_CXX_COMPILER})")
    set(CMAKE_CXX_COMPILER ${PLATFORM_ARCH_I386_CXX_COMPILER})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_CXX_COMPILER> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_LINKER NAMES i686-elf-ld)
if (PLATFORM_ARCH_I386_LINKER)
    message(STATUS "<PLATFORM_ARCH_I386_LINKER> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_LINKER})")
    set(CMAKE_LINKER ${PLATFORM_ARCH_I386_LINKER})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_LINKER> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_ARHIVING_TOOL NAMES i686-elf-ar)
if (PLATFORM_ARCH_I386_ARHIVING_TOOL)
    message(STATUS "<PLATFORM_ARCH_I386_ARHIVING_TOOL> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_ARHIVING_TOOL})")
    set(CMAKE_AR ${PLATFORM_ARCH_I386_ARHIVING_TOOL})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_ARHIVING_TOOL> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_RANDOMAZING_TOOL NAMES i686-elf-ranlib)
if (PLATFORM_ARCH_I386_RANDOMAZING_TOOL)
    message(STATUS "<PLATFORM_ARCH_I386_RANDOMAZING_TOOL> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_RANDOMAZING_TOOL})")
    set(CMAKE_RANLIB ${PLATFORM_ARCH_I386_RANDOMAZING_TOOL})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_RANDOMAZING_TOOL> PROGRAM")
endif ()

find_program(PLATFORM_ARCH_I386_PYTHON_INTERPRETER NAMES python)
if (PLATFORM_ARCH_I386_PYTHON_INTERPRETER)
    message(STATUS "<PLATFORM_ARCH_I386_PYTHON_INTERPRETER> PROGRAM SUCCESSFULLY FOUNDED (${PLATFORM_ARCH_I386_PYTHON_INTERPRETER})")
    set(PLATFORM_PYTHON_INTERPRETER ${PLATFORM_ARCH_I386_PYTHON_INTERPRETER})
else ()
    message(FATAL_ERROR "FAILED TO FIND <PLATFORM_ARCH_I386_PYTHON_INTERPRETER> PROGRAM")
endif ()

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_ASM_FLAGS "-f elf32")
set(CMAKE_C_FLAGS "-std=gnu11 -march=i386")
set(CMAKE_CXX_FLAGS "-std=gnu++17 -march=i386")
set(CMAKE_EXE_LINKER_FLAGS "")

if (PLATFORM_BUILD_DISABLE_WARNINGS)
    string(APPEND CMAKE_ASM_FLAGS " -w") # todo: disable warnings correctly
    string(APPEND CMAKE_C_FLAGS " -w")
    string(APPEND CMAKE_CXX_FLAGS " -w")
    string(APPEND CMAKE_EXE_LINKER_FLAGS " -w")
else ()
    string(APPEND CMAKE_ASM_FLAGS " -Wall")
    string(APPEND CMAKE_C_FLAGS " -Wall")
    string(APPEND CMAKE_CXX_FLAGS " -Wall")
    string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wall")
endif ()

set(CMAKE_C_COMPILER_FORCED ON)
set(CMAKE_CXX_COMPILER_FORCED ON)