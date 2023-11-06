extern gdtr
extern println

global interrupt
global interrupt_context
global interrupt_callback

; CODE

bits 32

interrupt:
    pushad
    pushfd
    mov eax, ebp
    mov [interrupt_callback], eax
    mov eax, esp
    mov [interrupt_callback + 4], eax
    mov ax, 0x20 ; RM Data
    mov ds, ax
    mov es, ax
    jmp 0x18:.bridge ; RM Code
.bridge:
    bits 16
    mov eax, cr0
    and eax, 0xFFFFFFFFFFFFFFFE
    mov cr0, eax
    jmp 0x00:.call ; Null
.call:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    sti
    mov ax, [interrupt_context + 9]
    mov si, ax
    mov ax, [interrupt_context + 11]
    mov di, ax
    mov ax, [interrupt_context + 1]
    mov bx, [interrupt_context + 3]
    mov cx, [interrupt_context + 5]
    mov dx, [interrupt_context + 7]
    push ax
    mov ax, [interrupt_context]
    cmp word [interrupt_context], 0x10
    pop ax
    je .0x10
    jmp .done
.0x10:
    int 0x10
    jmp .done
.done:
    mov [interrupt_context + 1], ax
    mov [interrupt_context + 3], bx
    mov [interrupt_context + 5], cx
    mov [interrupt_context + 7], dx
    mov ax, si
    mov [interrupt_context + 9], ax
    mov ax, di
    mov [interrupt_context + 11], ax
    cli
    xor ax, ax
    mov ds, ax
    lgdt [gdtr]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x8:.free
.free:
    bits 32
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov eax, [interrupt_callback]
    mov ebp, eax
    mov eax, [interrupt_callback + 4]
    mov esp, eax
    popfd
    popad
    ret

; DATA

interrupt_context:
.code: db 0
.ax: dw 0
.bx: dw 0
.cx: dw 0
.dx: dw 0
.si: dw 0
.di: dw 0

interrupt_callback:
.ebp: dd 0
.esp: dd 0