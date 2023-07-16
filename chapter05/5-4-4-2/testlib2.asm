; Link Library Test #2 (TestLib2.asm)

; Testing the Irvine32 Library procedures.

include irvine32.inc

option casemap:none     ; identifier case-sensitive

TAB = 9                 ; ascii code for tab

.code
main proc
    call Randomize      ; init random generator
    
    call Rand1
    call Rand2

    call WaitMsg        ; "Press any key..."

    exit
main endp

Rand1 proc
; Generate ten pseudo-random integers.
    mov ecx, 10         ; loop 10 times
L1: call Random32       ; generate random int
    call WriteDec       ; write in unsigned decimal

    mov al, TAB         ; horizontal tab
    call WriteChar      ; write the tab

    loop L1

    call Crlf
    ret
Rand1 endp

Rand2 proc
; Generate ten pseudo-random integers from -50 to +49
    mov ecx, 10         ; loop 10 times
L1: mov eax, 100        ; values 0-99
    call RandomRange    ; generate random int
    sub eax, 50         ; values -50 to +49
    call WriteInt       ; write signed decimal

    mov al, TAB         ; horizontal tab
    call WriteChar      ; write the tab

    loop L1

    call Crlf
    ret
Rand2 endp

end main