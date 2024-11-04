.global _start

.data
arr1: .fill 10, 4, 0
arr1end: .word 0

.text
_start:
    // load the array's address
    ldr x1, =arr1

    // load the first element
    ldr w2, [x1]

    // load the third element
    ldr w2, [x1, #(2*4)]

    // load the third element using register offset
    mov x3, #(2 * 4)
    ldr w2, [x1, x3]

    // load the nineth element(x1 points to the end of the array)
    ldr x1, =arr1end
    ldr w2, [x1, #-(2*4)]
    
    mov x3, #(-2 * 4)
    ldr w2, [x1, x3]

    // load the third element(addr + (2*4))
    ldr x1, =arr1
    mov x3, #2
    ldr w2, [x1, x3, lsl #2]

    // load the third element and update pointer
    ldr w2, [x1, #(2 * 4)]!

    // load x1 with the memory pointed to by x2, and update x2
    // warning [x2] pointers to word, but x1 is qword.
    ldr x2, =arr1
    ldr x1, [x2], #4
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0
