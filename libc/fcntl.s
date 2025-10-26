*	fcntl(fd, cmd, arg)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	manipulate file descriptor

	.globl	_fcntl
_fcntl:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#53,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
