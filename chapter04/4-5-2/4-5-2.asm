title 4-5-2.asm

.386
.model flat, stdcall

.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 4-5-2
    mov ax, 0
    mov ecx, 5
L1:
    inc ax
    loop L1

.data
    count1 dword ?
.code
    mov ecx, 100     ; set loop count
top:
    mov count1, ecx  ; save the count
    mov ecx, 20      ; modify ecx
    mov ecx, count1  ; restore loop count
    loop top

.data
    count2 dword ?
.code
    mov ecx, 100    ; set outer loop count
L2:
    mov count2, ecx ; save outer loop count
    mov ecx, 20     ; set inner loop count
L3:
    nop
    loop L3         ; repeat the inner loop
    mov ecx, count2 ; restore outer loop count
    loop L2         ; repeat the outer loop

    invoke ExitProcess, 0
main endp
end main