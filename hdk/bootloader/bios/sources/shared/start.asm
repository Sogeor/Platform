%include "include.asm"

extern __main__

global __halt__
global __print__
global __println__
global __read_sectors__

section .start
bits 16

times 90 db 0
jmp 0x0:__start__

__start__:
    mov [__disk], dl
    xor cx, cx
    xor si, si
    xor di, di
    mov bp, cx
    mov sp, __start__
    mov ds, cx
    mov es, cx
    mov fs, cx
    mov gs, cx
    mov ss, cx
    mov ax, word [__number_of_sectors]
    mov bx, __main__
    mov edx, 1
    call __read_sectors__
    jmp __main__

__halt__:
    hlt
    jmp __halt__

__disk: db 0
__number_of_sectors: dw NUMBER_OF_SECTORS

__print__:
    push ax
    push si
    pushf
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0
    je .ret
    int 0x10
    jmp .loop
.ret:
    popf
    pop si
    pop ax
    ret

__crlf: db 13, 10, 0

__println__:
    push si
    call __print__
    mov si, __crlf
    call __print__
    pop si
    ret

__dap:
__dap_size: db 16
__dap_reserved: db 0
__dap_number_of_sectors: dw 0
__dap_buffer_offset: dw 0
__dap_buffer_segment: dw 0
__dap_lba_lower: dd 0
__dap_lba_upper: dd 0

__read_sectors__:
    push si
    pushf
.check:
    cmp ax, 127
    ja .loop
    call .reading
    jmp .ret
.loop:
    push ax
    mov ax, 127
    call .reading
    pop ax
    sub ax, 127
    add cx, 127 * (512 / 16)
    add edx, 127
    jmp .check
.reading:
    mov [__dap_number_of_sectors], ax
    mov [__dap_buffer_offset], bx
    mov [__dap_buffer_segment], cx
    mov [__dap_lba_lower], edx
    mov ah, 0x42
    mov dl, [__disk]
    mov si, __dap
    int 0x13
    jc __halt__
    ret
.ret:
    popf
    pop si
    ret

times 510 - ($ - $$) db 0
dw 0xAA55