title 8-5-3-1.asm

.386
.model flat, stdcall
.stack 4096

extern count:dword, SYM1:abs

ExitProcess proto, dwExitCode:dword

.code
main proc
    mov eax, count
    mov eax, SYM1

    mov ecx, 0
    call ExitProcess
main endp

end main
