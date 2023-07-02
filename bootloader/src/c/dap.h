#pragma once

#include <stdint.h>

extern volatile uint8_t x16_real_dap_size;
extern volatile uint8_t x16_real_dap_reserved;
extern volatile uint64_t x16_real_dap_number_of_sectors;
extern volatile uint64_t x16_real_dap_buffer_offset;
extern volatile uint64_t x16_real_dap_buffer_segment;
extern volatile uint16_t x16_real_dap_lba_lower;
extern volatile uint16_t x16_real_dap_lba_upper;