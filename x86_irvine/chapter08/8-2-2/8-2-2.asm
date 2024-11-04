; 8-2-2.asm

.386
.model flat, stdcall
.stack 4096

DumpMem proto
RandomRange proto
ExitProcess proto, dwExitCode:dword

.data
    array1 dword 00010000h, 00020000h, 00030000h

.code
main proc
; 8-2-2
    ; stack parameters
    mov ebx, 11111111h
    mov ecx, 22222222h
    mov esi, 33333333h
                                ; save register values
    push ebx                    ; callee-saved (non-volatile), no need to save
    push ecx                    ; caller-saved (volatile) register, need to save
    push esi                    ; callee-saved (non-volatile), no need to save

    mov esi, offset array1      ; starting offset
    mov ecx, lengthof array1    ; size, in units
    mov ebx, type array1        ; doubleword format
    call DumpMem                ; display memory

    pop esi                     ; restore register values
    pop ecx
    pop ebx

    ; passing by value
.data
    val1 dword 5
    val2 dword 6
.code
    push val2
    push val1
    call AddTwo     ; EAX = Bh = 11d
    add esp, 8

    ; passing by reference
    push offset val2
    push offset val1
    call Swap       ; val1 = 6d, val2 = 5d
    add esp, 8

    ; passing arrays
.data
    array2 dword 50 dup(0)
.code
    push offset array2
    push lengthof array2
    call ArrayFill

    mov esi, offset array2
    mov ecx, lengthof array2
    mov ebx, type array2
    call DumpMem

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
AddTwo proc
; Adds two integers, return sum in EAX. (cdecl convention)
; ------------------------------------------------------------------------------
    push ebp
    mov ebp, esp        ; base of stack frame

    mov eax, [ebp + 12] ; second parameter
    add eax, [ebp + 8]  ; first parameter

    pop ebp
    ret                 ; caller cleans up the arguments from the stack
AddTwo endp

; ------------------------------------------------------------------------------
Swap proc
; Exchange the values of two 32-bit integers. (cdecl convention)
; Returns: nothing
; ------------------------------------------------------------------------------
    mov esi, [esp + 4]  ; pointer to first integer
    mov edi, [esp + 8]  ; pointer to second integer
    
    mov eax, [esi]      ; get first integer
    xchg eax, [edi]     ; exchange with second
    mov [esi], eax      ; replace first integer

    ret                 ; caller cleans up the arguments from the stack
Swap endp

; ------------------------------------------------------------------------------
ArrayFill proc
; Fills an array with 32-bit random integers. (stdcall convention)
; ------------------------------------------------------------------------------
    push ebp
    mov ebp, esp

    pushad              ; save registers

    mov esi, [ebp + 12] ; offset of array
    mov ecx, [ebp + 8]  ; array length
    cmp ecx, 0          ; ECX == 0?
    je L2               ; yes: skip over loop
L1:
    mov eax, 0FFFFFFFFh ; get random 0 - FFFFFFFEh
    call RandomRange    ; from the link library
    mov [esi], eax      ; insert value in array
    add esi, type dword ; move to next element
    loop L1
L2:
    popad               ; restore registers

    pop ebp
    ret 8               ; callee cleans up the arguments from the stack
ArrayFill endp

end main
