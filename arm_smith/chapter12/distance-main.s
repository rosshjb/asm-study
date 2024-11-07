.global main

.equ N, 3   // the number of points

main:
    // save x19, x20 and lr
    stp x19, x20, [sp, #-16]!
    str lr, [sp, #-16]!
    
    ldr x20, =points         // pointer to current point
    mov w19, #N              // loop counter (down to 0)
loop:
    mov x0, x20              // parameter for distance
    bl distance

    fmov s2, w0              // move to fpu for conversion to double
    fcvt d0, s2              // convert to double

    fmov x1, d0              // 2nd arg for printf
    ldr x0, =prtstr          // 1st arg for printf
    bl printf

    add x20, x20, #(4*4)     // next point
    subs w19, w19, #1
    b.ne loop

    mov x0, #0               // return value
    
    // restore x19, x20 and lr
    ldr lr, [sp], #16
    ldp x19, x29, [sp], #16

    ret

.data
points: .single 0.0,       0.0,     3.0,     4.0
        .single 1.3,       5.4,     3.1,    -1.5
        .single 1.323e10, -1.2e-4, 34.55, 5454.234
prtstr: .asciz "Distance = %f\n"
