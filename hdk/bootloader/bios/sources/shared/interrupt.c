#include "interrupt.h"

__asm__(".code32");

__attribute__((section(".interrupt"))) void interrupt()
{
    __interrupt__();
}