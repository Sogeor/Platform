section .bootable
bits 16

jmp 0:die
die:
    xor ax, ax
    mov ds, ax
    mov ah, 0xE
    mov bx, 0
    mov cx, 40
    mov si, .msg
.loop:
    lodsb
    int 10h
    loop .loop
.halt:
    hlt
    jmp .halt
.msg: db "Using Sogeor Platform Boot Protocol v1.0"
;.msg: db "This message is displayed when trying to boot using the Master Boot Record (MBR)", 10, 13
;      db "Unfortunately, the currently used boot protocol "
;      db "(Sogeor Platform Boot Protocol Version 1.0) doesn't support MBR. "
;      db "However, full support for the GUID partition table (GPT) is provided. "
;      db "To boot successfully, you need to use a UEFI-compatible computer "
;      db "on which legacy mode is disabled."

times 440 - ($ - $$) db 0

dd 0
dw 0

__partition_1:
    db 0
    db 0, 0x2, 0
    db 0xEE
    db 0xFF, 0xFF, 0xFF ; TODO:
    db 0x1, 0, 0, 0
    db 0xFF, 0xFF, 0xFF, 0xFF ; TODO:
__partition_2: times 16 db 0
__partition_3: times 16 db 0
__partition_4: times 16 db 0

db 0x55, 0xAA
