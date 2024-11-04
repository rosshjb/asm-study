.global _start

_start:
    // multiply 2 by -1 by using movn and then adding 1
    movn w0, #2
    add w0, w0, #1

    // w0 is the exit code and will be what we calculated above
    mov x8, #93 // exit
    svc 0       // system call
