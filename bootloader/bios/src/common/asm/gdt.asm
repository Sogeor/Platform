extern writeln

global prepare_gdt
global load_gdt
global gdt
global gdt_base
global gdt_end

bits 16
section .gdt

prepare_gdt:
    push si
    mov si, PREPARING_GDT
    call writeln
    pop si

    call load_gdt
    ret

load_gdt:
    push si
    mov si, LOADING_GDT
    call writeln
    pop si

    lgdt [gdt]
    ret

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

PREPARING_GDT: db 'Preparing the GDT...', 0
LOADING_GDT: db 'Loading the GDT...', 0