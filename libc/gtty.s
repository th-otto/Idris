*	gtty(fd, buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get status of tty

	.globl	_gtty
_gtty:
	.globl	__gtty
__gtty:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#32,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
