#include "cpu.h"

inline void cpu_pause()
{
    __asm __volatile("rep; nop");
}

inline umx cpu_flags()
{
    umx value;
    __asm __volatile("pushf\n\t"
                     "pop %0" : "=r"(value) : : "memory");
    return value;
}

inline void cpu_set_flags(umx value)
{
    __asm __volatile("push %0\n\t"
                     "popf" : : "rm"(value) : "cc", "memory");
}

inline umx cpu_cr0()
{
    umx value;
    __asm __volatile("mov %0, %%cr0" : "=r"(value) : : "memory");
    return value;
}

inline void cpu_set_cr0(umx value)
{
    __asm __volatile("mov %%cr0, %0\n\t" : : "r"(value) : "memory");
}

inline umx cpu_cr2()
{
    umx value;
    __asm __volatile("mov %0, %%cr2" : "=r"(value) : : "memory");
    return value;
}

inline void cpu_set_cr2(umx value)
{
    __asm __volatile("mov %%cr2, %0\n\t" : : "r"(value) : "memory");
}
