%include "include.asm"

extern entrance

global entry
global print
global println
global read_sectors
global disk
global dap
global dap_size
global dap_reserved
global dap_number_of_sectors
global dap_buffer_offset
global dap_buffer_segment
global dap_lba_lower
global dap_lba_upper

bits 16
section .text

times 90 db 0
jmp 0x0:entry

entry:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, entry
    mov [disk], dl
    cld
    mov ax, INCLUDE_NUMBER_OF_LATE_SECTORS
    mov bx, entrance
    xor cx, cx
    mov edx, 1
    mov si, LATE_SECTORS_READING
    call println
    call read_sectors
    jc .error
    mov si, JUMPING_TO_LATE_SECTORS
    call println
    jmp entrance
.error:
    mov si, LATE_SECTORS_READING_ERROR
    call println
.halt:
    hlt
    jmp .halt

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

read_sectors:
    cmp ax, 127
    jbe .reading
    push ax
    mov ax, 127
    call read_sectors
    jc .error
    pop ax
    sub ax, 127
    add cx, 127 * 512 / 16
    add edx, 127
    jmp read_sectors
.reading:
    mov [dap_number_of_sectors], ax
    mov [dap_buffer_offset], bx
    mov [dap_buffer_segment], cx
    mov [dap_lba_lower], edx
    mov dl, [disk]
    mov si, dap
    mov ah, 0x42
    int 0x13
.error:
    ret

disk: db 0x80

dap:
dap_size: db 16
dap_reserved: db 0
dap_number_of_sectors: dw 0
dap_buffer_offset: dw 0
dap_buffer_segment: dw 0
dap_lba_lower: dd 0
dap_lba_upper: dd 0

LN_SEPARATOR: db 13, 10, 0
LATE_SECTORS_READING: db 'Reading the late sectors...', 0
LATE_SECTORS_READING_ERROR: db 'Unable to read the late sectors', 0
JUMPING_TO_LATE_SECTORS: db 'Jumping to the late sectors...', 0

times 510 - ($ - $$) db 0
dw 0xAA55