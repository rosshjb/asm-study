; 6-5-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 6-5-1-1
.data
    op1 dword 10
    op2 dword 10
    x1 byte ?
    y1 byte ?
.code
    mov eax, op1
    cmp eax, op2    ; op1 == op2?
    jne L1          ; no: skip next
    mov x1, 1       ; yes: assign x and y
    mov y1, 2
L1: nop

; 6-5-1-2
.data
    op3 dword 10
    op4 dword 20
    x2 byte ?
    y2 byte ?
.code
    mov eax, op3
    cmp eax, op4    ; op3 == op4?
    je L2           ; yes: jump to L2
    jmp L3          ; no: skip assignments
L2: mov x2, 1
    mov y2, 2
L3: nop

; 6-5-1-3
.data
    clusterSize word ?
    terrabytes byte 32
.code
    mov clusterSize, 8192   ; assume larger cluster
    cmp terrabytes, 16      ; smaller than 16 TB?
    jae next1
    mov clusterSize, 4096   ; switch to smaller cluster
next1:
    nop

; 6-5-1-4
.data
    op5 dword 10
    op6 dword 10
.code
    mov eax, op5        ; move op1 to a register
    cmp eax, op6        ; op5 > op6?
    jg a1               ; yes: call Routine1
    call Routine2       ; no: call Routin2
    jmp a2              ; exit the if statement
a1: call Routine1
a2: nop

; 6-5-1-5
.data
    op7 dword 10
    op8 dword 20
    x3 dword 30
    y3 dword 40
.code
    mov eax, op7
    cmp eax, op8    ; op7 == op8?
    jne L5          ; no: call Routine5
    ; process the inner if-else statement
    mov eax, x3
    cmp eax, y3     ; x3 > y3?
    jg L4           ; yes: call Routine3
    call Routine4   ; no: call Routine4
    jmp L6          ; and exit
L4: call Routine3   ; call Routine3
    jmp L6          ; and exit
L5: call Routine5
L6: nop

; 6-5-2-1
.data
    x4 dword ?
.code
    mov al, 3
    mov bl, 2
    mov cl, 1
    cmp al, bl      ; first expression...
    ja L7
    jmp next2
L7: cmp bl, cl      ; second expression...
    ja L8
    jmp next2
L8: mov x4, 1       ; both true: set x to 1
next2: nop

; 6-5-2-2
.data
    x5 dword ?
.code
    mov al, 3
    mov bl, 2
    mov cl, 1
    cmp al, bl      ; first expression...
    jbe next3       ; quit if false
    cmp bl, cl      ; second expression
    jbe next3       ; quit if false
    mov x5, 1       ; both are true
next3: nop

; 6-5-2-3
.data
    x6 dword ?
.code
    mov al, 1
    mov bl, 3
    mov cl, 2
    cmp al, bl      ; 1: compare al to bl
    ja L9           ; if true, skip second expression
    cmp bl, cl      ; 2: compare bl to cl
    jbe next4       ; false: skip next statement
L9: mov x6, 1       ; true: set x = 1
next4: nop

    mov ecx, 0
    call ExitProcess
main endp

Routine1 proc
    ret
Routine1 endp

Routine2 proc
    ret
Routine2 endp

Routine3 proc
    ret
Routine3 endp

Routine4 proc
    ret
Routine4 endp

Routine5 proc
    ret
Routine5 endp

end main