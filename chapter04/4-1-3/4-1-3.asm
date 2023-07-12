; 4-1-3.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    ; 4-1-3
    var1 byte 10h

    ; 4-1-4
    var2 word 1234h
    var3 word ?

    oneByte byte 78h
    oneWord word 1234h
    oneDword dword 12345678h

    ; 4-1-5
    count word 1

    signedVal sword -16

.code
main proc
    ; 4-1-3
    mov eax, 0
    mov al, var1

    mov eax, 0
    mov al, [var1]

    ; 4-1-4
    mov eax, 0
    mov ax, var2
    mov var3, ax

    mov eax, 0          ; eax = 00000000h
    mov al, oneByte     ; eax = 00000078h
    mov ax, oneWord     ; eax = 00001234h
    mov eax, oneDword   ; eax = 12345678h
    mov ax, 0           ; eax = 12340000h

    ; 4-1-5
    mov ecx, 0
    mov cx, count

    mov ecx, 0
    mov cx, signedVal   ; 0000fff0h

    mov ecx, 0ffffffffh
    mov cx, signedVal   ; fffffff0h

.data
    byteVal1 byte 10001111b
.code
    mov eax, 0ffffh     ; eax = 0000ffffh
    movzx ax, byteVal1  ; eax = 0000008fh

    mov bx, 0a69bh
    movzx eax, bx       ; eax = 0000a69bh
    movzx edx, bl       ; edx = 0000009bh
    movzx cx, bl        ; cx = 009bh

.data
    byte1 byte 9bh
    word1 word 0a69bh
.code
    movzx eax, word1    ; eax = 0000a69bh
    movzx edx, byte1    ; edx = 0000009bh
    movzx cx, byte1     ; cx = 009bh

.data
    byteVal2 byte 10001111b
.code
    mov eax, 0
    movsx ax, byteVal2  ; ax = FF8Fh

    mov bx, 0a69bh
    movsx eax, bx       ; eax = ffffa69bh
    movsx edx, bl       ; edx = ffffff9bh
    movsx cx, bl        ; cx = ff9bh

    ; 4-1-6
.data
    saveflags byte ?
.code
    mov eax, 0
    lahf
    mov saveflags, ah

    mov eax, 0
    mov ah, saveflags
    sahf

    ; 4-1-7
.data
    var4 word 5555h
.code
    mov eax, 43214321h
    mov ebx, 56785678h
    xchg ax, bx
    xchg ah, al
    xchg var4, bx
    xchg eax, ebx

.data
    var5 word 6666h
    var6 word 7777h
.code
    mov ax, var5
    xchg ax, var6
    mov var5, ax

    ; 4-1-8
.data
    arrayB byte 10h, 20h, 30h, 40h, 50h
    arrayW word 100h, 200h, 300h
    arrayD dword 10000h, 20000h
.code
    mov al, arrayB          ; al = 10h
    mov al, [arrayB + 1]    ; al = 20h
    mov al, arrayB + 1      ; al = 20h
    mov al, [arrayB + 2]    ; al = 30h
    mov al, [arrayB + 20]   ; outside the array

    mov ax, arrayW          ; ax = 100h
    mov ax, [arrayW + 2]    ; ax = 200h

    mov eax, arrayD         ; eax = 10000h
    mov eax, [arrayD + 4]   ; eax = 20000h

    invoke ExitProcess, 0
main endp
end main
