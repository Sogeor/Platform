#include "ptr.h"

__asm(".code16");

uint32_t ptr_r_compose(struct ptr_r *ptr_r)
{
    return ptr_r->offset + ptr_r->segment * PTR_R_SEG_SIZE;
}

void ptr_r_decompose(uint32_t ptr, struct ptr_r *ptr_r)
{
    ptr_r->segment = ptr / PTR_R_SEG_SIZE;
    ptr_r->offset = ptr - ptr_r->segment * PTR_R_SEG_SIZE;
}

uint32_t ptr_p_compose(struct ptr_p *ptr_p)
{
    return ptr_p->offset + gdt_get_entry_base(gdt_get_entry(ptr_p->selector));
}
