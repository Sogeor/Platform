global gdt
global gdt_base
global gdt_end

bits 16
section .gdt

align 8, db 0

gdt:
    dw (gdt_end - gdt_base - 1)
    dd gdt_base

gdt_base:
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
    db 0x9E
    dw 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    dw 0
gdt_end:

align 4, db 0