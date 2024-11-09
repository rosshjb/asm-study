.global _start

// convert input string to uppercase; assumes only alphabetic characters.
// return length of output string
.macro toupper inputstr, outputstr
    ldr x0, =\inputstr
    ldr x1, =\outputstr
    mov x2, x1              // hold start of outputstr
loop:
    ldrb w3, [x0], #1       // load char and increment input pointer

    // convert to uppercase
    bic w3, w3, #0x20

    strb w3, [x1], #1       // store char and increment out pointer

    // if not null, repeat
    cmp w3, #0
    b.ne loop

    sub x0, x1, x2          // return length of output string
.endm

_start:
    toupper instr, outstr

    // write
    mov x2, x0              // return value is length of the string
    mov x0, #1              // stdout
    ldr x1, =outstr         // string to print
    mov x8, #64
    svc 0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
instr:  .asciz "ThisIsRatherALargeVariableNameAaZz//[`{\n"
.align 4
outstr: .fill 255, 1, 0
