title DisplaySum Procedure (_display.asm)

include sum.inc

.code
; ------------------------------------------------------------------------------
DisplaySum proc,
    ptrPrompt:ptr byte, ; prompt string
    theSum:dword        ; the array sum
;
; displays the sum on the console.
; returns:  nothing
; ------------------------------------------------------------------------------
    push eax
    push edx

    mov edx, ptrPrompt  ; pointer to prompt
    call WriteString
    mov eax, theSum
    call WriteInt       ; display eax
    call Crlf
    
    pop edx
    pop eax
    ret
DisplaySum endp

end
