; Library Test #1: Integer I/O (InputLoop.asm)

; Tests the Clrscr, Crlf, DumpMem, ReadInt, SetTextColor,
; WaitMsg, WriteBin, WriteHex, and WriteString procedures.

include irvine32.inc

.data
    COUNT = 4
    BlueTextOnGray = blue + (lightGray * 16)
    DefaultColor   = lightGray + (black * 16)

    arrayD sdword 12345678h, 1A4B2000h, 3434h, 7AB9h
    prompt byte   "Enter a 32-bit signed integer: ", 0

.code
main proc
; Select blue text on a light gray background
    mov eax, BlueTextOnGray
    call SetTextColor
    call Clrscr                 ; clear the screen

; Display an array using DumpMem
    mov esi, offset arrayD
    mov ebx, type arrayD        ; doubleword = 4 bytes
    mov ecx, lengthof arrayD    ; number of units in arrayD
    call DumpMem                ; display memory

; Ask the user to input a sequence of signed integers
    call Crlf                   ; new line
    mov ecx, COUNT
L1: mov edx, offset prompt
    call WriteString
    call ReadInt                ; input integer into EAX
    call Crlf                   ; display a newline

; Display the integer in decimal, hexadecimal, and binary
    call WriteInt               ; display in signed decimal
    call Crlf

    call WriteHex               ; display in hexadecimal
    call Crlf
    call WriteBin               ; display in binary
    call Crlf
    call Crlf

    loop L1                     ; repeat the loop

; Return the console window to default colors
    call WaitMsg                ; "Press any key..."

    mov eax, DefaultColor
    call SetTextColor
    call Clrscr

    exit                        ; invoke ExitProcess, 0
main endp

end main