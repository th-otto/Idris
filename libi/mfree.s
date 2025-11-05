	.globl _mfree
_mfree:
	movea.l    (a7)+,a0
	moveq.l    #72,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
