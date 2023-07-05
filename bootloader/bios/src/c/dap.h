#pragma once

#include <stdint.h>

extern volatile uint8_t dap_size;
extern volatile uint8_t dap_reserved;
extern volatile uint32_t dap_number_of_sectors;
extern volatile uint32_t dap_buffer_offset;
extern volatile uint32_t dap_buffer_segment;
extern volatile uint16_t dap_lba_lower;
extern volatile uint16_t dap_lba_upper;