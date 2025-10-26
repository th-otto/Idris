*	getppid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get parent process id

	.globl	_getppid
_getppid:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#45,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
