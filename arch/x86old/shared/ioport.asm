global outb
global outw
global outl
global inb
global inw
global inl

outb:
    push ax
    push dx
    mov al, [bp]
    mov dx, [bp + 1]
    out dx, al
    pop dx
    pop ax
    ret

outw:
    push ax
    push dx
    mov ax, [bp]
    mov dx, [bp + 2]
    out dx, ax
    pop dx
    pop ax
    ret

outl:
    push eax
    push dx
    mov eax, [bp]
    mov dx, [bp + 4]
    out dx, eax
    pop dx
    pop eax
    ret

inb:
    push dx
    xor eax, eax
    mov dx, [bp]
    in al, dx
    pop dx
    ret

inw:
    push dx
    xor eax, eax
    mov dx, [bp]
    in ax, dx
    pop dx
    ret

inl:
    push dx
    xor eax, eax
    mov dx, [bp]
    in eax, dx
    pop dx
    ret
