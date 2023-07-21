title multishift.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    ArraySize = 3
    array byte ArraySize dup(99h)   ; 1001 pattern in each nybble
.code
main proc
    mov esi, 0
    ; [esi + 2] [esi + 1] [esi] = 10011001 10011001 10011001
    shr array[esi + 2], 1           ; high byte
    rcr array[esi + 1], 1           ; middle byte, include Carry flag
    rcr array[esi], 1               ; low byte, include Carry flag
    ; [esi + 2] [esi + 1] [esi] = 01001100 11001100 11001100

    mov ecx, 0
    call ExitProcess
main endp

end main