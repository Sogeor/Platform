#ifndef PLATFORM_BALLOC_H
#define PLATFORM_BALLOC_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "enjoy.h"

struct balloc_block
{
    uint32_t length;
    bool allocated;
} __attribute((packed));

struct balloc_image
{
    bool mounted;
    uint32_t base;
    uint32_t space;
    struct balloc_block *root;
} __attribute((packed));

#define BALLOC_CODE_SUCCESS 0
#define BALLOC_CODE_INVALID_IMAGE 1
#define BALLOC_CODE_ALREADY_MOUNTED 2
#define BALLOC_CODE_ALREADY_UNMOUNTED 3
#define BALLOC_CODE_INVALID_LENGTH 4
#define BALLOC_CODE_INVALID_POINTER 5
#define BALLOC_CODE_NOT_ENOUGH_MEMORY 6

typedef uint8_t balloc_code;

balloc_code balloc_mount(struct balloc_image *image);
balloc_code balloc_unmount(struct balloc_image *image);
balloc_code balloc_allocate(struct balloc_image *image, void **ptr, uint32_t length);
balloc_code balloc_deallocate(struct balloc_image *image, void **ptr);
balloc_code balloc_reallocate(struct balloc_image *image, void **ptr, uint32_t length);

#endif // PLATFORM_BALLOC_H
