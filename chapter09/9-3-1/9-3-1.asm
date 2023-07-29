title 9-3-1.asm

.386
.model flat, stdcall
.stack 4096

Str_compare proto string1:ptr byte, string2:ptr byte
Str_length  proto pString:ptr byte
Str_copy    proto source:ptr byte, target:ptr byte
Str_trim    proto pString:ptr byte, char:byte
Str_ucase   proto pString:ptr byte
ExitProcess proto dwExitCode:dword

.data
    string_1 byte "ABCDEFG", 0
    string_2 byte "ABCDEFG", 0
    string_3 byte 8 dup(0FFh)
    string_4 byte "Hello##", 0
    string_5 byte "aB234cdEfg", 0
.code
main proc
    invoke Str_compare, addr string_1, addr string_2
    invoke Str_length, addr string_1
    invoke Str_copy, addr string_1, addr string_3
    invoke Str_trim, addr string_4, '#'
    invoke Str_ucase, addr string_5

    mov ecx, 0
    call ExitProcess
main endp

; ------------------------------------------------------------------------------
Str_compare proc uses eax edx esi edi,
    string1:ptr byte,
    string2:ptr byte
; Compare two strings. Affects the Zero and Carry flags exactly as they would
; be by the CMP instruction.
; Returns: nothing
; ------------------------------------------------------------------------------
    mov esi, string1
    mov edi, string2
L1: mov al, [esi]
    mov dl, [edi]
    cmp al, 0           ; end of string?
    jne L2              ; no
    cmp dl, 0           ; yes: end of string2?
    jne L2              ; no
    jmp L3              ; yes: exit with ZF = 1
L2:
    inc esi             ; point to next
    inc edi
    cmp al, dl          ; characters equal?
    je L1               ; yes: continue loop
                        ; no: exit with flags set
L3: ret
Str_compare endp

; ------------------------------------------------------------------------------
Str_length proc USES edi,
    pString:ptr byte
; Return the length of a null-terminated string.
; Receives: pString (pointer to a string)
; Returns: EAX = string length
; ------------------------------------------------------------------------------
    mov edi, pString
    mov eax, 0              ; character count
L1:
	cmp byte ptr [edi], 0   ; end of string?
	je L2                   ; yes: quit
	inc edi                 ; no: point to next
	inc eax                 ; add 1 to count
	jmp L1
L2: ret
Str_length endp

; ------------------------------------------------------------------------------
Str_copy proc uses eax ecx esi edi,
    source:ptr byte,        ; source string
    target:ptr byte         ; target string
; Copy a string from source to target.
; Returns: nothing
; Requires: the target string must contain enough space to hold a copy
;           of the source string.
; ------------------------------------------------------------------------------
    invoke Str_length, source   ; EAX = length source
    mov ecx, eax                ; REP count
    inc ecx                     ; add 1 for null byte

    mov esi, source
    mov edi, target
    cld                         ; direction = forward
    rep movsb                   ; copy the string
    ret
Str_copy endp

; ------------------------------------------------------------------------------
Str_trim proc uses eax ecx edi,
    pString:ptr byte,           ; points to string
    char:byte                   ; char to remove
; Remove all occurences of a given character from the end of a string. 
; Returns: nothing
; ------------------------------------------------------------------------------
    mov edi, pString
    invoke Str_length, edi      ; returns the length in EAX

    cmp eax, 0                  ; is the length equal to zero?
    je L3                       ; yes: exit now
    mov ecx, eax                ; no: ECX = string length

    dec eax
    add edi, eax                ; point to last character
	
L1:	mov al, [edi]               ; get a character
    cmp al, char                ; character to be trimmed?
    jne L2                      ; no: insert null byte
    dec edi                     ; yes: keep backing up
    loop L1                     ; until beginning reached
L2: mov byte ptr [edi + 1], 0   ; insert a null byte
L3: ret
Str_trim endp

; ------------------------------------------------------------------------------
Str_ucase proc uses eax esi,
    pString:ptr byte
; Converts a null-terminated string to uppercase.
; Returns: nothing
; ------------------------------------------------------------------------------
    mov esi, pString
L4:
    mov al, [esi]                   ; get char
    cmp al, 0                       ; end of string?
    je L6                           ; yes: quit
    cmp al, 'a'                     ; below 'a'?
    jb L5
    cmp al, 'z'                     ; above 'z'?
    ja L5
    and byte ptr [esi], 11011111b   ; convert the char
L5:
    inc esi                         ; next char
    jmp L4
L6: ret
Str_ucase endp

end main
