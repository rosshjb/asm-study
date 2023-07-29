title 9-4-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 9-4-2
.data
    array word 1000h, 2000h, 3000h
.code
    mov ebx, offset array
    mov esi, 2
    mov ax, [ebx + esi]     ; AX = 2000h

    mov edi, offset array
    mov ecx, 4
    mov ax, [edi + ecx]     ; AX = 3000h

    mov ebp, offset array
    mov esi, 0
    mov ax, [ebp + esi]     ; AX = 1000h

.data
    tableB  byte  10h,  20h,  30h,  40h,  50h
    rowSize = ($ - tableB)
            byte  60h,  70h,  80h,  90h, 0A0h
            byte 0B0h, 0C0h, 0D0h, 0E0h, 0F0h
.code
    row_index = 1
    column_index = 2

    mov ebx, offset tableB          ; table offset
    add ebx, rowSize * row_index    ; row offset
    mov esi, column_index
    mov al, [ebx + esi]             ; AL = 80h

.data
    tableB2 byte  10h,  20h,  30h,  40h,  50h
            byte  60h,  70h,  80h,  90h, 0A0h
            byte 0B0h, 0C0h, 0D0h, 0E0h, 0F0h
.code
    mov ebx, offset tableB2
    mov eax, 1
    mov ecx, 5
    call calc_row_sum

.data
    tableW  word  10h,  20h,  30h,  40h,  50h
    rowSizeW = ($ - tableW)
            word  60h,  70h,  80h,  90h, 0A0h
            word 0B0h, 0C0h, 0D0h, 0E0h, 0F0h
.code
    mov ebx, offset tableW              ; table offset
    add ebx, rowSizeW * 1               ; row offset
    mov esi, 2                          ; column index
    mov ax, [ebx + esi * type tableW]   ; AX = 0080h

; 9-4-3
.data
    tableD  dword  10h,  20h,  30h,  40h,  50h
    rowSizeD = ($ - tableD)
            dword  60h,  70h,  80h,  90h, 0A0h
            dword 0B0h, 0C0h, 0D0h, 0E0h, 0F0h
.code
    mov ebx, 1 * rowSizeD                       ; row index
    mov esi, 2                                  ; column index
    mov eax, tableD[ebx + esi * type tableD]    ; EAX = 00000080h

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
calc_row_sum proc uses ebx ecx edx esi
; Calculates the sum of a row in a byte matrix
; Receives: EBX = table offset, EAX = row index, ECX = row size, in bytes.
; Returns: EAX holds the sum.
; ------------------------------------------------------------------------------
    mul ecx                         ; row index * row size
    add ebx, eax                    ; rof offset

    mov eax, 0                      ; accumulator
    mov esi, 0                      ; column index
L1: movzx edx, byte ptr [ebx + esi] ; get a byte
    add eax, edx                    ; add to accmulator
    inc esi                         ; next byte in row
    loop L1

    ret
calc_row_sum endp

end main
