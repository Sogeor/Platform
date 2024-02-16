section .a20

bits 16
extern header_die
extern gdt_main
global a20_main
a20_main:
    mov ah, 0xE
    mov bx, 0xC
    mov cx, 11
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
    call gdt_main
    ret
.msg: db "a20.nasm > " ; 11
