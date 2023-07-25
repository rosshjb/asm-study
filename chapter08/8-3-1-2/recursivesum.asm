title Sum of Integers (recursivesum.asm)

.386
.model flat, stdcall
.stack 4096

WriteDec proto
Crlf proto
WaitMsg proto
ExitProcess proto, dwExitCode:dword

.code
main proc
    mov ecx, 5                  ; counter = 5
    mov eax, 0                  ; holds the sum
    call CalcSum                ; calculate sum
L1: call WriteDec               ; display EAX
    call Crlf                   ; new line
    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
CalcSum proc
; Calculates the sum of a list of integers
; Receives: ECX = count
; Returns: EAX = sum
; ------------------------------------------------------------------------------
    cmp ecx, 0                  ; check counter value
    jz L2                       ; quit if zero
    add eax, ecx                ; otherwise, add to sum
    dec ecx                     ; decrement counter
    call CalcSum                ; recursive call
L2:
    ret
CalcSum endp

end main
