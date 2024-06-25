org 0x7C00
bits 16

%if PMSTAGE_SIZE > 43
%error "PMSTAGE SIZE IS TOO BIG"
%endif

jmp 0:_start
_start:
    hlt

times 440 - ($ - $$) db 0
times 6 db 0

p1: times 16 db 0
p2: times 16 db 0
p3: times 16 db 0
p4: times 16 db 0

dw 0xAA55
