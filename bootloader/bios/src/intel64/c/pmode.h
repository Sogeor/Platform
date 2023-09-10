#pragma once

#include "stdint.h"

extern void enter_pmode();

void pmode_clear_screen();

void pmode_print_symbol(char symbol);

void pmode_print(const char *string);

void pmode_println(const char *string);