#!/usr/bin/python

from sys import argv
from os import system

PLATFORM_BUILD_ARCH = argv[1]
PLATFORM_BUILD_DISPLAY_WARNINGS = argv[2]

OBJECTS = argv[3].split(";") # wtf???


def objects_nasm_filter(obj: str):
    return obj.endswith(".asm")


OBJECTS_NASM = filter(objects_nasm_filter, OBJECTS)


def objects_c_filter(obj: str):
    return obj.endswith(".c")


OBJECTS_C = filter(objects_c_filter, OBJECTS)


def objects_cpp_filter(obj: str):
    return obj.endswith(".cpp")


OBJECTS_CPP = filter(objects_cpp_filter, OBJECTS)

COMPILE_NASM_TOOL = "nasm"
COMPILE_C_TOOL = "i686-elf-gcc"
COMPILE_CPP_TOOL = "i686-elf-g++"

LINK_TOOL = "i686-elf-ld"

COMPILE_NASM_FLAGS = "-f elf32"
COMPILE_C_FLAGS = "-std=gnu17 -O0 -ffreestanding"
COMPILE_CPP_FLAGS = "i686-elf-g++"

for obj in OBJECTS_NASM:
    system(f"{COMPILE_NASM_TOOL} {COMPILE_NASM_FLAGS} {obj} -o {12}")
