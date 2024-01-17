#ifndef RGA_H
#define RGA_H

#include "../../../../../arch/i386/bootloader/bios/def.h"

__attribute__((unused))
extern void rga_set_ds(u16_t val);
__attribute__((unused))
extern void rga_set_es(u16_t val);
__attribute__((unused))
extern void rga_set_fs(u16_t val);
__attribute__((unused))
extern void rga_set_gs(u16_t val);
__attribute__((unused))
extern void rga_set_cr0(u32_t val);

__attribute__((unused))
extern u16_t rga_get_ds();
__attribute__((unused))
extern u16_t rga_get_es();
__attribute__((unused))
extern u16_t rga_get_fs();
__attribute__((unused))
extern u16_t rga_get_gs();
__attribute__((unused))
extern u32_t rga_get_cr0();

#endif // RGA_H