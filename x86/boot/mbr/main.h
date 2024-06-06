#ifndef PLATFORM_MAIN_H
#define PLATFORM_MAIN_H

#include <stdint.h>
#include "stdlib.h"
#include "gdt.h"

int32_t main(void);

extern struct gdt_desc gdt_desc;
extern uint8_t gdt[];

#ifdef BALLOC

extern struct balloc_image balloc_image;

#endif

#endif // PLATFORM_MAIN_H
