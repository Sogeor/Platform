#ifndef IO_H
#define IO_H

#include "../def.h"

/*
 * Writes the value of the operand ``value`` to the I/O port with the number
 * specified by the value of the operand ``port``.
 */
__attribute__((unused))
void __io_outb(u16_t port, u8_t value);

/*
 * Writes the value of the operand ``value`` to the I/O port with the number
 * specified by the value of the operand ``port``.
 */
__attribute__((unused))
void __io_outw(u16_t port, u16_t value);

/*
 * Writes the value of the operand ``value`` to the I/O port with the number
 * specified by the value of the operand ``port``.
 */
__attribute__((unused))
void __io_outd(u16_t port, u32_t value);

/*
 * Reads and returns the value of the I/O port with the number specified by
 * the value of the operand ``port``.
 */
__attribute__((unused))
u8_t __io_inb(u16_t port);

/*
 * Reads and returns the value of the I/O port with the number specified by
 * the value of the operand ``port``.
 */
__attribute__((unused))
u16_t __io_inw(u16_t port);

/*
 * Reads and returns the value of the I/O port with the number specified by
 * the value of the operand ``port``.
 */
__attribute__((unused))
u32_t __io_ind(u16_t port);

#endif // IO_H