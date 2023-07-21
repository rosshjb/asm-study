title 7-2-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    mov eax, 123
    mov ebx, eax

    shl eax, 5      ; multiply by 2^5
    shl ebx, 2      ; multiply by 2^2
    add eax, ebx    ; add the products

    mov ecx, 0
    call ExitProcess
main endp

end main