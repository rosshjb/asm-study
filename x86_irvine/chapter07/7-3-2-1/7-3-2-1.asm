title 7-3-2-1.asm

ExitProcess proto

.data
    multiplicand qword -16
.code
main proc
    mov rax, -4
    mov rbx, 4
    imul rbx                    ; RDX = FFFFFFFFFFFFFFFFh, RAX = FFFFFFFFFFFFFFF0h (RDX:RAX = -16d)

    imul rax, multiplicand, 4   ; RAX = FFFFFFFFFFFFFFC0h (-64d)

    mov rcx, 0
    call ExitProcess
main endp

end