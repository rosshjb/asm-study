title 8-4-2.asm

.386
.model flat, stdcall
.stack 4096

FillArray proto, pArray:ptr dword
Swap proto, pValX:ptr dword, pValY:ptr dword
ExitProcess proto, dwExitCode:dword

.data
    array dword 4 dup(0)
.code
main proc
    invoke FillArray, addr array

    invoke Swap,
        addr array,
        addr [array + 4]

    mov ecx, 0
    call ExitProcess
main endp

FillArray proc, pArray:ptr dword
    mov ecx, 0
L1:
    cmp ecx, 4
    jge L2
    mov edx, pArray
    mov [edx + ecx * type dword], ecx
    inc ecx
    jmp L1
L2:
    ret
FillArray endp

Swap proc uses eax esi edi, pValX:ptr dword, pValY:ptr dword
	mov esi, pValX
	mov edi, pValY
	mov eax, [esi]
	xchg eax, [edi]
	mov [esi], eax
	ret
Swap endp

end main
