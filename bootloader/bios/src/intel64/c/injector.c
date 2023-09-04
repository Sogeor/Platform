#include "injector.h"

__asm__(".code16gcc");

void print_adapter(const char *string) {
    __asm__ __volatile__("call print" : : "S"(string));
}

void println_adapter(const char *string) {
    __asm__ __volatile__("call println" : : "S"(string));
}

void read_sectors_adapter(uint16_t number_of_sectors, uint16_t buffer_offset, uint16_t buffer_segment,
                          uint16_t lba_lower) {
    __asm__ __volatile__("call read_sectors" : : "a"(number_of_sectors), "b"(buffer_offset), "c"(buffer_segment), "d"(lba_lower));
}