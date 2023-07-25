title 8-4-4-2.asm

.386
.model flat, stdcall
.stack 4096

Sub1 proto p1:byte, p2:word, p3:ptr byte
ExitProcess proto, dwExitCode:dword

.data
    byte_1  byte  10h
    word_1  word  2000h
    word_2  word  3000h
    dword_1 dword 12345678h
.code
main proc
    invoke Sub1, byte_1, word_1, addr byte_1

    ; invoke Sub1, word_1, word_2, addr byte_1    ; error: type mismatch

    ; invoke Sub1, byte_1, word_2                 ; error: too few arguments

    ; invoke Sub1,
    ;     byte_1, word_2, addr byte_1, word_2     ; error: too many arguments

    invoke Sub1, byte_1, byte_1, addr byte_1

    invoke Sub1, byte_1, word_1, dword_1        ; no error detected

    mov ecx, 0
    call ExitProcess
main endp

Sub1 proc p1:byte, p2:word, p3:ptr byte
    ret
Sub1 endp

end main
