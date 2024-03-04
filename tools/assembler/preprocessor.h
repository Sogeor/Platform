#ifndef PLATFORM_ASSEMBLER_PREPROCESSOR_H
#define PLATFORM_ASSEMBLER_PREPROCESSOR_H

#include "pch.h"
#include "context.h"
#include "options.h"

/**
 * @author Bloogefest
 * @since 0.1.0
 * */
struct preprocessor_descriptor
{
    const char *id;
    const char *name;
    int (*translator)(struct options_descriptor *options, struct context_descriptor *context);
};

#endif // PLATFORM_ASSEMBLER_PREPROCESSOR_H
