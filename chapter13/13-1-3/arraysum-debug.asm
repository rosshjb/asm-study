; Listing generated by Microsoft (R) Optimizing Compiler Version 19.35.32216.1 

	TITLE	C:\Users\rosshjb\source\repos\asm-study\chapter13\13-1-3\Debug\arraysum.obj
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRTD
INCLUDELIB OLDNAMES

msvcjmc	SEGMENT
__5D45951B_arraysum@cpp DB 01H
msvcjmc	ENDS
PUBLIC	?ArraySum@@YAHQAHH@Z				; ArraySum
PUBLIC	_main
PUBLIC	__JustMyCode_Default
EXTRN	@_RTC_CheckStackVars@8:PROC
EXTRN	@__CheckForDebuggerJustMyCode@4:PROC
EXTRN	@__security_check_cookie@4:PROC
EXTRN	__RTC_CheckEsp:PROC
EXTRN	__RTC_InitBase:PROC
EXTRN	__RTC_Shutdown:PROC
EXTRN	___security_cookie:DWORD
;	COMDAT rtc$TMZ
rtc$TMZ	SEGMENT
__RTC_Shutdown.rtc$TMZ DD FLAT:__RTC_Shutdown
rtc$TMZ	ENDS
;	COMDAT rtc$IMZ
rtc$IMZ	SEGMENT
__RTC_InitBase.rtc$IMZ DD FLAT:__RTC_InitBase
rtc$IMZ	ENDS
;	COMDAT voltbl
voltbl	SEGMENT
_volmd	DB	025H
	DB	05fH
voltbl	ENDS
; Function compile flags: /Odt
;	COMDAT __JustMyCode_Default
_TEXT	SEGMENT
__JustMyCode_Default PROC				; COMDAT
	push	ebp
	mov	ebp, esp
	pop	ebp
	ret	0
__JustMyCode_Default ENDP
_TEXT	ENDS
; Function compile flags: /Odtp /RTCsu /ZI
; File C:\Users\rosshjb\source\repos\asm-study\chapter13\13-1-3\arraysum.cpp
;	COMDAT _main
_TEXT	SEGMENT
_sum$ = -220						; size = 4
_Array$ = -208						; size = 200
__$ArrayPad$ = -4					; size = 4
_main	PROC						; COMDAT

; 12   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 416				; 000001a0H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-224]
	mov	ecx, 56					; 00000038H
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax
	mov	ecx, OFFSET __5D45951B_arraysum@cpp
	call	@__CheckForDebuggerJustMyCode@4

; 13   :     int Array[50];
; 14   : 
; 15   :     int sum = ArraySum(Array, 50);

	push	50					; 00000032H
	lea	eax, DWORD PTR _Array$[ebp]
	push	eax
	call	?ArraySum@@YAHQAHH@Z			; ArraySum
	add	esp, 8
	mov	DWORD PTR _sum$[ebp], eax

; 16   : }

	xor	eax, eax
	push	edx
	mov	ecx, ebp
	push	eax
	lea	edx, DWORD PTR $LN5@main
	call	@_RTC_CheckStackVars@8
	pop	eax
	pop	edx
	pop	edi
	pop	esi
	pop	ebx
	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	add	esp, 416				; 000001a0H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
	npad	2
$LN5@main:
	DD	1
	DD	$LN4@main
$LN4@main:
	DD	-208					; ffffff30H
	DD	200					; 000000c8H
	DD	$LN3@main
$LN3@main:
	DB	65					; 00000041H
	DB	114					; 00000072H
	DB	114					; 00000072H
	DB	97					; 00000061H
	DB	121					; 00000079H
	DB	0
_main	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp /RTCsu /ZI
; File C:\Users\rosshjb\source\repos\asm-study\chapter13\13-1-3\arraysum.cpp
;	COMDAT ?ArraySum@@YAHQAHH@Z
_TEXT	SEGMENT
_i$1 = -20						; size = 4
_sum$ = -8						; size = 4
_array$ = 8						; size = 4
_count$ = 12						; size = 4
?ArraySum@@YAHQAHH@Z PROC				; ArraySum, COMDAT

; 2    : {

	push	ebp
	mov	ebp, esp
	sub	esp, 216				; 000000d8H
	push	ebx
	push	esi
	push	edi
	lea	edi, DWORD PTR [ebp-24]
	mov	ecx, 6
	mov	eax, -858993460				; ccccccccH
	rep stosd
	mov	ecx, OFFSET __5D45951B_arraysum@cpp
	call	@__CheckForDebuggerJustMyCode@4

; 3    :     int sum = 0;

	mov	DWORD PTR _sum$[ebp], 0

; 4    : 
; 5    :     for (int i = 0; i < count; i++)

	mov	DWORD PTR _i$1[ebp], 0
	jmp	SHORT $LN4@ArraySum
$LN2@ArraySum:
	mov	eax, DWORD PTR _i$1[ebp]
	add	eax, 1
	mov	DWORD PTR _i$1[ebp], eax
$LN4@ArraySum:
	mov	eax, DWORD PTR _i$1[ebp]
	cmp	eax, DWORD PTR _count$[ebp]
	jge	SHORT $LN3@ArraySum

; 6    :         sum += array[i];

	mov	eax, DWORD PTR _i$1[ebp]
	mov	ecx, DWORD PTR _array$[ebp]
	mov	edx, DWORD PTR _sum$[ebp]
	add	edx, DWORD PTR [ecx+eax*4]
	mov	DWORD PTR _sum$[ebp], edx
	jmp	SHORT $LN2@ArraySum
$LN3@ArraySum:

; 7    : 
; 8    :     return sum;

	mov	eax, DWORD PTR _sum$[ebp]

; 9    : }

	pop	edi
	pop	esi
	pop	ebx
	add	esp, 216				; 000000d8H
	cmp	ebp, esp
	call	__RTC_CheckEsp
	mov	esp, ebp
	pop	ebp
	ret	0
?ArraySum@@YAHQAHH@Z ENDP				; ArraySum
_TEXT	ENDS
END
