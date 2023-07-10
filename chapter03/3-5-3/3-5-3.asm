; 3-5-3.asm

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

pi  equ <3.1416>
pressKey    equ <"Press any key to continue...", 0>

matrix1 equ 10 * 10
matrix2 equ <10 * 10>

continueMsg textequ <"Do you wish to continue <Y/N>?">

rowSize = 5
count   textequ %(rowSize * 2)
move    textequ <mov>
setupAL textequ <move al, count>

.data
    prompt  byte pressKey

    m1  word    matrix1
    m2  word    matrix2

    prompt1 byte continueMsg

.code
main proc
    mov eax, 0
    setupAL     ; mov al, 10

    invoke ExitProcess, 0
main endp
end main