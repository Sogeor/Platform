#ifndef PLATFORM_MISC_TYPES_H
#define PLATFORM_MISC_TYPES_H

#include <stdint.h>
#include <stdbool.h>

// signed integer types

typedef int8_t i8;
typedef int16_t i16;
typedef struct i24_s
{
    i16 base;
    i8 addition;
} __attribute__((packed)) i24;
typedef int32_t i32;
typedef struct i40_s
{
    i32 base;
    i8 addition;
} __attribute__((packed)) i40;
typedef struct i48_s
{
    i32 base;
    i16 addition;
} __attribute__((packed)) i48;
typedef struct i56_s
{
    i32 base;
    i24 addition;
} __attribute__((packed)) i56;
typedef int64_t i64;
typedef struct i72_s
{
    i64 base;
    i8 addition;
} __attribute__((packed)) i72;
typedef struct i80_s
{
    i64 base;
    i16 addition;
} __attribute__((packed)) i80;
typedef struct i88_s
{
    i64 base;
    i24 addition;
} __attribute__((packed)) i88;
typedef struct i96_s
{
    i64 base;
    i32 addition;
} __attribute__((packed)) i96;
typedef struct i104_s
{
    i64 base;
    i40 addition;
} __attribute__((packed)) i104;
typedef struct i112_s
{
    i64 base;
    i48 addition;
} __attribute__((packed)) i112;
typedef struct i120_s
{
    i64 base;
    i56 addition;
} __attribute__((packed)) i120;
typedef struct i128_s
{
    i64 base;
    i64 addition;
} __attribute__((packed)) i128;

i24 i24a(i16 base, i8 addition);
i24 i24b(i16 base);
i40 i40a(i32 base, i8 addition);
i40 i40b(i32 base);
i48 i48a(i32 base, i16 addition);
i48 i48b(i32 base);
i56 i56a(i32 base, i24 addition);
i56 i56b(i32 base);
i72 i72a(i64 base, i8 addition);
i72 i72b(i64 base);
i80 i80a(i64 base, i16 addition);
i80 i80b(i64 base);
i88 i88a(i64 base, i24 addition);
i88 i88b(i64 base);
i96 i96a(i64 base, i32 addition);
i96 i96b(i64 base);
i104 i104a(i64 base, i40 addition);
i104 i104b(i64 base);
i112 i112a(i64 base, i48 addition);
i112 i112b(i64 base);
i120 i120a(i64 base, i56 addition);
i120 i120b(i64 base);
i128 i128a(i64 base, i64 addition);
i128 i128b(i64 base);

// unsigned integer types

typedef uint8_t u8;
typedef uint16_t u16;
typedef struct u24_s
{
    u16 base;
    u8 addition;
} __attribute__((packed)) u24;
typedef uint32_t u32;
typedef struct u40_s
{
    u32 base;
    u8 addition;
} __attribute__((packed)) u40;
typedef struct u48_s
{
    u32 base;
    u16 addition;
} __attribute__((packed)) u48;
typedef struct u56_s
{
    u32 base;
    u24 addition;
} __attribute__((packed)) u56;
typedef uint64_t u64;
typedef struct u72_s
{
    u64 base;
    u8 addition;
} __attribute__((packed)) u72;
typedef struct u80_s
{
    u64 base;
    u16 addition;
} __attribute__((packed)) u80;
typedef struct u88_s
{
    u64 base;
    u24 addition;
} __attribute__((packed)) u88;
typedef struct u96_s
{
    u64 base;
    u32 addition;
} __attribute__((packed)) u96;
typedef struct u104_s
{
    u64 base;
    u40 addition;
} __attribute__((packed)) u104;
typedef struct u112_s
{
    u64 base;
    u48 addition;
} __attribute__((packed)) u112;
typedef struct u120_s
{
    u64 base;
    u56 addition;
} __attribute__((packed)) u120;
typedef struct u128_s
{
    u64 base;
    u64 addition;
} __attribute__((packed)) u128;

u24 u24a(u16 base, u8 addition);
u24 u24b(u16 base);
u40 u40a(u32 base, u8 addition);
u40 u40b(u32 base);
u48 u48a(u32 base, u16 addition);
u48 u48b(u32 base);
u56 u56a(u32 base, u24 addition);
u56 u56b(u32 base);
u72 u72a(u64 base, u8 addition);
u72 u72b(u64 base);
u80 u80a(u64 base, u16 addition);
u80 u80b(u64 base);
u88 u88a(u64 base, u24 addition);
u88 u88b(u64 base);
u96 u96a(u64 base, u32 addition);
u96 u96b(u64 base);
u104 u104a(u64 base, u40 addition);
u104 u104b(u64 base);
u112 u112a(u64 base, u48 addition);
u112 u112b(u64 base);
u120 u120a(u64 base, u56 addition);
u120 u120b(u64 base);
u128 u128a(u64 base, u64 addition);
u128 u128b(u64 base);

// float types

typedef float f32;
typedef double f64;

// pointer types

#define p8 u8
#define p16 u16
#define p24 u24
#define p32 u32
#define p40 u40
#define p48 u48
#define p56 u56
#define p64 u64
#define p72 u72
#define p80 u80
#define p88 u88
#define p96 u96
#define p104 u104
#define p112 u112
#define p120 u120
#define p128 u128

#define p24a u24a
#define p24b u24b
#define p40a u40a
#define p40b u40b
#define p48a u48a
#define p48b u48b
#define p56a u56a
#define p56b u56b
#define p72a u72a
#define p72b u72b
#define p80a u80a
#define p80b u80b
#define p88a u88a
#define p88b u88b
#define p96a u96a
#define p96b u96b
#define p104a u104a
#define p104b u104b
#define p112a u112a
#define p112b u112b
#define p120a u120a
#define p120b u120b
#define p128a u128a
#define p128b u128b

#endif // PLATFORM_MISC_TYPES_H
