	.globl _mcreat
__mcreat:
	movea.l    (a7)+,a0
	moveq.l    #69,d7
	trap       #1
	bcc.s      1f
	move.l     d7,d6
	moveq.l    #6,d7
	trap       #1
	move.l     d6,d7
	jmp        seterr
1:
	jmp        (a0)
