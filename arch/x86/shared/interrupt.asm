global interrupt

interrupt:
    pushad
    push ds
    push es
    push fs
    push gs
    pushfd
    mov eax, [bp]
    cmp eax, interrupt_current_state
    je .free
    mov bl, [bp + 4]
    mov [.call + 1], bl ; self-modifying code
    push dword [eax] ; eax
    push dword [eax + 4] ; ebx
    push dword [eax + 8] ; ecx
    push dword [eax + 12] ; edx
    push dword [eax + 16] ; esi
    push dword [eax + 20] ; edi
    push word [eax + 24] ; ds
    push word [eax + 26] ; es
    push word [eax + 28] ; fs
    push word [eax + 30] ; gs
    push dword [eax + 32] ; eflags
    mov eax, [eax]
    mov ebx, [eax + 4]
    mov ecx, [eax + 8]
    mov edx, [eax + 12]
    mov esi, [eax + 16]
    mov edi, [eax + 20]
    mov ds, [eax + 24]
    mov es, [eax + 26]
    mov fs, [eax + 28]
    mov gs, [eax + 30]
    mov eflags, [eax + 32]
.call: int 0

.free:
    popfd
    pop gs
    pop fs
    pop es
    pop ds
    popad
    ret
