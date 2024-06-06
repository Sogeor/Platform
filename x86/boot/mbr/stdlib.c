#include "stdlib.h"
#include "main.h"

__asm(".code16gcc");

#ifdef BALLOC

void *malloc(size_t size)
{
    if (size > UINT32_MAX) return NULL;
    void *ptr;
    return balloc_allocate(&balloc_image, &ptr, (uint32_t) size) == BALLOC_CODE_SUCCESS ? ptr : NULL;
}

void free(void *ptr)
{
    balloc_deallocate(&balloc_image, ptr);
}

void *calloc(size_t nmemb, size_t size)
{
    die();
}

void *realloc(void *ptr, size_t size)
{
    die();
}

void *reallocarray(void *ptr, size_t nmemb, size_t size)
{
    die();
}

#else

void *malloc(size_t size)
{
    die();
}

void free(void *ptr)
{
    die();
}

void *calloc(size_t nmemb, size_t size)
{
    die();
}

void *realloc(void *ptr, size_t size)
{
    die();
}

void *reallocarray(void *ptr, size_t nmemb, size_t size)
{
    die();
}

#endif
