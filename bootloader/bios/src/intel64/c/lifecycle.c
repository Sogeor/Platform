#include "lifecycle.h"
#include "injector.h"

__asm__(".code16gcc");

void lifecycle() {
    for (int i = 0; i < 10; ++i) {
        println_adapter("hello world");
    }
}