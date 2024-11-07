.global _start

_start:
    // save and restore fpu(or neon) registers
    stp q8, q9, [sp, #-32]!
    str q10,    [sp, #-16]!
    // ...do work
    ldr q10, [sp], #16
    ldp q8, q9, [sp], #32

    // load and store fpu registers from/to memory
    ldr x1, =fp1
    ldr s4, [x1]        // load fp1
    ldr d5, [x1, #4]    // load fp2
    str s4, [x1, #12]   // store fp1 to fp3
    str d5, [x1, #16]   // store fp2 to fp4

    // move data between CPU registers and FPU registers
    fmov h1, w2
    fmov w2, h1
    fmov s1, w2
    fmov x1, d2
    fmov d2, d3
    
    // operations
    fadd h1, h2, h3         // h1 = h2 + h3
    fadd s1, s2, s3         // s1 = s2 + s3
    fadd d1, d2, d3         // d1 = d2 + d3
    fsub d1, d2, d3         // d1 = d2 - d3
    fmul d1, d2, d3         // d1 = d2 * d3
    fdiv d1, d2, d3         // d1 = d2 / d3
    fmadd d1, d2, d3, d4    // d1 = d4 + d2 * d3
    fmsub d1, d2, d3, d4    // d1 = d4 - d2 * d3
    fneg d1, d2             // d1 = -d2
    fabs d1, d2             // d1 = |d2|
    fmax d1, d2, d3         // d1 = max(d2, d3)
    fmin d1, d2, d3         // d1 = min(d2, d3)
    fsqrt d1, d2            // d1 = sqrt(d2)
    
    // conversions
    fcvt d1, s2             // single precision to double precision
    fcvt s1, d2             // double precision to single precision
    fcvt s1, h2             // half   precision to single precision
    fcvt h1, s2             // single precision to half   precision

    scvtf d1, x1            // signed integer to double precision
    ucvtf s1, w1            // unsigned integer to single precision

    fcvtas w1, h1           // half   precision to signed   integer (round to nearest)
    fcvtau w1, s1           // single precision to unsigned integer (round to nearest)
    fcvtms x1, d1           // double precision to signed   integer (round towards -infinity)
    fcvtmu x1, d1           // double precision to unsigned integer (round towards -infinity)
    fcvtps x1, d1           // double precision to signed   integer (round towards +infinity)
    fcvtpu x1, d1           // double precision to unsigned integer (round towards +infinity)
    fcvtzs x1, d1           // double precision to signed   integer (round towards 0)
    fcvtzu x1, d1           // double precision to unsigned integer (round towards 0)
    
    // comparing floating-point numbers
    fcmp h1, h2             // half precision 
    fcmp h1, #0.0
    fcmp s1, s2             // single precision
    fcmp s1, #0.0
    fcmp d1, d2             // double precision
    fcmp d1, #0.0

    // exit
    mov x0, #0
    mov x8, #93
    svc 0

.data
// an example of IEEE-754 floating point numbers
.single 1.343, 4.343e20, -0.4343, -0.4444e-10
.double -4.24322322332e-10, 3.141592653589793

fp1: .single 3.14159
fp2: .double 4.3341
fp3: .single 0.0
fp4: .double 0.0
