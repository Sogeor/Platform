#include "lifecycle.h"

__asm__(".code32");

__attribute__((section(".lifecycle")))
void __lifecycle()
{
    __pm_println("hello pmode world");
    __vbe_query_controller_info();
    __pm_clear_screen();
    __pm_println("hello pmode world");
    __vbe_select_mode_info();
//    __vbe_require_mode(__vbe_mode_brief.number);
    char buf[UTIL_TA_ADAPTIVE_BUF_SIZE];
    __pm_print("NOB: ");
    __util_u16ta(__vbe_controller_info.number_of_memory_blocks, buf, 10);
    __pm_print((const char *) &buf);
    __pm_println("");
    __pm_print("VBE Resolution: ");
    __util_u16ta(__vbe_mode_brief.width, buf, 10);
    __pm_print((const char *) &buf);
    __pm_print("x");
    __util_u16ta(__vbe_mode_brief.height, buf, 10);
    __pm_print((const char *) &buf);
    __pm_println("");
    //    __pm_hlt();
}