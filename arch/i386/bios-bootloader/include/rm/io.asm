section .io
bits 16

; Writes the value of the operand ``value`` to the I/O port with the number
; specified by the value of the operand ``port``.
global __io_outb
__io_outb:
    mov dx, [bp]
    mov al, [bp + 2]
    out dx, al
    ret

; Writes the value of the operand ``value`` to the I/O port with the number
; specified by the value of the operand ``port``.
global __io_outw
__io_outw:
    mov dx, [bp]
    mov ax, [bp + 2]
    out dx, ax
    ret

; Writes the value of the operand ``value`` to the I/O port with the number
; specified by the value of the operand ``port``.
global __io_outd
__io_outd:
    mov dx, [bp]
    mov eax, [bp + 2]
    out dx, eax
    ret

; Reads and returns the value of the I/O port with the number specified by
; the value of the operand ``port``.
global __io_inb
__io_inb:
    mov dx, [bp]
    in al, dx
    ret

; Reads and returns the value of the I/O port with the number specified by
; the value of the operand ``port``.
global __io_inw
__io_inw:
    mov dx, [bp]
    in ax, dx
    ret

; Reads and returns the value of the I/O port with the number specified by
; the value of the operand ``port``.
global __io_ind
__io_ind:
    mov dx, [bp]
    in eax, dx
    ret