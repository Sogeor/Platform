#pragma once

#include <stdint.h>

typedef struct dap_s {
    volatile uint8_t size;
    volatile uint8_t reserved;
    volatile uint16_t number_of_sectors;
    volatile uint16_t buffer_offset;
    volatile uint16_t buffer_segment;
    volatile uint32_t lba_lower;
    volatile uint32_t lba_upper;
} __attribute__((__packed__)) dap_t;

extern volatile dap_t dap;