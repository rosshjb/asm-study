#include <asm/unistd.h>
#include "fileio.S"

.equ BUFFERLEN, 250

.global _start

_start:
    openFile inFile, O_RDONLY
    adds x11, xzr, x0           // save fd for use later
    b.pl nxtfil
    // if error happend
    mov x1, #1                  // stdout
    ldr x2, =inpErrsz           // error msg size address
    ldr w2, [x2]                // error msg size
    writeFile x1, inpErr, x2    // print the error
    b exit

nxtfil:
    openFile outFile, O_CREAT+O_WRONLY
    adds x9, xzr, x0            // save fd for use later
    b.pl loop
    // if error happend
    mov x1, #1                  // stdout
    ldr x2, =outErrsz           // error msg size address
    ldr w2, [x2]                // error msg size
    writeFile x1, outErr, x2    // print the error

loop:
    readFile x11, buffer, BUFFERLEN
    mov x10, x0                 // save read length
    mov x1, #0                  // null

    // toupper
    ldr x0, =buffer             // input str
    strb w1, [x0, x10]          // set null at the end of past input str
    ldr x1, =outBuf             // output str
    bl toupper

    writeFile x9, outBuf, x10
    cmp x10, #BUFFERLEN
    b.eq loop

    flushClose x11 // read
    flushClose x9  // write

exit:
    mov x0, #0
    mov x8, #__NR_exit
    svc 0

.data
    inFile:     .asciz  "main.S"
    outFile:    .asciz  "upper.txt"
    buffer:     .fill   BUFFERLEN+1, 1, 0
    outBuf:     .fill   BUFFERLEN+1, 1, 0
    inpErr:     .asciz  "Failed to open input file.\n"
    inpErrsz:   .word   .-inpErr
    outErr:     .asciz  "Failed to open output file.\n"
    outErrsz:   .word   .-outErr
