#pragma once

#include <stdint.h>

#include "rmode.h"

__attribute__((unused))
typedef struct __pmode_cursor_s
{
    uint16_t x;
    uint16_t y;
} __attribute__((packed)) __pmode_cursor_t;

__attribute__((unused))
extern __pmode_cursor_t __pmode_cursor;

__attribute__((unused))
extern void __pmode_enter__();

__attribute__((unused))
extern void __pmode_leave__();

__attribute__((unused))
extern void __pmode_clear_screen__();

__attribute__((unused))
uint32_t pmode_ptr_compute(rmode_ptr_t *ptr);

__attribute__((unused))
void pmode_halt();

__attribute__((unused))
void pmode_print_symbol(const char symbol);

__attribute__((unused))
void pmode_print_string(const char *string);

__attribute__((unused))
void pmode_println();

__attribute__((unused))
void pmode_println_symbol(const char symbol);

__attribute__((unused))
void pmode_println_string(const char *string);

__attribute__((unused))
void pmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset,
                        uint16_t buffer_segment, uint16_t lba_lower);

__attribute__((unused))
void pmode_clear_screen();