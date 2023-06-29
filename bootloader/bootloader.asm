bits 16 ; Tell assembler to generate 16-bit code

section .text

%include "build/include.asm"

extern bootloader_main

bios_data: ; BIOS may store some data here
    times 90 db 0

first_entry: ; Bootloader entry point
    jmp 0x00:.setup ; Perform far jump to clear the CS register

.setup: ; Clear registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov sp, first_entry ; Setup the Stack Pointer register

    mov [disk], dl ; Store disk to use it later

    cld ; Clear direction flag

    ; Print message

    mov si, msg_disk_reading
    call x16_prefixed_println

    xor dx, dx
    mov ax, 1
    mov cx, (bootloader_size - (first_stage_end - first_stage_start)) / 512
    mov bx, second_stage_start
    call x16_read_disk
%endif

    mov si, msg_jumping_to_second_stage
    call x16_prefixed_println
    jmp second_entry

x16_read_disk:

.start:
    cmp cx, 127
    jbe .reading
    pusha
    mov cx, 127
    call x16_read_disk
    popa
    add eax, 127
    add dx, 127 * 512 / 16
    sub cx, 127
    jmp .start

.reading:
    mov [dap_lba_lower], ax
    mov [dap_number_sectors], cx
    mov [dap_buffer_segment], dx
    mov [dap_buffer_offset], bx
    mov dl, [disk]
    mov si, dap
    mov ah, 0x42
    int 0x13
    ret

.error:
    mov si, msg_disk_reading_error
    call x16_prefixed_println

x16_println:
    push si
    call x16_print
    mov si, msg_println
    call x16_print
    pop si
    ret

x16_print:
    push ax
    push cx
    push si
    mov cx, word [si]
    add si, 2

.loop:
    lodsb
    mov ah, 0x0E
    int 0x10
    loop .loop, cx
    pop si
    pop cx
    pop ax
    ret

x16_prefixed_println:
    push si
    mov si, msg_prefix
    call x16_print
    pop si
    call x16_println
    ret

x16_prefixed_print:
    push si
    mov si, msg_prefix
    call x16_print
    pop si
    call x16_print
    ret

disk db 0x80

global dap
global dap_number_sectors
global dap_buffer_offset
global dap_buffer_segment
global dap_lba_lower
global dap_lba_upper

dap:
    db 0x10
    db 0

dap_number_sectors:
    dw 0

dap_buffer_offset:
    dw 0

dap_buffer_segment:
    dw 0

dap_lba_lower:
    dd 0

dap_lba_upper:
    dd 0

msg_prefix:
    dw 13
    db '[Bootloader] '

msg_disk_reading:
    dw 16
    db 'Reading the disk'

msg_jumping_to_second_stage:
    dw 27
    db 'Jumping to the second stage'

msg_disk_reading_error:
    dw 36
    db 'An error occurred while reading disk'

msg_println:
    dw 2
    db 13, 10 ; "\r\n"

times 510 - ($ - $$) db 0 ; Pad to 510 bytes

dw 0xAA55 ; Boot sector magic value

first_stage_end:

second_stage_start:

second_entry:
.loop:
    hlt
    jmp .loop

second_stage_end: