	.globl _pcntl
_pcntl:
	movea.l    (a7)+,a0
	moveq.l    #65,d7
	trap       #1
	bcc.w      1f
	jmp        seterr
1:
	jmp        (a0)
