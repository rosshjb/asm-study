title Integer Summation Program (sum_main.asm)

; Multimodule example: (main module)
; This program inputs multiple integers from the user,
; stores them in an array, calculates the sum of the
; array, and displays the sum.

include sum.inc

COUNT = 3

.data
    prompt1 BYTE  "Enter a signed integer: ", 0
    prompt2 BYTE  "The sum of the integers is: ", 0
    array   DWORD COUNT dup(?)
    sum     DWORD ?

.code
main proc
    call Clrscr
    
    invoke PromptForIntegers, 
        addr prompt1, 
        addr array, 
        COUNT

    invoke ArraySum, 
        addr array, 
        COUNT
    mov	sum, eax

    invoke DisplaySum, 
        addr prompt2, 
        sum

    call Crlf
    call WaitMsg

    mov ecx, 0
    call ExitProcess
main endp

end main
