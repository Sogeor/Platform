#ifndef PLATFORM_X86_BOOT_MANAGER_MAIN
#define PLATFORM_X86_BOOT_MANAGER_MAIN

#include <stddef.h>
#include "macro.h"
#include <x86/misc/types.h>
#include <x86/misc/cpu.h>
#include <x86/misc/io.h>

extern u8 disk;

__attribute((noreturn))
extern void halt(void);

extern void main(void);

#endif // PLATFORM_X86_BOOT_MANAGER_MAIN
