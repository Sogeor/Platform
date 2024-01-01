#include "main.h"

__asm__(".code16gcc");

__attribute__((unused, section(".main")))
extern void __main_dap_process(u16_t sectors, u16_t buf_off, u16_t buf_seg, u32_t lba_low)
{
    __asm__ volatile("call __bootable_dap_process" : : "a"(sectors), "b"(buf_off), "c"(buf_seg), "d"(lba_low));
}

__attribute__((unused, section(".main")))
void __main_launch()
{
    __pm_enter();
    __asm__(".code32");
    __lifecycle();
    __pm_leave();
    __asm__(".code16gcc");
}

__attribute__((unused, section(".main")))
extern void __main_print(const char *s)
{
    __asm__ volatile("call __bootable_print" : : "S"(s));
}

__attribute__((unused, section(".main")))
extern void __main_println(const char *s)
{
    __asm__ volatile("call __bootable_println" : : "S"(s));
}