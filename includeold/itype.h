#ifndef PLATFORM_ITYPE_H
#define PLATFORM_ITYPE_H

typedef signed char i8;
typedef signed short int i16;
typedef signed long int i32;
typedef signed long long i64;

#define imin i8
#define imax i64

inline i8 GetI16Byte0(const i16 v)
{
    return (i8) v;
}

inline i8 GetI16Byte1(const i16 v)
{
    return (i8) (v >> 8);
}

inline i8 GetI32Byte0(const i32 v)
{
    return (i8) v;
}

inline i8 GetI32Byte1(const i32 v)
{
    return (i8) (v >> 8);
}

inline i8 GetI32Byte2(const i32 v)
{
    return (i8) (v >> 16);
}

inline i8 GetI32Byte3(const i32 v)
{
    return (i8) (v >> 24);
}

inline i16 GetI32Word0(const i32 v)
{
    return (i16) v;
}

inline i16 GetI32Word1(const i32 v)
{
    return (i16) (v >> 16);
}

inline i8 GetI64Byte0(const i64 v)
{
    return (i8) v;
}

inline i8 GetI64Byte1(const i64 v)
{
    return (i8) (v >> 8);
}

inline i8 GetI64Byte2(const i64 v)
{
    return (i8) (v >> 16);
}

inline i8 GetI64Byte3(const i64 v)
{
    return (i8) (v >> 24);
}

inline i8 GetI64Byte4(const i64 v)
{
    return (i8) (v >> 32);
}

inline i8 GetI64Byte5(const i64 v)
{
    return (i8) (v >> 40);
}

inline i8 GetI64Byte6(const i64 v)
{
    return (i8) (v >> 48);
}

inline i8 GetI64Byte7(const i64 v)
{
    return (i8) (v >> 56);
}

inline i16 GetI64Word0(const i64 v)
{
    return (i16) v;
}

inline i16 GetI64Word1(const i64 v)
{
    return (i16) (v >> 16);
}

inline i16 GetI64Word2(const i64 v)
{
    return (i16) (v >> 32);
}

inline i16 GetI64Word3(const i64 v)
{
    return (i16) (v >> 48);
}

inline i32 GetI64DWord0(const i64 v)
{
    return (i32) v;
}

inline i32 GetI64DWord1(const i64 v)
{
    return (i32) (v >> 32);
}

#endif // PLATFORM_ITYPE_H
