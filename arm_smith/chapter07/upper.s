.global toupper

// x0 : address of input string
// x1 : address of output string 
toupper:
    mov x4, x1
loop:
    ldrb w5, [x0], #1 // load char and increment input pointer

    // if w5 > 'z' then goto cont
    cmp w5, #'z'
    b.gt cont
    // else if w5 < 'a' then goto cont
    cmp w5, #'a'
    b.lt cont
    // else then convert to upper case.
    sub w5, w5, #('a'-'A')
cont:
    strb w5, [x1], #1 // store char and increment output ptr
    // if not null, repeat
    cmp w5, #0
    b.ne loop

    sub x0, x1, x4    // get the length and return it
    ret
