#pragma once

#include <stdint.h>

typedef struct dap_s {
    uint8_t size;
    uint8_t reserved;
    uint16_t number_of_sectors;
    uint16_t buffer_offset;
    uint16_t buffer_segment;
    uint32_t lba_lower;
    uint32_t lba_upper;
} __attribute__((packed)) dap_t;

extern dap_t dap;