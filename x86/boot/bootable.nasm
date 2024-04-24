section .start

bits 16
jmp start

halt: hlt
    jmp halt

die:
    mov ah, 0xE
    mov bx, 0
    mov cx, 14
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
    jmp halt
.msg: db "Failed to boot"

extern main
start:
    jmp die ; todo: rm it
    call main
    cmp ax, 0
    jne die
    jmp halt
