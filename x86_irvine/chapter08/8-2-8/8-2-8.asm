title 8-2-8.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
    call MySub1
    call MySub2
    call MySub3
    call MySub4
    call MySub5
    call MySub6
    call Example1

    mov ecx, 0
    call ExitProcess
main endp

MySub1 proc
    enter 0, 0

    leave
    ret
MySub1 endp

MySub2 proc
    enter 8, 0

    leave
    ret
MySub2 endp

MySub3 proc
    local var1:byte
    ; ...
    ret
MySub3 endp

MySub4 proc
    local temp:dword, swapFlag:byte
    ; ...
    ret
MySub4 endp

MySub5 proc
    local pArray:ptr word
    ; ...
    ret
MySub5 endp

MySub6 proc
    local tempArray[10]:dword
    ; ...
    ret
MySub6 endp

Example1 proc
    local temp:dword
    ; ...
    ret
Example1 endp

end main
