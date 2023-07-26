title 8-4-8.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword
myProc proto, x:dword, y:dword
WriteStackFrame proto, numParam:dword, numLocalVal:dword, numSavedReg:dword
WriteStackFrameName proto, numParam:dword, numLocalVal:dword,
    numSavedReg:dword, procName:ptr byte
Crlf proto
WaitMsg proto

.code
main proc
    mov eax, 0EAEAEAEAh
    mov ebx, 0EBEBEBEBh

    invoke myProc, 1111h, 2222h     ; pass two integers arguments

    mov ecx, 0
    call ExitProcess
main endp

myProc proc uses eax ebx,
    x:dword, y:dword
    local a:dword, b:dword
.data
    params = 2
    locals = 2
    saved_regs = 2
    procName byte "myProc", 0
.code
    mov a, 0AAAAh
    mov b, 0BBBBh

    invoke WriteStackFrame,
        params,                     ; number of passed parameters
        locals,                     ; number of local variables
        saved_regs                  ; number of saved registers
    call Crlf

    invoke WriteStackFrameName,
        params,                     ; number of passed parameters
        locals,                     ; number of local variables
        saved_regs,                 ; number of saved registers
        addr procName               ; null-terminated string
    call Crlf

    call WaitMsg
    ret
myProc endp

end main
