.global _start

_start:
    mov w2, #10     // w2 is iteration index
loop:
    subs w2, w2, #1
    b.ne loop

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
