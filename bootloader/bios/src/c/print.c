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
    print_s(X16_REAL_BIOS_LINE_SEPARATOR);
}

void println_c(const char c) {
    print_c(c);
    println();
}

void println_s(const char *s) {
    print_s(s);
    println();
}

void print_prefixed() {
    print_s(X16_REAL_MSG_PREFIX);
}

void print_prefixed_c(const char c) {
    print_prefixed();
    print_c(c);
}

void print_prefixed_s(const char *s) {
    print_prefixed();
    print_s(s);
}

void println_prefixed() {
    print_prefixed();
    println();
}

void println_prefixed_c(const char c) {
    print_prefixed();
    print_c(c);
}

void println_prefixed_s(const char *s) {
    print_prefixed();
    println_s(s);
}