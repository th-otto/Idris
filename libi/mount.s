	.globl _mount
_mount:
	movea.l    (a7)+,a0
	moveq.l    #21,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
