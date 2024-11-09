.global toupper

// inputs
//  - x0 : address of input string
//  - x1 : address of output string
// output : the length of uppercase output string
toupper:
    mov x4, x1          // back up address of output string
loop:
    ldrb w5, [x0], #1   // load char and increment output pointer
    
    // shift lower case range from ['a', 'z'] to ['a'-'a', 'z'-'a']
    sub w6, w5, #'a'

    // let's treat the w6 as unsigned; if char is <= 'z', it is lowercase
    cmp w6, #('a'-'A')
    sub w6, w5, #('a'-'A')  // if lowercase, this is the uppercase, else meaningless
    csel w5, w6, w5, ls     // Use w6 if lowercase, otherwise use original char w5

    strb w5, [x1], #1       // store char to output string and increment out pointer
    // if not null, repeat
    cmp w5, #0
    b.ne loop

    sub x0, x1, x4          // return length of output string

    ret
