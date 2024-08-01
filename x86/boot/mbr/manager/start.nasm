section .start
bits 16

extern disk
extern stack
extern main
start:
    mov [disk], dl

    mov bp, stack
    mov ss, ax
    mov sp, bp

    call main

    mov ah, 0xE
    mov bx, 0
    mov cx, 21
    mov si, msg
.loop:
    lodsb
    int 10h
    loop .loop

global halt
halt:
    cli
.loop:
    hlt
    jmp .loop

msg: db "Initialization failed"
