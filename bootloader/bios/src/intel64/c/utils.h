#pragma once

#include <stddef.h>
#include <stdint.h>
#include "injector.h"
#include "x.h"

typedef struct r_ptr_s {
    uint16_t offset;
    uint16_t segment;
} __attribute__((packed)) r_ptr_t;

typedef struct p_ptr_s {
    uint16_t offset;
    uint16_t selector;
} __attribute__((packed)) p_ptr_t;

uint32_t util_parse_r_ptr(r_ptr_t* r_ptr);

uint32_t util_parse_p_ptr(p_ptr_t* p_ptr);

size_t util_get_string_length(const char *string);

char *util_flip_string(char *string);

char *util_int32_to_str(int32_t value, uint8_t radix);

char *util_uint32_to_str(uint32_t value, uint8_t radix);