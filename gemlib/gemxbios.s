	.text

	.globl _trap_14_w
	.globl _x0__ios
_trap_14_w:
_x0__ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #2,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_ww
	.globl _xw__ios
_trap_14_ww:
_xw__ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #4,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wl
	.globl _xl__ios
_trap_14_wl:
_xl__ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #6,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_www
	.globl _xww_ios
_trap_14_www:
_xww_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 18(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #6,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wwl
	.globl _xwl_ios
_trap_14_wwl:
_xwl_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 16(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	addq.l #8,a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wwll
	.globl _xwllios
_trap_14_wwll:
_xwllios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 20(a6),-(a7)
	move.l 16(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 12(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wllw
	.globl _xllwios
_trap_14_wllw:
_xllwios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 22(a6),-(a7)
	move.l 16(a6),-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 12(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wlll
	.globl _xlllios
_trap_14_wlll:
_xlllios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 20(a6),-(a7)
	move.l 16(a6),-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 14(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wwwwl
	.globl _xwwwlos
_trap_14_wwwwl:
_xwwwlos:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.l 24(a6),-(a7)
	move.w 22(a6),-(a7)
	move.w 18(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 12(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wllww
	.globl _xllwwos
_trap_14_wllww:
_xllwwos:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 26(a6),-(a7)
	move.w 22(a6),-(a7)
	move.l 16(a6),-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 14(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wwwwwww
	.globl _x6w_ios
_trap_14_wwwwwww:
_x6w_ios:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 34(a6),-(a7)
	move.w 30(a6),-(a7)
	move.w 26(a6),-(a7)
	move.w 22(a6),-(a7)
	move.w 18(a6),-(a7)
	move.w 14(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 14(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wllwwwww
	.globl _xll5wos
_trap_14_wllwwwww:
_xll5wos:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 38(a6),-(a7)
	move.w 34(a6),-(a7)
	move.w 30(a6),-(a7)
	move.w 26(a6),-(a7)
	move.w 22(a6),-(a7)
	move.l 16(a6),-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 20(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts

	.globl _trap_14_wllwwwwwlw
	.globl _x2l5wlw
_trap_14_wllwwwwwlw:
_x2l5wlw:
	link a6,#0
	movem.l d1-d2/a0-a2,-(a7)
	move.w 46(a6),-(a7)
	move.l 40(a6),-(a7)
	move.w 38(a6),-(a7)
	move.w 34(a6),-(a7)
	move.w 30(a6),-(a7)
	move.w 26(a6),-(a7)
	move.w 22(a6),-(a7)
	move.l 16(a6),-(a7)
	move.l 12(a6),-(a7)
	move.w 10(a6),-(a7)
	trap #14
	lea 26(a7),a7
	movem.l (a7)+,d1-d2/a0-a2
	move.l d0,d7
	unlk a6
	rts
