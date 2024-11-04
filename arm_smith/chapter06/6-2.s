.global _start

_start:
    bl myfunc
    mov x1, #4
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0

myfunc:
    str lr, [sp, #-16]! // save lr
    bl myfunc2
    ldr lr, [sp], #16   // restore lr
    ret

myfunc2:
    ret
