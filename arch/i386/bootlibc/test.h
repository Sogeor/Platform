#ifndef BOOTLIBC_TEST_H
#define BOOTLIBC_TEST_H

typedef struct bootlibc_test_s {
    int val;
} bootlibc_test_t;

void set_val(bootlibc_test_t* ptr, int val);

#endif