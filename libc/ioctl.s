*	ioctl(fd, cmd, arg)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	control device

	.globl	_ioctl
_ioctl:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#54,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
