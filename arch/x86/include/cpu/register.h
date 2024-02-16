#ifndef X86_CPU_REGISTER_H
#define X86_CPU_REGISTER_H

#include <stdint.h>

uint16_t x86_get_ds(void);
void x86_set_ds(uint16_t);

uint16_t x86_get_es(void);
void x86_set_es(uint16_t);

uint16_t x86_get_fs(void);
void x86_set_fs(uint16_t);

uint16_t x86_get_gs(void);
void x86_set_gs(uint16_t);

uint32_t x86_get_eflags(void);

#endif // X86_CPU_REGISTER_H
