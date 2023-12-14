#pragma once

#include <stdint.h>

typedef struct interrupt_context_s {
    uint16_t ax;
    uint16_t bx;
    uint16_t cx;
    uint16_t dx;
    uint16_t si;
    uint16_t di;
    uint16_t bp;
    uint16_t sp;
    uint16_t es;
    uint16_t fs;
    uint16_t gs;
    uint16_t ss;
} __attribute__((packed)) interrupt_context_t;

extern void interrupt(uint8_t code, interrupt_context_t *context);