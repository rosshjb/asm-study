title 8-4-4-3.asm

.386
.model flat, stdcall
.stack 4096

ArraySum    proto ptrArray:ptr dword,
                  szArray:dword

ExitProcess proto dwExitCode:dword

.data
    array dword 10000h, 20000h, 30000h, 40000h, 50000h
    theSum dword ?
.code
main proc
    invoke ArraySum,
        addr array,             ; address of the array
        lengthof array          ; number of elements

    mov theSum, eax

    mov ecx, 0
    call ExitProcess
main endp

ArraySum proc uses esi ecx,
    ptrArray:ptr dword,         ; points to the array
    szArray:dword               ; array size

    mov esi, ptrArray           ; address of the array
    mov ecx, szArray            ; size of the array
    mov eax, 0                  ; set the sum to zero

    cmp ecx, 0                  ; length = zero?
    je L2                       ; yes: quit

L1: add eax, [esi]              ; add each integer to sum
    add esi, 4                  ; point to next integer
    loop L1                     ; repeat for array size

L2: ret
ArraySum endp

end main
