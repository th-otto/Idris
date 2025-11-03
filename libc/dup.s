*	dup(fd)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	duplicate an open file descriptor

	.globl	__dup
__dup:
	.globl	_dup
_dup:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#41,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
