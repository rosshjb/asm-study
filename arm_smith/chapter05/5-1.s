.global _start

.data
helloworld: .ascii "Hello World!"

// sample memory directives
label1:
    .byte 74, 0112, 0b00101010, 0x4A, 0X4a, 'J', 'H'+2
    .word 0x1234ABCD, -1434
    .quad 0x123456789ABCDEF0
    .ascii "Hello World\n"

// sample prefix operators
label2:
    .byte -0x45, -33, ~0b00111001

// define larger set of memory
label3:
    .fill 10, 4, 0

// repeat a value of given size, repeat times
label4:
    .rept 3
    .byte 0, 1, 2
    .endr

// aligning data
label5:
    .byte 0x3F
    .align 4
    .word 0x12345678

// loading a register with an address
.text
_start:
    ldr x1, =helloworld
    ldr x1, =0x1234ABCDDCBA4321
    adr x1, helloworld2

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

helloworld2: .ascii "HELLO WORLD!"
