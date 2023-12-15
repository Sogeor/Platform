#include "lifecycle.h"

__asm__(".code16gcc");

__attribute__((section(".lifecycle"))) void __lifecycle__()
{
    println("hello world");
    __pmode_enter__();
    __asm__(".code32");
    // pmode
    pmode_println("hello pmode world");
    __pmode_leave__();
    __asm__(".code16gcc");
    println("hello world");
}