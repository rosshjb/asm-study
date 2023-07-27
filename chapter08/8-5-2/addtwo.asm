title addtwo.asm
option casemap:none

.386
.model flat, stdcall

.code
AddTwo1 proc,
    val1:dword,
    val2:dword

    mov eax, val1
    add eax, val2

    ret
AddTwo1 endp

AddTwo2 proc,
    val1:dword,
    val2:dword

    mov eax, val1
    add eax, val2

    ret
AddTwo2 endp

end
