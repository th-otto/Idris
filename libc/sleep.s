*	sleep(seconds)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	delay for awhile

	.globl	_sleep
_sleep:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#35,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	jmp	(a0)
