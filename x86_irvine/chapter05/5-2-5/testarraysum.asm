; Testing the ArraySum procedure (testarraysum.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    array  dword 10000h, 20000h, 30000h, 40000h, 50000h
    theSum dword ?
.code
main proc
    mov esi, offset array   ; esi points to array
    mov ecx, lengthof array ; ecx = array count
    call ArraySum           ; calculate the sum
    mov theSum, eax         ; returned in eax

    invoke ExitProcess, 0
main endp

; ---------------------------------------------------
; ArraySum
; Calculates the sum of an array of 32-bit integers.
; Receives: esi = the array offset
;           ecx = number of elements in the array
; Returns:  eax = sum of the array elements
; ---------------------------------------------------
ArraySum proc
    push esi                ; save esi, ecx
    push ecx

    mov eax, 0              ; set the sum to zero
L1:
    add eax, [esi]          ; add each integer to sum
    add esi, type dword     ; point to next integer
    loop L1                 ; repeat for array size

    pop ecx                 ; restore ecx, esi
    pop esi

    ret                     ; sum is in eax
ArraySum endp

end main