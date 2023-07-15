#pragma once

#include "stdint.h"

#define LN_SEPARATOR "\r\n"

void print_c(const char c);

void print_s(const char *s);

void println();

void println_c(const char c);

void println_s(const char *s);

void protected_print_c(const char c);

void protected_print_s(const char *s);

void protected_println();

void protected_println_c(const char c);

void protected_println_s(const char *s);