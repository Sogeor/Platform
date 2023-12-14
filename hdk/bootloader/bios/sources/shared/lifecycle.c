#include "lifecycle.h"

__asm__(".code16gcc");

__attribute__((section(".lifecycle"))) void __lifecycle__()
{
    println("hello world");
}