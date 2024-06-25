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

times 440 - ($ - $$) db 0

dd 0
dw 0

__partition_1: times 16 db 0
__partition_2: times 16 db 0
__partition_3: times 16 db 0
__partition_4: times 16 db 0

db 0x55, 0xAA
