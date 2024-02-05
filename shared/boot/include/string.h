#ifndef _STRING_H
#define _STRING_H 1

#define __need_size_t
#define __need_NULL

#include <stddef.h>

#define _STRING_H_MEMCPY(s1, s2, o) s1[o] = s2[o]

/**
 * @brief Copies the number of bytes from the source to the destination.
 * @param s1 The destination.
 * @param s2 The source.
 * @param n The number of bytes.
 * @warning The overlap of the source and destination is not checked and the
 * behavior is not defined.
 * @return The destination.
 * */
void *memcpy(void *restrict s1, const void *restrict s2, size_t n);

/**
 * @brief Copies the number of bytes from the source to the destination.
 * @param s1 The destination.
 * @param s2 The source.
 * @param n The number of bytes.
 * @warning When copying, a temporary array is used, so the problem with
 * overlapping the source and destination is replaced by a problem with
 * insufficient memory.
 * @return The destination.
 * */
void *memmove(void *s1, const void *s2, size_t n);

#endif // _STRING_H