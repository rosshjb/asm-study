title Pointers (pointers.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

; create user-defined types.
pbyte  typedef ptr byte     ; pointer to bytes
pword  typedef ptr word     ; pointer to words
pdword typedef ptr dword    ; pointer to doublewords    

.data
    arrayB byte  10h, 20h, 30h
    arrayW word  1, 2, 3
    arrayD dword 4, 5, 6

    ptr1 pbyte  arrayB
    ptr2 pword  arrayW
    ptr3 pdword arrayD

.code
main proc
    mov esi, ptr1
    mov al, [esi]   ; 10h

    mov esi, ptr2
    mov ax, [esi]   ; 1

    mov esi, ptr3
    mov eax, [esi]  ; 4

    invoke ExitProcess, 0
main endp
end main