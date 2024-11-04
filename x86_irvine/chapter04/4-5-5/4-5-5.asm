; Copying a String (copystr.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    source byte "This is the source string", 0
    target byte sizeof source dup(0)
.code
main proc
    mov esi, 0              ; index register
    mov ecx, sizeof source  ; loop counter
L1:
    mov al, source[esi]     ; get a character from source
    mov target[esi], al     ; store it in the target
    inc esi                 ; move to next character
    loop L1                 ; repeat for entire string
    
    invoke ExitProcess, 0
main endp
end main