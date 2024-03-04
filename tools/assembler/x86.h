#ifndef PLATFORM_ASSEMBLER_X86_H
#define PLATFORM_ASSEMBLER_X86_H

#include "architecture.h"

/**
 * @author Bloogefest
 * @since 0.1.0
 * */
int x86_translator(const struct options_descriptor *options, struct context_descriptor *context);

/**
 * @author Bloogefest
 * @since 0.1.0
 * */
extern const struct architecture_descriptor x86_descriptor;

#endif // PLATFORM_ASSEMBLER_X86_H
