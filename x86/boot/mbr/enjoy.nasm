section .enjoy
bits 16

times 512 db 0 ; reserve memory for header sector

extern main
jdit: ; just do it!
    mov [disk], dl
    call main

global die
die:
    mov ah, 0xE
    mov bx, 0
    mov cx, 14
    mov si, msg
.lp:
    lodsb
    int 10h
    loop .lp

global halt
halt:
    hlt
    jmp halt

msg: db "Failed to boot"

global disk
disk: db 0
