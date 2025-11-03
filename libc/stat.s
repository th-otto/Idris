*	stat(name, buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get status of file

	.globl	_stat
_stat:
	.globl	__stat
__stat:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#18,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
