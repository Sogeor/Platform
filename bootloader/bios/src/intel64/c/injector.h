#pragma once

#include "stdint.h"

extern void halt();

extern void print();

extern void println();

extern void read_sectors();

void print_adapter(const char *string);

void println_adapter(const char *string);

void read_sectors_adapter(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment,
                          uint16_t lba_lower);

extern uint8_t disk;
extern uint8_t number_of_sectors;