title Comparing Multiplications (comparemult.asm)

include irvine32.inc

LOOP_COUNT = 0FFFFFFFFh

.data
    intval dword 5
    startTime dword ?
.code
main proc
    ; mult_by_shifting
    call GetMseconds        ; get start time
    mov startTime, eax

    mov eax, intval         ; multiply now
    call mult_by_shifting

    call GetMseconds        ; get stop time
    sub eax, startTime

    call WriteDec           ; display elapsed time (4713)
    call Crlf

    ; mult_by_MUL
    call GetMseconds        ; get start time
    mov startTime, eax

    mov eax, intval         ; multiply now
    call mult_by_MUL

    call GetMseconds        ; get stop time
    sub eax, startTime

    call WriteDec           ; display elapsed time (5460)
    call Crlf

    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

; --------------------------------------------------
mult_by_shifting proc
;
; Multiplies EAX by 36 using SHL, LOOP_COUNT times.
; Receives: EAX
; --------------------------------------------------
    mov ecx, LOOP_COUNT
L1: push eax                ; save original eax

    mov ebx, eax
    shl eax, 5
    shl ebx, 2
    add eax, ebx

    pop eax                 ; restore eax
    loop L1

    ret
mult_by_shifting endp

; --------------------------------------------------
mult_by_MUL proc
;
; Multiplies EAX by 36 using MUL, LOOP_COUNT times.
; Receives: EAX
; --------------------------------------------------
    mov ecx, LOOP_COUNT
L1: push eax                ; save original eax
    
    mov ebx, 36
    mul ebx

    pop eax                 ; restore eax
    loop L1

    ret
mult_by_MUL endp

end main