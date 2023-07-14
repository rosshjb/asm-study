title jmp instruction (4-5-1.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    mov eax, 0
    mov ebx, 100

target:
    inc eax

    dec ebx

    jmp target

    invoke ExitProcess, 0
main endp
end main