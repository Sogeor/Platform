#pragma once

#include "stdint.h"

typedef struct idt_entry_s {
    uint16_t offset_1;
    uint16_t selector;
    uint8_t  ist_and_reserved_1;
    uint8_t  gate_type_and_reserved_2_and_dpl_and_p;
    uint16_t offset_2;
    uint32_t offset_3;
    uint32_t reserved_3;
} __attribute__((__packed__)) idt_entry_t;

typedef struct idt_entry_info_s {
    uint64_t offset;
    uint16_t selector;
    uint8_t  ist;
    uint64_t reserved;
    uint8_t  gate_type;
    uint8_t  dpl;
    uint8_t  p;
} __attribute__((__packed__)) idt_entry_info_t;

void idt_write_entry(idt_entry_t *entry, uint64_t offset, uint16_t selector, uint8_t ist, uint64_t reserved,
                     uint8_t gate_type, uint8_t dpl, uint8_t p);

void idt_write_entry_info(idt_entry_t *entry, idt_entry_info_t *entry_info);

void idt_read_entry_info(idt_entry_t *entry, idt_entry_info_t *entry_info);