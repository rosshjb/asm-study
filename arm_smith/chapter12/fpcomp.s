.global fpcomp

// inputs x0 : pointer to the 3 floating-point numbers
//             float x1, float x2, tolerance(epsilon) e
// output x0 : 1 if x1 and x2 are equal, else 0
fpcomp:
    ldp s0, s1, [x0], #8    // load x1 and x2
    ldr s2, [x0]            // load e
    
    // |x2-x1|
    fsub s3, s1, s0
    fabs s3, s3

    // if |x2-x1| < e, then 1 else 0
    fcmp s3, s2
    b.ge notequal

    mov x0, #1
    b done
notequal:
    mov x0, #0
done:
    ret
