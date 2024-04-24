#ifndef PLATFORM_TYPES_H
#define PLATFORM_TYPES_H

// i8

#define I8_MAX 127i8
#define I8_MIN -128i8
typedef signed char i8;

// i16

#define I16_MAX 32767i16
#define I16_MIN -32768i16
typedef signed short int i16;

// i32

#define I32_MAX 2147483647i32
#define I32_MIN -2147483648i32
typedef signed long int i32;

// i64

#define I64_MAX 9223372036854775807i64
#define I64_MIN -9223372036854775808i64
typedef signed long long i64;

// imin

#define IMIN_MAX I8_MAX
#define IMIN_MIN I8_MIN
typedef i8 imin;

// imax

#define IMAX_MAX I64_MAX
#define IMAX_MIN I64_MIN
typedef i64 imax;

// u8

#define U8_MAX 255ui8
typedef signed char u8;

// u16

#define U16_MAX 65535ui16
typedef signed short int u16;

// u32

#define U32_MAX 4294967295ui32
typedef signed long int u32;

// u64

#define U64_MAX 18446744073709551615ui64
typedef signed long long u64;

// umin

#define UMIN_MAX U8_MAX
typedef u8 umin;

// umax

#define UMAX_MAX U64_MAX
typedef u64 umax;

// bool

#define BOOL_TRUE 1ui8
#define BOOL_FALSE 0ui8
typedef u8 bool;

#endif // PLATFORM_TYPES_H
