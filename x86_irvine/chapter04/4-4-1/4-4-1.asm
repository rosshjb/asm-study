; 4-4-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 4-4-1
.data
    byteval byte 10h
.code
    mov esi, offset byteval
    mov al, [esi]           ; al = 10h

    mov bl, 20h
    mov [esi], bl           ; byteval = 20h

    inc byte ptr [esi]      ; byteval = 21h

; 4-4-2
.data
    arrayB byte  10h, 20h, 30h
    arrayW word  1000h, 2000h, 3000h
.code
    mov esi, offset arrayB
    mov al, [esi]           ; al = 10h
    inc esi
    mov al, [esi]           ; al = 20h
    inc esi
    mov al, [esi]           ; al = 30h

    mov esi, offset arrayW
    mov ax, [esi]           ; ax = 1000h
    add esi, 2
    mov ax, [esi]           ; ax = 2000h
    add esi, 2
    mov ax, [esi]           ; ax = 3000h

.data
    arrayD dword 10000h, 20000h, 30000h
.code
    mov esi, offset arrayD
    mov eax, [esi]      ; first number
    add esi, 4
    add eax, [esi]      ; second number
    add esi, 4
    add eax, [esi]      ; third number

; 4-4-3
.data
    arrayB2 byte  10h, 20h, 30h
    arrayW2 word  1000h, 2000h, 3000h
    arrayD2 dword 10000h, 20000h, 30000h
.code
    mov esi, 0
    mov al, arrayB2[esi]    ; al = 10h

    mov esi, offset arrayW2
    mov ax, [esi]           ; ax = 1000h
    mov ax, [esi + 2]       ; ax = 2000h
    mov ax, [esi + 4]       ; ax = 3000h

    mov esi, 0
    mov al, arrayB2[si]      ; al = 10h
    mov edi, 0
    mov ax, arrayW2[di]      ; ax = 1000h
    mov ebx, 0
    mov eax, arrayD2[bx]     ; eax = 10000h

.data
    arrayD3 dword 100h, 200h, 300h, 400h
    arrayD4 dword 1, 2, 3, 4
.code
    mov esi, 3 * type arrayD3    ; offset of arrayD[3]
    mov eax, arrayD3[esi]        ; eax = 400h

    mov esi, 3                  ; subscript
    mov eax, arrayd4[esi * 4]   ; eax = 4

    mov esi, 3                              ; subscript
    mov eax, arrayD4[esi * type arrayD4]    ; eax = 4

; 4-4-4
.data
    arrayB3 byte 10h, 20h, 30h, 40h
    ptrB1 dword arrayB3
    ptrB2 dword offset arrayB3
.code

.data
    arrayB4 byte 10h, 20h, 30h, 40h
    arrayW3 word 1000h, 2000h, 3000h
    ptrB3 dword arrayB4
    ptrB4 dword offset arrayB4
    
    ptrW1 dword arrayW3
    ptrW2 dword offset arrayW3

    arrayB5 byte 10h, 20h, 30h, 40h
    pbyte typedef ptr byte
    ptr1 pbyte ?
    ptr2 pbyte arrayB5
.code
    invoke ExitProcess, 0
main endp
end main