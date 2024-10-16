#include <misc/types.h>

inline i24 i24a(i16 base, i8 addition)
{
    i24 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i24 i24b(i16 base)
{
    return i24a(base, 0);
}

inline i40 i40a(i32 base, i8 addition)
{
    i40 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i40 i40b(i32 base)
{
    return i40a(base, 0);
}

inline i48 i48a(i32 base, i16 addition)
{
    i48 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i48 i48b(i32 base)
{
    return i48a(base, 0);
}

inline i56 i56a(i32 base, i24 addition)
{
    i56 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i56 i56b(i32 base)
{
    return i56a(base, i24b(0));
}

inline i72 i72a(i64 base, i8 addition)
{
    i72 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i72 i72b(i64 base)
{
    return i72a(base, 0);
}

inline i80 i80a(i64 base, i16 addition)
{
    i80 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i80 i80b(i64 base)
{
    return i80a(base, 0);
}

inline i88 i88a(i64 base, i24 addition)
{
    i88 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i88 i88b(i64 base)
{
    return i88a(base, i24b(0));
}

inline i96 i96a(i64 base, i32 addition)
{
    i96 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i96 i96b(i64 base)
{
    return i96a(base, 0);
}

inline i104 i104a(i64 base, i40 addition)
{
    i104 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i104 i104b(i64 base)
{
    return i104a(base, i40b(0));
}

inline i112 i112a(i64 base, i48 addition)
{
    i112 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i112 i112b(i64 base)
{
    return i112a(base, i48b(0));
}

inline i120 i120a(i64 base, i56 addition)
{
    i120 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i120 i120b(i64 base)
{
    return i120a(base, i56b(0));
}

inline i128 i128a(i64 base, i64 addition)
{
    i128 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline i128 i128b(i64 base)
{
    return i128a(base, 0);
}

inline u24 u24a(u16 base, u8 addition)
{
    u24 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u24 u24b(u16 base)
{
    return u24a(base, 0);
}

inline u40 u40a(u32 base, u8 addition)
{
    u40 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u40 u40b(u32 base)
{
    return u40a(base, 0);
}

inline u48 u48a(u32 base, u16 addition)
{
    u48 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u48 u48b(u32 base)
{
    return u48a(base, 0);
}

inline u56 u56a(u32 base, u24 addition)
{
    u56 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u56 u56b(u32 base)
{
    return u56a(base, u24b(0));
}

inline u72 u72a(u64 base, u8 addition)
{
    u72 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u72 u72b(u64 base)
{
    return u72a(base, 0);
}

inline u80 u80a(u64 base, u16 addition)
{
    u80 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u80 u80b(u64 base)
{
    return u80a(base, 0);
}

inline u88 u88a(u64 base, u24 addition)
{
    u88 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u88 u88b(u64 base)
{
    return u88a(base, u24b(0));
}

inline u96 u96a(u64 base, u32 addition)
{
    u96 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u96 u96b(u64 base)
{
    return u96a(base, 0);
}

inline u104 u104a(u64 base, u40 addition)
{
    u104 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u104 u104b(u64 base)
{
    return u104a(base, u40b(0));
}

inline u112 u112a(u64 base, u48 addition)
{
    u112 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u112 u112b(u64 base)
{
    return u112a(base, u48b(0));
}

inline u120 u120a(u64 base, u56 addition)
{
    u120 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u120 u120b(u64 base)
{
    return u120a(base, u56b(0));
}

inline u128 u128a(u64 base, u64 addition)
{
    u128 result = {
        .base = base, .addition = addition
    };
    return result;
}

inline u128 u128b(u64 base)
{
    return u128a(base, 0);
}
