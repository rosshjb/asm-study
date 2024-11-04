.global _start

_start:
    // Load x2 with 0x1234fedc4f5d6e3a first using mov and movk
    mov x2, #0x6e3a
    movk x2, #0x4f5d, lsl #16
    movk x2, #0xfedc, lsl #32
    movk x2, #0x1234, lsl #48

    // just move w2 into w1
    mov w1, w2

    // lets see all the shift versions of mov
    mov x1, x2, lsl #1  // logical shift left
    mov x1, x2, lsr #1  // logical shift right
    mov x1, x2, asr #1  // arithmetic shift right
    mov x1, x2, ror #1  // rotate right

    // repeat the above shifts using mnemonics
    lsl x1, x2, #1      // logical shift left
    lsr x1, x2, #1      // logical shift right
    asr x1, x2, #1      // arithmetic shift right
    ror x1, x2, #1      // rotate right

    // example that works
    mov x1, #0xab000000 // too big for #imm16

    // example that can't be represented and results in an error
    // mov x1, #0xabcdef11

    // example of movn
    movn w1, #45

    // example of a mov that the assembler will change to movn
    mov w1, #0xfffffffe

    // exit
    mov x0, #0
    mov x8, #93
    svc 0
