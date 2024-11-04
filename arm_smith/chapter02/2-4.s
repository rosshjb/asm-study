.global _start

_start:
    // first 64-bit number is 0x0000000000000003FFFFFFFFFFFFFFFF
    mov x2, #0x0000000000000003
    mov x3, #0xFFFFFFFFFFFFFFFF

    // second 64-bit number is 0x00000000000000050000000000000001
    mov x4, #0x0000000000000005
    mov x5, #0x0000000000000001

    adds x1, x3, x5 // lower order 64-bits
    adc  x0, x2, x4 // higher order 64-bits

    // w0 is the exit code
    mov x8, #93 // exit
    svc 0       // system call
