#include "boot.h"

__asm__(".code16gcc");

int main(void)
{
    int a = 0;
    int b = 8;
    int c = a + b;
    return c;
}
