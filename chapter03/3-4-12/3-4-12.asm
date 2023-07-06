; 3-4-12.asm

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	smallArray1	dword	10		dup(0)	; 40 bytes,		offset 0h(0d)
.data?
	bigArray1	dword	5000	dup(?)	; 20000 bytes, not initialized

.data
	smallArray2	dword	10		dup(0)	; 40 bytes,		offset 28h(40d)
	bigArray2	dword	5000	dup(?)	; 20000 bytes,	offset 50h(80d)

	wall		byte	?				; 1 byte,		offset 4e70h(20080d)

.code
main proc
	mov ebx, 10d
	mov eax, ebx
.data
	temp dword ?
.code
	mov temp, eax
	invoke ExitProcess, 0
main endp
end main