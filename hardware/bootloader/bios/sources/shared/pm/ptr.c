#include "ptr.h"

asm(".code32");

__attribute__((unused, section(".ptr")))
void __ptr_parse(ptr_t ptr, ptr_table_t *ptr_table)
{
    ptr_table->off = ptr;
    ptr_table->seg = ptr >> 16;
}

__attribute__((unused, section(".ptr")))
ptr_t __ptr_compute(ptr_table_t *ptr_table)
{
    return ptr_table->off + ptr_table->seg * 16;
}