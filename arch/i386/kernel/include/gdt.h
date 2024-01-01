#pragma once

#include <stdint.h>

typedef uint64_t gdt_raw_entity_t;

typedef struct gdt_entity_s {
    uint64_t base;
    uint32_t limit;
    uint8_t access;
    uint8_t flags;
} __attribute__((packed)) gdt_entity_t;

extern void gdt_load(uint16_t size, uint64_t offset);

void gdt_read_entity(gdt_raw_entity_t *ptr, gdt_entity_t *entity);

void gdt_write(gdt_raw_entity_t *ptr, uint64_t base, uint32_t limit, uint8_t access, uint8_t flags);

void gdt_write_entity(gdt_raw_entity_t *ptr, gdt_entity_t *entity);

void gdt_clear_entity(gdt_raw_entity_t *ptr);