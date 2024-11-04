.MACRO toupper instr, outstr
    ldr x0, =\instr
    ldr x1, =\outstr
    mov x2, x1

// loop  
1:
    ldrb w3, [x0], #1   // load char and increment input pointer

    // if w3 > 'z' then goto cont
    cmp w3, #'z'
    b.gt 2f
    // else if w3 < 'a' then goto cont
    cmp w3, #'a'
    b.lt 2f
    // else then convert it.
    sub w3, w3, #('a'-'A')
2:
    strb w3, [x1], #1   // store converted char and increment output pointer
    // if not null, then repeat
    cmp w3, #0
    b.ne 1b
    
    sub x0, x1, x2      // length : changed out str pointer - original out str pointer
.endm
