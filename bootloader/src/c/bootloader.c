#include "bootloader.h"

__asm__(".code16gcc");

void bootloader_main() {
    x16_real_prefixed_println_s("daroy");
    //enter_protected_mode();
}