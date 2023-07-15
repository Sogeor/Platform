#include "print.h"

__asm__(".code16gcc");

void print_c(const char c) {
    __asm__ __volatile__("mov $0xE, %%ah\n"
                         "mov %0, %%al\n"
                         "int $0x10" : : "c"(c));
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

__asm__(".code32");

void protected_print_c(const char c) {
    //    mov ebx,0xb8000    ; The video address
    //    mov al,'!'         ; The character to be print
    //    mov ah,0x0F        ; The color: white(F) on black(0)
    //    mov [ebx],ax        ; Put the character into the video memory
    //    __asm__ __volatile__("mov $0xB8000, %%ebx\n"
    //                         "mov %0, %%al\n"
    //                         "mov $0x0F, %%ah\n"
    //                         "mov %%ax,(%%ebx)\n" : : "c"(c));
    static int x = 0;
    static int y = 0;

    if (c == '\n') {
        ++y;
        return;
    } else if (c == '\r') {
        x = 0;
        return;
    }

    *((uint16_t *) 0xB8000 + y * 80 + x) = 0x0F00 | c;
    ++x;
}

void protected_print_s(const char *s) {
    while (*s) protected_print_c(*s++);
}

void protected_println() {
    protected_print_s(LN_SEPARATOR);
}

void protected_println_c(const char c) {
    protected_print_c(c);
    protected_println();
}

void protected_println_s(const char *s) {
    protected_print_s(s);
    protected_println();
}