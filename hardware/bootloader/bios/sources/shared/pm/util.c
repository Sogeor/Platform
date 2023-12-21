#include "util.h"

asm(".code32");

__attribute__((section(".util")))
umax_t __util_strlen(const char *s)
{
    umax_t len = 0;
    while (*s++) ++len;
    return len;
}

__attribute__((section(".util")))
void __util_strrev(char *s, umax_t base, umax_t end)
{
    char c;
    for (; base < end; ++base, --end)
    {
        c = s[base];
        s[base] = s[end];
        s[end] = c;
    }
}

const char *__util_ta = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

__attribute__((unused, section(".util")))
void __util_i8ta(i8_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    b_t sign = val < 0;
    umax_t i = sign;
    if (val < 0)
    {
        i = 1;
        val = -val;
        buf[0] = '-';
    } else
    {
        i = 0;
    }
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, sign, --i);
}

__attribute__((unused, section(".util")))
void __util_i16ta(i16_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    b_t sign = val < 0;
    umax_t i = sign;
    if (val < 0)
    {
        i = 1;
        val = -val;
        buf[0] = '-';
    } else
    {
        i = 0;
    }
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, sign, --i);
}

__attribute__((unused, section(".util")))
void __util_i32ta(i32_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    b_t sign = val < 0;
    umax_t i = sign;
    if (val < 0)
    {
        i = 1;
        val = -val;
        buf[0] = '-';
    } else
    {
        i = 0;
    }
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, sign, --i);
}

__attribute__((unused, section(".util")))
void __util_u8ta(u8_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    umax_t i = 0;
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, 0, --i);
}

__attribute__((unused, section(".util")))
void __util_u16ta(u16_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    umax_t i = 0;
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, 0, --i);
}

__attribute__((unused, section(".util")))
void __util_u32ta(u32_t val, char *buf, u8_t radix)
{
    if (radix < 2 || radix > 16) return;
    umax_t i = 0;
    do
    {
        buf[i++] = __util_ta[val % radix];
    } while (val /= radix);
    buf[i] = '\0';
    __util_strrev(buf, 0, --i);
}