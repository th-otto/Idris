*	alarm(seconds)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	set an alarm clock for delivery of a signal

	.globl	_alarm
_alarm:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#27,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
