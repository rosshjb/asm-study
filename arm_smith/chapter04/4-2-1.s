.global _start

_start:
    mov x4, #45
    cmp x4, #45
    b.eq _start

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
