#pragma once

#include <stdint.h>

typedef struct drive_parameters_s {
    uint16_t size;
    uint16_t flags;
    uint32_t number_of_cylinders;
    uint32_t number_of_heads;
    uint32_t number_of_sectors_per_track;
    uint64_t number_of_sectors;
    uint16_t number_of_bytes_per_sector;
} __attribute__((__packed__)) drive_parameters_t;

extern drive_parameters_t drive_parameters;