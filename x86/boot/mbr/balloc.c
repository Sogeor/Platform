#include "balloc.h"

__asm(".code16gcc");

balloc_code balloc_mount(struct balloc_image *image)
{
    if (image == NULL || image->base == 0 || image->space < sizeof(struct balloc_block))
        return BALLOC_CODE_INVALID_IMAGE;
    if (image->mounted) return BALLOC_CODE_ALREADY_MOUNTED;
    image->root = (struct balloc_block *) image->base;
    image->root->length = image->space - sizeof(struct balloc_block);
    image->root->allocated = false;
    image->mounted = true;
    return BALLOC_CODE_SUCCESS;
}

balloc_code balloc_unmount(struct balloc_image *image)
{
    if (image == NULL) return BALLOC_CODE_INVALID_IMAGE;
    if (!image->mounted) return BALLOC_CODE_ALREADY_UNMOUNTED;
    image->mounted = false;
    image->root = NULL;
    return BALLOC_CODE_SUCCESS;
}

balloc_code balloc_allocate(struct balloc_image *image, void **ptr, uint32_t length)
{
    if (image == NULL || !image->mounted) return BALLOC_CODE_INVALID_IMAGE;
    if (length == 0) return BALLOC_CODE_INVALID_LENGTH;
    if (length > image->space - sizeof(struct balloc_block)) return BALLOC_CODE_NOT_ENOUGH_MEMORY;
    struct balloc_block *block = image->root;
    while (length <= image->base + image->space - (uint32_t) block)
    {
        if (block->allocated || block->length < length)
        {
            block = (struct balloc_block *) ((uint32_t) block + block->length);
            continue;
        }
        if (block->length >= length + sizeof(struct balloc_block))
        {
            struct balloc_block *next = (struct balloc_block *) ((uint32_t) block + length);
            next->length = block->length - length - sizeof(struct balloc_block);
            next->allocated = false;
        }
        block->allocated = true;
        *ptr = (void *) ((uint32_t) block + sizeof(struct balloc_block));
        return BALLOC_CODE_SUCCESS;
    }
    return BALLOC_CODE_NOT_ENOUGH_MEMORY;
}

balloc_code balloc_deallocate(struct balloc_image *image, void **ptr)
{
    if (image == NULL || !image->mounted) return BALLOC_CODE_INVALID_IMAGE;
    if (ptr == NULL || *ptr == NULL || (uint32_t) *ptr < image->base + sizeof(struct balloc_block) ||
        (uint32_t) *ptr > image->base + image->space)
        return BALLOC_CODE_INVALID_POINTER;
    struct balloc_block *block = image->root;
    while ((uint32_t) block + block->length < (uint32_t) *ptr)
        block = (struct balloc_block *) ((uint32_t) block + block->length);
    if ((uint32_t) *ptr != (uint32_t) block + sizeof(struct balloc_block)) return BALLOC_CODE_INVALID_POINTER;
    *ptr = NULL;
    block->allocated = false;
    struct balloc_block *initial = block;
    while ((uint32_t) block + block->length + sizeof(struct balloc_block) <= image->base + image->space)
    {
        block = (struct balloc_block *) ((uint32_t) block + block->length);
        if (block->allocated) break;
        initial->length += sizeof(struct balloc_block) + block->length;
    }
    while (initial != image->root)
    {
        block = image->root;
        while ((uint32_t) block + block->length + sizeof(struct balloc_block) < (uint32_t) initial)
        {
            block = (struct balloc_block *) ((uint32_t) block + block->length);
        }
        if (block->allocated == true) break;
        block->length += sizeof(struct balloc_block) + initial->length;
        initial = block;
    }
    return BALLOC_CODE_SUCCESS;
}

balloc_code balloc_reallocate(struct balloc_image *image, void **ptr, uint32_t length)
{
    if (length == 0) return balloc_deallocate(image, ptr);
    if (image == NULL || !image->mounted) return BALLOC_CODE_INVALID_IMAGE;
    if (ptr == NULL || *ptr == NULL) return BALLOC_CODE_INVALID_POINTER;
    die();
}
