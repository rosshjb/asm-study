.include "debug.s"

.global main

main:
    // operands
    mov x2, #1000
    mov x3, #4

    printStr "Inputs:"
    printReg 2
    printReg 3

    // --------------------------
    sdiv x4, x2, x3
    printStr "[sdiv] x4 = x2 / x3 (signed):"
    printReg 4

    udiv x4, x2, x3
    printStr "[udiv] x4 = x2 / x3 (unsigned):"
    printReg 4
    
    // ----- division by 0 ------
    mov x3, #0
    sdiv x4, x2, x3
    printStr "[sdiv] x4 = x2 / 0  (signed):"
    printReg 4

    // --------------------------
    mov x0, #0  // exit code
    ret
