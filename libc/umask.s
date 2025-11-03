*	umask(pathname, mode)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	set file mode creation mask

	.globl	_umask
_umask:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#60,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
