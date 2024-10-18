bits 16
org 0x600

_reloc: ; 0x7C00, relocate to 0:0x600
    xor cx, cx
    mov ds, cx
    mov es, cx
    mov ss, cx
    mov si, 0x7C00
    mov di, 0x600
    mov cx, 512 / 2
    cld
    rep movsw
    jmp 0:_boot

struc disk_s
.drive: resb 1
.seconds: resb 1
.minutes: resb 1
.hours: resb 1
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

struc partition_s
.status: resb 1
.base_chs: resb 3
.type: resb 1
.end_chs: resb 3
.base_lba: resd 1
.number_of_sectors: resd 1
endstruc

_boot: ; 0:0x600 + _boot
    mov ax, 7
    mov cx, 4
    mov si, partition_1
.select:
    bt [si + partition_s.status], ax
    jc .selected
    add si, 16
    loop .select
    mov si, msg_1
    jmp _die
.selected:
    mov [disk + disk_s.drive], dl
    mov bx, si
    mov ax, [si + partition_s.base_lba]
    mov [dap + dap_s.lower_bits_of_lba], ax
    mov ax, [si + partition_s.base_lba + 2]
    mov [dap + dap_s.lower_bits_of_lba + 2], ax
    mov ah, 0x42
    mov si, dap
    int 13h
    jnc .readed
    mov si, msg_2
    jmp _die
.readed:
    mov dl, [disk + disk_s.drive]
    mov si, bx
    jmp _hlt

times 218 - ($ - $$) db 0

dw 0 ; reserved
disk:
istruc disk_s
at disk_s.drive, db 0x80 ; the original physical drive
at disk_s.seconds, db 0
at disk_s.minutes, db 0
at disk_s.hours, db 0
iend

_die:
    lodsb
    mov cl, al
    xor ch, ch
    mov ah, 0xE
.print:
    mov bx, 0
    lodsb
    int 10h
    loop .print
    cli

_hlt:
    hlt
    jmp _hlt

dap:
istruc dap_s
at dap_s.size, db 16
at dap_s.reserved, db 0
at dap_s.number_of_sectors, dw 1
at dap_s.buffer_offset, dw 0
at dap_s.buffer_segment, dw 0x7C00 / 16
at dap_s.lower_bits_of_lba, dd 0
at dap_s.upper_bits_of_lba, dw 0
at dap_s.extra_bits_of_lba, dw 0
iend

msg_1: db 55, "There is no active partition, so booting isn't possible"
msg_2: db 74, "There was an error reading the active partition, so booting isn't possible"

times 440 - ($ - $$) db 0

dd 0 ; the disk signature
dw 0 ; the read-write state of the drive

struc partition_s
.status: resb 1
.base_chs: resb 3
.type: resb 1
.end_chs: resb 3
.base_lba: resd 1
.number_of_sectors: resd 1
endstruc

partition_1:
istruc partition_s
at partition_s.status, db 0x80
at partition_s.base_chs, db 0, 0, 0
at partition_s.type, db 0
at partition_s.end_chs, db 0, 0, 0
at partition_s.base_lba, dd 1
at partition_s.number_of_sectors, dd 0
iend

partition_2:
istruc partition_s
at partition_s.status, db 0
at partition_s.base_chs, db 0, 0, 0
at partition_s.type, db 0
at partition_s.end_chs, db 0, 0, 0
at partition_s.base_lba, dd 0
at partition_s.number_of_sectors, dd 0
iend

partition_3:
istruc partition_s
at partition_s.status, db 0
at partition_s.base_chs, db 0, 0, 0
at partition_s.type, db 0
at partition_s.end_chs, db 0, 0, 0
at partition_s.base_lba, dd 0
at partition_s.number_of_sectors, dd 0
iend

partition_4:
istruc partition_s
at partition_s.status, db 0
at partition_s.base_chs, db 0, 0, 0
at partition_s.type, db 0
at partition_s.end_chs, db 0, 0, 0
at partition_s.base_lba, dd 0
at partition_s.number_of_sectors, dd 0
iend

dw 0xAA55
