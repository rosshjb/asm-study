title Binary to ASCII (bintoasc.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    binval dword 1234ABCDh  ; sample binary value
    buffer byte 32 dup(0), 0
.code
main proc
    mov eax, binval         ; EAX = binary integer
    mov esi, offset buffer  ; point to the buffer
    call BinToAsc           ; do the conversion
                            ; buffer = "00010010001101001010101111001101"
    mov ecx, 0
    call ExitProcess
main endp

; -----------------------------------------------------
BinToAsc proc
;
; Converts 32-bit binary integer to ASCII binary string.
; Receives: EAX = binary integer, ESI points to buffer
; Returns: buffer filled with ASCII binary digits
; -----------------------------------------------------
    push ecx
    push esi

    mov ecx, 32             ; number of bits in EAX
L1: shl eax, 1              ; shift high bit into Carry flag
    mov byte ptr [esi], '0' ; choose 0 as default digit
    jnc L2                  ; if no Carry, jump to L2
    mov byte ptr [esi], '1' ; else move 1 to buffer
L2: inc esi                 ; next buffer position
    loop L1                 ; shift another bit to left

    pop esi
    pop ecx
    
    ret
BinToAsc endp

end main