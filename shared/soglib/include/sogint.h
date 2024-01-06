#ifndef SOGLIB_SOGINT_H
#define SOGLIB_SOGINT_H

typedef signed char i8_t;
typedef signed short int i16_t;
typedef signed long int i32_t;
typedef signed long long i64_t;

#define imin_t i8_t
#define imax_t i64_t

#define I8_MIN -128i8
#define I16_MIN -32768i16
#define I32_MIN -2147483648i32
#define I64_MIN -9223372036854775808i64
#define I8_MAX 127i8
#define I16_MAX 32767i16
#define I32_MAX 2147483647i32
#define I64_MAX 9223372036854775807i64

typedef unsigned char u8_t;
typedef unsigned short int u16_t;
typedef unsigned long int u32_t;
typedef unsigned long long u64_t;

#define umin_t u8_t
#define umax_t u64_t

#define U8_MIN 0ui8
#define U16_MIN 0ui16
#define U32_MIN 0ui32
#define U64_MIN 0ui64
#define U8_MAX 255ui8
#define U16_MAX 65535ui16
#define U32_MAX 4294967295ui32
#define U64_MAX 18446744073709551615ui64

#endif // SOGLIB_SOGINT_H