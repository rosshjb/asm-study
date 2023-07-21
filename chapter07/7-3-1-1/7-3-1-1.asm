TITLE 7-3-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 7-3-1
    mov al, 5h
    mov bl, 10h
    mul bl          ; AX = 0050h, CF = 0

.data
    val1 word 2000h
    val2 word 0100h
.code
    mov ax, val1
    mul val2         ; DX:AX = 00200000h, CF = 1

    mov eax, 12345h
    mov ebx, 1000h
    mul ebx         ; EDX:EAX = 0000000012345000h, CF = 0

    mov ecx, 0
    call ExitProcess
main endp

end main