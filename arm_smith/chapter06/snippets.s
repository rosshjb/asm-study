.global _start

_start:
    // --- stack frame ---
    sub sp, sp, #16

    // do work but don't change sp, lr, and fp
    str w0, [sp]        // store a
    str w1, [sp, #4]    // store b
    str w2, [sp, #8]    // store c

    add sp, sp, #16
    // -------------------

    // --- stack frame with fp ---
    str fp, [sp, #-16]! // save fp
    sub fp, sp, #16
    sub sp, sp, #16

    // do work but don't change sp and lr
    str w0, [fp]        // store a
    str w1, [fp, #4]    // store b
    str w2, [fp, #8]    // store c

    add sp, sp, #16
    ldr fp, [sp], #16   // restore fp
    // -------------------
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0
