#ifndef PLATFORM_IC8042_H
#define PLATFORM_IC8042_H

#include <stdint.h>

uint8_t ic8042_data_r8(void);
uint16_t ic8042_data_r16(void);
uint32_t ic8042_data_r32(void);
void ic8042_data_w8(uint8_t value);
void ic8042_data_w16(uint16_t value);
void ic8042_data_w32(uint32_t value);



#endif // PLATFORM_IC8042_H
