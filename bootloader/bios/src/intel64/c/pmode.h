#pragma once

#include <stdint.h>

extern void pmode_enter();

extern void pmode_clear();

void pmode_print_symbol(char symbol);

void pmode_print(const char *string);

void pmode_println(const char *string);