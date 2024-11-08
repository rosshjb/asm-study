.global main

.equ N, 3   // the number of pair of 4D vectors.

main:
    // save x19, x20 and lr
    stp x19, x20, [sp, #-16]!
    str lr, [sp, #-16]!

    ldr x20, =points        // pointer to current pair of vectors
    mov w19, #N             // loop counter (down to 0)
loop:
    mov x0, x20
    bl distance

    fmov s2, w0             // move into fpu to convert to double
    fcvt d0, s2

    fmov x1, d0             // 2nd arg for printf
    ldr x0, =prtstr         // 1st arg for printf
    bl printf

    add x20, x20, #(8*4)    // next pair of vectors
    subs w19, w19, #1
    b.ne loop

    mov x0, #0              // return value

    // restore x19, x20 and lr
    ldr lr, [sp], #16
    ldp x19, x20, [sp], #16

    ret

.data
points: .single      0.0,     0.0,   0.0,      0.0, 17.0,   4.0, 2.0,    1.0
        .single      1.3,     5.4,   3.1,     -1.5, -2.4, 0.323, 3.4, -0.232
        .single 1.323e10, -1.2e-4, 34.55, 5454.234, 10.9,  -3.6, 4.2,    1.3

prtstr: .asciz "Distance = %f\n"
