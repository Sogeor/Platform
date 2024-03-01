section .boot

bits 16
extern a20_main
extern pm_main
global boot_main
boot_main:
    call a20_main
    ; todo: check features of computer
    ; todo: use apm or acpi
    ; todo: create memory map
    ; todo: move gdt loading here
    ; todo: move interrupt disabling here
    call pm_main
    mov si, BOOT_MAIN_MSG_FAILED_TO_ENTER_PM
    jmp boot_die

; si --> address of message (1)
;
; struct of (1):
;     dw <length>
;     db <text>
global boot_print
boot_print:
    push ax
    push cx
    push si
    pushf
    mov cx, [si] ; get length
    add si, 2 ; set to text
    mov ah, 0xE
.loop:
    lodsb
    int 10h
    loop .loop,
    popf
    pop si
    pop cx
    pop ax
    ret

; si --> address of message (1)
;
; struct of (1):
;     dw <length>
;     db <text>
global boot_println
boot_println:
    push ax
    push cx
    push si
    pushf
    mov cx, [si] ; get length
    add si, 2 ; set to text
    mov ah, 0xE
.loop:
    lodsb
    int 10h
    loop .loop
    mov al, 13 ; print `\r`
    int 10h
    mov al, 10 ; print `\n`
    int 10h
    popf
    pop si
    pop cx
    pop ax
    ret

extern header_hlt
global boot_hlt
boot_hlt:
    jmp header_hlt

; si --> address of message (1)
;
; struct of (1):
;     dw <length>
;     db <text>
global boot_die
boot_die:
    call boot_print
    jmp boot_hlt

BOOT_MAIN_MSG_FAILED_TO_ENTER_PM:
    dw 43
    db "Failed to enter protected mode (0x00000003)"
