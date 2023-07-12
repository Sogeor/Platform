#pragma once

#include <stdint.h>

typedef struct drive_parameters_s {
    volatile uint16_t size;
    volatile uint16_t flags;
    volatile uint32_t number_of_cylinders;
    volatile uint32_t number_of_heads;
    volatile uint32_t number_of_sectors_per_track;
    volatile uint64_t number_of_sectors;
    volatile uint16_t number_of_bytes_per_sector;
} __attribute__((__packed__)) drive_parameters_t;

extern volatile drive_parameters_t drive_parameters;