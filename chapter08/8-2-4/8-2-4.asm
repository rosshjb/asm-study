title 32-bit calling convention (8-2-4.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    push 6
    push 5
    call AddTwo_cdecl   ; AddTwo_cdecl(5, 6)
    add esp, 8          ; remove arguments from the stack

    push 6
    push 5
    call AddTwo_stdcall ; AddTwo_stdcall(5, 6)
                        ; callee would remove arguments from the stack

    push 5
    call MySub          ; MySub(5)
                        ; callee would remove arguments from the stack

    mov ecx, 0
    call ExitProcess
main endp

AddTwo_cdecl proc
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]
    add eax, [ebp + 8]

    pop ebp
    ret
AddTwo_cdecl endp

AddTwo_stdcall proc
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]
    add eax, [ebp + 8]

    pop ebp
    ret 8               ; clean up arguments from the stack
AddTwo_stdcall endp

MySub proc
    push ebp            ; save base pointer
    mov ebp, esp        ; base of stack frame

    push ecx            ; save registers
    push edx

    mov eax, [ebp + 8]  ; get the stack parameter
    add eax, eax

    pop edx             ; restore saved registers
    pop ecx

    pop ebp             ; restore base pointer
    ret 4               ; clean up arguments from the stack
MySub endp

end main
