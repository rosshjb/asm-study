title 8-4-3.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    barray byte  10h, 20h, 30h
    darray dword 10000h, 20000h, 30000h
.code
main proc
    push 2
    push 1
    call AddTwo

    push offset barray
    call FillArray

    push offset darray + 4
    push offset darray
    call Swap

    push offset barray
    call Read_File

    push 2
    push 1
    call Example1
    add esp, 8

    push 4
    push 3
    call Example2

    mov ecx, 0
    call ExitProcess
main endp

AddTwo proc,
    val1: dword,
    val2: dword
    mov eax, val1
    add eax, val2
    ret
AddTwo endp

FillArray proc, pArray: ptr byte
    ; ...
    ret
FillArray endp

Swap proc pValX: ptr dword, pValY: ptr dword
    ; ...
    ret
Swap endp

Read_File proc uses eax ebx,
    pBuffer: ptr byte
    local fileHandle:dword

    mov esi, pBuffer
    mov fileHandle, eax
    ret
Read_File endp

Example1 proc c param1: dword, param2: dword
    ret
Example1 endp

Example2 proc stdcall param1: dword, param2: dword
    ret
Example2 endp

end main
