#pragma once

#include <stdint.h>

#include <stddef.h>

#include "print.h"
#include "mode.h"

#define MSG "???"

void bootloader_main();

// deprecated

extern void do_bios_call(int func, int arg);

extern void bios_call(char *target, uint32_t sector);