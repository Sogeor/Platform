section .gdt

bits 16
global gdt_load
gdt_load:
    lgdt [gdt_desc]
    ret

align 16

gdt_desc:
gdt_desc_size: dw gdt_end - gdt_base - 1
gdt_desc_offset: dd gdt_base

align 16 ; recommended by Intel

gdt_base:
    ; null segment descriptor
    ; base = 0
    ; limit = 0
    ; access = 0
    ; flags = 0
    dq 0
    ; 32-bit code segment descriptor
    ; base = 0
    ; limit = 0xFFFFF
    ; access = 0x9A
    ; flags = 0xC
    dw 0xFFFF
    db 0, 0, 0
    db 0x9A
    db 0xF
    db 0xC
    db 0
    ; 32-bit data segment descriptor
    ; base = 0
    ; limit = 0xFFFFF
    ; access = 0x92
    ; flags = 0xC
    dw 0xFFFF
    db 0, 0, 0
    db 0x92
    db 0xF
    db 0xC
    db 0
    ; 16-bit code segment descriptor
    ; base = 0
    ; limit = 0xFFFFF
    ; access = 0x9A
    ; flags = 0
    dw 0xFFFF
    db 0, 0, 0
    db 0x9A
    db 0xF
    db 0
    db 0
    ; 16-bit data segment descriptor
    ; base = 0
    ; limit = 0xFFFFF
    ; access = 0x92
    ; flags = 0
    dw 0xFFFF
    db 0, 0, 0
    db 0x92
    db 0xF
    db 0
    db 0
gdt_end:
