#pragma once

#include "stddef.h"
#include "stdint.h"

size_t util_get_string_length(const char *string);

char *util_flip_string(char *string);

char *util_int32_to_str(int32_t value, uint8_t radix);

char *util_uint32_to_str(uint32_t value, uint8_t radix);