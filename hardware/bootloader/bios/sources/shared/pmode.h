#pragma once

#include <stdint.h>

#include "asm.h"

typedef struct __pmode_cursor_s
{
    uint16_t x;
    uint16_t y;
} __attribute__((packed)) __pmode_cursor_t;

extern void __pmode_enter__();

extern void __pmode_leave__();

void pmode_print(const char *string);

void pmode_println(const char *string);

void pmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment,
                        uint16_t lba_lower);

extern __pmode_cursor_t __pmode_cursor;