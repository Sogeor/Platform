#include "gdt.h"

__asm(".code16gcc");

void gdt_load(struct gdt_desc *desc)
{
    if (desc->size == 0 || desc->size > 65535) die();
    __asm __volatile("lgdt %0" : : "m"(desc));
}

void gdt_entry_set(struct gdt_desc *desc, uint16_t ordinal, uint32_t base, uint32_t limit, uint8_t access,
                   uint8_t flags)
{
    if (desc->size == 0 || desc->size > 65535) die();
    if (ordinal == 0 || ordinal > 65535) die();
    if (limit > 0xFFFFF) die();
    if (flags > 0xF) die();
    *((uint32_t *) (desc->offset + ordinal * GDT_ENTRY_SIZE)) =
        (((uint64_t) limit) & 0xFFFF) | (((uint64_t) base) & 0xFFFFFF) << 16 | ((uint64_t) access) << 40 |
        (((uint64_t) limit) & 0xF0000) << 48 | (((uint64_t) flags) & 0xF) << 52 |
        (((uint64_t) base) & 0xFF000000) << 56;
}
