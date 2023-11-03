extern println

global prepare_gdt
global load_gdt
global gdt
global gdt_base
global gdt_end

section .gdt
bits 16

prepare_gdt:
    mov si, PREPARING_GDT
    call println
    call load_gdt
    ret

load_gdt:
    mov si, LOADING_GDT
    call println
    lgdt [gdt]
    ret

PREPARING_GDT: db 'Preparing the GDT...', 0
LOADING_GDT: db 'Loading the GDT...', 0

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
    db 0x9A
    db 0x0F
    db 0

    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 0x0F
    db 0
gdt_end: