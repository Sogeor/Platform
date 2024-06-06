#ifndef PLATFORM_ENJOY_H
#define PLATFORM_ENJOY_H

#include <stdint.h>

__attribute((noreturn))
extern void die();

__attribute((noreturn))
extern void halt();

extern uint8_t disk;

#endif // PLATFORM_ENJOY_H
