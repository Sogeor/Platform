bits 16
org 0x7C00

jmp 0:_start
_start:

_hlt:
    hlt
    jmp _hlt

times 510 - ($ - $$) db 0

dw 0xAA55
