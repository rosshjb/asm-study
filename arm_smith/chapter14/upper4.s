.global toupper

.equ N, 4

// inputs
// - x0   : address of fixed length input string
// - x1   : address of output string
// output : length of the output string
toupper:
    ldr x2, =aaas
    ldr q1, [x2]                // load all a's
    ldr x2, =endch
    ldr q3, [x2]                // load all ('z'-'a')s
    ldr x2, =spaces
    ldr q8, [x2]                // load all spaces

    mov w3, #N                  // loop counter (down to 0), maximum string length 16*4=64
loop:
    ldr q0, [x0], #16           // load 16 chars from input string and update input pointer for next block
    sub v2.16b, v0.16b, v1.16b  // shift all 16 chars range ['a','z'] to ['a'-'a', 'z'-'a']

    // choose chars in the lowercase range ['a'-'a', 'z'-'a']
    cmhi v2.16b, v2.16b, v3.16b
    not v2.16b, v2.16b

    // extract only bit 0x20 from lowercase letters
    and v2.16b, v2.16b, v8.16b

    // capitalize letters by removing 0x20 bit
    bic v0.16b, v0.16b, v2.16b

    // store chars to output string
    str q0, [x1], #16

    // update loop counter
    subs w3, w3, #1
    b.ne loop

    mov x0, #(N*16)             // return length of string
    ret

.data
aaas:   .fill 16, 1, 'a'        // to shift range of all chars in neon register
endch:  .fill 16, 1, 'z'-'a'    // to determine whether shifted chars are in lowercase range
spaces: .fill 16, 1, 0x20       // spaces for bic
