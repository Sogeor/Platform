#ifndef PM_H
#define PM_H

#include "../def.h"
#include "../rm/main.h"

// #pragma region PM

extern void __pm_enter();
extern void __pm_leave();
extern void __pm_clear_screen();

__attribute__((unused, noreturn))
void __pm_die();
__attribute__((unused, noreturn))
void __pm_hlt();
__attribute__((unused))
void __pm_dap_process(u16_t sectors, u16_t buf_off, u16_t buf_seg, u32_t lba_low);

// #pragma endregion PM

// #pragma region PM_CURSOR

typedef struct pm_cursor_s
{
    uint16_t x;
    uint16_t y;
} __attribute__((packed)) pm_cursor_t;

__attribute__((unused))
extern pm_cursor_t __pm_cursor;

// #pragma endregion PM_CURSOR

// #pragma region PM_PRINT

#define PM_PRINT_CRLF "\r\n"

__attribute__((unused))
void __pm_print(const char *s);
void __pm_println(const char *s);

// #pragma endregion PM_PRINT

#endif // PM_H