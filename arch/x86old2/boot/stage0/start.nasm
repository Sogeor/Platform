section .mbr
bits 16
org 0x7C00

struc msg_s
.disk_extensions_not_present: resb 77
.failed_to_read_stage1: resb 94
.failed_to_transfer_control_to_stage1: resb 109
endstruc

struc dap_s
.size: resb 1
.reserved: resb 1
.number_of_sectors: resw 1
.buffer_offset: resw 1
.buffer_segment: resw 1
.lower_bits_of_lba: resd 1
.upper_bits_of_lba: resw 1
.extra_bits_of_lba: resw 1
endstruc

jmp 0:start
start:
    mov [disk], dl
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov bp, 0x7BFF
    mov ss, ax
    mov sp, bp
    mov ah, 0x41
    mov bx, 0x55AA
    clc
    int 13h
    jnc read_stage1
    mov cx, 77
    mov si, msg + msg_s.disk_extensions_not_present

die:
    mov ah, 0xE
.print:
    mov bx, 0
    lodsb
    int 10h
    loop .print
    cli
.halt:
    hlt
    jmp .halt

read_stage1:
    mov ah, 0x42
    mov dl, [disk]
    mov si, dap
    clc
    int 13h
    jc .fail
    test ah, ah
    jnz .fail
    mov dl, [disk]
    call 0x7E00
    mov cx, 109
    mov si, msg + msg_s.failed_to_read_stage1
    jmp die
.fail:
    mov cx, 94
    mov si, msg + msg_s.failed_to_read_stage1
    jmp die

disk: db 0

msg:
istruc msg_s
at msg_s.disk_extensions_not_present, db "Disk service extensions aren't provided, so further booting isn't possible..."
at msg_s.failed_to_read_stage1, db "An unexpected error occurred while trying to read stage1, so further booting isn't possible..."
at msg_s.failed_to_transfer_control_to_stage1, db "An unexpected error occurred while trying to transfer control to stage1, so further booting isn't possible..."
iend

dap:
istruc dap_s
at dap_s.size, db 16
at dap_s.reserved, db 0
at dap_s.number_of_sectors, dw (STAGE1_SIZE + 511) / 512
at dap_s.buffer_offset, dw 0
at dap_s.buffer_segment, dw 0x7E00 / 16
at dap_s.lower_bits_of_lba, dd 1
at dap_s.upper_bits_of_lba, dw 0
at dap_s.extra_bits_of_lba, dw 0
iend

times 440 - ($ - $$) db 0

times 4 db 0 ; disk id or signature
times 2 db 0 ; reserved

partition1: times 16 db 0
partition2: times 16 db 0
partition3: times 16 db 0
partition4: times 16 db 0

dw 0xAA55
