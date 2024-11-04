; Reversing a String (RevStr.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    aName byte "Abraham Lincoln", 0
    nameSize = ($ - aName) - 1
.code
main proc
; push the name on the stack.
    mov ecx, nameSize
    mov esi, 0
L1: movzx eax, aName[esi]   ; get character
    push eax                ; push on stack
    inc esi
    loop L1
; pop the name from the stack, in reverse,
; and store in the aName array.
    mov ecx, nameSize
    mov esi, 0
L2: pop eax                 ; get character
    mov aName[esi], al
    inc esi
    loop L2

    invoke ExitProcess, 0
main endp

end main