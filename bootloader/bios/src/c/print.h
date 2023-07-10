#pragma once

#define X16_REAL_BIOS_LINE_SEPARATOR "\r\n"
#define X16_REAL_MSG_PREFIX "[real_x16] "

void print_c(const char c);

void print_s(const char *s);

void println();

void println_c(const char c);

void println_s(const char *s);

void println_prefixed();

void print_prefixed_c(const char c);

void print_prefixed_s(const char *s);

void println_prefixed_c(const char c);

void println_prefixed_s(const char *s);