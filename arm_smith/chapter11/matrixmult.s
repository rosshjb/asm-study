.global main

.equ N,         3 // matrix dimensions
.equ WDSIZE,    4 // element size

main:
    // save lr, x19 and x20
    str lr, [sp, #-16]!
    stp x19, x20, [sp, #-16]!

    // initialization for row loop
    mov w1, #N                  // row counter (down to 0)
    ldr x4, =A                  // current row address in first matrix
    ldr x19, =C                 // result matrix address
rowloop:
    // initialization for col loop
    mov w2, #N                  // column counter (down to 0)
    ldr x5, =B                  // current column address in second matrix
colloop:
    // initialization for dot prod loop
    mov x7, #0                 // accumulator
    mov w0, #N                 // dot product counter (down to 0)

    mov x12, x4                // element for current row for dot product
    mov x6, x5                 // element for current column for dot product
dotprodloop:
    // dot product of a row of A with column of B
    ldr w9, [x12], #WDSIZE     // load elem for curr row and incr for next elem
    ldr w10, [x6], #(N*WDSIZE) // load elem for curr col and incr for next elem
    smaddl x7, w9, w10, x7     // multiply and accumulate

    // update dot prod loop counter
    subs w0, w0, #1
    b.ne dotprodloop

    // update col loop counter
    str w7, [x19], #WDSIZE      // store dot prod result and incr for next elem
    add x5, x5, #WDSIZE         // next column
    subs w2, w2, #1
    b.ne colloop

    // update row loop counter
    add x4, x4, #(N*WDSIZE)     // next row
    subs w1, w1, #1
    b.ne rowloop

    // initialization for print loop
    mov w20, #3                 // row counter (down to 0)
    ldr x19, =C                 // current elem address in result matrix
printloop:
    ldr x0, =prtstr
    ldr w1, [x19], #WDSIZE
    ldr w2, [x19], #WDSIZE
    ldr w3, [x19], #WDSIZE
    bl printf

    // update print loop counter
    subs w20, w20, #1
    b.ne printloop

    // set return value
    mov x0, #0

    // restore lr, x19 and x20
    ldp x19, x20, [sp], #16
    ldr lr, [sp], #16

    ret

.data
// first matrix
A:  .word 1, 2, 3
    .word 4, 5, 6
    .word 7, 8, 9
// second matrix
B:  .word 9, 8, 7
    .word 6, 5, 4
    .word 3, 2, 1
// result matrix
C:  .fill 9, 4, 0

prtstr: .asciz "%3d %3d %3d\n"
