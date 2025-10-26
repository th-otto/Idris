*	stty(fd, buf)
*	copyright (c) 1979 by Whitesmiths, Ltd.
*	set status of tty

	.globl	_stty
_stty:
	.globl	__stty
__stty:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#31,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
