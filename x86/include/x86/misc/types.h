#ifndef PLATFORM_X86_MISC_TYPES_H
#define PLATFORM_X86_MISC_TYPES_H

#include <misc/types.h>

typedef
#if defined(M64)
i64
#elif defined(M32)
i32
#elif defined(M16)
i16
#else
i64
#endif
    im;

typedef
#if defined(M64)
i64
#elif defined(M32)
i32
#else
i64
#endif
    imx;

typedef
#if defined(M64)
u64
#elif defined(M32)
u32
#elif defined(M16)
u16
#else
u64
#endif
    um;

typedef
#if defined(M64)
u64
#elif defined(M32)
u32
#else
u64
#endif
    umx;

#endif // PLATFORM_X86_MISC_TYPES_H
