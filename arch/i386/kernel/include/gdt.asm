global gdtr
global gdt_load

gdtr:
    dw 0
    dq 0

gdt_load:
    mov [gdtr], di
    mov [gdtr + 2], rsi
    lgdt [gdtr]
    ret