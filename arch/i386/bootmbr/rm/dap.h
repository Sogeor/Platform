#ifndef RM_DAP_H
#define RM_DAP_H

#include "../def.h"

typedef struct dap_s
{
    u8_t size;
    u8_t reserved;
    u16_t sectors;
    u16_t buf_off;
    u16_t buf_seg;
    u32_t lba_low;
    u32_t lba_up;
} __attribute__((packed)) dap_t;

__attribute__((unused))
extern dap_t __boot_dap;

#endif // RM_DAP_H