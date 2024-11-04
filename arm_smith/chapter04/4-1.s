.global _start

_start:
l1:
    mov x1, #1
    b _start

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
