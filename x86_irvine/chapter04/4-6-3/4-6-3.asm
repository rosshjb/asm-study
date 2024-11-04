; 4-6-3.asm

ExitProcess proto

.data
    bArray byte  10h, 20h, 30h
    wArray word  1000h, 2000h, 3000h
    qArray qword 100000000h, 200000000h, 300000000h

    array qword 1, 2, 3, 4
    
    arrayB byte 10h, 20h, 30h, 40h
    ptrB1   qword arrayB
    ptrB2   qword offset arrayB
.code
main proc
    mov rax, 0FFFFFFFFh ; fill the lower 32 bits
    add rax, 1          ; rax = 100000000h

    mov rax, 0FFFFh     ; rax = 000000000000FFFFh
    mov bx, 1
    add ax, bx          ; rax = 0000000000000000h

    mov rax, 0FFh       ; rax = 00000000000000FFh
    mov bl, 1
    add al, bl          ; rax = 0000000000000000h

    mov rax, 0          ; rax = 0000000000000000h
    mov ebx, 1
    sub eax, ebx        ; rax = 00000000FFFFFFFFh

    mov rax, 0          ; rax = 0000000000000000h
    mov bx, 1
    sub ax, bx          ; rax = 000000000000FFFFh

    mov rdi, offset bArray
    dec byte ptr [rdi]      ; 8-bit target

    mov rbx, offset wArray
    inc word ptr [rbx]      ; 16-bit target

    mov rsi, offset qArray
    inc qword ptr [rsi]     ; 64-bit target

    ; In 64-bit mode, displacement on a memory operand is 32-bits (it gets sign extended to 64-bit):
    ; https://stackoverflow.com/q/36667825/9304999
    mov esi, 3              ; subscript
    lea rdi, offset array
    mov rax, [rdi + rsi * 8] ; rax = 4

    mov rsi, ptrB1
    mov rsi, ptrB2

    mov ecx, 0
    call ExitProcess
main endp
end