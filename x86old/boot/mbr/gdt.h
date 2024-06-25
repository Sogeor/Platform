#ifndef PLATFORM_GDT_H
#define PLATFORM_GDT_H

#include <stdint.h>
#include "enjoy.h"

struct gdt_desc
{
    uint16_t size;
    uint32_t offset;
} __attribute((packed));

#define GDT_ENTRY_SIZE 8

void gdt_load(struct gdt_desc *desc);
void gdt_entry_set(struct gdt_desc *desc, uint16_t ordinal, uint32_t base, uint32_t limit, uint8_t access,
                   uint8_t flags);

#endif // PLATFORM_GDT_H
