%include "generated.asm"

extern __main
global __boot_die
global __boot_hlt
global __boot_disk
global __boot_platform_arch
global __boot_sectors
global __boot_print
global __boot_crlf
global __boot_println
global __boot_dap
global __boot_dap_process

section .bootstrap
bits 16

times 90 db 0
jmp 0x0:__boot

__boot:
    mov [__boot_disk], dl
    xor cx, cx
    xor si, si
    xor di, di
    mov sp, __boot
    mov bp, cx
    mov ds, cx
    mov es, cx
    mov ss, cx
    mov fs, cx
    mov gs, cx
    mov ax, word [__boot_sectors]
    mov bx, __main
    mov edx, 1
    call __boot_dap_process
    call __main
    jmp __boot_die

__boot_fail: db "Failed to boot", 0

__boot_die:
    mov si, __boot_fail
    call __boot_print

__boot_hlt:
    hlt
    jmp __boot_hlt

__boot_disk: db 0
__boot_platform_arch: db PLATFORM_BUILD_ARCH, 0
__boot_sectors: dw NUMBER_OF_SECTORS

__boot_print:
    mov ah, 0xE
.lp:
    lodsb
    cmp al, 0
    je .rt
    int 0x10
    jmp .lp
.rt:
    ret

__boot_crlf: db 13, 10, 0

__boot_println:
    call __boot_print
    mov si, __boot_crlf
    call __boot_print
    ret

__boot_dap:
__boot_dap_size: db 16
__boot_dap_reserved: db 0
__boot_dap_sectors: dw 0
__boot_dap_buf_off: dw 0
__boot_dap_buf_seg: dw 0
__boot_dap_lba_low: dd 0
__boot_dap_lba_up: dd 0

__boot_dap_process:
    cmp ax, 127
    ja .lp
    call .rd
    jmp .rt
.lp:
    push ax
    push edx
    mov ax, 127
    call .rd
    pop edx
    pop ax
    sub ax, 127
    add cx, (127 * 512) / 16
    add edx, 127
    jmp __boot_dap_process
.rd:
    mov [__boot_dap_sectors], ax
    mov [__boot_dap_buf_off], bx
    mov [__boot_dap_buf_seg], cx
    mov [__boot_dap_lba_low], edx
    mov ah, 0x42
    mov dl, [__boot_disk]
    mov si, __boot_dap
    int 0x13
    jc __boot_die
.rt:
    ret

times 510 - ($ - $$) db 0
dw 0xAA55