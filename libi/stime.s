*	set time
*	copyright (c) 1985 by Whitesmiths, Ltd.

* int stime(time_t t)

	.globl	_stime
_stime:
	* save return
	move.l	(sp)+,a0
	* stime call number
	moveq	#25,d7
	* call Idris
	trap	#1
	bcc.s	1f
	jmp		seterr
1:
	* return
	jmp		(a0)
