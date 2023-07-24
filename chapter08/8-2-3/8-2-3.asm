title 8-2-3.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 8-2-3
    push 6
    push 5
    call AddTwo1        ; AddTwo1(5, 6)
    add esp, 8

    push 4
    push 3
    call AddTwo2        ; AddTwo2(3, 4)
    add esp, 8

    call Example1       ; stack corruption example

    mov ecx, 0
    call ExitProcess
main endp

AddTwo1 proc
    push ebp
    mov ebp, esp        ; base of stack frame

    mov eax, [ebp + 12] ; second parameter (6)
    add eax, [ebp + 8]  ; first parameter (5)

    pop ebp
    ret
AddTwo1 endp

AddTwo2 proc
.data
    y_param equ [ebp + 12]
    x_param equ [ebp + 8]
.code
    push ebp
    mov ebp, esp

    mov eax, y_param
    add eax, x_param

    pop ebp
    ret
AddTwo2 endp

Example1 proc
    push 6
    push 5
    call AddTwo1
    ret             ; stack is corrupted!
Example1 endp

end main
