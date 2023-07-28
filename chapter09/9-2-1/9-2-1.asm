title 9-2-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 9-2-1
.data
    source1 dword 20 dup(0FFFFFFFFh)
    target1 dword 20 dup(?)
.code
    cld                         ; direction = forward
    mov ecx, lengthof source1   ; set rep counter
    mov esi, offset source1     ; esi points to source
    mov edi, offset target1     ; edi points to target
    rep movsd

; 9-2-2
.data
    source2 dword 1234h
    target2 dword 5678h

    source3 dword 1234h, 5678h, 2222h, 3333h
    target3 dword 1234h, 5678h, 9999h, 3333h
.code
    mov esi, offset source2
    mov edi, offset target2
    cmpsd                       ; compare doublewords
    ja L1                       ; jump if source > target
    mov eax, 1
L1: mov eax, 0

    mov esi, offset source3
    mov edi, offset target3
    cld                         ; direction = forward
    mov ecx, lengthof source3   ; repeatition counter
    repe cmpsd                  ; repeat while equal (ECX > 0 && ZF = 1)

; 9-2-3
.data
    alpha byte "ABCDEFGH", 0
.code
    mov edi, offset alpha       ; EDI points to the string
    mov al, 'F'                 ; search for the letter 'F'
    mov ecx, lengthof alpha     ; set the search count
    cld                         ; direction = forward
    repne scasb                 ; repeat while not equal
    jnz quit                    ; quit if letter not found
    dec edi                     ; found: back up EDI
quit:
    nop

; 9-2-4
.data
    COUNT = 100
    string1 byte COUNT dup(?)
.code
    mov al, 0FFh                ; value to be stored
    mov edi, offset string1     ; EDI points to target
    mov ecx, COUNT              ; character count
    cld                         ; direction = forward
    rep stosb                   ; fill with contents of AL

; 9-2-5
.data
    array      dword 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  ; test data
    multiplier dword 10                             ; test data
.code
    cld                     ; direction = forward
    mov esi, offset array   ; source index
    mov edi, esi            ; destination index
    mov ecx, lengthof array ; loop counter
L2: lodsd                   ; load [ESI] into EAX
    mul multiplier          ; multiply by a value
    stosd                   ; store EAX into [EDI]
    loop L2

    mov ecx, 0
    call ExitProcess
main endp

end main
