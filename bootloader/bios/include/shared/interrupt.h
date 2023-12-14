#pragma once

#include <stdint.h>

__asm__(".code32");

typedef struct interrupt_context_s
{
    uint8_t code;
    uint16_t ax;
    uint16_t bx;
    uint16_t cx;
    uint16_t dx;
    uint16_t si;
    uint16_t di;
} __attribute__((packed)) interrupt_context_t;

typedef struct interrupt_callback_s
{
    uint32_t ebp;
    uint32_t esp;
    uint16_t result;
} __attribute__((packed)) interrupt_callback_t;

extern void interrupt();

extern interrupt_context_t interrupt_context;

extern interrupt_callback_t interrupt_callback;