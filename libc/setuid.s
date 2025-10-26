*	setuid(gid)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	set userid

	.globl	_setuid
_setuid:
	.globl	__setuid
__setuid:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#23,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
