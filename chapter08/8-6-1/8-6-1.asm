title 8-6-1.asm

.386
.model flat, stdcall
.stack 4096

includelib irvine32.lib

WriteHex proto
Crlf proto
WaitMsg proto
ExitProcess proto, dwExitCode:dword

.data
    charVal byte 'x'

    word1   word 1234h
    word2   word 4111h

    longval qword 1234567800ABCDEFh
.code
main proc
    call mySub1

    push 10
    call mySub2

    push 20
    call mySub3

    push 'x'
    call Uppercase

    movzx eax, charVal          ; move with zero extension
    push eax
    call Uppercase

    movzx eax, word1
    push eax
    movzx eax, word2
    push eax
    call AddTwo                 ; sum is in EAX

    push dword ptr longVal + 4  ; high doubleword
    push dword ptr longVal      ; low doubleword
    call WriteHex64
    call Crlf

    call Example1

    call Example2

    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

mySub1 proc uses ecx edx
    ret
mySub1 endp

mySub2 proc uses ecx edx
    push ebp            ; save base pointer
    mov ebp, esp        ; base of stack frame

    mov eax, [ebp + 8]  ; wrong location!

    pop ebp             ; restore base pointer
    ret 4               ; clean up arguments from the stack
mySub2 endp

mySub3 proc uses ecx edx param:dword
    mov eax, [ebp + 8]  ; EAX = 20

    ret 4               ; clean up arguments from the stack
mySub3 endp

Uppercase proc
    push ebp
    mov ebp, esp

    mov al, [esp + 8]   ; AL = character
    cmp al, 'a'         ; less than 'a'?
    jb L1               ; yes: do nothing
    cmp al, 'z'         ; greater than 'z'?
    ja L1               ; yes: do nothing
    sub al, 32          ; no: convert it
L1:
    pop ebp
    ret 4               ; clean up arguments from the stack
Uppercase endp

AddTwo proc
    mov eax, [esp + 4]
    add eax, [esp + 8]

    ret 8
AddTwo endp

WriteHex64 proc
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]     ; high doubleword
    call WriteHex
    mov eax, [ebp + 8]      ; low doubleword
    call WriteHex

    pop ebp
    ret 8
WriteHex64 endp

Example1 proc
    local var1:byte         ; EBP - 4 = ESP (byte variable, but dword aligned)

    mov var1, 12h           ; var1 = [EBP - 1], not [EBP - 4]
    mov al, var1            ; like 'byte push but doubleword aligned'

    ret
Example1 endp

Example2 proc
    local temp:dword, SwapFlag:byte     ; EBP - 8 = ESP

    mov temp, 12345678h                 ; temp = [EBP - 4]
    mov SwapFlag, 90h                   ; SwapFlag = [EBP - 5], not [EBP - 8]

    ret
Example2 endp

end main
