#ifndef BOOTMBR_PTR_H
#define BOOTMBR_PTR_H

#include <stdint.h>

#include "gdt.h"

struct ptr_r
{
    uint16_t offset;
    uint16_t segment;
} __attribute__((packed));

#define PTR_R_SEG_SIZE 16

uint32_t ptr_r_compose(struct ptr_r* ptr_r);
void ptr_r_decompose(uint32_t ptr, struct ptr_r* ptr_r);

struct ptr_p
{
    uint16_t offset;
    uint16_t selector;
} __attribute__((packed));

uint32_t ptr_p_compose(struct ptr_p* ptr_p);

#endif //BOOTMBR_PTR_H
