TITLE asm main

includelib legacy_stdio_definitions.lib

.686p
.model flat, c
.stack 4096

printf proto c, format:ptr byte, args:vararg
scanf proto c, format:ptr byte, args:vararg

.data
    doublev real8 1234567.890123
    formatStr byte "%.3f", 0dh, 0ah, 0

    formatTwo byte "%.2f", 9, "%.3f", 0dh, 0ah, 0
    val1 real8 456.789
    val2 real8 864.231

    strSingle byte "%f", 0
    strDouble byte "%lf", 0
    single1 real4 ?
    double1 real8 ?
.code
asmMain proc c
    push dword ptr [doublev + 4]
    push dword ptr [doublev]
    push offset formatStr
    call printf
    add esp, 12

    invoke printf, addr formatTwo, val1, val2

    push offset single1
    push offset strSingle
    call scanf
    add esp, 8

    invoke scanf, addr strDouble, addr double1

    ret
asmMain endp

end
