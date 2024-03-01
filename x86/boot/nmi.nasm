section .nmi

bits 16
extern nmi_enable
nmi_enable:
    push ax
    in al, 0x70
    and al, 0x7F
    out 0x70, al
    in al, 0x71
    pop ax
    ret

extern nmi_disable
nmi_disable:
    push ax
    in al, 0x70
    or al, 0x80
    out 0x70, al
    in al, 0x71
    pop ax
    ret
