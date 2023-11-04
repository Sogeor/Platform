#include "gdt.h"

void gdt_read_entity(gdt_raw_entity_t *ptr, gdt_entity_t *entity) {
    entity->base = ((*ptr & 0xFFFFFF0000) + (*ptr & 0xFF00000000000000)) >> 16;
    entity->limit = (*ptr & 0xFFFF) + (*ptr & 0xF000000000000);
    entity->access = (*ptr >> 40) & 0xFF;
    entity->flags = (*ptr >> 52) & 0xF;
}

void gdt_write(gdt_raw_entity_t *ptr, uint64_t base, uint32_t limit, uint8_t access, uint8_t flags) {
    *ptr = limit & 0xFFFF;
    *ptr = (base & 0xFFFFFF) << 16;
    *ptr = (uint64_t) access << 40;
    *ptr = (uint64_t) (limit & 0xF0000) << 48;
    *ptr = (uint64_t) flags << 52;
    *ptr = (base & 0xF000000) << 56;
    ptr[1] = base >> 32;
}

void gdt_write_entity(gdt_raw_entity_t *ptr, gdt_entity_t *entity) {
    gdt_write(ptr, entity->base, entity->limit, entity->access, entity->flags);
}

void gdt_clear_entity(gdt_raw_entity_t *ptr) {
    *ptr = 0;
}