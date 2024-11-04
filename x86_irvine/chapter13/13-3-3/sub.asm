title asm functions called from C++ (sub.asm)

.386
.model flat, stdcall
.stack 4096

SetTextColor proto
Clrscr proto
Crlf proto

; External C++ functions
askForInteger proto c
showInt proto c, value: sdword, outWidth:dword
newLine proto c

OUT_WIDTH = 8
ENDING_POWER = 10

.data
    intVal dword ?
.code
; ------------------------------------------------------------------------------
SetTextOutColor proc c, color:dword
;
; Sets the text colors and clears the console window.
; ------------------------------------------------------------------------------
    mov eax, color
    call SetTextColor
    call Clrscr
    ret
SetTextOutColor endp

; ------------------------------------------------------------------------------
DisplayTable proc c
;
; Inputs an integer n and displays a multiplication table ranging from n * 2^1
; to n * 2^10.
; ------------------------------------------------------------------------------
    call askForInteger                  ; call C++ function
    mov intVal, eax                     ; save the integer

    mov ecx, ENDING_POWER               ; loop counter
L1: push ecx                            ; save loop counter
    shl intVal, 1                       ; multiply by 2

    push OUT_WIDTH
    push intVal
    call showInt
    add esp, 8

    call Crlf
    pop ecx                             ; restore loop counter
    loop L1

    ret
DisplayTable endp

end
