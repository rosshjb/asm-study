; Table of Procedure Offsets (proctable.asm)

; This program contains a table with offsets of procedures.
; It uses the table to execute indirect procedure calls.

include irvine32.inc

.data
    CaseTable byte 'A'          ; lookup value
              dword Process_A   ; address of procedure
    EntrySize = ($ - CaseTable)
              byte 'B'
              dword Process_B
              byte 'C'
              dword Process_C
              byte 'D'
              dword Process_D
    NumberOfEntries = ($ - CaseTable) / EntrySize
    
    prompt byte "Press capital A, B, C, or D: ", 0

    msgA byte "Process_A", 0
    msgB byte "Process_B", 0
    msgC byte "Process_C", 0
    msgD byte "Process_D", 0

.code
main proc
    mov edx, offset prompt      ; ask user for input
    call WriteString

    call ReadChar               ; read character into AL
    mov ebx, offset CaseTable   ; point ebx to the table
    mov ecx, NumberOfEntries    ; loop counter
L1:
    cmp al, [ebx]               ; match found?
    jne L2                      ; no: continue
    call NEAR PTR [ebx + 1]     ; yes: call the procedure

    call WriteString            ; display message
    call Crlf
    jmp L3                      ; exit the search
L2:
    add ebx, EntrySize          ; point to the next entry
    loop L1
L3:
    call WaitMsg

    exit
    
main endp

Process_A proc
    mov edx, offset msgA
    ret
Process_A endp

Process_B proc
    mov edx, offset msgB
    ret
Process_B endp

Process_C proc
    mov edx, offset msgC
    ret
Process_C endp

Process_D proc
    mov edx, offset msgD
    ret
Process_D endp

end main