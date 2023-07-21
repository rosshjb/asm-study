title 7-3-2-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    word1  sword  4
    dword1 sdword 4
.code
main proc
    mov al, 48
    mov bl, 4
    imul bl             ; AX = 00C0h, OF = 1

    mov al, -4
    mov bl, 4
    imul bl             ; AX = FFF0h, OF = 0

    mov ax, 48
    mov bx, 4
    imul bx             ; DX:AX = 000000C0h, OF = 0

    mov eax, +4823424
    mov ebx, -423
    imul ebx            ; EDX:EAX = FFFFFFFF86635D80h, OF = 0

    mov ax, -16         ; AX = -16
    mov bx, 2           ; BX = 2
    imul bx, ax         ; BX = -32
    imul bx, 2          ; BX = -64
    imul bx, word1      ; BX = -256

    mov eax, -16        ; EAX = -16
    mov ebx, 2          ; EBX = 2
    imul ebx, eax       ; EBX = -32
    imul ebx, 2         ; EBX = -64
    imul ebx, dword1    ; EBX = -256

    mov ax, -32000
    imul ax, 2          ; OF = 1

    imul bx, word1, -16             ; BX = word1 * -16   = -64
    imul ebx, dword1, -16           ; EBX = dword1 * -16 = -64
    imul ebx, dword1, -2000000000   ; signed overflow! -> 2329B000h = 589934592d != FFFFFFFE.2329B000h = -8000000000d

    mov ecx, 0
    call ExitProcess
main endp

end main