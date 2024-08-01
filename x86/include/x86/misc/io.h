#ifndef PLATFORM_X86_MISC_IO_H
#define PLATFORM_X86_MISC_IO_H

#include <x86/misc/types.h>

inline void outb(u16 port, u8 value);
inline void outw(u16 port, u16 value);
inline void outl(u16 port, u32 value);

inline u8 inb(u16 port);
inline u16 inw(u16 port);
inline u32 inl(u16 port);

#endif // PLATFORM_X86_MISC_IO_H
