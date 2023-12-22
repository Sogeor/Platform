cmake_minimum_required(VERSION 3.22)

project(bootloader-bios ASM_NASM C CXX)

#enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_FORMAT)
#set(CMAKE_C_COMPILER i686-elf-gcc)
#set(CMAKE_CXX_COMPILER i686-elf-g++)
set(CMAKE_ASM_FLAGS "-f elf32")
set(CMAKE_C_FLAGS "-O0 -std=gnu17 -ffreestanding -Wall")
set(CMAKE_CXX_FLAGS "-O0 -std=gnu++17 -ffreestanding -Wall")

set(CRUTCH_LINKER i686-elf-ld)
set(CRUTCH_LINKER_FLAGS)
set(CRUTCH_LINKER_SCRIPT $ENV{CRUTCH_GLOBAL_ARCH_ALIAS}.ld)

set(CRUTCH_TARGET_FILENAME $ENV{CRUTCH_GLOBAL_ARCH}.bin)

#add_subdirectory(sources)
add_subdirectory(intel64)

#add_library(bootloader-bios-library OBJECT)
#
#add_custom_target(bootloader-bios-target
#                  COMMAND ${CRUTCH_LINKER} ${CRUTCH_LINKER_FLAGS} -o ${CRUTCH_TARGET_FILENAME}
##                  DEPENDS bootloader-bios-sources-${CRUTCH_GLOBAL_ARCH_ALIAS} bootloader-bios-sources-shared
#                  DEPENDS bootloader-bios-library
#                  BYPRODUCTS ${CRUTCH_TARGET_FILENAME})

#add_custom_target(bootloader-bios-target
#                  COMMAND ${CRUTCH_LINKER} ${CRUTCH_LINKER_FLAGS} -o ${CRUTCH_TARGET_FILENAME} $<TARGET_OBJECTS:bootloader-bios-sources-${CRUTCH_GLOBAL_ARCH_ALIAS}> $<TARGET_OBJECTS:bootloader-bios-sources-shared>
#                  DEPENDS bootloader-bios-sources-${CRUTCH_GLOBAL_ARCH_ALIAS} bootloader-bios-sources-shared
#                  BYPRODUCTS ${CRUTCH_TARGET_FILENAME})

#############################
#
#cmake_minimum_required(VERSION 3.22)
#
#project(sogeor-platform-hardware-bootloader-bios ASM C CXX)

# GENERAL VARIABLES DEFINITION

#set(CMAKE_ASM_COMPILER nasm)
#set(CMAKE_C_COMPILER i686-elf-gcc)
#set(CMAKE_CXX_COMPILER i686-elf-g++)
#set(CRUTCH_LINKER i686-elf-ld)
#
#set(CMAKE_ASM_FLAGS "-f elf32")
#set(CMAKE_C_FLAGS "-O0 -std=gnu17 -ffreestanding -Wall")
#set(CMAKE_CXX_FLAGS "-O0 -std=gnu++17 -ffreestanding -Wall")
#set(CRUTCH_LINKER_FLAGS sources/${ARCH}/linker.ld)
#
## CRUTCH VARIABLES DEFINITION
#
#set(CRUTCH_GLOBAL_TARGET_EXTENSION "bin")
#set(CRUTCH_INTEL64_TARGET_FILENAME "intel64")
#set(CRUTCH_INTEL64_LINKER_SCRIPT "intel64.ld")
#
#set(CRUTCH_RUNTIME_TARGET_FILENAME "${CRUTCH_GLOBAL_ARCH}.bin")
#set(CRUTCH_RUNTIME_TARGET_FILENAME "${CRUTCH_GLOBAL_ARCH}.bin")
#
##set(CRUTCH_GLOBAL_ARCH INTEL64)
##set(CRUTCH_GLOBAL_ARCH_DIRNAME intel64)
#
#add_library(sogeor-platform-hardware-bootloader-bios-library)
#add_subdirectory(sources/shared)
#target_link_libraries(sogeor-platform-hardware-bootloader-bios-library sogeor-platform-hardware-bootloader-bios-sources-shared)
#
#if (CRUTCH_GLOBAL_ARCH STREQUAL "INTEL64")
#    add_subdirectory(sources/intel64)
#    target_link_libraries(sogeor-platform-hardware-bootloader-bios-library sogeor-platform-hardware-bootloader-bios-sources-intel64)
#endif ()
#
#
#function (add_binary name)
#    add_library("${name}-crutch" OBJECT ${ARGN})
#    set(OUTPUT_NAME "${name}.bin")
#    add_custom_target("${name}"
#                      COMMAND "${CRUTCH_LINKER} ${CRUTCH_LINKER_FLAGS} -o ${OUTPUT_NAME}" $<TARGET_OBJECTS:${name}-crutch>
#                      DEPENDS "${name}-crutch"
#                      BYPRODUCTS "${CRUTCH_INTEL64_TARGET_FILENAME}.${CRUTCH_GLOBAL_TARGET_EXTENSION}")
#
#    # OLD
#
#    set(output_name "{target}.bin")
#    set(linker_flags
#        "$<TARGET_PROPERTY:${target}.objects,LINK_OPTIONS>"
#    )
#    set(link_libraries
#        "$<TARGET_PROPERTY:${target}.objects,LINK_LIBRARIES>"
#    )
#
#    #    add_custom_target(${name}
#    #                      COMMAND "${CMAKE_LINKER}" "${linker_flags}" -o "${output_name}" $<TARGET_OBJECTS:${target}.objects> -lgcc "${linker_libraries}"
#    #                      DEPENDS ${name}-crutch
#    #                      BYPRODUCTS "${output_name}"
#    #    )
#endfunction ()
#
#function (crutch_binary_sources name)
#    target_sources(${name}-crutch PRIVATE ${ARGN})
#endfunction ()
#
#add_binary(sogeor-platform-hardware-bootloader-bios-bin)
#crutch_binary_sources(sogeor-platform-hardware-bootloader-bios-bin sources/shared/rm/main.asm)