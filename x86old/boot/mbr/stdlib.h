#ifndef PLATFORM_STDLIB_H
#define PLATFORM_STDLIB_H

#include <stdint.h>
#include <stddef.h>
#include "balloc.h"

void *malloc(size_t size);
void free(void *ptr);
void *calloc(size_t nmemb, size_t size);
void *realloc(void *ptr, size_t size);
void *reallocarray(void *ptr, size_t nmemb, size_t size);

#endif // PLATFORM_STDLIB_H
