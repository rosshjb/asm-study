.global _start

_start:
    ldr x4, =instr  // start of input string
    ldr x3, =outstr // address of output string

loop:
    // load input character and increment output pointer
    ldrb w5, [x4], #1   

    // if w5 > 'z' then goto cont
    cmp w5, #'z'
    b.gt cont
    // else if w5 < 'a' then goto cont
    cmp w5, #'a'
    b.lt cont
    // else this letter is lowercase, covert it
    sub w5, w5, #('a'-'A')
cont:
    strb w5, [x3], #1   // store char to output str
    // if doesn't hit null, repeat
    cmp w5, #0
    b.ne loop

    // write
    mov x0, #1
    ldr x1, =outstr
    sub x2, x3, x1      // get the length
    mov x8, #64
    svc 0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
instr: .asciz "This is our Test String that we will convert.\n"
outstr: .fill 255, 1, 0
