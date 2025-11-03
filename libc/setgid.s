*	setuid(gid)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	set group id

	.globl	_setgid
_setgid:
	.globl	__setgid
__setgid:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#46,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
