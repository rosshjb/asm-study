.include "debug.s"

.global main

main:
    // operands
    mov x2, #25
    mov x3, #4

    printStr "Inputs:"
    printReg 2
    printReg 3

    // ------------------------------
    mul x4, x2, x3
    printStr "[mul] x4 = x2 * x3:"
    printReg 4

    mneg x4, x2, x3
    printStr "[mneg] x4 = -(x2 * x3):"
    printReg 4

    smull x4, w2, w3
    printStr "[smull] x4 = w2 * w3:"
    printReg 4

    smnegl x4, w2, w3
    printStr "[smnegl] x4 = -(w2 * w3):"
    printReg 4

    umull x4, w2, w3
    printStr "[umull] x4 = w2 * w3:"
    printReg 4
    
    umnegl x4, w2, w3
    printStr "[umnegl] x4 = -(w2 * w3):"
    printReg 4

    // 64-bits operand 1
    ldr x2, =A
    ldr x2, [x2]
    // 64-bits operand 2
    ldr x3, =B
    ldr x3, [x3]
    printStr "Inputs:"
    printReg 2
    printReg 3
    // lower order 64-bits result
    mul x4, x2, x3
    printStr "[mul] x4 = bottom 64-bits of x2 * x3:"
    printReg 4
    // higher order 64-bits result (signed)
    smulh x4, x2, x3
    printStr "[smulh] x4 = top 64-bits of x2 * x3 (signed):"
    printReg 4
    // higher order 64-bits result (unsigned)
    umulh x4, x2, x3
    printStr "[umulh] x4 = top 64-bits of x2 * x3 (unsigned):"
    printReg 4

    // ------------------------------
    mov x0, #0 // exit code
    ret

.data
A: .dword 0x7812345678
B: .dword 0xFABCD12345678901
