	.globl _mtimer
_mtimer:
	movea.l    (a7)+,a0
	moveq.l    #81,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
