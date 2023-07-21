title 7-2-4.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    day byte ?
    month byte ?
    year word ?
.code
main proc
    mov edx, 0010011001101010b

    mov al, dl          ; make a copy of dl
    and al, 00011111b   ; clear bits 5-7
    mov day, al         ; save in day

    mov ax, dx          ; make a copy of dx
    shr ax, 5           ; shift right 5 bits
    and al, 00001111b   ; clear bits 4-7
    mov month, al       ; save in month

    mov al, dh          ; make a copy of dh
    shr al, 1           ; shift right one position
    mov ah, 0           ; clear AH to zeroes
    add ax, 1980        ; yerar is relative to 1980
    mov year, ax        ; save in year

    mov ecx, 0
    call ExitProcess
main endp

end main