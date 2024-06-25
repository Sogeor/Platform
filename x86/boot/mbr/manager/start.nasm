section .start
bits 16

extern stack
extern main
start:
    mov [disk], dl

    mov bp, stack
    mov ss, ax
    mov sp, bp

    call main

die:
    mov ah, 0xE
    mov bx, 0
    mov cx, 14
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
.halt:
    hlt
    jmp .halt
.msg: db "Failed to boot"

global disk
disk: db 0 ; TODO: move it to c files?
