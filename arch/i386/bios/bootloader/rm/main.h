#ifndef MAIN_H
#define MAIN_H

#include "../def.h"
#include "../pm/lifecycle.h"
#include "../pm/pm.h"

// #pragma region MAIN

__attribute__((unused, noreturn))
extern void __main_die();
__attribute__((unused, noreturn))
extern void __main_hlt();
__attribute__((unused))
void __main_dap_process(u16_t sectors, u16_t buf_off, u16_t buf_seg, u32_t lba_low);

__attribute__((unused))
void __main_launch();

// #pragma endregion MAIN

// #pragma region MAIN_PRINT

__attribute__((unused))
void __main_print(const char *s);
__attribute__((unused))
void __main_println(const char *s);

// #pragma endregion MAIN_PRINT

#endif // MAIN_H