.global _start

_start:
    // load the address
    ldr x1, =myoctaword

    // load the 128bits into x2 and x3
    ldp x2, x3, [x1]
    // store x2 and x3 into the myoctaword
    stp x2, x3, [x1]
    
    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
myoctaword: .octa 0x12345678876543211234567887654321
