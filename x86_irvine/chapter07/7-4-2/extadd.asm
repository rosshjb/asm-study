title Extended Addition Example (extadd.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword
Crlf proto
WriteHexB proto
WaitMsg proto

.data
    op1 byte 34h, 12h, 98h, 74h, 06h, 0A4h, 0B2h, 0A2h
    op2 byte 02h, 45h, 23h, 00h, 00h,  87h,  10h,  80h
    sum byte 9 dup(?)       ; 01.22C32B06.74BB5736h
.code
main proc
    ; add two integers
    mov esi, offset op1     ; first operand
    mov edi, offset op2     ; second operand
    mov ebx, offset sum     ; sum operand
    mov ecx, lengthof op1   ; number of bytes
    call Extended_Add

    ; display the sum
    mov esi, offset sum
    mov ecx, lengthof sum
    call Display_Sum
    call Crlf
    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

;-------------------------------------------------------------------------------
Extended_Add proc
;
; Calculates the sum of two extended integers stored as arrays of bytes.
; Receives: ESI and EDI point to the two integers, EBX points to a variable
;           that will hold the sum, and ECX indicates the number of bytes
;           to be added.
; Storage for the sum must be one byte longer than the input operands.
; Returns: nothing
;-------------------------------------------------------------------------------
    pushad
    clc                     ; clear the Carry flag
    
L1: mov al, [esi]           ; get the first integer
    adc al, [edi]           ; add the second integer
    pushfd                  ; save the Carry flag
    mov [ebx], al           ; store partial sum
    add esi, 1              ; advance all three pointers
    add edi, 1
    add ebx, 1
    popfd                   ; restore the Carry flag
    loop L1                 ; repeat the loop

    mov byte ptr [ebx], 0   ; clear high byte of sum
    adc byte ptr [ebx], 0   ; add any leftover carry

    popad
    ret
Extended_Add endp

;-------------------------------------------------------------------------------
Display_Sum proc
;
; Displays a large integer that is stored in little endian order (LSB to MSB).
; The output displays the array in hexadecimal, starting with the most
; significant byte.
; Receives: ESI points to the array, ECX is the array size
; Returns: nothing
;-------------------------------------------------------------------------------
    pushad

    ; point to the last array element
    add esi, ecx
    sub esi, type byte
    mov ebx, type byte
	
L1:	mov al, [esi]           ; get an array byte
    call WriteHexB          ; display it
    sub esi, type byte      ; point to previous byte
    loop L1

    popad
    ret
Display_Sum endp

end main
