#include "x.h"

__asm__ (".code16gcc");

void x_print(const char *string) {
    __asm__("call print" : : "S"(string));
}

void x_println(const char *string) {
    __asm__("call println" : : "S"(string));
}

void x_read_sectors(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment, uint16_t lba_lower) {
    __asm__("call read_sectors" : : "a"(number_of_sectors), "b"(buffer_offset), "c"(buffer_segment), "d"(lba_lower));
}