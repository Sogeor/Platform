section .enjoy
bits 16

times 512 db 0 ; reserve memory for header sector

jdit: ; just do it!
    mov ax, dx ; TODO: write normal enjoy algorythm (& jmp to main)
.halt:
    hlt
    jmp .halt
