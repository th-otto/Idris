*	wait(pstatus)
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	wait for a child to die

	.globl	_wait
_wait:
	.globl	__wait
__wait:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#7,d7
	trap	#1
	bcc		1f
	jmp		seterr
1:
	tst.l      (a7)
	beq.s      1f
	move.l	(sp),a1
	move.l     d7,d6
	andi.l     #0xffff,d6
	move.l     d6,(a1)
1:
	clr.w	d7
	swap	d7
	jmp		(a0)
