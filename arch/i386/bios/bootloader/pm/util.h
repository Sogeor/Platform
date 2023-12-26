#ifndef UTIL_H
#define UTIL_H

#include "../def.h"

#pragma region UTIL_STR

umax_t __util_strlen(const char *s);
void __util_strrev(char *s, umax_t base, umax_t end);

#pragma endregion UTIL_STR

#pragma region UTIL_TA

extern const char *__util_ta;

__attribute__((unused))
void __util_i8ta(i8_t val, char *buf, u8_t radix);
__attribute__((unused))
void __util_i16ta(i16_t val, char *buf, u8_t radix);
__attribute__((unused))
void __util_i32ta(i32_t val, char *buf, u8_t radix);

#define UTIL_I8TA_BUF_SIZE 5
#define UTIL_I16TA_BUF_SIZE 7
#define UTIL_I32TA_BUF_SIZE 12

__attribute__((unused))
void __util_u8ta(u8_t val, char *buf, u8_t radix);
__attribute__((unused))
void __util_u16ta(u16_t val, char *buf, u8_t radix);
__attribute__((unused))
void __util_u32ta(u32_t val, char *buf, u8_t radix);

#define UTIL_U8TA_BUF_SIZE 4
#define UTIL_U16TA_BUF_SIZE 6
#define UTIL_U32TA_BUF_SIZE 11

#define UTIL_TA_ADAPTIVE_BUF_SIZE 12

#pragma endregion UTIL_TA

#endif // UTIL_H