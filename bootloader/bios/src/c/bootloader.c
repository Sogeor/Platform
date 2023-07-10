#include "bootloader.h"

__asm__(".code16gcc");

void bootloader_main() {
    println_prefixed_s("daroy");
    //enter_protected_mode();
}