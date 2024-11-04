.global _start

_start:
    mov w0, #6 // 1st operand
    mov w1, #3 // 2nd operand
    bl sumfn   
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0

// define local variables offset   
    .equ VAR1,  0
    .equ VAR2,  4
    .equ SUM,   8

sumfn:
    // prolog
    stp lr, fp, [sp, #-16]! // save lr and fp
    sub fp, sp, #16         // adjust frame pointer for local vars.
    sub sp, sp, #16         // room for 3 32-bit local vars.

    // init local vars
    str w0, [fp, #VAR1]
    str w1, [fp, #VAR2]

    // do a bunch of other work, but don't change sp
    ldr w4, [fp, #VAR1]
    ldr w5, [fp, #VAR2]
    add w6, w4, w5
    str w6, [fp, #SUM]

    ldr w0, [fp, #SUM]      // setup return value

    // epilog
    add sp, sp, #16         // release local vars
    ldp lr, fp, [sp], #16   // restore lr and fp
    ret
