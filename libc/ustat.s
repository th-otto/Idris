*	GET FILESYSTEM INFORMATION
*	copyright (c) 1985 by Whitesmiths, Ltd.

* int ustat(fd, st)

	.globl _ustat
_ustat:
	* save return
	movea.l    (a7)+,a0
	* ustat call number
	moveq.l    #50,d7
	* call Idris
	trap       #1
	bcc.s      1f
	jmp        seterr
1:
	* return
	jmp        (a0)
