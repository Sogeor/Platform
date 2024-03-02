#include "main.h"

__asm__(".code16gcc");

#include "interrupt.h"

extern void header_die();

__attribute__((noreturn))
void main() {
    interrupt_dump();
//    interrupt_istate.ah = 0xE;
//    interrupt_istate.al = 13;
//    interrupt(0x10);
//    interrupt_istate.al = 10;
//    interrupt(0x10);
    header_die();
}