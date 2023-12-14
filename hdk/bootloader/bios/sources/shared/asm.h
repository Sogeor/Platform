#pragma once

#include <stdint.h>

extern void __halt__();

extern const uint8_t disk;
extern const uint16_t number_of_sectors;

extern void __print__();

extern void __println__();

extern void __read_sectors__();

void halt();

void print(const char *string);

void println(const char *string);

void read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower);