#include "bootloader.h"

__asm__(".code16gcc");

void bootloader_main() {
    println_s("=== UNREAL MODE ===");
    switch_to_protected_mode();
    protected_println_s("=== PROTECTED MODE ===");
    //enter_protected_mode();
}