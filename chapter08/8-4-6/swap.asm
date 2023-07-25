title Swap Procedure Example (swap.asm)

.386
.model flat, stdcall
.stack 4096

DumpMem     proto
Swap        proto, pValX:ptr dword,
                   pValY:ptr dword
WaitMsg     proto
ExitProcess proto, dwExitCode:dword

.data
    array dword 10000h, 20000h
.code
main proc
    ; Display the array before the exchange:
    mov esi, offset array
    mov ecx, 2                      ; count = 2
    mov ebx, type array
    call DumpMem                    ; dump the array values

    invoke Swap, addr array,
                 addr [array + 4]

    ; Display the array after the exchange:
    call DumpMem

    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
Swap proc uses eax esi edi,
    pValX:ptr dword,                ; pointer to first integer
    pValY:ptr dword                 ; pointer to second integer
;
; Exchange the values of two 32-bit integers
; Returns: nothing
; ------------------------------------------------------------------------------
    mov esi, pValX                  ; get pointers
    mov edi, pValY

    mov eax, [esi]                  ; get first integer
    xchg eax, [edi]                 ; exchange with second
    mov [esi], eax                  ; replace first integer

    ret                             ; proc generates ret 8 here
Swap endp

end main
