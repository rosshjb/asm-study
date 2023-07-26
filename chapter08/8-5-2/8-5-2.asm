title 8-5-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    mov ecx, 0
    call ExitProcess
main endp

end main
