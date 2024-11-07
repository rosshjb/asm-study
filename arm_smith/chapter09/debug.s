.macro printReg reg
    stp x0,  x1,  [sp, #-16]!
    stp x2,  x3,  [sp, #-16]!
    stp x4,  x5,  [sp, #-16]!
    stp x6,  x7,  [sp, #-16]!
    stp x8,  x9,  [sp, #-16]!
    stp x10, x11, [sp, #-16]!
    stp x12, x13, [sp, #-16]!
    stp x14, x15, [sp, #-16]!
    stp x16, x17, [sp, #-16]!
    stp x18, lr,  [sp, #-16]!
    
    // must move x1, x2 and x3 first (If not, when \reg is x0, the \reg is overwritten)
    mov x1, #\reg       // for %u
    mov x2, x\reg       // for %d
    mov x3, x\reg       // for %x
    ldr x0, =ptfStr     // format str
    bl printf

    ldp x18, lr,  [sp], #16
    ldp x16, x17, [sp], #16
    ldp x14, x15, [sp], #16
    ldp x12, x13, [sp], #16
    ldp x10, x11, [sp], #16
    ldp x8,   x9, [sp], #16
    ldp x6,   x7, [sp], #16
    ldp x4,   x5, [sp], #16
    ldp x2,   x3, [sp], #16
    ldp x0,   x1, [sp], #16
.endm

.macro printStr str
    stp x0,  x1,  [sp, #-16]!
    stp x2,  x3,  [sp, #-16]!
    stp x4,  x5,  [sp, #-16]!
    stp x6,  x7,  [sp, #-16]!
    stp x8,  x9,  [sp, #-16]!
    stp x10, x11, [sp, #-16]!
    stp x12, x13, [sp, #-16]!
    stp x14, x15, [sp, #-16]!
    stp x16, x17, [sp, #-16]!
    stp x18, lr,  [sp, #-16]!

    ldr x0, =1f         // print str
    bl printf

    ldp x18, lr,  [sp], #16
    ldp x16, x17, [sp], #16
    ldp x14, x15, [sp], #16
    ldp x12, x13, [sp], #16
    ldp x10, x11, [sp], #16
    ldp x8,   x9, [sp], #16
    ldp x6,   x7, [sp], #16
    ldp x4,   x5, [sp], #16
    ldp x2,   x3, [sp], #16
    ldp x0,   x1, [sp], #16
    b 2f
1:  .asciz "\str\n"
    .align 4
2:
.endm

.data
ptfStr: .asciz "x%-2u = %32ld, 0x%016lx\n"
.align 4
.text
