title Calculating a Factorial (fact.asm)

.386
.model flat, stdcall
.stack 4096

WriteDec proto
Crlf proto
WaitMsg proto
ExitProcess proto, dwExitCode:dword

.code
main proc
    push 5                  ; calc 5!
    call Factorial          ; calculate factorial (EAX)
    call WriteDec           ; display it
    call Crlf
    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
Factorial proc
; Calculates a factorial.
; Receives: [ebp + 8] = n, the number to calculate
; Returns: eax = the factorial of n
; ------------------------------------------------------------------------------
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]      ; get n
    cmp eax, 0              ; n > 0?
    ja L1                   ; yes: continue
    mov eax, 1              ; no: return 1 as the value of 0!
    jmp L2                  ;     and return to the caller
L1: dec eax
    push eax
    call Factorial          ; Factorial(n-1)

    ; Instructions from this point on execute when each recursive call returns.
ReturnFact:
    mov ebx, [ebp + 8]      ; get n
    mul ebx                 ; EDX:EAX = EAX * EBX
L2:
    pop ebp
    ret 4
Factorial endp

end main
