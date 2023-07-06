#pragma once

#define X16_REAL_BIOS_LINE_SEPARATOR "\r\n"
#define X16_REAL_MSG_PREFIX "[real_x16] "

void x16_real_print_c(const char c);

void x16_real_prefixed_print_c(const char c);

void x16_real_print_s(const char *s);

void x16_real_prefixed_print_s(const char *s);

void x16_real_println();

void x16_real_prefixed_println();

void x16_real_println_c(const char c);

void x16_real_prefixed_println_c(const char c);

void x16_real_println_s(const char *s);

void x16_real_prefixed_println_s(const char *s);