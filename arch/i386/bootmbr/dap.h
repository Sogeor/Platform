#ifndef BOOTMBR_DAP_H
#define BOOTMBR_DAP_H

#include <stdint.h>

#include "ptr.h"

struct dap
{
    uint8_t size; // always = 16 // size of dap
    uint8_t unused; // should = 0
    uint16_t sec_num; // must <= 127 // number of sectors
    struct ptr_r mem_ptr; // memory buffer offset
    uint64_t lba_num: 48;
    uint64_t reserved: 16; // should = 0
} __attribute__((packed));

#define DAP_SEC_SIZE 512

extern struct dap dap;

extern void dap_read();

#endif //BOOTMBR_DAP_H