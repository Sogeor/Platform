#ifndef BOOT_MSEC_H
#define BOOT_MSEC_H

#include <stdint.h>

__attribute((noreturn))
extern void msec_halt(void);

__attribute((noreturn))
void msec_die(void);

#define msec_print(s) __asm("call msec_print" : : "S"(s))
#define msec_println(s) __asm("call msec_println" : : "S"(s))

extern uint8_t msec_disk;

#endif // BOOT_MSEC_H
