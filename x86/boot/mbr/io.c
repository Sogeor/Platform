#include "io.h"

__asm(".code16gcc");

inline void outb(uint16_t port, uint8_t value)
{
    __asm __volatile("outb %0, $al" : : "a"(port), "m"(value));
}

inline void outw(uint16_t port, uint16_t value)
{
    __asm __volatile("outw %0, $al" : : "a"(port), "m"(value));
}

inline void outl(uint16_t port, uint32_t value)
{
    __asm __volatile("outl %0, $al" : : "a"(port), "m"(value));
}

inline uint8_t inb(uint16_t port)
{
    uint8_t value;
    __asm __volatile("outb %0, $al" : "=m"(value) : "a"(port));
    return value;
}

inline uint16_t inw(uint16_t port)
{
    uint16_t value;
    __asm __volatile("outw %0, $al" : "=m"(value) : "a"(port));
    return value;
}

inline uint32_t inl(uint16_t port)
{
    uint32_t value;
    __asm __volatile("outl %0, $al" : "=m"(value) : "a"(port));
    return value;
}
