bits 16 ; Tell assembler to generate 16-bit code

section .text

%include "build/include.asm"

extern bootloader_main

bios_data: ; BIOS may store some data here

    times 90 db 0

entry: ; Bootloader entry point

    jmp 0x00:.segments ; Perform far jump to clear the CS register

.segments:

    ; Clear registers

    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov sp, entry ; Setup the Stack Pointer register

    mov [disk], dl ; Store disk to use it later

    cld ; Clear direction flag

    ; Print message

    mov si, msg_disk_reading
    call x16_prefixed_println

.loop:
    hlt
    jmp .loop

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

msg_prefix:
    dw 13
    db '[Bootloader] '

msg_disk_reading:
    dw 16
    db 'Reading the disk'

msg_disk_reading_error:
    dw 36
    db 'An error occurred while reading disk'

msg_println:
    dw 2
    db 13, 10 ; "\r\n"

times 510 - ($ - $$) db 0 ; Pad to 510 bytes

dw 0xAA55 ; Boot sector magic value
