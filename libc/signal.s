*	signal(signo, fn)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	connect fn to signal signo

	.globl	_signal
_signal:
	.globl	__signal
__signal:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#48,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)

