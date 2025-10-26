*	time(buf)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get time

	.globl	_time
_time:
	.globl	__time
__time:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#13,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	tst.l	(sp)
	beq.s	1f
	move.l	(sp),a1
	move.l	d7,(a1)
1:
	jmp	(a0)
