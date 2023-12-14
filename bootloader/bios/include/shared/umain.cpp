#include "umain.hpp"

__attribute__((section(".umain")))

void umain() {
    __asm__(".code32");
}