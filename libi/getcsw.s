	.globl _getcsw
_getcsw:
	moveq.l    #38,d7
	trap       #1
	bcc.s      1f
	jmp        pseterr
1:
	rts
