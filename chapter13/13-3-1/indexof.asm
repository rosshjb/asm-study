title indexof function (indexof.asm)

.586
.model flat, C
option casemap:none

IndexOf proto, srchVal:dword, arrayPtr:ptr dword, count: dword

.code
; ------------------------------------------------------------------------------
IndexOf proc uses ecx esi edi, srchVal:dword, arrayPtr:ptr dword, count: dword
;
; Performs a linear search of a 32-bit integer array, looking for a specific
; value. If the value is found, the matching index position is returns in EAX;
; otherwise, EAX equals -1.
; ------------------------------------------------------------------------------
    NOT_FOUND = -1

    mov eax, srchVal            ; search value
    mov ecx, count              ; array size
    mov esi, arrayPtr           ; pointer to array
    mov edi, 0                  ; index

L1:
    cmp [esi + edi * 4], eax
    je found
    inc edi
    loop L1
notFound:
    mov eax, NOT_FOUND
    jmp exit
found:
    mov eax, edi
exit:
    ret
IndexOf endp

end
