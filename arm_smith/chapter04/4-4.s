.global _start

_start:
    mov w4, #0      // w4 is iteration index
loop:
    cmp w4, #5
    b.ge loopdone
    add w4, w4, #1
    b loop
loopdone:

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
