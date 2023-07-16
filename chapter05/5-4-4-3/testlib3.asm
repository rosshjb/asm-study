; Link Library Test #3 (TestLib3.asm)

; Calculate the elapsed execution time of a nested loop

include Irvine32.inc

.data
    outer_loop_count = 3
    
    startTime dword ?
    msg1 byte "Please wait...", 0dh, 0ah, 0
    msg2 byte "Elapsed milliseconds: ", 0

.code
main proc
    mov edx, offset msg1    ; "Please wait..."
    call WriteString

; save the starting time
    call GetMSeconds
    mov startTime, eax

; start the outer loop
    mov ecx, outer_loop_count
L1: call innerLoop
    loop L1

; calculate the elapsed time
    call GetMSeconds
    sub eax, startTime

; display the elapsed time
    mov edx, offset msg2    ; "Elapsed milliseconds: "
    call WriteString

    call WriteDec           ; write the milliseconds
    call Crlf

    call WaitMsg

    exit
main endp

innerLoop proc
    push ecx                ; save current ecx value

    mov ecx, 0FFFFFFFh      ; set the loop counter
L1: mul eax                 ; use up some cycles
    mul eax
    mul eax
    loop L1                 ; repeat the inner loop

    pop ecx                 ; restore ecx's saved value

    ret
innerLoop endp

end main