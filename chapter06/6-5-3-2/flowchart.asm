title flowchart.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    sum dword 0

    sample dword 50

    array dword 10, 60, 20, 33, 72, 89, 45, 65, 72, 18
    arraysize = ($ - array) / type array

.code
main proc
    mov eax, 0              ; sum
    mov edx, sample
    mov esi, 0              ; index
    mov ecx, arraysize

L1: cmp esi, ecx            ; if esi < ecx
    jl L2
    jmp L5
L2: cmp array[esi * 4], edx ; if array[esi] > edx
    jg L3
    jmp L4
L3: add eax, array[esi * 4]
L4: inc esi
    jmp L1
L5: mov sum, eax

    mov ecx, 0
    call ExitProcess
main endp

end main