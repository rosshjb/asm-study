; Define.asm

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
; ---------------- byte ----------------
bvalue1	byte	'A'		; charcater literal	
bvalue2	byte	0		; smallest unsigned byte
bvalue3	byte	255		; largest unsigned byte
bvalue4	sbyte	-128	; smallest signed byte
bvalue5	sbyte	+127	; largest signed byte
bvalue6	byte	?

bvalue7	byte	10h
bvalue8 byte	20h

bval1	db	255		; unsigned byte
bval2	db	-128	; signed byte

list1	byte	10, 20, 30, 40

list2	byte	10,20,30,40
		byte	50,60,70,80
		byte	81,82,83,84

; same content
list3	byte	10, 32, 41h, 00100010b
list4	byte	0Ah, 20h, 'A', 22h

; null-terminated string
greeting1	byte	"Good afternoon", 0
greeting2	byte	'Good night', 0
greeting3	byte	"Welcome to the Encryption Demo program "
			byte	"created by Kip Irvine.", 0dh, 0ah
			byte	"If you wish to modify this program, please "
			byte	"send me a copy.", 0dh, 0ah, 0

; equivalent
greeting4	byte	"Welcome to the Encryption Demo program "
greeting5	\
			byte	"Welcome to the Encryption Demo program "

byte 20 dup(0)			; 20bytes, all equal to zero
byte 20 dup(?)			; 20bytes, uninitialized
byte 4	dup("STACK")	; 20bytes, "STACKSTACKSTACKSTACK"

; ---------------- word ----------------
word1	word	65535	; largest unsigned value
word2	sword	-32768	; smallest signed value
word3	word	?		; unintialized, unsigned

wval1	dw		65535	; unsigned
wval2	dw		-32768	; signed

myWList	word	1,2,3,4,5

warray	word	5 dup(?)	; 5 values, uninitialized

; ---------------- doubleword ----------------
dwval1	dword	12345678h	; unsigned
dwval2	sdword	-2147483648	; signed
dwval3	dword	20	dup(?)	; unsigned array

dwval4	dd		12345678h	; unsigned
dwval5	dd		-2147483648	; signed

dwVal6	dword	12345h
pdwVal	dword	dwVal6

myDWList	dword	1, 2, 3, 4, 5

; ---------------- quadword ----------------
quad1	qword	1234567812345678h
quad2	dq		1234567812345678h

; ---------------- packed bcd(tbyte) ----------------
bcdIntVal1	tbyte	80000000000000001234h	; valid
bcdIntVal2	tbyte	-1234					; invalid

posVal	real8	1.5
bcdVal	tbyte	?

; ---------------- floating-point ----------------
rVal1		real4	-1.2
rVal2		real8	3.2E-260
rVal3		real10	4.6E+4096

ShortArray	real4	20 dup(0.0)

rVal4		dd		-1.2		; short real
rVal5		dq		3.2E-260	; long real
rVal6		dt		4.6e+4096	; extended-precision real

.code
main proc
	fld		posVal	; load onto floating-point stack
	fbstp	bcdVal	; rounds up to 2 as packed bcd

	invoke ExitProcess, 0
main endp
end main