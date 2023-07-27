; Include file for the ArraySum Program (sum.inc)

.386
.model flat, stdcall

option casemap:none

includelib irvine32.lib

WriteString proto
WriteInt proto
ReadInt proto
Crlf proto
Clrscr proto
WaitMsg proto
ExitProcess proto, dwExitCode:dword

PromptForIntegers proto,
    ptrPrompt:ptr byte,     ; prompt string
    ptrArray:ptr dword,     ; points to the array
    arraySize:dword         ; size of the array

ArraySum proto,
    ptrArray:ptr dword,     ; points to the array
    count:dword             ; size of the array

DisplaySum PROTO,
    ptrPrompt:ptr byte,     ; prompt string
    theSum:dword            ; sum of the array