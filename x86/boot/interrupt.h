#ifndef INTERRUPT_H
#define INTERRUPT_H

#include <stdint.h>

/**
 * The state of the registers.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
struct interrupt_state
{
    union
    {
        struct
        {
            uint8_t al, ah, alx, ahx;
            uint8_t bl, bh, blx, bhx;
            uint8_t cl, ch, clx, chx;
            uint8_t dl, dh, dlx, dhx;
            uint8_t sil, sih, silx, sihx;
            uint8_t dil, dih, dilx, dihx;
            uint8_t spl, sph, splx, sphx;
            uint8_t bpl, bph, bplx, bphx;
        };
        struct
        {
            uint16_t ax, axhe;
            uint16_t bx, bxhe;
            uint16_t cx, cxhe;
            uint16_t dx, dxhe;
            uint16_t si, sihe;
            uint16_t di, dihe;
            uint16_t sp, sphe;
            uint16_t bp, bphe;
        };
        struct
        {
            uint32_t eax;
            uint32_t ebx;
            uint32_t ecx;
            uint32_t edx;
            uint32_t esi;
            uint32_t edi;
            uint32_t esp;
            uint32_t ebp;
        };
    };
    uint16_t ds;
    uint16_t es;
    uint16_t fs;
    uint16_t gs;
    uint32_t eflags;
} __attribute__((packed));

/**
 * The default state of the registers before execution.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern struct interrupt_state interrupt_istate;

/**
 * The default state of the registers after execution.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern struct interrupt_state interrupt_ostate;

/**
 * @brief Resets the default state of registers before execution.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern void interrupt_istate_reset();

/**
 * @brief Resets the default state of registers after execution.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern void interrupt_ostate_reset();

/**
 * @brief Copies the current state of the registers to the default state of the registers before execution.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern void interrupt_dump();

/**
 * @brief Executes an interrupt with the number specified in the `number` parameter and the state of registers specified
 * in the `istate` parameter. After the call, the state of registers is saved in the `ostate` parameter.
 *
 * @param number the number of the interrupt.
 * @param istate the required state of the registers before execution.
 * @param ostate the received state of the registers after execution.
 *
 * @note Passing the same pointer in the `istate` and `ostate` parameters will not result in undefined behavior.
 *
 * @author Bloogefest
 * @since 0.1.0-alpha
 * */
extern void interrupt(uint8_t number);

#endif // INTERRUPT_H
