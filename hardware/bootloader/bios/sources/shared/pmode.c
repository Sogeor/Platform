#include "pmode.h"

__asm__(".code32");

__attribute__((section(".pmode"))) uint32_t pmode_ptr_compute(rmode_ptr_t *ptr)
{
    return ptr->segment * 16 + ptr->offset;
}

__attribute__((section(".pmode"))) void pmode_halt()
{
    __pmode_leave__();
    __asm__(".code16gcc");
    rmode_halt();
    __pmode_enter__();
    __asm__(".code32");
}

__attribute__((section(".pmode"))) void pmode_print_symbol(const char symbol)
{
    if (symbol == '\n')
    {
        ++__pmode_cursor.y;
        return;
    }
    if (symbol == '\r')
    {
        __pmode_cursor.x = 0;
        return;
    }
    *((uint16_t *) 0xB8000 + __pmode_cursor.y * 80 + __pmode_cursor.x++) = 0xF00 | symbol;
}

__attribute__((section(".pmode"))) void pmode_print_string(const char *string)
{
    while (*string)
    {
        pmode_print_symbol(*string++);
    }
}

__attribute__((section(".pmode"))) void pmode_println()
{
    __pmode_cursor.x = 0;
    ++__pmode_cursor.y;
}

__attribute__((section(".pmode"))) void pmode_println_symbol(const char symbol)
{
    pmode_print_symbol(symbol);
    pmode_println();
}

__attribute__((section(".pmode"))) void pmode_println_string(const char *string)
{
    pmode_print_string(string);
    pmode_println();
}

__attribute__((section(".pmode"))) void pmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset,
                                                           uint16_t buffer_segment, uint16_t lba_lower)
{
    __pmode_leave__();
    __asm__(".code16gcc");
    rmode_read_sectors(number_of_sectors, buffer_offset, buffer_segment, lba_lower);
    __pmode_enter__();
    __asm__(".code32");
}

__attribute__((section(".pmode"))) void pmode_clear_screen()
{
    __pmode_clear_screen__();
}