#include "asm.h"

__asm__(".code16gcc");

void halt()
{
    __halt__();
}

void print(const char *string)
{
    __asm__("call __print__" : : "S"(string));
}

void println(const char *string)
{
    __asm__("call __println__" : : "S"(string));
}

void read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower)
{
    __asm__("call __read_sectors__" : : "a"(number_of_sectors), "b"(buffer_offset), "c"(buffer_segment), "d"(lba_lower));
}