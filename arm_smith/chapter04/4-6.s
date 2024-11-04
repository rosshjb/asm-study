.global _start

_start:
    // mask off the high order byte
    mov w6, #0xABFFFFFF
    and w6, w6, #0xFF000000

    // shift the byte down to the low order position
    lsr w6, w6, #24

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
