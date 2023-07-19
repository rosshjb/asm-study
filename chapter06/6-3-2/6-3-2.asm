; 6-3-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 6-3-2-1
    mov eax, 5
    cmp eax, 5
    je L1           ; jump if equal

    mov eax, 1
L1:
    mov eax, 0

; 6-3-2-2
    mov ax, 5
    cmp ax, 6
    jl L2           ; jump if less

    mov eax, 1
L2:
    mov eax, 0

; 6-3-2-3
    mov ax, 5
    cmp ax, 4
    jg L3           ; jump if greater

    mov eax, 1
L3:
    mov eax, 0

; 6-3-3-1
    mov edx, 0A523h
    cmp edx, 0A523h
    jne L4          ; jump not taken
    je  L4          ; jump is taken
    mov eax, 1
L4:
    mov eax, 0

; 6-3-3-2
    mov bx, 1234h
    sub bx, 1234h
    jne L5          ; jump not taken
    je  L5          ; jump is taken
    mov eax, 1
L5:
    mov eax, 0

; 6-3-3-3
    mov cx, 0FFFFh
    inc cx
    jcxz L6          ; jump is taken
    mov eax, 1
L6:
    mov eax, 0

; 6-3-3-4
    mov ecx, 1
    xor ecx, ecx
    jecxz L7        ; jump is taken
    mov eax, 1
L7:
    mov eax, 0

; 6-3-3-5
    mov al, +127    ; hexadecimal value is 7Fh
    cmp al, -128    ; hexadecimal value is 80h
    ja IsAbove      ; jump not taken, because 7Fh < 80h
    jg IsGreater    ; jump taken, because 7Fh > 80h (+127 > -128)
    mov eax, 1
IsAbove:
IsGreater:
    mov eax, 0

; 6-3-3-6
    mov edx, -1
    cmp edx, 0
    jnl  L8         ; jump not taken (-1 >= 0 is false)
    jnle L8         ; jump not taken (-1 > 0 is false)
    jl   L8         ; jump is taken  (-1 < 0 is true)
    mov eax, 1
L8:
    mov eax, 0

; 6-3-3-7
    mov bx, +32
    cmp bx, -35
    jng  L9         ; jump not taken (+32 <= -35 is false)
    jnge L9         ; jump not taken (+32 < -35 is false)
    jge  L9         ; jump is taken (+32 >= -35 is true)
    mov eax, 1
L9:
    mov eax, 0

; 6-3-3-8
    mov ecx, 0
    cmp ecx, 0
    jg  L10         ; jump not taken (0 > 0 is false)
    jnl L10         ; jump is taken (0 >= 0 is true)
    mov eax, 1
L10:
    mov eax, 0

; 6-3-3-9
    mov ecx, 0
    cmp ecx, 0
    jl  L11         ; jump not taken (0 < 0 is false)
    jng L11         ; jump is taken (0 <= 0 is true)
    mov eax, 1
L11:
    mov eax, 0

; 6-3-4-1
.data
    status1 byte 00100000b
.code
    mov al, status1
    test al, 00100000b  ; test bit 5
    jnz DeviceOffline
    mov eax, 1
DeviceOffline:
    mov eax, 0

; 6-3-4-2
.data
    status2 byte 11010000b
.code
    mov al, status2
    test al, 00010011b  ; test any of the bits 0, 1, 4
    jnz InputDataByte
    mov eax, 1
InputDataByte:
    mov eax, 0

; 6-3-4-3
.data
    status3 byte 11001110b
.code
    mov al, status3
    and al, 10001100b   ; mask bits 2, 3, 7
    cmp al, 10001100b   ; all bits set?
    je ResetMachine     ; yes: jump to label
    mov eax, 1
ResetMachine:
    mov eax, 0

; 6-3-4-4
    mov eax, 6
    mov ebx, 4
    mov edx, eax        ; assume eax is larger
    cmp eax, ebx        ; if eax is >= ebx
    jae L12             ;   jump to L12
    mov edx, ebx        ; else move ebx to edx
    mov eax, 1
L12:
    mov eax, 0

; 6-3-4-5
.data
    v1 word 3
    v2 word 1
    v3 word 2
.code
    mov ax, v1          ; assume v1 is smallest
    cmp ax, v2          ; if ax <= v2
    jbe L13             ;   jump to L13
    mov ax, v2          ; else move v2 to ax
L13:
    cmp ax, v3          ; if ax <= v3
    jbe L14             ;   jump to L14
    mov ax, v3          ; else move v3 to ax
    mov eax, 1
L14:
    mov eax, 0

    mov ecx, 0
    call ExitProcess
main endp

end main