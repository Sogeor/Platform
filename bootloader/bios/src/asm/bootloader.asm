%include "include.asm"

extern entrance

global entry
global halt
global write
global writeln
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
section .bootloader

times 90 db 0
jmp 0x0:entry

entry:
    mov [disk], dl ; Сохранение загрузочной информации.

    xor ax, ax ; Подготовка общих регистров.
    xor bx, bx
    xor cx, cx
    xor dx, dx
    xor si, si
    xor di, di

    mov bp, ax ; Подготовка стековых регистров.
    mov sp, entry

    mov ds, ax ; Подготовка сегментных регистров.
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov si, READING_LATE_SECTORS ; Чтение поздних секторов с диска в память.
    call writeln

    mov ax, NUMBER_OF_LATE_SECTORS
    mov bx, entrance
    xor cx, cx
    mov edx, 1
    call read_sectors
    jc halt

    mov si, TRANSFER_OF_CONTROL_TO_LATE_SECTORS ; Передача управления поздним секторам.
    call writeln

    jmp entrance

halt:
    hlt
    jmp halt

write:
    push ax
    mov ah, 0xE
.loop:
    lodsb
    cmp al, 0
    je .free
    int 0x10
    jmp .loop
.free:
    pop ax
    ret

writeln:
    call write
    mov si, LINE_SEPARATOR
    call write
    ret

read_sectors:
    cmp ax, 127
    jbe .reading

    push ax
    mov ax, 127
    call read_sectors
    pop ax
    jc .free

    sub ax, 127
    add cx, 127 * 512 / 16
    add edx, 127

    jmp read_sectors
.reading:
    mov [dap_number_of_sectors], ax
    mov [dap_buffer_offset], bx
    mov [dap_buffer_segment], cx
    mov [dap_lba_lower], edx

    mov ah, 0x42
    mov dl, [disk]
    mov si, dap
    int 0x13
.free:
    ret

disk: db 0

dap:
dap_size: db 16
dap_reserved: db 0
dap_number_of_sectors: dw 0
dap_buffer_offset: dw 0
dap_buffer_segment: dw 0
dap_lba_lower: dd 0
dap_lba_upper: dd 0

LINE_SEPARATOR: db 13, 10, 0
READING_LATE_SECTORS: db 'Reading the late sectors from disk to memory...', 0
TRANSFER_OF_CONTROL_TO_LATE_SECTORS: db 'Transfer of control to the late sectors...', 0

times 510 - ($ - $$) db 0
dw 0xAA55