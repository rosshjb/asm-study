.include "debug.s"

.global main

main:
    str lr, [sp, #-16]! // save lr

    // First 64-bit number is 0x0000000000000003FFFFFFFFFFFFFFFF
    mov x2, #0x0000000000000003
    mov x3, #0xFFFFFFFFFFFFFFFF // will change to movn

    // Second 64-bit number is 0x00000000000000050000000000000001
    mov x4, #0x0000000000000005
    mov x5, #0x0000000000000001

    printStr "Inputs:"
    printReg 2
    printReg 3
    printReg 4
    printReg 5
    
    adds x1, x3, x5 // lower order word
    adc  x0, x2, x4 // higher order world

    printStr "Outputs:"
    printReg 1
    printReg 0

    mov x0, #0          // return value

    ldr lr, [sp], #16   // restore lr
    ret
