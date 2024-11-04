; Data Transfer Examples (Moves.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    val1 word 1000h
    val2 word 2000h
    
    arrayB byte 10h, 20h, 30h, 40h, 50h
    arrayW word 100h, 200h, 300h
    arrayD dword 10000h, 20000h

.code
main proc
    ; demonstrating movzx instruction:
    mov bx, 0a69bh
    movzx eax, bx   ; eax = 0000a69bh
    movzx edx, bl   ; edx = 0000009bh
    movzx cx, bl    ; cx  = 009bh

    ; demonstrating movsx instruction:
    mov bx, 0a69bh
    movsx eax, bx   ; eax = ffffa69bh
    movsx edx, bl   ; edx = ffffff9bh
    
    mov bl, 7bh
    movsx cx, bl    ; cx = 007bh

    ; memory-to-memory exchange:
    mov ax, val1    ; ax = 1000h
    xchg ax, val2   ; ax = 2000h, val2 = 1000h
    mov val1, ax    ; val1 = 2000h

    ; direct-offset addressing (byte array):
    mov al, arrayB       ; al = 10h
    mov al, [arrayB + 1] ; al = 20h
    mov al, [arrayB + 2] ; al = 30h

    ; direct-offset addressing (word array):
    mov ax, arrayW          ; ax = 100h
    mov ax, [arrayW + 2]    ; ax = 200h

    ; direct-offset addressing (doubleword array):
    mov eax, arrayD         ; eax = 10000h
    mov eax, [arrayD + 4]   ; eax = 20000h
    mov eax, arrayD + 4     ; eax = 20000h

    invoke ExitProcess, 0
main endp
end main