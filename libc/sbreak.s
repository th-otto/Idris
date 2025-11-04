*	sbreak(incr), sbrk(incr)
*	copyright (c) 1981, 1986 by Whitesmiths, Ltd.
*	move system break up at least incr bytes, return old break

	.globl	_sbreak
_sbreak:
	.globl	__sbreak
__sbreak:
	moveq.l		#0,d0
	bra.s		sbreak
	.globl _sbrk
_sbrk:
	.globl __sbrk
__sbrk:
	moveq.l		#1,d0
sbreak:
	pea			-1
	* brk
	moveq.l		#17,d7
	trap		#1
	move.l		d7,d6
	add.l		8(sp),d7
	addq.l		#1,d7
	bclr		#0,d7
	move.l		d7,(sp)
	moveq.l		#17,d7
	trap		#1
	tst.l		(sp)+
	cmp.l		#-1,d7
	bne.s		2f
	* ENOMEM
	move.l		#12,_errno
	tst.l		d0
	bne.s		1f
	moveq.l		#0,d7
1:
	rts
2:
	move.l		d6,d7
	rts
