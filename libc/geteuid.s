*	geteuid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get effective user id

	.globl	__geteuid
__geteuid:
	.globl	_geteuid
_geteuid:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#24,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	lsr.l	#8,d7
	jmp		(a0)
