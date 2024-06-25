#ifndef PLATFORM_IOPORT_H
#define PLATFORM_IOPORT_H

#include <stdint.h>

inline void outb(uint16_t port, uint8_t value);
inline void outw(uint16_t port, uint16_t value);
inline void outl(uint16_t port, uint32_t value);

inline uint8_t inb(uint16_t port);
inline uint16_t inw(uint16_t port);
inline uint32_t inl(uint16_t port);

#endif // PLATFORM_IOPORT_H
