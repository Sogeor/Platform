section .text
bits 16
org 0x7C00

jmp 0:start
start:
    mov [disk], dl

    mov ah, 0xE
    mov bx, 0
    mov cx, 19
    mov si, .msg
.print:
    lodsb
    int 10h
    loop .print
    cli
.halt:
    hlt
    jmp .halt
.msg: db "Initial boot failed"

disk: db 0

times 440 - ($ - $$) db 0

times 4 db 0 ; disk id or signature
times 2 db 0 ; reserved

partition1: times 16 db 0
partition2: times 16 db 0
partition3: times 16 db 0
partition4: times 16 db 0

dw 0xAA55
