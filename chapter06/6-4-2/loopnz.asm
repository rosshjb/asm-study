; loopnz.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    array sword -3, -6, -1, -10, 10, 30, 40, 4
    sentinel sword 0
.code
main proc
    mov esi, offset array
    mov ecx, lengthof array
L1: test word ptr [esi], 8000h      ; test the sign bit
    
    pushfd                          ; push flags on stack
    add esi, type array             ; move to next position
    popfd                           ; pop flags from stack

    loopnz L1                       ; continue loop
    jnz quit                        ; none found
    sub esi, type array             ; esi points to value

quit:
    invoke ExitProcess, 0
main endp

end main