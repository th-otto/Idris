	.globl sync
_sync:
	moveq.l    #36,d7
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	rts
