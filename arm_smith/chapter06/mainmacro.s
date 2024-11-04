.include "uppermacro.s"

.global _start

_start:
    // convert first string tststr
    toupper tststr, buffer

    // write
    mov x2, x0          // return value(length of the string)
    mov x0, #1          // stdout
    ldr x1, =buffer     // string to print
    mov x8, #64         // write
    svc 0

    // convert second string tststr2
    toupper tststr2, buffer

    // write
    mov x2, x0          // return value(length of the string)
    mov x0, #1          // stdout
    ldr x1, =buffer     // string to print
    mov x8, #64         // write
    svc 0

    // exit
    mov x0, #0          // exit code
    mov x8, #93         // exit
    svc 0

.data
tststr:     .asciz  "This is our Test String that we will convert.\n"
tststr2:    .asciz  "A second string to upper case!!\n"
buffer:     .fill   255, 1, 0
