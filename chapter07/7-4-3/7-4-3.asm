title 7-4-3.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    mov edx, 7          ; upper half.
    mov eax, 1          ; lower half.           EDX:EAX = 00000007.00000001h
    sub eax, 2          ; subtract 2.           EDX:EAX = 00000007.FFFFFFFFh
    sbb edx, 0          ; subtract upper half.  EDX:EAX = 00000006.FFFFFFFFh

    mov ecx, 0
    call ExitProcess
main endp

end main
