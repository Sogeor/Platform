#include "test.h"

__asm__(".code16gcc");

void set_val(bootlibc_test_t* ptr, int val) {
    ptr->val = val;
}