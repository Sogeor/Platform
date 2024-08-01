global gdt_load

bits 16
section .gdt

gdt_load:
    lgdt [gdt_desc]
    ret

align 16

gdt_desc:
    dw (gdt_end - gdt_base - 1)
    dd gdt_base

align 16

gdt_base: ; todo: check & remake gdt
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
gdt_end:
