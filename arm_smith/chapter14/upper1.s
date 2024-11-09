.global toupper

// inputs
// - x0 : address of input string
// - x1 : address of output string
// output : length of the uppercase output string

toupper:
    mov x4, x1              // back up address of output string
loop:
    ldrb w5, [x0], #1       // load char and increment input pointer
    
    // shift lower case range from ['a', 'z'] to ['a'-'a', 'z'-'a']
    sub w6, w5, #'a'
    
    // Let's treat the w6 as unsigned. if w5 is greater than 'z'; if it is not a lowercase letter
    cmp w6, #('z'-'a')
    b.hi cont
    
    // Now the letter is lowercase, so convert it
    sub w5, w5, #('a'-'A')
    
cont:
    strb w5, [x1], #1       // store char to output string and increment out pointer
    // if not null, repeat
    cmp w5, #0
    b.ne loop

    sub x0, x1, x4          // return length of output string
    ret
