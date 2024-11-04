title DisplaySum Procedure (_display.asm)

option casemap:none

.386
.model flat, stdcall

includelib irvine32.lib

extern WriteString@0:proc, WriteInt@0:proc, Crlf@0:proc

.code
; ------------------------------------------------------------------------------
DisplaySum proc stdcall
; Displays the sum on the console.
; Receives:
;   ptrPrompt   ; offset of prompt string
;   theSum      ; the array sum (DWORD)
; Returns: nothing
; ------------------------------------------------------------------------------
    theSum    equ [ebp+12]
    ptrPrompt equ [ebp+8]

	push ebp
    mov ebp, esp

	push eax
	push edx

	mov edx, ptrPrompt      ; pointer to prompt
	call WriteString@0
	mov eax, theSum
	call WriteInt@0         ; display EAX
	call Crlf@0

	pop	edx
	pop	eax

    mov esp, ebp
    pop ebp
	ret	8                   ; restore the stack
DisplaySum endp

end
