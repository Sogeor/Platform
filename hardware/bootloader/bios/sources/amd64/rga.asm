section .rga
bits 16

rga_set_ds:
    push ax
    mov ax, [bp]
    mov ds, ax
    pop ax
    ret

rga_set_es:
    push ax
    mov ax, [bp]
    mov es, ax
    pop ax
    ret

rga_set_fs:
    push ax
    mov ax, [bp]
    mov fs, ax
    pop ax
    ret

rga_set_gs:
    push ax
    mov ax, [bp]
    mov gs, ax
    pop ax
    ret

rga_set_cr0:
    push eax
    mov eax, [bp]
    mov cr0, eax
    pop eax
    ret

rga_get_ds:
    mov ax, ds
    ret

rga_get_es:
    mov ax, es
    ret

rga_get_fs:
    mov ax, fs
    ret

rga_get_gs:
    mov ax, gs
    ret

rga_get_cr0:
    mov eax, cr0
    ret