*	utime(filename, buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	change file last access and modification times

	.globl	_utime
_utime:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#30,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
