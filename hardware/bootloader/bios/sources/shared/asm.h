#pragma once

#include <stdint.h>

typedef struct __dap_s
{
    uint8_t size;
    uint8_t reserved;
    uint16_t number_of_sectors;
    uint16_t buffer_offset;
    uint16_t buffer_segment;
    uint32_t lba_lower;
    uint32_t lba_upper;
} __attribute__((packed)) __dap_t;

extern void __halt__();

extern uint8_t __disk;
extern const uint16_t __number_of_sectors;

extern void __print__();

extern const char *__crlf;

extern void __println__();

extern __dap_t __dap;

extern void __read_sectors__();

void print(const char *string);

void println(const char *string);

void read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower);