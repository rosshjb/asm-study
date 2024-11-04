; Scanning an Array (arrayscan.asm)
; Scan an array for the first nonzero value.

include irvine32.inc

.data
    intarray sword 0, 0, 0, 0, 1, 20, 35, -12, 66, 4, 0
    ;intarray sword 1, 0, 0, 0   ; alternate test data
    ;intarray sword 0, 0, 0, 0   ; alternate test data
    ;intarray sword 0, 0, 0, 1   ; alternate test data
    noneMsg byte "A non-zero value was not found", 0
.code
main proc
    mov ebx, offset intarray    ; point to the array
    mov ecx, lengthof intarray  ; loop counter

L1: cmp word ptr [ebx], 0       ; compare value to zero
    jnz found                   ; found a value
    add ebx, 2                  ; point to next
    loop L1                     ; continue the loop
    jmp notFound                ; none found

found:                          ; display the value
    movsx eax, word ptr [ebx ]  ; sign-extend into eax
    call WriteInt
    jmp quit

notFound:                       ; display "not found" message
    mov edx, offset noneMsg
    call WriteString

quit:
    call Crlf
    call WaitMsg

    exit
main endp

end main