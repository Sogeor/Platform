#pragma once

#include <stdint.h>

extern void halt();

extern void print();

extern void println();

extern void read_sectors();

void inj_print(const char *string);

void inj_println(const char *string);

void inj_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower);

extern const uint8_t disk;

extern const uint16_t number_of_sectors;