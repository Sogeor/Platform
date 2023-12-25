cmake_minimum_required(VERSION 3.22)

target_sources(sogeor-platform-hardware-bootloader-bios-executable
               PRIVATE lifecycle.c pm.asm pm.c ptr.c util.c vbe.asm vbe.c)