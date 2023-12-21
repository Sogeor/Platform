global __gdt_load
global __gdt_desc
global __gdt_base
global __gdt_end

section .gdt
bits 16

__gdt_load:
    lgdt [__gdt_desc]
    ret

align 16

__gdt_desc:
    dw (__gdt_end - __gdt_base - 1)
    dd __gdt_base

align 16

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