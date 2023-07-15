; 5-1-2-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    saveFlags dword ?
.code
main proc
    pushfd                  ; save the flags
    mov eax, 0FFFFFFFFh
    add eax, 1
    popfd                   ; restore the flags

    pushfd                  ; push flags on stack
    pop saveFlags           ; copy into a variable
    mov eax, 0FFFFFFFFh
    add eax, 1
    push saveFlags          ; push saved flag values
    popfd                   ; copy into the flags

    call mysub

    call readvalue

    invoke ExitProcess, 0
main endp

mysub proc
    pushad ; save general-purpose registers

    mov eax, 10h
    mov edx, 20h
    mov ecx, 30h

    popad  ; restore general-purpose registers
    ret
mysub endp

readvalue proc
    pushad          ; save general-purpose registers

    mov eax, 10h    ; return_value

    popad           ; overwrites eax!
    ret
readvalue endp

end main