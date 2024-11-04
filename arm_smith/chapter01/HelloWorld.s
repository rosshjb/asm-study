.global _start

_start:
    mov x0, #1          // stdout
    ldr x1, =helloworld // string to print
    mov x2, #13         // length of our string
    mov x8, #64         // Linux write system call
    svc 0               // system call

    mov x0, #0          // use 0 for exit code
    mov x8, #93         // Linux exit system call
    svc 0               // system call

.data
    helloworld: .ascii "Hello World!\n" 
