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

    mov si, msg_hello
    call println16

.loop:
    hlt
    jmp .loop

println16: ; Real mode println

    push si
    call print16
    mov si, msg_println
    call print16
    pop si
    ret

print16: ; Real mode print

    push ax
    push cx
    push si
    mov cx, word [si]
    add si, 2

.string_loop:

    lodsb
    mov ah, 0x0E
    int 0x10
    loop .string_loop, cx
    pop si
    pop cx
    pop ax
    ret

disk db 0x80

msg_hello: ; Hello message string

    dw 26
    db 'Sogeor.Platform Bootloader'

msg_println: ; New line string

    dw 2
    db 13, 10 ; "\r\n"

times 510 - ($ - $$) db 0 ; Pad to 510 bytes

dw 0xAA55 ; Boot sector magic value
