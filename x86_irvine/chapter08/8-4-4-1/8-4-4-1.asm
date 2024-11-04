title 8-4-4-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

MySub1 proto                    ; procedure1 prototype

ArraySum proto,                 ; procedure3 prototype
    ptrArray:ptr dword,
    szArray:dword

Example1 proto C,               ; procedure4 prototype
    parm1:dword, parm2:dword

.code
MySub2 proc                     ; procedure2 definition
    ret
MySub2 endp

.data
    array dword 100h, 200h, 300h
.code
main proc
    invoke MySub1               ; procedure1 call
    invoke MySub2               ; procedure2 call

    invoke ArraySum,            ; procedure3 call
        offset array,
        lengthof array

    invoke Example1, 4, 5       ; procedure4 call

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
MySub1 proc                     ; procedure1 definition
; ------------------------------------------------------------------------------
    ret
MySub1 endp

; ------------------------------------------------------------------------------
ArraySum proc uses esi ecx,     ; procedure3 definition
    ptrArray:ptr dword,         ; points to the array
    szArray:dword               ; array size
; ------------------------------------------------------------------------------
    mov eax, 0
    mov esi, ptrArray
    mov ecx, szArray
L1: cmp ecx, 0
    je L2
    add eax, [esi]
    add esi, type dword
    loop L1
L2:
    ret 8
ArraySum endp

; ------------------------------------------------------------------------------
Example1 proc C parm1:dword, parm2:dword    ; procedure4 definition
; ------------------------------------------------------------------------------
    mov eax, parm1
    add eax, parm2
    ret
Example1 endp

end main
