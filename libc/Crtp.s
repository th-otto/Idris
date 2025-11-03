 *
 *	C runtime header for profiling
 *	copyright (c) 1982, 1986 by Whitesmiths, Ltd.
 *	MUST BE LOADED FIRST
 *	MUST BE LOADED WITH LIBI (at the moment)
 *

	.globl __penable
	.globl __pheader
	.globl __profil
	.globl _exit
	.globl a~count

p_start:
	pea		__pheader
	jsr		__profil
	addq.l	#4,sp
	clr.l	d6
	move.w	p_esize,d6
	sub.l	d6,p_subidx
	move.l	d7,p_buf
	bne.s	p_onward
	pea		0
	jsr		_exit

a~count:
	* here on each function entry
	tst.b	__penable
	beq.s	3f
	* we're counting entries
	move.l	(a0),a1
	move.l	a1,d0
	bne.s	2f
	* first time
	move.l	p_subidx,a1
	move.l	a1,d0
	beq.s	1f
	* entry count array not full
	addq.l	#8,p_subidx
1:
	add.l	p_buf,a1
	* record entry point
	move.l	(sp),-8(a1)
	move.l	a1,(a0)
2:
	* increment long count
	addq.l	#1,-(a1)
3:
	rts
p_onward:

	.data
__pheader:
	* header
	.word	0x9a2d
p_esize:
	* # entries to count, then # bytes of counters
	.word	100
p_pbuf:
	* time profile buffer
	.long	0
p_psize:
	* size of text, then size of histogram
	.long	x__text__
	* start of profiling area
	.long	p_start
	* bytes per counter, then profil scale fraction
	.long	8
	* text bias
	.long	p_start
	* offset from start of functions
	.long	12
	.long	p_fname

p_subidx:
	.long	8
p_buf:
	.long	0
p_fname:
"profil"
	.byte 0
