*	geteuid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get effective groupid

	.globl	__getgid
__getgid:
	.globl	_getgid
_getgid:
	moveq.l	#47,d7
	trap	#1
	bcc.s	1f
	jmp		pseterr
1:
	andi.l  #0xff,d7
	jmp		(a0)
