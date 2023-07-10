global dap
global dap_size
global dap_reserved
global dap_number_of_sectors
global dap_buffer_offset
global dap_buffer_segment
global dap_lba_lower
global dap_lba_upper
global disk

read_sectors:
.loop:
    cmp ax, 127
    jbe .reading
    push ax
    mov ax, 127
    call read_sectors
    jc .error
    pop ax
    sub ax, 127
    add cx, 127 * 512 / 16
    add edx, 127
    jmp .loop
.error:
    ret
.reading:
    mov [dap_number_of_sectors], ax
    mov [dap_buffer_offset], bx
    mov [dap_buffer_segment], cx
    mov [dap_lba_lower], edx
    mov dl, [disk]
    mov si, dap
    mov ah, 0x42
    int 0x13
    ret

dap:
dap_size: db 16
dap_reserved: db 0
dap_number_of_sectors: dw 0
dap_buffer_offset: dw 0
dap_buffer_segment: dw 0
dap_lba_lower: dd 0
dap_lba_upper: dd 0

disk db 0x80