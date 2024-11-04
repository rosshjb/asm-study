.global _start

_start:
    // w5 = 9
    // if w5 < 10, then w5 = 111
    // else if w5 >= 10, then w5 = 101
    // w5 = 0

    mov w5, #9

    cmp w5, #10
    b.ge elseclause
    mov w5, #111
    b endif
elseclause:
    mov w5, #101
endif:
    mov w5, #0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
