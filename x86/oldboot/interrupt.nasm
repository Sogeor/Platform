section .text

; @author Bloogefest
; @since 0.1.0-alpha
bits 16
global interrupt_istate_reset
interrupt_istate_reset:
    push cx
    push esi
    mov esi, interrupt_istate
    mov cx, 11
.loop:
    mov [esi], dword 0
    add esi, 4
    loop .loop
    pop esi
    pop cx
    ret

; @author Bloogefest
; @since 0.1.0-alpha
bits 16
global interrupt_ostate_reset
interrupt_ostate_reset:
    push cx
    push esi
    mov esi, interrupt_ostate
    mov cx, 11
.loop:
    mov [esi], dword 0
    add esi, 4
    loop .loop
    pop esi
    pop cx
    ret

; @author Bloogefest
; @since 0.1.0-alpha
bits 16
global interrupt_dump
interrupt_dump:
    pushf
    pop dword [interrupt_ostate + 40]
    mov [interrupt_ostate + 38], gs
    mov [interrupt_ostate + 36], fs
    mov [interrupt_ostate + 34], es
    mov [interrupt_ostate + 32], ds
    mov [interrupt_ostate + 28], ebp
    mov [interrupt_ostate + 24], esp
    mov [interrupt_ostate + 20], edi
    mov [interrupt_ostate + 16], esi
    mov [interrupt_ostate + 12], edx
    mov [interrupt_ostate + 8], ecx
    mov [interrupt_ostate + 4], ebx
    mov [interrupt_ostate], eax
    ret

; @author Bloogefest
; @since 0.1.0-alpha
bits 16
global interrupt
interrupt:
    pushf
    push gs
    push fs
    push es
    push ds
    push edi
    push esi
    push edx
    push ecx
    push ebx
    push eax
    mov eax, esp
    sub eax, 36
    mov al, [eax]
    mov [.opcode + 1], al ; set number of interrupt in opcode
    mov [.esp], esp
    mov [.ebp], ebp
    mov eax, [interrupt_istate]
    mov ebx, [interrupt_istate + 4]
    mov ecx, [interrupt_istate + 8]
    mov edx, [interrupt_istate + 12]
    mov esi, [interrupt_istate + 16]
    mov edi, [interrupt_istate + 20]
    mov esp, [interrupt_istate + 24]
    mov ebp, [interrupt_istate + 28]
    mov ds, [interrupt_istate + 32]
    mov es, [interrupt_istate + 34]
    mov fs, [interrupt_istate + 36]
    mov gs, [interrupt_istate + 38]
    push dword [interrupt_istate + 40]
    popf
.opcode: db 0xCD, 0
    pushf
    pop dword [interrupt_ostate + 40]
    mov [interrupt_ostate + 38], gs
    mov [interrupt_ostate + 36], fs
    mov [interrupt_ostate + 34], es
    mov [interrupt_ostate + 32], ds
    mov [interrupt_ostate + 28], ebp
    mov [interrupt_ostate + 24], esp
    mov [interrupt_ostate + 20], edi
    mov [interrupt_ostate + 16], esi
    mov [interrupt_ostate + 12], edx
    mov [interrupt_ostate + 8], ecx
    mov [interrupt_ostate + 4], ebx
    mov [interrupt_ostate], eax
    mov ebp, [.ebp]
    mov esp, [.esp]
    pop eax
    pop ebx
    pop ecx
    pop edx
    pop esi
    pop edi
    pop ds
    pop es
    pop fs
    pop gs
    popf
    ret
.esp: dd 0
.ebp: dd 0

global interrupt_istate
interrupt_istate: times 44 db 0

global interrupt_ostate
interrupt_ostate: times 44 db 0
