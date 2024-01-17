%include "include.asm"

extern __main

global __bootable_stack
global __bootable
global __bootable_die
global __bootable_hlt
global __bootable_print
global __bootable_println
global __bootable_dap_process
global __bootable_disk
global __bootable_number_of_sectors
global __bootable_die_txt
global __bootable_crlf
global __bootable_dap
global __bootable_dap_size
global __bootable_dap_reserved_0
global __bootable_dap_number_of_sectors
global __bootable_dap_buffer_offset
global __bootable_dap_buffer_segment
global __bootable_dap_lower_bits_of_lba_number
global __bootable_dap_upper_bits_of_lba_number
global __bootable_dap_reserved_1

section .bootable
bits 16

__bootable_stack:

jmp 0x0:__bootable

__bootable:
    mov [__bootable_disk], dl
    xor cx, cx
    xor si, si
    mov sp, __bootable_stack
    mov bp, cx
    mov ds, cx
    mov es, cx
    mov ss, cx
    mov fs, cx
    mov gs, cx
    mov ax, [__bootable_number_of_sectors]
    mov bx, __bootable
    mov bx, __main
    mov edx, 1
    call __bootable_dap_process
    call __main

__bootable_die:
    mov si, __bootable_die_txt
    call __bootable_print

__bootable_hlt:
    hlt
    jmp __bootable_hlt

; si - address of text
__bootable_print:
    mov ah, 0xE
.lp:
    lodsb
    cmp al, 0
    je .rt
    int 0x10
    jmp .lp
.rt:
    ret

; si - address of text
__bootable_println:
    call __bootable_print
    mov si, __bootable_crlf
    call __bootable_print
    ret

; ax - number of sectors
; bx - buffer offset (should be 2 byte aligned)
; cx - buffer segment
; edx - lower 32 bits of lba number
; si - upper 16 bits of lba number
__bootable_dap_process:
    cmp ax, 127
    ja .lp
.rd:
    mov [__bootable_dap_number_of_sectors], ax
    mov [__bootable_dap_buffer_offset], bx
    mov [__bootable_dap_buffer_segment], cx
    mov [__bootable_dap_lower_bits_of_lba_number], edx
    mov [__bootable_dap_upper_bits_of_lba_number], si
    mov ah, 0x42
    mov dl, [__bootable_disk]
    mov si, __bootable_dap
    int 0x13
    ret
.lp:
    push ax
    push edx
    push si
    mov ax, 127
    call .rd
    pop si
    pop edx
    pop ax
    sub ax, 127
    add cx, (127 * 512) / 16
    cmp edx, 2 ^ 32 - 127
    ja .overflow
    add edx, 127
    jmp __bootable_dap_process
.overflow:
    cmp si, 2 ^ 16
    je __bootable_die
    push eax
    mov eax, 2 ^ 32
    sub eax, edx
    mov edx, 127
    sub dl, al ; optimization (eax < 127 & edx = 127)
    pop eax
    inc si
    jmp __bootable_dap_process

__bootable_disk: db 0
__bootable_number_of_sectors: dw NUMBER_OF_SECTORS

__bootable_die_txt: db "Failed to boot", 0

__bootable_crlf: db 13, 10, 0

__bootable_dap:
__bootable_dap_size: db 16
__bootable_dap_reserved_0: db 0
__bootable_dap_number_of_sectors: dw 0
__bootable_dap_buffer_offset: dw 0
__bootable_dap_buffer_segment: dw 0
__bootable_dap_lower_bits_of_lba_number: dd 0
__bootable_dap_upper_bits_of_lba_number: dw 0
__bootable_dap_reserved_1: dw 0

times 510 - ($ - $$) db 0

dw 0xAA55