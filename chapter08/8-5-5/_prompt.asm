title Prompt for Integers (_prompt.asm)

option casemap:none

.386
.model flat, stdcall

includelib irvine32.lib

extern WriteString@0:proc, ReadInt@0:proc, Crlf@0:proc

.code
; ------------------------------------------------------------------------------
PromptForIntegers proc stdcall
; Prompts the user for an array of integers and fills the array with the user's
; input.
; Receives:
;   ptrPrompt:PTR BYTE ; prompt string
;   ptrArray:PTR DWORD ; pointer to array
;   arraySize:DWORD    ; size of the array
; Returns: nothing
; ------------------------------------------------------------------------------
    arraySize equ [ebp + 16]
    ptrArray  equ [ebp + 12]
    ptrPrompt equ [ebp + 8]

    push ebp
    mov ebp, esp

    pushad                              ; save all registers

    mov ecx, arraySize
    cmp ecx, 0                          ; array size <= 0?
    jle L2                              ; yes: quit
    mov edx, ptrPrompt                  ; address of the prompt
    mov esi, ptrArray

L1:
    call WriteString@0                  ; display string

    call ReadInt@0                      ; read integer into EAX
    call Crlf@0                         ; go to next output line
    mov [esi], eax                      ; store in array
    add esi, 4                          ; next integer
    loop L1

L2:
    popad                               ; restore all registers

    mov esp, ebp
    pop ebp
    ret 12                              ; restore the stack
PromptForIntegers endp

end
