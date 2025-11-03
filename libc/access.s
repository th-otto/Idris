*	access(pathname, mode)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	check user's permissions for a file

	.globl	_access
_access:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#33,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
