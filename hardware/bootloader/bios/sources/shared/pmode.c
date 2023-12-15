#include "pmode.h"

__asm__(".code32");

void pmode_print(const char *string)
{
    while (*string)
    {
        if (*string == '\n')
        {
            ++__pmode_cursor.y;
            ++string;
            continue;
        }
        if (*string == '\r')
        {
            __pmode_cursor.x = 0;
            ++string;
            continue;
        }
        *((uint16_t *) 0xB8000 + __pmode_cursor.y * 80 + __pmode_cursor.x++) = 0x0F00 | *string++;
    }
}

void pmode_println(const char *string)
{
    pmode_print(string);
    pmode_print("\r\n");
    //    pmode_print(__crlf);
}

void pmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower)
{
    __pmode_leave__();
    __asm__(".code16gcc");
    read_sectors(number_of_sectors, buffer_offset, buffer_segment, lba_lower);
    __pmode_enter__();
    __asm__(".code32");
}

void pmode_print_symbol(char symbol)
{
    static int x = 0;
    static int y = 0;
    if (symbol == '\n')
    {
        ++y;
        return;
    } else if (symbol == '\r')
    {
        x = 0;
        return;
    }
    *((uint16_t *) 0xB8000 + y * 80 + x) = 0x0F00 | symbol;
    ++x;
}