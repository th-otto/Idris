	.globl __mrm
__mrm:
	movea.l    (a7)+,a0
	moveq.l    #78,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
