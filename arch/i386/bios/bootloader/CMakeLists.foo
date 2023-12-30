cmake_minimum_required(VERSION 3.22)

string(APPEND CMAKE_C_FLAGS " -O0 -m32 -ffreestanding")
string(APPEND CMAKE_CXX_FLAGS " -O0 -m32 -ffreestanding")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -nostdlib -T \"${CMAKE_CURRENT_SOURCE_DIR}/script.ld\"")

set(CRUTCH_TARGET_FILEPATH "\"${CMAKE_CURRENT_BINARY_DIR}/bios-bootloader.bin\"")
set(CRUTCH_PYTHON_INTERPRETER "python")
set(CRUTCH_PYTHON_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/generate.py")
set(CRUTCH_PYTHON_SCRIPT_BYPRODUCT "${CMAKE_CURRENT_BINARY_DIR}/generated.asm")
set(CRUTCH_PYTHON_SCRIPT_FLAGS ${CRUTCH_TARGET_FILEPATH} ${CRUTCH_PYTHON_SCRIPT_BYPRODUCT})

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_custom_target(bios-bootloader-generated
                  COMMAND ${CRUTCH_PYTHON_INTERPRETER} ${CRUTCH_PYTHON_SCRIPT} ${CRUTCH_PYTHON_SCRIPT_FLAGS}
                  BYPRODUCTS ${CRUTCH_PYTHON_SCRIPT_BYPRODUCT})

#add_library(bios-bootloader-objects OBJECT)
#add_dependencies(bios-bootloader-objects bios-bootloader-generated)
#
#add_custom_target(bios-bootloader-target ALL
#                  COMMAND "${CRUTCH_LINKER} ${CRUTCH_LINKER_FLAGS} -o ${CRUTCH_TARGET_FILEPATH} $<TARGET_OBJECTS:bios-bootloader-objects>"
#                  DEPENDS bios-bootloader-objects
#                  BYPRODUCTS ${CRUTCH_TARGET_FILEPATH})

add_executable(bios-bootloader-target)
add_dependencies(bios-bootloader-target bios-bootloader-generated)

add_subdirectory(include)

message(STATUS "=== BOOTLOADER ===")
message(STATUS "CMAKE_ASM_FLAGS: ${CMAKE_ASM_FLAGS}")
message(STATUS "CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
message(STATUS "CMAKE_EXE_LINKER_FLAGS: ${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "CMAKE_LINKER: ${CMAKE_LINKER}")
message(STATUS "=== BOOTLOADER ===")