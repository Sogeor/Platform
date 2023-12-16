#pragma once

#include <stdint.h>

#include "rmode.h"

typedef struct __pmode_cursor_s
{
    uint16_t x;
    uint16_t y;
} __attribute__((packed)) __pmode_cursor_t;

extern __pmode_cursor_t __pmode_cursor;

extern void __pmode_enter__();

extern void __pmode_leave__();

extern void __pmode_clear_screen__();

uint32_t pmode_ptr_compute(rmode_ptr_t *ptr);

void pmode_halt();

void pmode_print_symbol(const char symbol);

void pmode_print_string(const char *string);

void pmode_println();

void pmode_println_symbol(const char symbol);

void pmode_println_string(const char *string);

void pmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment,
                        uint16_t lba_lower);

void pmode_clear_screen();