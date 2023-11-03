#include "idt.h"

void idt_write_entry(idt_entry_t *entry, uint64_t offset, uint16_t selector, uint8_t ist, uint64_t reserved,
                     uint8_t gate_type, uint8_t dpl, uint8_t p) {
    entry->offset_1                               = (uint16_t) offset;
    entry->offset_2                               = (uint16_t)(offset >> 16);
    entry->offset_3                               = (uint32_t)(offset >> 32);
    entry->selector                               = selector;
    entry->ist_and_reserved_1                     = ist & 0x7;
    entry->ist_and_reserved_1 |= (uint8_t) reserved << 3;
    entry->gate_type_and_reserved_2_and_dpl_and_p = (uint8_t) reserved & 0x10;
    entry->reserved_3                             = (uint32_t)(reserved >> 6);
    entry->gate_type_and_reserved_2_and_dpl_and_p |= gate_type & 0xF;
    entry->gate_type_and_reserved_2_and_dpl_and_p |= dpl & 0x3 << 5;
    entry->gate_type_and_reserved_2_and_dpl_and_p |= p << 7;
}

void idt_write_entry_info(idt_entry_t *entry, idt_entry_info_t *entry_info) {
    idt_write_entry(entry, entry_info->offset, entry_info->selector, entry_info->ist, entry_info->reserved,
                    entry_info->gate_type, entry_info->dpl, entry_info->p);
}

void idt_read_entry_info(idt_entry_t *entry, idt_entry_info_t *entry_info) {
    entry_info->offset =
            (uint64_t) entry->offset_1 | (uint64_t) entry->offset_2 << 16 | (uint64_t) entry->offset_3 << 32;
    entry_info->selector  = entry->selector;
    entry_info->ist       = entry->ist_and_reserved_1 & 0x7;
    entry_info->reserved  = (uint64_t) entry->ist_and_reserved_1 >> 3 |
                            (uint64_t)(entry->gate_type_and_reserved_2_and_dpl_and_p & 0x10) << 1 |
                            (uint64_t) entry->reserved_3 << 6;
    entry_info->gate_type = entry->gate_type_and_reserved_2_and_dpl_and_p & 0xF;
    entry_info->dpl       = entry->gate_type_and_reserved_2_and_dpl_and_p & 0x60 >> 5;
    entry_info->p         = entry->gate_type_and_reserved_2_and_dpl_and_p >> 7;
}