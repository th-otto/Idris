*	getuid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get userid

	.globl	_getuid
_getuid:
	.globl	__getuid
__getuid:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l	#24,d7
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	andi.l	#0xff,d7
	jmp		(a0)
