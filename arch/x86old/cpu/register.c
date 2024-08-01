#include "cpu/register.h"

inline uint16_t x86_get_ds(void)
{
    uint16_t v;
    __asm __volatile("movw %%ds, %0" : "=rm"(v));
    return v;
}

inline void x86_set_ds(uint16_t v)
{
    __asm __volatile("movw %0, %%ds" : : "rm"(v));
}

inline uint16_t x86_get_es(void)
{
    uint16_t v;
    __asm __volatile("movw %%es, %0" : "=rm"(v));
    return v;
}

inline void x86_set_es(uint16_t v)
{
    __asm __volatile("movw %0, %%es" : : "rm"(v));
}

inline uint16_t x86_get_fs(void)
{
    uint16_t v;
    __asm __volatile("movw %%fs, %0" : "=rm"(v));
    return v;
}

inline void x86_set_fs(uint16_t v)
{
    __asm __volatile("movw %0, %%fs" : : "rm"(v));
}

inline uint16_t x86_get_gs(void)
{
    uint16_t v;
    __asm __volatile("movw %%gs, %0" : "=rm"(v));
    return v;
}

inline void x86_set_gs(uint16_t v)
{
    __asm __volatile("movw %0, %%gs" : : "rm"(v));
}

inline uint32_t x86_get_eflags(void)
{
    uint32_t v;
    __asm __volatile("pushf\r\n"
                     "movl (%%esp), %0"
                     "popf\r\n" : "=rm"(v));
    return v;
}

inline void x86_set_eflags(uint32_t v)
{
    __asm __volatile("push %0\r\n"
                     "popf" : : "rm"(v));
}
