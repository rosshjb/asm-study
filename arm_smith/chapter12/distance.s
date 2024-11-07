.global distance

// x0 - pointer to the 4 floating point numbers (x1,y1), (x2,y2)
distance:
    // save lr
    str lr, [sp, #-16]!

    // load 4 floats
    ldp s0, s1, [x0], #8
    ldp s2, s3, [x0]
    
    fsub s4, s2, s0     // (x2-x1)
    fsub s5, s3, s1     // (y2-y1)
    fmul s4, s4, s4     // (x2-x1)^2
    fmul s5, s5, s5     // (y2-y1)^2
    fadd s4, s4, s5     // (x2-x1)^2 + (y2-y1)^2
    fsqrt s4, s4        // sqrt of (x2-x1)^2 + (y2-y1)^2
    
    fmov w0, s4         // return value

    // restore lr
    ldr lr, [sp], #16
    ret
