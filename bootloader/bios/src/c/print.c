#include "print.h"

__asm__(".code16gcc");

void print_c(const char c) {
    __asm__ __volatile__("mov $0xE, %%ah\n"
                         "mov %0, %%al\n"
                         "int $0x10"::"c"(c));
}

void print_s(const char *s) {
    while (*s) print_c(*s++);
}

void println() {
    print_s(LN_SEPARATOR);
}

void println_c(const char c) {
    print_c(c);
    println();
}

void println_s(const char *s) {
    print_s(s);
    println();
}