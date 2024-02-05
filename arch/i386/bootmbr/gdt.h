#ifndef BOOTMBR_GDT_H
#define BOOTMBR_GDT_H

#include <stdint.h>

struct gdt_desc
{
    uint16_t size;
    uint32_t offset;
} __attribute((packed));

extern struct gdt_desc gdt_desc;

struct gdt_entry
{
    uint64_t limit_0: 16;
    uint64_t base_0: 24;
    uint64_t a: 1;
    uint64_t rw: 1;
    uint64_t dc: 1;
    uint64_t e: 1;
    uint64_t s: 1;
    uint64_t dpl: 2;
    uint64_t p: 1;
    uint64_t limit_1: 4;
    uint64_t reserved: 1;
    uint64_t l: 1;
    uint64_t db: 1;
    uint64_t g: 1;
    uint64_t base_1: 8;
} __attribute((packed));

void gdt_set_entry(uint16_t selector, struct gdt_entry *gdt_entry);
gdt_entry *gdt_get_entry(uint16_t selector);

void gdt_set_entry_limit(uint32_t limit, struct gdt_entry *gdt_entry);
uint32_t gdt_get_entry_limit(struct gdt_entry *gdt_entry);

void gdt_set_entry_base(uint32_t base, struct gdt_entry *gdt_entry);
uint32_t gdt_get_entry_base(struct gdt_entry *gdt_entry);

#endif //BOOTMBR_GDT_H
