#include "utils.h"

__asm__(".code16gcc");

uint32_t util_parse_r_ptr(r_ptr_t *r_ptr) {
    return r_ptr->segment * 16 + r_ptr->offset;
}

uint32_t util_parse_p_ptr(p_ptr_t *p_ptr) {
    // todo
    halt();
    return 0;
}

size_t util_get_string_length(const char *string) {
    size_t length = 0;
    while (*string++) length++;
    return length;
}

char *util_flip_string(char *string) {
    char cache;
    size_t i = 0;
    size_t j = util_get_string_length(string) - 1;
    for (; i < j; i++, j--) {
        cache = string[i];
        string[i] = string[j];
        string[j] = cache;
    }
    return string;
}

char *util_int32_to_str(int32_t value, uint8_t radix) {
    if (radix < 2 || radix > 36) return 0;
    const char symbols[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    char buffer[12];
    uint8_t index = 0;
    uint8_t negative = value < 0;
    if (negative) value = -value;
    do buffer[index++] = symbols[value % radix]; while (value /= radix);
    if (negative) buffer[index++] = '-';
    buffer[index] = '\0';
    return util_flip_string(buffer);
}

char *util_uint32_to_str(uint32_t value, uint8_t radix) {
    if (radix < 2 || radix > 36) return 0;
    const char symbols[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    char buffer[11];
    uint8_t index = 0;
    do buffer[index++] = symbols[value % radix]; while (value /= radix);
    buffer[index] = '\0';
    return util_flip_string(buffer);
}