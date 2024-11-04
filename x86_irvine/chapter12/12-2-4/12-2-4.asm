title 12-2-4

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    finit

; 12-2-4
.data
    dblOne   real8 234.56
    dblTwo   real8 10.1
    dblThree real8 ?
    dblFour  real8 ?
.code
    fld dblOne      ; ST(0) = dblOne
    fld dblTwo      ; ST(0) = dblTwo, ST(1) = dblOne

    fst dblThree    ; dblThree = 10.1
    fst dblFour     ; dblFour = 10.1

    fstp dblThree   ; dblThree = 10.1
    fstp dblFour    ; dbdlFour = 234.56

; 12-2-5
.data
    dbl1 real4 234.56
    dbl2 real4 10.1
    dbl3 real8 1234.56
    dbl4 real8 10.0
    mySingle real4 0.1
    myInteger dword 1
    myInteger2 dword 2
.code
    ; fchs, fabs
    fld dbl1            ; ST(0) = 234.56
    fchs                ; ST(0) = -234.56
    fabs                ; ST(0) = 234.56

    ; fadd, faddp, fiadd
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fadd                ; ST(0) = 244.66

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fadd st(1), st(0)   ; ST(0) = 10.1, ST(1) = 244.66

    finit
    fld dbl1                    ; ST(0) = 234.56
    fadd mySingle               ; ST(0) = 234.66
    mov esi, offset mySingle
    fadd real4 ptr [esi]        ; ST(0) = 234.76

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    faddp st(1), st(0)  ; ST(0) = 244.66

    finit
    fld dbl1            ; ST(0) = 234.56
    fiadd myInteger     ; ST(0) = 235.56

    ; fsub, fsubp, fisub
    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fsub                ; ST(0) = 224.46

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fsub st(1), st(0)   ; ST(0) = 10.1, ST(1) = 224.46

    finit
    fld dbl1            ; ST(0) = 234.56
    fsub mySingle       ; ST(0) = 234.46

    finit
    fld dbl1                ; ST(0) = 234.56
    mov esi, offset dbl2
    fsub real4 ptr [esi]    ; ST(0) = 224.46

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fsubp st(1), st(0)  ; ST(0) = 224.46

    finit
    fld dbl1            ; ST(0) = 234.56
    fisub myInteger     ; ST(0) = 233.56

    ; fmul, fmulp, fimul
    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fmul                ; ST(0) = 2369.056

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fmul st(1), st(0)   ; ST(0) = 10.1, ST(1) = 2369.056

    finit
    fld dbl1            ; ST(0) = 234.56
    fmul mySingle       ; ST(0) = 23.456

    finit
    fld dbl1                ; ST(0) = 234.56
    mov esi, offset dbl2
    fmul real4 ptr [esi]    ; ST(0) = 2369.056

    finit
    fld dbl1            ; ST(0) = 234.56
    fld dbl2            ; ST(0) = 10.1, ST(1) = 234.56
    fmulp st(1), st(0)  ; ST(0) = 2369.056

    finit
    fld dbl1            ; ST(0) = 234.56
    fimul myInteger     ; ST(0) = 234.56

    ; fdiv ,fdivp, fidiv
    finit
    fld dbl3            ; ST(0) = 1234.56
    fld dbl4            ; ST(0) = 10.0, ST(1) = 1234.56
    fdiv                ; ST(0) = 123.456

    finit
    fld dbl3            ; ST(0) = 1234.56
    fld dbl4            ; ST(0) = 10.0, ST(1) = 1234.56
    fdiv st(1), st(0)   ; ST(0) = 10.0, ST(1) = 123.456

    finit
    fld dbl3            ; ST(0) = 1234.56
    fdiv dbl4           ; ST(0) = 123.456

    finit
    fld dbl3                ; ST(0) = 1234.56
    mov esi, offset dbl4
    fdiv real8 ptr [esi]    ; ST(0) = 123.456

    finit
    fld dbl3            ; ST(0) = 1234.56
    fld dbl4            ; ST(0) = 10.0, ST(1) = 1234.56
    fdivp st(1), st(0)  ; ST(0) = 123.456

    finit
    fld dbl3            ; ST(0) = 1234.56
    fidiv myInteger2    ; ST(0) = 617.28

    mov ecx, 0
    call ExitProcess
main endp

end main
