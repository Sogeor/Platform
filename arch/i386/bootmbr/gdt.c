#include "gdt.h"

__asm(".code16");

void gdt_set_entry(uint16_t selector, struct gdt_entry *gdt_entry)
{
    gdt_get_entry(selector) = gdt_entry;
}

gdt_entry *gdt_get_entry(uint16_t selector)
{
    return *(gdt_desc.offset + selector * sizeof(struct gdt_entry_s));
}

void gdt_set_entry_limit(uint32_t limit, struct gdt_entry *gdt_entry)
{
    gdt_entry->limit_0 = limit & 0xFFFF;
    gdt_entry->limit_1 = (limit >> 16) & 0xF;
}

uint32_t gdt_get_entry_limit(struct gdt_entry *gdt_entry)
{
    uint32_t limit = (gdt_entry->limit_1 & 0xF) << 16;
    limit |= gdt_entry->limit_0 & 0xFFFF;
    return limit;
}

void gdt_set_entry_base(uint32_t base, struct gdt_entry *gdt_entry)
{
    gdt_entry->base_0 = base & 0xFFFFFF;
    gdt_entry->base_1 = (base >> 24) & 0xFF;
}

uint32_t gdt_get_entry_base(struct gdt_entry *gdt_entry)
{
    uint32_t base = (gdt_entry->base_1 & 0xFF) << 24;
    base |= gdt_entry->base_0 & 0xFFFFFF;
    return base;
}
