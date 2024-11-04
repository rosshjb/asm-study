; Summing an Array (SumArray.asm)

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    intarray dword 10000h, 20000h, 30000h, 40000h
.code
main proc
    mov edi, offset intarray        ; 1. edi = address of intarray
    mov ecx, lengthof intarray      ; 2. initialize loop counter
    mov eax, 0                      ; 3. sum = 0
L1:                                 ; 4. mark beginning of loop
    add eax, [edi]                  ; 5. add an integer
    add edi, type intarray          ; 6. point to next element
    loop L1                         ; 7. repeat until ecx = 0

    invoke ExitProcess, 0
main endp
end main