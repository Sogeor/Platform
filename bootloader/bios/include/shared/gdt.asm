extern println

global gdtr
global gdt_base
global gdt_end

section .gdt
bits 16

gdtr:
    dw (gdt_end - gdt_base - 1)
    dd gdt_base

gdt_base:
    ; -------------- ;
    ; Address:   0x0 ;
    ; Tip:      Null ;
    ; -------------- ;
    ; Base:      0x0 ;
    ; Limit:     0x0 ;
    ; Access:    0x0 ;
    ; Flags:     0x0 ;
    ; -------------- ;
    dq 0

    ; -------------- ;
    ; Address:   0x8 ;
    ; Tip:   PM Mode ;
    ; -------------- ;
    ; Base:      0x0 ;
    ; Limit: 0xFFFFF ;
    ; Access:   0x9A ;
    ; Flags:     0xC ;
    ; -------------- ;
    dw 0xFFFF
    dw 0
    db 0
    db 0x9A
    db 0xCF
    db 0

    ; -------------- ;
    ; Address:  0x10 ;
    ; Tip:   PM Data ;
    ; -------------- ;
    ; Base:      0x0 ;
    ; Limit: 0xFFFFF ;
    ; Access:   0x92 ;
    ; Flags:     0xC ;
    ; -------------- ;
    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 0xCF
    db 0

    ; -------------- ;
    ; Address:  0x18 ;
    ; Tip:   RM Code ;
    ; -------------- ;
    ; Base:      0x0 ;
    ; Limit: 0xFFFFF ;
    ; Access:   0x9A ;
    ; Flags:     0x0 ;
    ; -------------- ;
    dw 0xFFFF
    dw 0
    db 0
    db 0x9A
    db 0xF
    db 0

    ; -------------- ;
    ; Address:  0x20 ;
    ; Tip:   RM Data ;
    ; -------------- ;
    ; Base:      0x0 ;
    ; Limit: 0xFFFFF ;
    ; Access:   0x92 ;
    ; Flags:     0x0 ;
    ; -------------- ;
    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 0xF
    db 0
gdt_end: