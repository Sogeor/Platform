#include "x86.h"

const struct architecture_descriptor x86_descriptor = {
    "x86",
    "x86",
    x86_translator
};

int x86_translator(const struct options_descriptor *options, struct context_descriptor *context)
{
    return 0;
}