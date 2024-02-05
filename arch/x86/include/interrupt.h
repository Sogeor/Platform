#ifndef INTERRUPT_H
#define INTERRUPT_H

#include <stdint.h>

struct interrupt_state
{
    union
    {
        struct
        {
            uint8_t al, ah, __b__a0, __b__a1;
            uint8_t bl, bh, __b__b0, __b__b1;
            uint8_t cl, ch, __b__c0, __b__c1;
            uint8_t dl, dh, __b__d0, __b__d1;
            uint8_t sil, __b__si0, __b__si1, __b__si2;
            uint8_t dil, __b__di0, __b__di1, __b__di2;
        };
        struct
        {
            uint16_t ax, __w__a0;
            uint16_t bx, __w__b0;
            uint16_t cx, __w__c0;
            uint16_t dx, __w__d0;
            uint16_t si, __w__si0;
            uint16_t di, __w__di0;
        };
        struct
        {
            uint32_t eax;
            uint32_t ebx;
            uint32_t ecx;
            uint32_t edx;
            uint32_t esi;
            uint32_t edi;
        };
    };
    uint16_t ds;
    uint16_t es;
    uint16_t fs;
    uint16_t gs;
    uint32_t eflags;
};

void interrupt_setup(struct interrupt_state* state);
void interrupt_clear(struct interrupt_state* state);
void interrupt_copy(struct interrupt_state* source, struct interrupt_state* dest);
extern void interrupt(uint8_t code, struct interrupt_state* state);

extern struct interrupt_state interrupt_current_state;

#endif // INTERRUPT_H
