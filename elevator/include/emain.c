#include "emain.h"
#include "io.hpp"

asm(".code32")

uint8_t emain(emain_table_t* table) {
    if (table->initiator == UNDEFINED) return 1;
    if (table->target == UNDEFINED) return 2;
    if (table->initiator == BIOS_BOOTLOADER) {
        switch (table->target) {
            
        }
    }
    switch (table->initiator) {
        case UEFI_BOOTLOADER:
            return 3;
        case KERNEL:
            return 4;
        default:
            return 5;
    }
    if (table->initiator == UNDEFINED) return 1;
    if (table->target == UNDEFINED) return 2;
    return table;
}