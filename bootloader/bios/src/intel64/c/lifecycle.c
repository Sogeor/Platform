#include "lifecycle.h"

__asm__(".code16gcc");

void lifecycle() {
    println_adapter("hello world");
    println_adapter(util_int32_to_str(-147, 10));
    print_adapter("number_of_sectors: ");
    println_adapter(util_uint32_to_str(dap.number_of_sectors, 10));
}