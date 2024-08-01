#include "io.h"

inline void outb(u16 port, u8 value)
{
    __asm __volatile("outb %b0, %w1" : : "a"(value), "Nd"(port) : "memory");
}

inline void outw(u16 port, u16 value)
{
    __asm __volatile("outw %b0, %w1" : : "a"(value), "Nd"(port) : "memory");
}

inline void outl(u16 port, u32 value)
{
    __asm __volatile("outl %b0, %w1" : : "a"(value), "Nd"(port) : "memory");
}

inline u8 inb(u16 port)
{
    u8 value;
    __asm __volatile("inb %w1, %b0" : "=a"(value) : "Nd"(port) : "memory");
    return value;
}

inline u16 inw(u16 port)
{
    u16 value;
    __asm __volatile("inw %w1, %b0" : "=a"(value) : "Nd"(port) : "memory");
    return value;
}

inline u32 inl(u16 port)
{
    u32 value;
    __asm __volatile("inl %w1, %b0" : "=a"(value) : "Nd"(port) : "memory");
    return value;
}