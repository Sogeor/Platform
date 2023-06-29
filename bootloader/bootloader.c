#include "bootloader.h"

__attribute__((noinline)) __attribute__((regparm(3)))
void real_printchar(char ch) {
    __asm__ __volatile__("mov $0x0E, %%ah\n"
                         "mov %0, %%al\n"
                         "int $0x10" : : "a"(ch));
}

void bootloader_main() {
    real_printchar('k');
}