#ifndef DEF_H
#define DEF_H

__attribute__((unused))
typedef signed char i8_t;
__attribute__((unused))
typedef signed short int i16_t;
__attribute__((unused))
typedef signed long int i32_t;
__attribute__((unused))
typedef signed long long i64_t;

#define imin_t i8_t
#define imax_t i64_t

#define I8_T_MIN -128i8
#define I16_T_MIN -32768i16
#define I32_T_MIN -2147483648i32
#define I64_T_MIN -9223372036854775808i64
#define I8_T_MAX 127i8
#define I16_T_MAX 32767i16
#define I32_T_MAX 2147483647i32
#define I64_T_MAX 9223372036854775807i64

__attribute__((unused))
typedef unsigned char u8_t;
__attribute__((unused))
typedef unsigned short int u16_t;
__attribute__((unused))
typedef unsigned long int u32_t;
__attribute__((unused))
typedef unsigned long long u64_t;

#define umin_t u8_t
#define umax_t u64_t

#define U8_T_MIN 0ui8
#define U16_T_MIN 0ui16
#define U32_T_MIN 0ui32
#define U64_T_MIN 0ui64
#define U8_T_MAX 255ui8
#define U16_T_MAX 65535ui16
#define U32_T_MAX 4294967295ui32
#define U64_T_MAX 18446744073709551615ui64

__attribute__((unused))
typedef umin_t b_t;

#define B_T_FALSE 0ui8
#define B_T_TRUE 1ui8

#endif // DEF_H