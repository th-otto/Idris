	.globl _brk
_brk:
**	profiler entry count code here
	move.l	(sp)+,a0
	moveq.l		#17,d7
	trap		#1
	cmp.l		#-1,d7
	bne.s		1f
	* ENOMEM
	move.l		#12,_errno
	jmp        (a0)
1:
	clr.l      d7
	jmp        (a0)
