*	unlink(name)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	remove directory link for file name

	.globl	_unlink
_unlink:
	.globl	__unlink
__unlink:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#10,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
