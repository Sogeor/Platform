#ifndef PLATFORM_ASSEMBLER_ARCHITECTURE_H
#define PLATFORM_ASSEMBLER_ARCHITECTURE_H

#include "pch.h"
#include "options.h"
#include "context.h"

/**
 * @author Bloogefest
 * @since 0.1.0
 * */
struct architecture_descriptor
{
    const char *id;
    const char *name;
    int (*translator)(const struct options_descriptor *options, struct context_descriptor *context);
};

#endif // PLATFORM_ASSEMBLER_ARCHITECTURE_H
