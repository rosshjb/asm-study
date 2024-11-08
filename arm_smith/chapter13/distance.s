.global distance

// inputs: x0 - pointer to 8 floating-point numbers
//              (a1, a2, a3, a4), (b1, b2, b3, b4)
distance:
    // load each 4 numbers at once
    ldp q2, q3, [x0]

    fsub  v1.4s, v2.4s, v3.4s // a_i - b_i   for each lane i in 1..4
    fmul  v1.4s, v1.4s, v1.4s // (a_i-b_i)^2 for each lane i in 1..4
    faddp v0.4s, v1.4s, v1.4s // 1:[(a_1-b_1)^2+(a_2-b_2)^2], 2:[(a_3-b_3)^2+(a_4-b_4)^2], 3:[...], 4:[...]
    faddp v0.4s, v0.4s, v0.4s // 1:[(a_1-b_1)^2+(a_2-b_2)^2+(a_3-b_3)^2+(a_4-b_4)^2], 2:[...], 3:[...], 4:[...]
    
    fsqrt s4, s0              // sqrt of lane 1
    
    fmov w0, s4               // return value
    ret
