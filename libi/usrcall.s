	.globl _usrcall
_usrcall:
	movea.l    (a7)+,a0
	moveq.l    #63,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
