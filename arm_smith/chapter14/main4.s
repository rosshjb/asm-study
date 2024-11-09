.global _start

_start:
    ldr x0, =instr      // start of input string
    ldr x1, =outstr     // address of output string
    bl toupper

    // write
    mov x2, x0          // return value of toupper is the string length
    mov x0, #1          // stdout
    ldr x1, =outstr     // string to print
    mov x8, #64
    svc 0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
instr: .asciz "This is our Test String that we will convert.AaZz@[`{\n"
       .align 4
outstr: .fill 255, 1, 0
