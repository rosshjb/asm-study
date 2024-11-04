.global _start

_start:
    bl myFunction   

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

// ----- helpers ----- //
.macro push1 register
    str \register, [sp, #-16]!
.endm

.macro pop1 register
    ldr \register, [sp], #16
.endm

.macro push2 register1, register2
    stp \register1, \register2, [sp, #-16]!
.endm

.macro pop2 register1, register2
    ldp \register1, \register2, [sp], #16
.endm
// ------------------- //

myFunction:
    push1 lr
    push2 x20, x23
    // ...
    pop2 X20, X23
    pop1 lr
    ret
