#ifndef PLATFORM_UTYPE_H
#define PLATFORM_UTYPE_H

typedef signed char u8;
typedef signed short int u16;
typedef signed long int u32;
typedef signed long long u64;

#define umin u8
#define umax u64

inline u8 GetU16Byte0(const u16 v)
{
    return (u8) v;
}

inline u8 GetU16Byte1(const u16 v)
{
    return (u8) (v >> 8);
}

inline u8 GetU32Byte0(const u32 v)
{
    return (u8) v;
}

inline u8 GetU32Byte1(const u32 v)
{
    return (u8) (v >> 8);
}

inline u8 GetU32Byte2(const u32 v)
{
    return (u8) (v >> 16);
}

inline u8 GetU32Byte3(const u32 v)
{
    return (u8) (v >> 24);
}

inline u16 GetU32Word0(const u32 v)
{
    return (u16) v;
}

inline u16 GetU32Word1(const u32 v)
{
    return (u16) (v >> 16);
}

inline u8 GetU64Byte0(const u64 v)
{
    return (u8) v;
}

inline u8 GetU64Byte1(const u64 v)
{
    return (u8) (v >> 8);
}

inline u8 GetU64Byte2(const u64 v)
{
    return (u8) (v >> 16);
}

inline u8 GetU64Byte3(const u64 v)
{
    return (u8) (v >> 24);
}

inline u8 GetU64Byte4(const u64 v)
{
    return (u8) (v >> 32);
}

inline u8 GetU64Byte5(const u64 v)
{
    return (u8) (v >> 40);
}

inline u8 GetU64Byte6(const u64 v)
{
    return (u8) (v >> 48);
}

inline u8 GetU64Byte7(const u64 v)
{
    return (u8) (v >> 56);
}

inline u16 GetU64Word0(const u64 v)
{
    return (u16) v;
}

inline u16 GetU64Word1(const u64 v)
{
    return (u16) (v >> 16);
}

inline u16 GetU64Word2(const u64 v)
{
    return (u16) (v >> 32);
}

inline u16 GetU64Word3(const u64 v)
{
    return (u16) (v >> 48);
}

inline u32 GetU64DWord0(const u64 v)
{
    return (u32) v;
}

inline u32 GetU64DWord1(const u64 v)
{
    return (u32) (v >> 32);
}

#endif // PLATFORM_UTYPE_H
