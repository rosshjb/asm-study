title sub1.asm
option casemap:none

.386
.model flat, stdcall

.code
sub1 proc
    call mySub
    ret
sub1 endp

mySub proc private
    ret
mySub endp

end
