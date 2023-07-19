; 6-3-4-6.asm

.386
.model flat, stdcall
.stack 4096

includelib irvine32.lib

ExitProcess proto, dwExitCode:dword
Delay proto
ReadKey proto

.data
    charv byte ?
.code
main proc
L1: mov eax, 10     ; create 10 ms delay
    call Delay
    call ReadKey    ; check for key
    jz L1           ; repeat if no key
    mov charv, al    ; save the character
    
    mov ecx, 0
    call ExitProcess
main endp

end main