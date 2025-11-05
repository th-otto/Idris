	.globl _getnpid
_getnpid:
	movea.l    (a7)+,a0
	moveq.l    #64,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
