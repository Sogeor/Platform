extern __gdtr

global __interrupt__
global __interrupt_context

section .bios
bits 32

__interrupt__:
    ret

__interrupt_context:
__interrupt_context_code: db 0
__interrupt_context_ax: dw 0
__interrupt_context_bx: dw 0
__interrupt_context_cx: dw 0
__interrupt_context_dx: dw 0
__interrupt_context_si: dw 0
__interrupt_context_di: dw 0