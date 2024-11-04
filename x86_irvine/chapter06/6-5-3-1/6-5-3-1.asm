; 6-5-3-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    val1 sdword 10
    val2 sdword 20

.code
main proc
    mov eax, val1   ; copy variable to eax
beginwhile:
    cmp eax, val2   ; if not (val1 < val2)
    jnl endwhile    ;   exit the loop
    inc eax         ; val1++
    dec val2        ; val2--
    jmp beginwhile  ; repeat the loop
endwhile:
    mov val1, eax   ; save new value for val1

    mov ecx, 0
    call ExitProcess
main endp

end main