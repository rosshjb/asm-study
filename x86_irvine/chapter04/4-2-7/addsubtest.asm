; Addition and Subtraction (addsubtest.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    rval sdword ?
    xval sdword 26
    yval sdword 30
    zval sdword 40

.code
main proc
    ; inc and dec
    mov ax, 1000h
    inc ax          ; ax = 1001h
    dec ax          ; ax = 1000h

    ; expression: rval = -xval + (yval - zval)
    mov eax, xval
    neg eax         ; -26
    mov ebx, yval
    sub ebx, zval   ; -10
    add eax, ebx
    mov rval, eax   ; -36

    ; zero flag example:
    mov cx, 1
    sub cx, 1       ; zf = 1
    mov ax, 0ffffh
    inc ax          ; zf = 1

    ; sign flag example:
    mov cx, 0
    sub cx, 1       ; sf = 1
    mov ax, 7fffh
    add ax, 2       ; sf = 1

    ; carry flag example
    mov al, 0ffh
    add al, 1       ; cf = 1, al = 00h

    ; overflow flag example
    mov al, +127
    add al, 1       ; of = 1
    mov al, -128
    sub al, 1       ; of = 1

    invoke ExitProcess, 0
main endp
end main