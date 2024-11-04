title Endless Recursion (endless.asm)

.386
.model flat, stdcall
.stack 4096

WriteString proto
ExitProcess proto, dwExitCode:dword

.data
    endlessStr byte "This recursion never stops", 0
.code
main proc
    call Endless

    mov ecx, 0
    call ExitProcess
main endp

Endless proc
    mov edx, offset endlessStr
    call WriteString

    call Endless
    ret                 ; never executes
Endless endp

end main
