*	uname(buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get name and information about current kernel

	.globl	_uname
_uname:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#62,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
