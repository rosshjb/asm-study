; Encryption Program (encrypt.asm)

include irvine32.inc

key = 239       ; any value between 1-255
bufmax = 128    ; maximum buffer size

.data
    sPrompt  byte  "Enter the plain text:", 0
    sEncrypt byte  "Cipher text:     ", 0
    sDecrypt byte  "Decrypted:       ", 0
    buffer   byte  bufmax + 1 dup(0)
    bufsize  dword ?

.code
main proc
    call InputTheString         ; input the plain text
    
    call TranslateBuffer        ; encrypt the buffer
    mov edx, offset sEncrypt    ; display encrypted message
    call DisplayMessage

    call TranslateBuffer        ; decrypt the buffer
    mov edx, offset sDecrypt    ; display decrypted message
    call DisplayMessage

    call WaitMsg
    exit
main endp

; ---------------------------------------------------------------------
InputTheString proc
;
; Prompts user for a plaintext string. Saves the string and its length.
; Receives: nothing
; Returns: nothing
; ---------------------------------------------------------------------
    pushad                  ; save 32-bit registers
    
    mov edx, offset sPrompt ; display a prompt
    call WriteString
    
    mov ecx, bufmax         ; maximum character count
    mov edx, offset buffer  ; point to the buffer
    call ReadString         ; input the string
    mov bufsize, eax        ; save the length
    call Crlf

    popad
    ret
InputTheString endp

; ---------------------------------------------------------------------
DisplayMessage proc
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns: nothing
; ---------------------------------------------------------------------
    pushad

    call WriteString
    mov edx, offset buffer  ; display the buffer
    call WriteString
    call Crlf
    call Crlf

    popad
    ret
DisplayMessage endp

; ---------------------------------------------------------------------
TranslateBuffer proc
;
; Translates the string by exclusive-ORing each byte with the
; encryption key byte.
; Receives: nothing
; Returns: nothing
; ---------------------------------------------------------------------
    pushad
    mov ecx, bufsize        ; loop counter
    mov esi, 0              ; index 0 in buffer
L1:
    xor buffer[esi], key    ; translate a byte
    inc esi
    loop L1

    popad
    ret
TranslateBuffer endp

end main