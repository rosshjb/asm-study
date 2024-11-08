.global main

main:
    // save x19, x20 and sp
    stp x19, x20, [sp, #-16]!
    str lr, [sp, #-16]!

    // load the each columns of matrix A into neon registers d0, d1, d2
    ldr x0, =A
    ldp d0, d1, [x0], #(2 * 8)
    ldr d2, [x0]

    // load the each columns of matrix B into neon registers d3, d4, d5
    // the elems of a column will be placed in each lanes 4h[0], 4h[1], 4h[2]
    ldr x0, =B
    ldp d3, d4, [x0], #(2 * 8)
    ldr d5, [x0]

// 1. multiply                A's 1st col with B's curr col's 1st elem
// 2. multiply and accumulate A's 2nd col with B's curr col's 2nd elem
// 3. multiply and accumulate A's 3rd col with B's curr col's 3rd elem
.macro mulcol ccolumn bcolumn
    mul \ccolumn\().4h, v0.4h, \bcolumn\().4h[0]
    mla \ccolumn\().4h, v1.4h, \bcolumn\().4h[1]
    mla \ccolumn\().4h, v2.4h, \bcolumn\().4h[2]
.endm

    mulcol v6, v3   // C column 1 = A columns * B column 1
    mulcol v7, v4   // C column 2 = A columns * B column 2
    mulcol v8, v5   // C column 3 = A columns * B column 3

    // store the result of matrix multiplication
    ldr x1, =C
    stp d6, d7, [x1], #(2 * 8)
    str d8, [x1]

    // initialization for print loop
    mov w19, #3     // loop counter (rows; down to zero)
    ldr x20, =C
printloop:
    // print result matrix in row column order
    ldr x0, =prtstr
    ldrh w1, [x20], #2              // first  element in current row
    ldrh w2, [x20, #(2 * 4 - 2)]    // second element in current row
    ldrh w3, [x20, #(2 * 8 - 2)]    // third  element in current row
    bl printf
    
    // update loop counter for printloop
    subs w19, w19, #1
    b.ne printloop

    mov x0, #0                      // return value
    
    // restore x19, x20 and lr
    ldr lr, [sp], #16
    ldp x19, x20, [sp], #16
    
    ret

.data
// A : 1 2 3  B : 9 8 7  C : 0 0 0
//     4 5 6      6 5 4      0 0 0
//     7 8 9      3 2 1      0 0 0 
// first matrix in column major order (with ignored extra elem to match neon register size)
A:  .short 1, 4, 7, 0
    .short 2, 5, 8, 0
    .short 3, 6, 9, 0
// second matrix in column major order (with ignored extra elem to match neon register size)
B:  .short 9, 6, 3, 0
    .short 8, 5, 2, 0
    .short 7, 4, 1, 0
// result matrix in column major order (with ignored extra elem to match neon register size)
C:  .fill (3+1)*3, 2, 0

prtstr: .asciz "%3d %3d %3d\n"
