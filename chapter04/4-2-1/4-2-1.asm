; 4-2-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 4-2-1
.data
    myWord word 1000h
.code
    inc myWord
    mov bx, myWord
    dec bx

; 4-2-2
.data
    var1 dword 10000h
    var2 dword 20000h
.code
    mov eax, var1
    add eax, var2

; 4-2-3
.data
    var3 dword 30000h
    var4 dword 10000h
.code
    mov eax, var3
    sub eax, var4

; 4-2-5
.data
    rval sdword ?
    xval sdword 26
    yval sdword 30
    zval sdword 40
.code
    ; first term: -xval
    mov eax, xval
    neg eax
    ; second term: (yval - zval)
    mov ebx, yval
    sub ebx, zval
    ; add the terms and store:
    add eax, ebx
    mov rval, eax
  
; 4-2-6
.code
    ; zr
    mov ecx, 1
    sub ecx, 1  ; ecx = 0, zf = 1

    mov eax, 0ffffffffh
    inc eax     ; eax = 0, zf = 1
    inc eax     ; eax = 1, zf = 0
    dec eax     ; eax = 0, zf = 1

    ; cy
    mov al, 0ffh
    add al, 1       ; al = 00h, cf = 1
    
    mov ax, 0ffh
    add ax, 1       ; ax = 0100h, cf = 0

    mov ax, 0ffffh
    add ax, 1       ; ax = 0000h, cf = 1

    mov al, 1
    sub al, 2       ; al = ffh, cf = 1

    ; ac
    mov al, 0fh
    add al, 1       ; al = 10h, ac = 1

    ; pe
    mov al, 10001100b
    add al, 00000010b   ; al = 10001110b, pf = 1
    sub al, 10000000b   ; al = 00001110b, pf = 0

    ; pl
    mov eax, 4
    sub eax, 5  ; eax = -1, sf = 1

    mov bl, 1
    sub bl, 2   ; bl = ffh, sf = 1

    ; ov
    mov al, +127
    add al, 1       ; al = 80h (-128), of = 1

    mov al, -128
    sub al, 1      ; al = 7fh (127), of = 1

    mov al, -128    ; al = 10000000b
    neg al          ; al = 10000000b, of = 1

    mov al, +127    ; al - 01111111b
    neg al          ; al = 10000001b, of = 0

    invoke ExitProcess, 0
main endp
end main