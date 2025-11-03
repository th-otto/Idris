*	fstat(fd, buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get status of open file

	.globl	__fstat
__fstat:
	.globl	_fstat
_fstat:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#28,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
