#pragma once

#include <stdint.h>

extern void halt();

extern void print();

extern void println();

extern void read_sectors();

extern const uint8_t disk;

extern const uint16_t number_of_sectors;