.global _start

.data
mynumber: .quad 0x123456789ABCDEF0

.text
_start:
    // load the address of mynumber into x1
    ldr x1, =mynumber

    // load the word stored at mynumber into x2
    ldr x2, [x1]
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0
