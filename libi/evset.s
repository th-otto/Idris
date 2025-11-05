	.globl _evset
_evset:
	movea.l    (a7)+,a0
	moveq.l    #85,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	jmp        (a0)
