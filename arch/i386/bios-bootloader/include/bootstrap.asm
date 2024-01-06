extern __bootable_die
extern __bootable_hlt
extern __bootable_print
extern __bootable_println
extern __bootable_dap_process
global __bootstrap
global __bootstrap_die
global __bootstrap_hlt
global __bootstrap_print
global __bootstrap_println
global __bootstrap_dap_process

section .bootstrap
bits 16

__bootstrap:
    ret

__bootstrap_die:
    jmp __bootable_die

__bootstrap_hlt:
    jmp __bootable_hlt

; si - address of text
__bootstrap_print:
    push ax
    push si
    pushf
    call __bootable_print
    popf
    pop si
    pop ax
    ret

; si - address of text
__bootstrap_println:
    push ax
    push si
    pushf
    call __bootable_println
    popf
    pop si
    pop ax
    ret

; ax - number of sectors
; bx - buffer offset (should be 2 byte aligned)
; cx - buffer segment
; edx - lower 32 bits of lba number
; si - upper 16 bits of lba number
__bootstrap_dap_process:
    push ax
    push bx
    push cx
    push edx
    push si
    pushf
    call __bootable_dap_process
    popf
    pop si
    pop edx
    pop cx
    pop bx
    pop ax
    ret