*	geteuid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get effective groupid

	.globl	__getegid
__getegid:
	.globl	_getegid
_getegid:
	moveq.l	#47,d7
	trap	#1
	bcc.s	1f
	jmp		pseterr
1:
	lsr.l	#8,d7
	jmp		(a0)
