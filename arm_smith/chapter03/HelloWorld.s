.global _start

_start:
    mov x0, #1          // stdout
    ldr x1, =helloworld // string to print
    mov x2, #13         // length of our string
    mov x8, #64         // write
    svc 0               // system call

    mov x0, #0          // exit code
    mov x8, #93         // exit
    svc 0               // system call

.data
    helloworld: .ascii "Hello World!\n" 
