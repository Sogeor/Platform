#pragma once

#include <stdint.h>

void x_print(const char *string);

void x_println(const char *string);

void x_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower);