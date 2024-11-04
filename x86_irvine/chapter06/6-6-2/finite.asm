; Finite State Machine (finite.asm)

include irvine32.inc

ENTER_KEY = 13

.data
    InvalidInputMsg byte "Invalid Input", 13, 10, 0

.code
main proc
    call Clrscr

StateA:
    call Getnext            ; read next char into AL
    cmp al, '+'             ; leading + sign?
    je StateB               ; go to State B
    cmp al, '-'             ; leading - sign?
    je StateB               ; go to State B
    call IsDigit            ; ZF = 1 if AL contains a digit
    jz StateC               ; go to State C
    call DisplayErrorMsg    ; invalid input found
    jmp Quit
StateB:
    call Getnext            ; read next char into AL
    call IsDigit            ; ZF = 1 if AL contains a digit
    jz StateC
    call DisplayErrorMsg    ; invalid input found
    jmp Quit
StateC:
    call Getnext            ; read next char into AL
    call IsDigit            ; ZF = 1 if AL contains a digit
    jz StateC
    cmp al, ENTER_KEY       ; Enter key pressed?
    je Quit
    call DisplayErrorMsg    ; invalid input found
    jmp Quit
Quit:
    call Crlf

    exit
main endp

; -------------------------------------------------------
Getnext proc
;
; Reads a character from standard input.
; Receives: nothing
; Returns: AL contains the character
; -------------------------------------------------------
    call ReadChar       ; input from keyboard
    call WriteChar      ; echo on screen
    ret
Getnext endp

; -------------------------------------------------------
DisplayErrorMsg proc
;
; Displays an error message indicating that the input
; stream contains illegal input.
; Receives: nothing
; Returns: nothing
; -------------------------------------------------------
    push edx
    mov edx, offset InvalidInputMsg
    call WriteString
    pop edx
    ret
DisplayErrorMsg endp

end main