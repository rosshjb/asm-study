title 8-2-5.asm

.386
.model flat, stdcall
.stack 4096

RandomRange proto
ExitProcess proto, dwExitCode:dword

.data
    count = 100
    array word count dup(?)
.code
main proc
    call MySub1
    call MySub2
    call MySub3

    push offset array
    push count
    call ArrayFill

    push 2Ah                    ; the '*' character
    call makeArray

    mov ecx, 0
    call ExitProcess
main endp

MySub1 proc
    push ebp
    mov ebp, esp

    sub esp, 8                  ; create locals

    mov dword ptr [ebp - 4], 10 ; X = 10
    mov dword ptr [ebp - 8], 20 ; Y = 20

    mov esp, ebp                ; remove locals from stack

    pop ebp
    ret
MySub1 endp

MySub2 proc
.data
    x_local equ dword ptr [ebp - 4]
    y_local equ dword ptr [ebp - 8]
.code
    push ebp
    mov ebp, esp

    sub esp, 8      ; create locals

    mov x_local, 10 ; X = 10
    mov y_local, 20 ; Y = 20

    mov esp, ebp    ; remove locals from stack

    pop ebp
    ret
MySub2 endp

MySub3 proc
    push ebp
    mov ebp, esp

    sub esp, 8                  ; create locals
    push ebx                    ; save callee-saved (non-volatile) register

    mov dword ptr [ebp - 4], 11 ; X = 11
    mov dword ptr [ebp - 8], 12 ; Y = 22

    pop ebx                     ; restore callee-saved (non-volatile) register
    mov esp, ebp                ; remove locals from stack

    pop ebp
    ret
MySub3 endp

ArrayFill proc
    push ebp
    mov ebp, esp

    pushad              ; save registers
    mov esi, [ebp + 12] ; offset of array
    mov ecx, [ebp + 8]  ; array length
    cmp ecx, 0          ; ECX == 0?
    je L2               ; yes: skip over loop
L1:
    mov eax, 10000h     ; get random 0 - FFFFh
    call RandomRange    ; from the link library
    mov [esi], ax       ; insert value in array
    add esi, type word  ; move to next element
    loop L1
L2:
    popad               ; restore registers

    pop ebp
    ret 8               ; clean up arguments from the stack
ArrayFill endp

makeArray proc
    push ebp
    mov ebp, esp

    sub esp, 32             ; keep it aligned on dword boundary: 30 -> 32
    lea esi, [ebp - 30]     ; load address of myString at EBP - 30
    mov ecx, 30             ; loop counter
    mov eax, [ebp + 8]      ; the '*' character parameter
L1: mov byte ptr [esi], al  ; fill one position
    inc esi                 ; move to next
    loop L1                 ; continue until ECX = 0
    add esp, 32             ; remove the array (restore ESP)

    pop ebp
    ret 4
makeArray endp

end main
