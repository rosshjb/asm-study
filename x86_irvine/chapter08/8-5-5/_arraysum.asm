title ArraySum Procedure (_arraysum.asm)

option casemap:none

.386
.model flat, stdcall

.code
ArraySum proc stdcall
; ------------------------------------------------------------------------------
; Calculates the sum of an array of 32-bit integers.
; Receives:
;   ptrArray ; pointer to array
;   arraySize; size of array (DWORD)
; Returns: EAX = sum
; ------------------------------------------------------------------------------
    ptrArray  equ [ebp+8]
    arraySize equ [ebp+12]
    
    push ebp
    mov ebp, esp
    
    push ecx                ; don't push EAX
    push esi
    
    mov eax, 0              ; set the sum to zero
    mov esi, ptrArray
    mov ecx, arraySize
    
    cmp ecx,0               ; array size <= 0?
    jle L2                  ; yes: quit
    
L1:	add eax, [esi]          ; add each integer to sum
    add esi, 4              ; point to next integer
    loop L1                 ; repeat for array size
    
L2:	pop esi
    pop ecx                 ; return sum in EAX
    
    mov esp, ebp
    pop ebp
    ret	8
ArraySum endp

end
