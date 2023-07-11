#include "bootloader.h"

__asm__(".code16gcc");

void bootloader_main() {
    println_s("daroy");
    //enter_protected_mode();
}