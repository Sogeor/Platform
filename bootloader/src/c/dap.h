#pragma once

#include <stdint.h>

// DAP (Disk Access Packet)

extern volatile uint8_t real_x16_dap_size;
extern volatile uint8_t real_x16_dap_reserved;
extern volatile uint64_t real_x16_dap_number_of_sectors;
extern volatile uint64_t real_x16_dap_buffer_offset;
extern volatile uint64_t real_x16_dap_buffer_segment;
extern volatile uint16_t real_x16_dap_lba_lower;
extern volatile uint16_t real_x16_dap_lba_upper;

extern void bios_call(char *target, uint32_t sector);