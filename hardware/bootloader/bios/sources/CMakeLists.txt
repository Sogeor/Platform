cmake_minimum_required(VERSION 3.22)
set(ENV{CRUTCH_GLOBAL_ARCH_ALIAS} intel64)

add_subdirectory($ENV{CRUTCH_GLOBAL_ARCH_ALIAS})
add_subdirectory(shared)