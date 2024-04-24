section .pmbr
bits 16

jmp 0:justload
justload: ; todo: loading with mbr
    hlt
    jmp justload


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
