#pragma once

#include "stdint.h"

typedef struct gdt_entry_s {
    uint16_t limit_1;
    uint16_t base_1;
    uint8_t  base_2;
    uint8_t  access;
    uint8_t  limit_2_and_flags;
    uint8_t  base_3;
    uint32_t base_4;
    uint32_t reserved;
} __attribute__((__packed__)) gdt_entry_t;

typedef struct gdt_entry_info_s {
    uint64_t base;
    uint32_t limit;
    uint8_t  access;
    uint8_t  flags;
} __attribute__((__packed__)) gdt_entry_info_t;

void gdt_write_entry(gdt_entry_t *entry, uint64_t base, uint32_t limit, uint8_t access, uint8_t flags);

void gdt_write_entry_info(gdt_entry_t *entry, gdt_entry_info_t *entry_info);

void gdt_read_entry_info(gdt_entry_t *entry, gdt_entry_info_t *entry_info);