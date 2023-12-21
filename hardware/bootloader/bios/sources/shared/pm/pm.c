#include "pm.h"

asm(".code32");

__attribute__((unused, noreturn, section(".pm")))
void __pm_die()
{
    __pm_leave();
    asm(".code16gcc");
    __main_die();
}

__attribute__((unused, noreturn, section(".pm")))
void __pm_hlt()
{
    __pm_leave();
    asm(".code16gcc");
    __main_hlt();
}

__attribute__((unused, section(".pm")))
extern void __pm_dap_process(u16_t sectors, u16_t buf_off, u16_t buf_seg, u32_t lba_low)
{
    __pm_leave();
    asm(".code16gcc");
    __main_dap_process(sectors, buf_off, buf_seg, lba_low);
    __pm_enter();
    asm(".code32");
}

__attribute__((unused, section(".pm")))
extern void __pm_print(const char *s)
{
    while (*s)
    {
        if (*s == '\n')
        {
            ++__pm_cursor.y;
            ++s;
            continue;
        }
        if (*s == '\r')
        {
            __pm_cursor.x = 0;
            ++s;
            continue;
        }
        *((uint16_t *) 0xB8000 + __pm_cursor.y * 80 + __pm_cursor.x++) = 0xF00 | *s;
        ++s;
    }
}

__attribute__((section(".pm")))
extern void __pm_println(const char *s)
{
    __pm_print(s);
    __pm_print(PM_PRINT_CRLF);
}