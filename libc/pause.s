*	pause(pathname, mode)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	wait for signal

	.globl	_pause
_pause:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#29,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	jmp	(a0)
;
