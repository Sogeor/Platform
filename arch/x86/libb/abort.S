.globl abort
.text

abort:
    hlt
    jmp abort
