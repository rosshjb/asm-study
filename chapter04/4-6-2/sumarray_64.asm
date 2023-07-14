; Summing an Array (sumarray_64.asm)

ExitProcess proto

.data
    intarray qword 1000000000000h, 2000000000000h,
                   3000000000000h, 4000000000000h

.code
main proc
    mov rdi, offset intarray    ; rdi = address of intarray
    mov rcx, lengthof intarray  ; initialize loop counter
    mov rax, 0                  ; sum = 0
L1:                             ; mark beginning of loop
    add rax, [rdi]              ; add an integer
    add rdi, type intarray      ; point to next element
    loop L1                     ; repeat until rcx = 0

    mov ecx, 0                  ; ExitProcess return value
    call ExitProcess

main endp
end