; 4-3-1.asm

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.code
main proc
; 4-3-1
.data
    bval1 byte  ?
    wval1 word  ?
    dval1 dword ?
    dval2 dword ?
.code
    mov esi, offset bval1   ; esi = 003d4000h
    mov esi, offset wval1   ; esi = 003d4001h
    mov esi, offset dval1   ; esi = 003d4003h
    mov esi, offset dval2   ; esi = 003d4007h

.data
    myArray1 word 1, 2, 3, 4, 5
.code
    mov esi, offset myArray1     ; esi = 00d5400bh
    mov esi, offset myArray1 + 4 ; esi = 00d5400fh

.data
    bigArray dword 500 dup(?)
    pArray dword bigArray
.code
    mov esi, pArray             ; esi = 000b4015h

; 4-3-2
.data
    bval2 byte  ?
    align 2
    wval2 word  ?
    bval3 byte  ?
    align 4
    dval3 dword ?
    dval4 dword ?
.code
    mov esi, offset bval2 ; esi = 000347e9h
    mov esi, offset wval2 ; esi = 000347eah
    mov esi, offset bval3 ; esi = 000347ech
    mov esi, offset dval3 ; esi = 000347f0h
    mov esi, offset dval4 ; esi = 000347f4h

; 4-3-3
.data
    myDouble dword 12345678h
    wordList word 5678h, 1234h
.code
    mov ax, word ptr myDouble       ; 5678h
    mov ax, word ptr [myDouble + 2] ; 1234h
    mov bl, byte ptr myDouble       ; 78h
    mov eax, dword ptr wordList     ; 12345678h

; 4-3-4
.data
    var1 byte  ?
    var2 word  ?
    var3 dword ?
    var4 qword ?
.code
    mov eax, type var1  ; eax = 1
    mov eax, type var2  ; eax = 2
    mov eax, type var3  ; eax = 4
    mov eax, type var4  ; eax = 8

; 4-3-5
.data
    byte1  byte   10, 20, 30
    array1 word   30 dup(?), 0, 0
    array2 word   5 dup(3 dup(?))
    array3 dword  1, 2, 3, 4
    digitStr byte "12345678", 0
.code
    mov eax, lengthof byte1     ; eax = 3
    mov eax, lengthof array1    ; eax = 32
    mov eax, lengthof array2    ; eax = 15
    mov eax, lengthof array3    ; eax = 4
    mov eax, lengthof digitStr  ; eax = 9

.data
    myArray2 byte 10, 20, 30, 40, 50
             byte 60, 70, 80, 90, 100

    myArray3 byte 10, 20, 30, 40, 50,
                  60, 70, 80, 90, 100
.code
    mov eax, lengthof myArray2  ; eax = 5
    mov eax, lengthof myArray3  ; eax = 10

; 4-3-6
.data
    intArray word 32 dup(0)
.code
    mov eax, sizeof intArray    ; eax = 64

; 4-3-7
.data
    val16 label word
    val32 dword      12345678h

    longvalue label dword
    val1 word 5678h
    val2 word 1234h
.code
    mov ax, val16       ; ax = 5678h
    mov dx, [val16 + 2] ; ax = 1234h

    mov eax, longvalue  ; eax = 12345678h

    invoke ExitProcess, 0
main endp
end main