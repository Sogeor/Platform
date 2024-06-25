#ifndef PLATFORM_X86_KERNEL_GDT_H
#define PLATFORM_X86_KERNEL_GDT_H

struct gdt {

};

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

void KnGdtInit();

#endif // PLATFORM_X86_KERNEL_GDT_H
