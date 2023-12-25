cmake_minimum_required(VERSION 3.22)

target_sources(sogeor-platform-hardware-bootloader-bios-executable
               PRIVATE a20.asm boot.asm gdt.asm io.asm main.asm main.c)