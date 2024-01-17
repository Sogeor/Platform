#pragma once

#include <stdint.h>

typedef struct __rmode_dap_s
{
    uint8_t size;
    uint8_t reserved;
    uint16_t number_of_sectors;
    uint16_t buffer_offset;
    uint16_t buffer_segment;
    uint32_t lba_lower;
    uint32_t lba_upper;
} __attribute__((packed)) __rmode_dap_t;

extern void __halt__();

extern uint8_t __disk;
extern uint16_t __number_of_sectors;

extern void __print__();

extern const char *__crlf;

extern void __println__();

extern __rmode_dap_t __dap;

extern void __read_sectors__();

extern void __rmode_print_symbol__();

typedef struct rmode_ptr_s
{
    uint16_t offset;
    uint16_t segment;
} __attribute__((packed)) rmode_ptr_t;

uint32_t rmode_ptr_compute(rmode_ptr_t *ptr);

void rmode_halt();

void rmode_print_symbol(const char symbol);

void rmode_print_string(const char *string);

void rmode_println();

void rmode_println_symbol(const char symbol);

void rmode_println_string(const char *string);

void rmode_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment,
                        uint16_t lba_lower);