#include "boot.h"

__asm(".code16gcc");

int main() {
    {
        int a = 2;
        int b = 4 + a;
        if (b == 2)
        {
            a = 2;
        }
    }
}
