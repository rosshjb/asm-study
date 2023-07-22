title 7-3-4.asm

ExitProcess proto

.data
    dividend qword 0000000800300020h
    divisor1 dword 00000100h

    dividend_hi qword 0000000000000108h
    dividend_lo qword 0000000033300020h
    divisor2    qword 0000000000010000h
.code
main proc
; 7-3-4
    mov ax, 0083h       ; dividend
    mov bl, 2           ; divisor
    div bl              ; AL = 41h, AH = 01h

    mov dx, 0           ; dividend, high 
    mov ax, 8003h       ; dividend, low
    mov cx, 100h        ; divisor
    div cx              ; AX = 0080h, DX = 0003h

    mov edx, dword ptr dividend + 4 ; high doubleword
    mov eax, dword ptr dividend     ; low doubleword
    div divisor1                    ; EAX = 08003000h, EAX = 00000020h

    mov rdx, dividend_hi
    mov rax, dividend_lo
    div divisor2                    ; RAX = 0108000000003330h
                                    ; RDX = 0000000000000020h

; 7-3-5
.data
    wordVal1 sword -101     ; FF9Bh
.code
    mov dx, 0
    mov ax, wordVal1        ; DX:AX = 0000FF9Bh (+65435)
    cwd                     ; DX:AX = FFFFFF9Bh (-101)
    mov bx, 2               ; BX is the divisor
    idiv bx                 ; divide DX:AX by BX (signed operation)
                            ; AX = FFCEh (-50d), DX = FFFFh (-1d)

.data
    byteValue  sbyte  -101
    wordValue  sword  -101
    dwordValue sdword -101
.code
    mov al, byteValue   ; AL = 9Bh
    cbw                 ; AX = FF9Bh

    mov ax, wordValue   ; AX = FF9Bh
    cwd                 ; DX:AX = FFFFFF9Bh

    mov eax, dwordValue ; EAX = FFFFFF9Bh
    cdq                 ; EDX:EAX = FFFFFFFF.FFFFFF9Bh

.data
    byteVal  sbyte  -48     ; D0h
    wordVal2 sword  -5000   ; EC78h
    dwordVal sdword +50000  ; 0000C350h 
.code
    mov al, byteVal     ; lower half of dividend
    cbw                 ; sign extend AL into AH
    mov bl, +5          ; divisor
    idiv bl             ; AL = F7h(-9d), AH = FDh(-3d)

    mov ax, wordVal2    ; dividend, low
    cwd                 ; extend AX into DX
    mov bx, +256        ; divisor
    idiv bx             ; AX = FFEDh(-19d), DX = FF78h(-136d)

    mov eax, dwordVal   ; dividend, low
    cdq                 ; extend EAX into EDX
    mov ebx, -256       ; divisor
    idiv ebx            ; EAX = FFFFFF3Dh(-195d), EDX = 00000050h(80d)

    ;mov ax, 1000h
    ;mov bl, 10h
    ;div bl              ; AL, the quotient cannot hold 100h

    mov eax, 1000h      ; 4096d
    cdq
    mov ebx, 10h        ; 16d
    div ebx             ; EAX = 00000100h(256d), EDX = 00000000h

.data
    dividend_ word 1000h    ; 4096d
    divisor_  byte 30h      ; 48d
.code
    mov ax, 0
    mov ax, dividend_
    mov bl, divisor_
    cmp bl, 0           ; check the divisor
    je NoDivideZero     ; zero? display error
    div bl              ; AL = 55h(85d), AH = 10h(16d)
NoDivideZero:
    nop

; 7-3-6
.data
    var1 dword 00000300h   ; 768d
    var2 dword 00000200h   ; 512d
    var3 dword 00000400h   ; 1024d
    var4 dword ?
.code
; var4 = (var1 + var2) * var3
    mov eax, var1
    add eax, var2       ; EAX = var1 + var2
    mul var3            ; EAX = EAX * var3
    jc tooBig
    mov var4, eax       ; var4 = 00140000h = 1310720d
    jmp next
tooBig:
    nop                 ; display error message
next:
    nop

; var4 = (var1 * 5) / (var2 - 3)
    mov eax, var1       ; left side
    mov ebx, 5
    mul ebx             ; EDX:EAX = product

    mov ebx, var2       ; right side
    sub ebx, 3

    div ebx             ; final division
    mov var4, eax       ; var4 = 00000007h = 7d

; var4 = (var1 * -5) / (-var2 % var3)
    mov eax, var2       ; begin right side
    neg eax
    cdq                 ; sign-extend dividend
    idiv var3           ; EDX(remainder) = -var2 % var3
    mov ebx, edx        ; EBX = right side

    mov eax, -5         ; begin left side
    imul var1           ; EDX:EAX = var1 * -5
    
    idiv ebx            ; final division; EAX = 00000007h = 7d, EDX = FFFFFF00h = -256d
    mov var4, eax       ; var4 = 00000007h = 7d

; 7-4-1
.code
    mov dl, 0           ; clear upper half 
    mov al, 0FFh        ; AL    = FFh               = 255d = 11111111b
    add al, 0FFh        ; AL    = FFh + FFh = FEh   = 254d = 11111110b
    adc dl, 0           ; DL:AL = 01FEh             = 510d = 00000001.11111110b

    mov edx, 0          ; clear upper half
    mov eax, 0FFFFFFFFh
    add eax, 0FFFFFFFFh ; FFFFFFFFh + FFFFFFFFh = FFFFFFFEh
    adc edx, 0          ; EDX:EAX = 00000001.FFFFFFFEh

    mov ecx, 0
    call ExitProcess
main endp

end