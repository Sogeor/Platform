#include "gdt.h"

void gdt_write_entry(gdt_entry_t *entry, uint64_t base, uint32_t limit, uint8_t access, uint8_t flags) {
    entry->base_1 = (uint16_t) base;
    entry->base_2 = (uint8_t) (base >> 16);
    entry->base_3 = (uint8_t) (base >> 24);
    entry->base_4 = (uint32_t) (base >> 32);
    entry->limit_1 = (uint16_t) limit;
    entry->limit_2_and_flags = (uint8_t) (limit & 0xFFFFF >> 16);
    entry->access = access;
    entry->limit_2_and_flags |= flags << 4;
}

void gdt_write_entry_info(gdt_entry_t *entry, gdt_entry_info_t *entry_info) {
    gdt_write_entry(entry, entry_info->base, entry_info->limit, entry_info->access, entry_info->flags);
}

void gdt_read_entry_info(gdt_entry_t *entry, gdt_entry_info_t *entry_info) {
    entry_info->base = (uint64_t) entry->base_1 | (uint64_t) entry->base_2 << 16 | (uint64_t) entry->base_3 << 24 | (uint64_t) entry->base_4 << 32;
    entry_info->limit = (uint32_t) entry->limit_1 | (uint32_t) (entry->limit_2_and_flags & 0xF) << 16;
    entry_info->access = entry->access;
    entry_info->flags = entry->limit_2_and_flags & 0xF0 >> 4;
}