*	getpid()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get process id

	.globl	_getpid
_getpid:
	.globl	__getpid
__getpid:
	moveq.l	#20,d7
	trap	#1
	rts
