global __gdtr
global __gdt_base
global __gdt_end

section .gdt
bits 16

__gdtr:
    dw (__gdt_end - __gdt_base - 1)
    dd __gdt_base

__gdt_base:
    dq 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x9A
    db 0xCF
    db 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 0xCF
    db 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x9A
    db 0xF
    db 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 0xF
    db 0
__gdt_end: