.global _start

_start:
    mov w2, #1      // w2 is iteration index
loop:
    add w2, w2, #1
    cmp w2, #10
    b.le loop

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
