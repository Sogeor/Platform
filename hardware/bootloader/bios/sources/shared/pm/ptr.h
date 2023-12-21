#ifndef PTR_H
#define PTR_H

#include "../def.h"

typedef u32_t ptr_t;

typedef struct ptr_table_s
{
    u16_t off;
    u16_t seg;
} __attribute__((packed)) ptr_table_t;

__attribute__((unused))
void __ptr_parse(ptr_t ptr, ptr_table_t *ptr_table);
__attribute__((unused))
ptr_t __ptr_compute(ptr_table_t *ptr_table);

#endif // PTR_H