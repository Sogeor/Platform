section .header

bits 64
header_hlt:
    hlt
    jmp header_hlt

header_die:
    mov ah, 0xE
    mov bx, 0xC
    mov cx, 14
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
    jmp header_hlt
.msg: db "Failed to boot" ; 14

header_main:
    jmp header_die
