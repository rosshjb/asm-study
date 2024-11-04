title asm program launched from C++ (asmMain.asm)
option casemap:none
includelib legacy_stdio_definitions.lib

.686p
.model flat, c

system proto pCommand:ptr byte
printf proto c, format:ptr byte, args:vararg
scanf  proto c, format:ptr byte, args:vararg
fopen  proto mode:ptr byte, filename:ptr byte
fclose proto pFile:dword

BUFFER_SIZE = 5000
.data
    str1 byte "cls", 0
    str2 byte "dir/w", 0
    str3 byte "Enter the name of a file:", 0
    str4 byte "%s", 0
    str5 byte "cannot open file", 0dh, 0ah, 0
    str6 byte "The file has been opened", 0dh, 0ah, 0
    modeStr byte "r", 0

    fileName byte 60 dup(0)
    pBuf dword ?
    pFile dword ?
.code
asm_main proc
    ; clear the screen, display disk directory
    push offset str1
    call system
    add esp, 4

    invoke system, addr str2

    ; ask for a filename
    push offset str3
    call printf
    add esp, 4

    invoke scanf, addr str4, addr fileName

    ; try to open the file
    invoke fopen, addr fileName, addr modeStr
    mov pFile, eax

    .if eax == 0    ; cannot open file?
        invoke printf, addr str5
        jmp quit
    .else
        invoke printf, addr str6
    .endif

    ; close the file
    invoke fclose, pFile

quit:
    ret
asm_main endp

end
