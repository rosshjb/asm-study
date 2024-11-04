.global _start

_start:
    // string to print
    mov x4, #0x6e3a
    movk x4, #0x4f5d, lsl #16
    movk x4, #0xfedc, lsl #32
    movk x4, #0x1234, lsl #48

    // initialize vars for overwritten string
    ldr x1, =hexstr
    add x1, x1, #17 // start at least 'G'
    
    // initialize loop counter
    mov w5, #16
loop:
    and w6, w4, #0xf // extract a nibble
    
    // if it is a letter
    cmp w6, #10
    b.ge letter
    // else it is a number
    add w6, w6, #'0'
    b cont
letter:
    add w6, w6, #('A'-10) // convert to char ascii
cont:
    // store ascii
    strb w6, [x1]
    sub x1, x1, #1 // next char
    lsr x4, x4, #4 // shift off for next nibble

    // counter update
    subs w5, w5, #1
    b.ne loop

    // write
    mov x0, #1
    ldr x1, =hexstr
    mov x2, #19
    mov x8, #64
    svc 0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
hexstr: .ascii "0x123456789ABCDEFG\n"
