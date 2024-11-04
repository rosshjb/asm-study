.global _start

_start:
    // store x0 to stack top
    str x0, [sp, #-16]!
    // load stack top to x0
    ldr x0, [sp], #16

    // transfer 16-bytes to and from stack
    stp x0, x1, [sp, #-16]!
    ldp x0, x1, [sp], #16
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0
