#include "print.h"

__asm__(".code16gcc");

void x16_real_print_c(const char c) {
    __asm__ __volatile__("mov $0xE, %%ah\n"
                         "mov %0, %%al\n"
                         "int $0x10"::""(c));
}

void x16_real_prefixed_print_c(const char c) {
    x16_real_print_s(X16_REAL_MSG_PREFIX);
    x16_real_print_c(c);
}

void x16_real_print_s(const char *s) {
    while (*s) x16_real_print_c(*s++);
}

void x16_real_prefixed_print_s(const char *s) {
    x16_real_print_s(X16_REAL_MSG_PREFIX);
    x16_real_print_s(s);
}

void x16_real_println() {
    x16_real_print_s(X16_REAL_BIOS_LINE_SEPARATOR);
}

void x16_real_prefixed_println() {
    x16_real_prefixed_print_s(X16_REAL_BIOS_LINE_SEPARATOR);
}

void x16_real_println_c(const char c) {
    x16_real_print_c(c);
    x16_real_println();
}

void x16_real_prefixed_println_c(const char c) {
    x16_real_prefixed_print_c(c);
    x16_real_println();
}

void x16_real_println_s(const char *s) {
    x16_real_print_s(s);
    x16_real_println();
}

void x16_real_prefixed_println_s(const char *s) {
    x16_real_prefixed_print_s(s);
    x16_real_println();
}