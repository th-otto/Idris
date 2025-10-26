*	getpgrp()
*	copyright (c) 1981 by Whitesmiths, Ltd.
*	get process group

	.globl	_getpgrp
_getpgrp:
	clr.l      -(a7)
	moveq.l    #39,d7
	trap       #1
	tst.l      (a7)+
	rts
