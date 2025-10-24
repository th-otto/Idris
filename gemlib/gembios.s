	.text

	.globl _trap_13_w
	.globl _b0_ios
_trap_13_w:
_b0_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 10(a6),-(a7)
	trap #13
	addq.l #2,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_13_ww
	.globl _bw_ios
_trap_13_ww:
_bw_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #13
	addq.l #4,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_13_wl
	.globl _bl_ios
_trap_13_wl:
_bl_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #13
	addq.l #6,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_13_www
	.globl _bwwios
_trap_13_www:
_bwwios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 18(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #13
	addq.l #6,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_13_wwl
	.globl _bwlios
_trap_13_wwl:
_bwlios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 16(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #13
	addq.l #8,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_13_wwlwww
	.globl _bwlwww
_trap_13_wwlwww:
_bwlwww:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 30(a6),-(a7)
	move.w 26(a6),-(a7)
	move.w 22(a6),-(a7)
	move.l 16(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #13
	lea    14(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

