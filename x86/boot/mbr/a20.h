#ifndef PLATFORM_A20_H
#define PLATFORM_A20_H

#include <stdbool.h>

bool a20_enable(void);

bool a20_check_raw(void);
bool a20_check_bios(void);

#endif // PLATFORM_A20_H
