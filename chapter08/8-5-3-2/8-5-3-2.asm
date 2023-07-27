title 8-5-3-2.asm

option casemap:none

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

include vars.inc

.code
main proc
    mov count, 2000h
    mov eax, SYM1

    mov ecx, 0
    call ExitProcess
main endp

end main
