.global main

.equ N, 100 // the number of additions

main:
    // save x19, x20 and lr
    stp x19, x20, [sp, #-16]!
    str lr, [sp, #-16]!

    // add up 0.01 hundred times
    mov w19, #N             // loop counter (down to 0)
    ldr x0, =cent
    ldp s0, s1, [x0], #8    // load 0.01 and running sum 0.0
    ldr s2, [x0]            // load 1.00
loop:
    fadd s1, s1, s0
    subs w19, w19, #1
    b.ne loop

    // store running sum
    ldr x0, =runsum
    str s1, [x0]   

    // compare running sum to real sum
    fcmp s1, s2
    b.eq equal

    // print not equal result
    ldr x0, =notequalstr
    bl printf
    b next

equal:
    // print equal result
    ldr x0, =equalstr
    bl printf

    // compare two floats with tolerance
next:
    ldr x0, =runsum // load pointer to running sum, real sum and epsilon
    bl fpcomp

    // 1 if equal, else 0
    cmp x0, #1
    b.eq equal2

    // print not equal result
    ldr x0, =notequalstr
    bl printf
    b done

equal2:
    // print equal result
    ldr x0, =equalstr
    bl printf

done:
    mov x0, #0  // return value

    // restore x19, x20 and lr
    ldr lr, [sp], #16
    ldp x19, x20, [sp], #16

    ret

.data
    cent:           .single 0.01
    runsum:         .single 0.0
    sum:            .single 1.00
    epsilon:        .single 0.00001
    equalstr:       .asciz "equal\n"
    notequalstr:    .asciz "not equal\n"
