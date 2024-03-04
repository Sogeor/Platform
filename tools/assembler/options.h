#ifndef PLATFORM_ASSEMBLER_OPTIONS_H
#define PLATFORM_ASSEMBLER_OPTIONS_H

#include "pch.h"

/**
 * @author Bloogefest
 * @since 0.1.0
 * */
struct options_descriptor
{
    char **vector;
    int count;
};

int options_validate(const struct options_descriptor* options);

#endif // PLATFORM_ASSEMBLER_OPTIONS_H
