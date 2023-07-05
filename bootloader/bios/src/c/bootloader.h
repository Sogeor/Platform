#pragma once

#include <stdint.h>

#include "bios.h"

void bootloader_main();

// deprecated

extern void enter_protected_mode();

extern void do_bios_call(int func, int arg);

extern void bios_call(char *target, uint32_t sector);