#include "rmode.h"

__asm__(".code16gcc");

__attribute__((section(".rmode"))) uint32_t rmode_ptr_compute(rmode_ptr_t *ptr)
{
    return ptr->segment * 16 + ptr->offset;
}

__attribute__((section(".rmode"))) void rmode_halt()
{
    __halt__();
}

__attribute__((section(".rmode"))) void rmode_print_symbol(const char symbol)
{
    __asm__("call __rmode_print_symbol__" : : "S"(&symbol));
}

__attribute__((section(".rmode"))) void rmode_print_string(const char *string)
{
    __asm__("call __print__" : : "S"(string));
}

__attribute__((section(".rmode"))) void rmode_println()
{
    __asm__("call __print__" : : "S"(__crlf));
}

__attribute__((section(".rmode"))) void rmode_println_symbol(const char symbol)
{
    rmode_print_symbol(symbol);
    rmode_println();
}

__attribute__((section(".rmode"))) void rmode_println_string(const char *string)
{
    __asm__("call __println__" : : "S"(string));
}

__attribute__((section(".rmode"))) void rmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset,
                                                           uint16_t buffer_segment, uint16_t lba_lower)
{
    __asm__("call __read_sectors__" : : "a"(number_of_sectors), "b"(buffer_offset), "c"(buffer_segment), "d"(lba_lower));
}