#include "lifecycle.h"

__asm__(".code16gcc");

__attribute__((section(".lifecycle"))) void __lifecycle__()
{
    __pmode_enter__();
    __asm__(".code32");
    vbe_get_controller_info();
    pmode_clear_screen();
    vbe_select_mode_info();
    pmode_println_string("hello pmode world");
    pmode_println_string("hello pmode world");
    vbe_select_mode();
}