title 12-2-6

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 12-2-6
.data
    x real8 1.2
    y real8 3.0
    n dword 0

    val1 real8 2.0

    epsilon real8 1.0E-12   ; small user-defined value (maximum difference)
    val2 real8 0.0          ; value to compare
    val3 real8 1.001E-13    ; considered equal to val2
.code
    ; if (x < y)
    ;     n = 1
    finit
    fld x               ; st(0) = x
    fcomp y             ; compare st(0) to y
    fnstsw ax           ; move status word into AX
    sahf                ; copy AH into EFLAGS (ZF = 0, PF = 0, CF = 1)
    jnb L1              ; x not < y? skip
    mov n, 1            ; n = 1
L1: nop

    finit
    fld y               ; st(0) = y
    fld x               ; st(0) = x, st(1) = y
    fcomi st(0), st(1)  ; compare st(0) to st(1). (ZF = 0, PF = 0, CF = 1)
    jnb L2              ; st(0) not < st(1)? skip
    mov n, 1            ; n = 1
L2: nop

    finit
    fld val1            ; st(0) = +2.0000000000000000e+0000
    fsqrt               ; st(0) = +1.4142135623730950e+0000
    fmul st(0), st(0)   ; st(0) = +2.0000000000000000e+0000
    fsub val1           ; st(0) = -1.0842021724855044e-0019

    finit
    fld epsilon         ; st(0) = +9.9999999999999998e-0013
    fld val2            ; st(0) = +0.0000000000000000e+0000,
                        ; st(1) = +9.9999999999999998e-0013
    fsub val3           ; st(0) = -1.0009999999999999e-0013
                        ; st(1) = +9.9999999999999998e-0013
    fabs                ; st(0) = +1.0009999999999999e-0013
                        ; st(1) = +9.9999999999999998e-0013
    fcomi st(0), st(1)  ; st(0) < st(1). ZF = 0, PF = 0, CF = 1
    ja skip
    mov n, 1            ; n = 1
skip: nop

; 12-2-8
.data
    intVal dword 25
.code
    finit
    fild intVal         ; load integer into st(0)
    fwait               ; wait for pending exceptions
    inc intVal          ; increment the integer

; 12-2-9-1
.data
    valA real8 1.5
    valB real8 2.5
    valC real8 3.0
    valD real8 ?
.code
    finit
    fld valA                ; st(0) = valA
    fchs                    ; st(0) = -st(0)
    fld valB                ; st(0) = valB, st(1) = -valA
    fmul valC               ; st(0) = valB * valC, st(1) = -valA
    fadd                    ; st(0) = -valA + (valB * valC)
    fstp valD               ; store st(0) to valD, and pop st(0) off the stack

; 12-2-9-2
.data
    array_size = 5
    sngArray real8 1.0, 2.0, 3.0, 4.0, 5.0
.code
    finit
    mov esi, 0              ; array index
    fldz                    ; push 0.0 on stack
    mov ecx, array_size
L3: fld sngArray[esi]       ; load mem into st(0)
    fadd                    ; add st(0), st(1), pop
    add esi, type real8     ; move to next element
    loop L3
    nop

; 12-2-9-3
.data
    valE real8 25.0
    valF real8 36.0
.code
    finit
    fld valE                ; push valE
    fsqrt                   ; st(0) = sqrt(valE)
    fld valF                ; push valF
    fsqrt                   ; st(0) = sqrt(valF)
    fadd                    ; add st(0), st(1), pop

; 12-2-9-4
.data
    array real4 6.0, 2.0, 4.5, 3.2
.code
    finit
    fld array               ; st(0) = +6.0000000000000000e+0000
    fmul [array + 4]        ; st(0) = +1.2000000000000000e+0001
    fld [array + 8]         ; st(0) = +4.5000000000000000e+0000
                            ; st(1) = +1.2000000000000000e+0001
    fmul [array + 12]       ; st(0) = +1.4400000214576721e+0001
                            ; st(1) = +1.2000000000000000e+0001
    fadd                    ; st(0) = +2.6400000214576721e+0001

; 12-2-10
.data
    vn sdword 20
    vx real8 3.5
    vz real8 ?

    vy sword ?

    ctrlWord word ?
.code
    finit
    fild vn                 ; load integer into st(0)
    fadd vx                 ; add vx to st(0)
    fstp vz                 ; store st(0) to vz

    finit
    fild vn                 ; load integer into st(0)
    fadd vx                 ; add vx to st(0)
    fist vy                 ; store st(0) to vy int

    finit
    fstcw ctrlWord                  ; store x87 fpu control word
    or ctrlWord, 110000000000b      ; set RC = 11b (truncate rounding mode)
    fldcw ctrlWord                  ; load control word
    fild vn                         ; load integer into st(0)
    fadd vx                         ; add vx into st(0)
    fist vy                         ; store st(0) to vy int
    fstcw ctrlWord                  ; store control word
    and ctrlWord, 001111111111b     ; reset rc(rounding control) field
    fldcw ctrlWord                  ; load control word

; 12-2-11
.data
    value1 dword 1
    value2 real8 0.0
    controlWord word ?
.code
    finit
    fild value1         ; load integer into st(0)
    fdiv value2         ; st(0) = 1#INF = positive infinity

    finit
    fstcw controlWord                   ; get the control word
    and controlWord, 1111111111111011b  ; unmask divide by zero
    fldcw controlWord                   ; load it back into FPU control word
    fild value1                         ; load integer into st(0)
    ;fdiv value2                         ; divide by zero
    ;fst value2                          ; unhandled exception

    fstcw controlWord                   ; get the control word
    or controlWord, 100b                ; mask divide by zero
    fldcw controlWord                   ; load it back into FPU control word

    mov ecx, 0
    call ExitProcess
main endp

end main
