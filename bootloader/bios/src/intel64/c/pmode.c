#include "pmode.h"

__asm__(".code32");

void pmode_clear_screen() {
    __asm__("mov $0, %al\n"
            "movl $3840, %ecx\n"
            "movl $0xB8000, %edi\n"
            "rep stosb");
}

void pmode_print_symbol(char symbol) {
    static int x = 0;
    static int y = 0;
    if (symbol == '\n') {
        ++y;
        return;
    } else if (symbol == '\r') {
        x = 0;
        return;
    }
    *((uint16_t *) 0xB8000 + y * 80 + x) = 0x0F00 | symbol;
    ++x;
}

void pmode_print(const char *string) {
    while (*string) pmode_print_symbol(*string++);
}

void pmode_println(const char *string) {
    pmode_print(string);
    pmode_print("\r\n");
}