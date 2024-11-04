; 5-2-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    theSum dword ?
.code
main proc
    mov eax, 10000h ; argument
    mov ebx, 20000h ; argument
    mov ecx, 30000h ; argument
    call sumof      ; eax = (eax + ebx + ecx)
    mov theSum, eax ; save the sum

    invoke ExitProcess, 0
main endp

; --------------------------------------------------------
; Calculates and returns the sum of three 32-bit integers.
; Receives: EAX, EBX, ECX, the three integers. May be
;           signed or unsigned.
; Returns: EAX = sum
; --------------------------------------------------------
sumof proc
    add eax, ebx
    add eax, ecx
    ret
sumof endp

end main