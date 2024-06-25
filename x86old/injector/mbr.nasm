section .mbr
org 0x500
bits 16

jmp 0:relocate
relocate:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    mov cx, 256
    mov si, 0x7C00
    mov di, 0x500
    cli
    rep movsw
    jmp continue

continue:
    sti
    mov [__drive], dl
    


__drive: db 0

db 0x55, 0xAA
