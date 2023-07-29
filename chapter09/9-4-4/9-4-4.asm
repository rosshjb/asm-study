title Two-dimensional arrays in 64-bit mode (9-4-4.asm)

ExitProcess proto

.data
    table qword 1, 2, 3, 4, 5
    ROW_SIZE = ($ - table)
          qword 6, 7, 8, 9, 10
          qword 11, 12, 13, 14, 15
.code
main proc
    mov rax, 1              ; row index (zero-based)
    mov rsi, 4              ; column index (zero-based)
    call get_tableVal       ; returns the value in RAX (0Ah = 10d)

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
get_tableVal proc uses rbx rdi
; Returns the array valuje at a given row and colunm in a two-dimensional
; array of quadwords.
; Receives: RAX = row number, RSI = column number
; Returns: value in RAX
; ------------------------------------------------------------------------------
    mov rbx, ROW_SIZE
    mul rbx                                 ; product(low) = RAX
    lea rdi, offset table
    add rdi, rax                            ; row offset
    mov rax, [rdi + rsi * type table]       ; [row offset + column offset]
    ret
get_tableVal endp

end
