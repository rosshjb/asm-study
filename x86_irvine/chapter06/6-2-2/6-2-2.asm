; 6-2-2.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 6-2-2
.code
    mov al, 10101110b
    and al, 11110110b   ; clear bits 0 and 3, leave others unchanged.
                        ; result in al = 10100110b

.data
    array byte "Hello"
.code
    mov ecx, lengthof array
    mov esi, offset array
L1:
    and byte ptr [esi], 11011111b   ; clear bit 5
    inc esi
    loop L1

; 6-2-3
.code
    mov al, 11100011b
    or  al, 00000100b   ; result in al = 11100111b

; 6-2-4
.data
    setX = 10000000000000000000000000000111b
    setY = 10000010101000000000011101100011b
.code
    mov eax, setX
    and eax, 10000b ; is element[4] a member of setX?

    mov eax, setX
    not eax

    mov eax, setX
    and eax, setY

    mov eax, setX
    or  eax, setY

; 6-2-5
    mov al, 10110101b   ; 5 bits = odd parity
    xor al, 0           ; parity flag clear (odd)
    mov al, 11001100b   ; 4 bits = even parity
    xor al, 0           ; parity flag set (even)

    mov ax, 64c1h       ; 01100100 11000001
    xor ah, al          ; parity flag set (even)

; 6-2-6
    mov al, 11110000b
    not al              ; al = 00001111b

; 6-2-7
    mov  al, 00100101b
    test al, 00001001b  ; zf = 0

    mov  al, 00100100b
    test al, 00001001b  ; zf = 1

; 6-2-8
    mov ax, 5
    cmp ax, 10          ; zf = 0 and cf = 1

    mov ax, 1000
    mov cx, 1000
    cmp cx, ax          ; zf = 1 and cf = 0

    mov si, 105
    cmp si, 0           ; zf = 0 and cf = 0

; 6-2-9
    mov al, 10101010b
    test al, 0          ; set zero flag
    and al, 0           ; set zero flag
    or al, 1            ; clear zero flag

    mov al, 00101010b
    or al, 80h          ; set sign flag
    and al, 7fh         ; clear sign flag

    mov al, 7fh         ; al = +127
    inc al              ; al = 80h (-128), of = 1
    or eax, 0           ; clear overflow flag

; 6-2-10
.data
    allones qword 0ffffffffffffffffh
.code
    mov rax, allones    ; rax = FFFFFFFFFFFFFFFF
    and rax, 80h        ; rax = 0000000000000080
    
    mov rax, allones    ; rax = FFFFFFFFFFFFFFFF
    and rax, 8080h      ; rax = 0000000000008080

    mov rax, allones    ; rax = FFFFFFFFFFFFFFFF
    and rax, 808080h    ; rax = 0000000000808080

    mov rax, allones    ; rax = FFFFFFFFFFFFFFFF
    and rax, 80808080h  ; rax = FFFFFFFF80808080

    invoke ExitProcess, 0
main endp

end main