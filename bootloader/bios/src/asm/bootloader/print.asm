global print
global println

print:
    push ax
    push si
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0
    jz .free
    int 0x10
    jmp .loop
.free:
    pop si
    pop ax
    ret

println:
    call print
    push si
    mov si, LN_SEPARATOR
    call print
    pop si
    ret

LN_SEPARATOR: db 13, 10, 0