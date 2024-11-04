; 4-6-1.asm

ExitProcess proto

.data
    myDword dword 80000000h
    myByte  byte  55h
    myWord  word  6666h
    myArray word  10, 20, 30, 40
.code
main proc
    mov rax, 0ABCDEF0AFFFFFFFFh ; 64-bit immediate operand
    mov rax, 0FFFFFFFFh         ; rax = 00000000FFFFFFFFh
    
    mov rax, 06666h             ; clears bits 16-63
    mov rax, 055h               ; clear bits 8-63

    mov rax, 0FFFFFFFFFFFFFFFFh
    mov eax, myDword            ; rax = 0000000080000000h

    mov rax, 0FFFFFFFFFFFFFFFFh
    mov ax, myWord              ; bits 16-63 are not affected

    mov rax, 0FFFFFFFFFFFFFFFFh
    mov al, myByte              ; bits 8-63 are not affected

    mov ebx, 0FFFFFFFFh
    mov rax, 0
    movsxd rax, ebx             ; rax = FFFFFFFFFFFFFFFFh

    mov rsi, offset myArray

    mov ecx, 0
    call ExitProcess
main endp
end