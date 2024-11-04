; 3-5-1.asm

.386
.model flat,stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

; constants
COUNT = 500
Esc_key = 27

.data
	var1	dword 10
	selfPtr dword $
	array	dword COUNT dup(0)

	list1 byte 10,20,30,40
	List1Size = 4

	list2 byte 10,20,30,40
	List2Size = ($ - list2)

	list3 byte 10,20,30,40
	var2 byte 20 dup(?)
	List3Size = ($ - list3)

	myString byte "This is a long string, containing"
			 byte "any number offset characters"
	myString_len = ($ - myString)

	list4 word 1000h, 2000h, 3000h, 4000h
	List4Size = ($ - list4) / 2

	list5 dword 10000000h, 20000000h, 30000000h, 40000000h
	List5Size = ($ - list5) / 4
.code
main proc
	mov eax, COUNT
	mov eax, selfPtr
	mov eax, 0
    
	mov al, Esc_key
	mov al, 27

	COUNT = 5
	mov al, COUNT
	COUNT = 10
	mov al, COUNT
	COUNT = 100
	mov al, COUNT

	mov eax, 0
	mov eax, List1Size
	mov eax, List2Size
	mov eax, List3Size

	mov eax, myString_len

	mov eax, List4Size
	mov eax, List5Size

	invoke ExitProcess, 0
main endp
end main