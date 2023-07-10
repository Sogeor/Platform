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
    db 0xFA
    db 0xCF
    db 0

    dw 0xFFFF
    dw 0
    db 0
    db 0xF2
    db 0xCF
    db 0
gdt_end:

align 4, db 0