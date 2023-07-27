title  Integer Summation Program (sum_main.asm)

; Multimodule example (main module):
; This program inputs multiple integers from the user, stores them in an array,
; calculates the sum of the array, and displays the sum.

option casemap:none

.386
.model flat, stdcall
.stack 4096

includelib irvine32.lib

extern PromptForIntegers@0:proc
extern ArraySum@0:proc
extern DisplaySum@0:proc
extern Clrscr@0:proc
extern Crlf@0:proc
extern WaitMsg@0:proc
extern ExitProcess@4:proc

PromptForIntegers   equ PromptForIntegers@0
ArraySum            equ ArraySum@0
DisplaySum          equ DisplaySum@0
Crlf                equ Crlf@0
WaitMsg             equ WaitMsg@0
ExitProcess         equ ExitProcess@4

.const
    COUNT = 3

.data
    prompt1 byte "Enter a signed integer: ", 0
    prompt2 byte "The sum of the integers is: ", 0
    array dword COUNT dup(?)
    sum dword ?
.code
main proc
    call Clrscr@0

; PromptForIntegers(offset prompt1, offset array, lengthof array)
    push lengthof array
    push offset array
    push offset prompt1
    call PromptForIntegers

; eax = ArraySum(offset array, lengthof array)
    push lengthof array
    push offset array
    call ArraySum
    mov sum, eax

; DisplaySum(offset prompt2, sum)
    push sum
    push offset prompt2
    call DisplaySum

    call Crlf
    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

end main
