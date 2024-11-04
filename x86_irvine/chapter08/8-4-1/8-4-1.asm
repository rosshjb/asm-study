title 8-4-1.asm

.386
.model flat, stdcall
.stack 4096

DumpArray proto stdcall pArray: ptr dword, nUnits: dword, tUnit: dword
DumpMem proto
WaitMsg proto
ExitProcess proto, dwExitCode:dword

.data
    array dword 00010000h, 00020000h, 00030000h
.code
main proc
; 8-4-1-1
    invoke DumpArray, offset array, lengthof array, type array

; 8-4-1-2
    push type array
    push lengthof array
    push offset array
    call DumpArray

; 8-4-1-3
    invoke DumpArray,       ; displays an array
        offset array,       ; points to the array
        lengthof array,     ; the array length
        type array          ; array component size

    call WaitMsg
    mov ecx, 0
    call ExitProcess
main endp

DumpArray proc stdcall pArray: ptr dword, nUnits: dword, tUnit: dword
    push esi        ; save callee-saved(non-volatile) registers
    push ebx

    mov esi, pArray ; starting offset   = [ebp + 8]
    mov ecx, nUnits ; number of units   = [ebp + 12]
    mov ebx, tUnit  ; unit size         = [ebp + 16]
    call DumpMem

    pop ebx         ; restore callee-saved(non-volatile) registers
    pop esi

    ret
DumpArray endp

end main
