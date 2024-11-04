title 7-1-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 7-1-2
    mov bl, 8Fh         ; BL = 10001111b
    shl bl, 1           ; CF = 1, BL = 00011110b

    mov al, 10000000b
    shl al, 2           ; CF = 0, AL = 00000000b

    mov dl, 5           ; DL = 00000101b = 5d
    shl dl, 1           ; DL = 00001010b = 10d

    mov dl, 10          ; before: 00001010b = 10d
    shl dl, 2           ; after : 00101000b = 40d

; 7-1-3
    mov al, 0D0h        ; AL = 11010000b
    shr al, 1           ; AL = 01101000b, CF = 0

    mov al, 00000010b
    shr al, 2           ; AL = 00000000b, CF = 1

    mov dl, 32          ; DL = 00100000b = 32d
    shr dl, 1           ; DL = 00010000b = 16d

    mov al, 01000000b   ; AL = 64d
    shr al, 3           ; divide by 8, AL = 00001000b = 8d

; 7-1-4
    mov al, 0F0h        ; AL = 11110000b = -16d
    sar al, 1           ; AL = 11111000b = -8d, CF = 0
    
    mov dl, -128        ; DL = 10000000b = -128d
    sar dl, 3           ; DL = 11110000b = -16d

    mov ax, -128        ; EAX = ????FF80h
    shl eax, 16         ; EAX = FF800000h
    sar eax, 16         ; EAX = FFFFFF80h

; 7-1-5
    mov al, 40h         ; AL = 01000000b
    rol al, 1           ; AL = 10000000b, CF = 0
    rol al, 1           ; AL = 00000001b, CF = 1
    rol al, 1           ; AL = 00000010b, CF = 0

    mov al, 00100000b
    rol al, 3           ; CF = 1, AL = 00000001b

    mov al, 26h
    rol al, 4           ; AL = 62h

    mov ax, 6A4Bh
    rol ax, 4           ; AX = A4B6h
    rol ax, 4           ; AX = 4B6Ah
    rol ax, 4           ; AX = B6A4h
    rol ax, 4           ; AX = 6A4Bh

; 7-1-6
    mov al, 01h         ; AL = 00000001b
    ror al, 1           ; AL = 10000000b, CF = 1
    ror al, 1           ; AL = 01000000b, CF = 0

    mov al, 00000100b
    ror al, 3           ; AL = 10000000b, CF = 1

; 7-1-7
    clc                 ; CF = 0
    mov bl, 88h         ; CF, BL = 0 10001000b
    rcl bl, 1           ; CF, BL = 1 00010000b
    rcl bl, 1           ; CF, BL = 0 00100001b

.data
    testval byte 01101010b
.code
    shr testval, 1      ; shift LSB into Carry flag
    jc exit             ; exit if Carry flag set
    rcl testval, 1      ; else restore the number
    mov al, testval
exit:
    nop

    stc                 ; CF = 1
    mov ah, 10h         ; AH, CF = 00010000 1
    rcr ah, 1           ; AH, CF = 10001000 0

; 7-1-8
    mov al, +127        ; AL = 01111111b
    rol al, 1           ; OF = 1, AL = 11111111b

    mov al, -128        ; AL = 10000000b
    shr al, 1           ; OF = 1, AL = 01000000b

; 7-1-9
.data
    wval word 9BA6h
.code
    mov ax, 0AC36h
    shld wval, ax, 4    ; wval = BA6Ah

    mov ax, 234Bh
    mov dx, 7654h
    shrd ax, dx, 4      ; AX = 4234h

.data
    array1 dword 648B2165h, 8C943A29h, 6DFA4B86h, 91F76C04h, 8BAF9857h
.code
    mov bl, 4                       ; shift count
    mov esi, offset array1          ; offset of the array
    mov ecx, (lengthof array1) - 1  ; number of array elements
L1: push ecx                        ; save loop counter
    mov eax, [esi + type dword]
    mov cl, bl                      ; shift count
    shrd [esi], eax, cl             ; shift EAX into high bits of [ESI]

    add esi, type dword             ; point to next doubleword pair
    pop ecx                         ; restore loop counter
    loop L1

    shr dword ptr [esi], 4          ; shift the last doubleword

    mov ecx, 0
    call ExitProcess
main endp

end main