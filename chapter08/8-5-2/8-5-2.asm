title 8-5-2.asm

.386
.model flat, stdcall
.stack 4096

extern sub1@0:proc
extern AddTwo1@8:proc
AddTwo2 proto, val1:dword, val2:dword

ExitProcess proto, dwExitCode:dword

.code
main proc
    call sub1@0

    push 2
    push 1
    call AddTwo1@8

    push 4
    push 3
    call AddTwo2

    mov ecx, 0
    call ExitProcess
main endp

end main
