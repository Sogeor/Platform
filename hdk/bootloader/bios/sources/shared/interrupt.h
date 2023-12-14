#pragma once

#include <stdint.h>

typedef struct __interrupt_context_s
{
    uint8_t code;
    uint16_t ax;
    uint16_t bx;
    uint16_t cx;
    uint16_t dx;
    uint16_t si;
    uint16_t di;
} __attribute__((packed)) __interrupt_context_t;

extern void __interrupt__();

void interrupt();

extern __interrupt_context_t __interrupt_context;