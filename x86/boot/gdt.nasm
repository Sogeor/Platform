section .gdt

bits 16
extern header_die
global gdt_main
gdt_main:
    mov ah, 0xE
    mov bx, 0xC
    mov cx, 11
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
    jmp header_die
    ret
.msg: db "gdt.nasm > " ; 11
