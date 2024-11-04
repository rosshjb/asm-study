title 7-3-1-2.asm

ExitProcess proto

.data
    multiplier qword 10h
.code
main proc
    mov rax, 0FFFF0000FFFF0000h
    mov rbx, 2
    mul rbx         ; RDX:RAX = 0000000000000001 FFFE0001FFFE0000h, CF = 1

    mov rax, 0AABBBBCCCCDDDDh
    mul multiplier  ; RDX:RAX = 0000000000000000 0AABBBBCCCCDDDD0h, CF = 0

    mov rcx, 0
    call ExitProcess
main endp

end