.global _start

download_credit_card_numbers:
    // write
    mov x0, #1                  // stdout
    ldr x1, =get_credit_cards   // string to print   
    mov x2, #30                 // length of the string
    mov x8, #64
    svc 0

    ret

call_toupper:
    str lr, [sp, #-16]!         // save lr
    sub sp, sp, #16             // local output buffer
    
    ldr x0, =instr              // 1st arg for toupper; input string
    mov x1, sp                  // 2nd arg for toupper; output buffer
    bl toupper

    add sp, sp, #16             // free local output buffer
    ldr lr, [sp], #16           // restore lr

    ret

_start:
    bl call_toupper

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
instr: .ascii "This is our Test" // input string
       .dword 0xb0               // for upper to overwrite LR to download_credit_card_numbers

get_credit_cards: .asciz "Downloading Credit Card Data!\n"
                  .align 4
