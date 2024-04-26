#ifndef PLATFORM_BOOT_H
#define PLATFORM_BOOT_H

#include <stdint.h>

extern uint8_t disk;

__attribute((noreturn))
extern void die();

__attribute((noreturn))
extern void halt();

int main();

#endif // PLATFORM_BOOT_H
