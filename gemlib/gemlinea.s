	.text

	.globl _Ainit
_Ainit:
	movem.l    d0-d6/a0-a6,-(a7)
	movea.l    #0,a2
	.word      0xa000
	move.l     a2,linea_funcs
	move.l     d0,d7
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Appixel
_Appixel:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa001
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Agpixel
_Agpixel:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa002
	move.l     d0,d7
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Aline
_Aline:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa003
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Ahline
_Ahline:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa004
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Afrect
_Afrect:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa005
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Afpoly
_Afpoly:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa006
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Abitblt
_Abitblt:
	link       a6,#0
	movem.l    d0-d6/a0-a6,-(a7)
	movea.l    8(a6),a6
	.word      0xa007
	movem.l    (a7)+,d0-d6/a0-a6
	unlk       a6
	rts

	.globl _Atxtblt
_Atxtblt:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa008
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Asmouse
_Asmouse:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa009
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Ahmouse
_Ahmouse:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa00a
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Atmouse
_Atmouse:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa00b
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Ausprit
_Ausprit:
	link       a6,#0
	movem.l    d0-d6/a0-a6,-(a7)
	movea.l    8(a6),a2
	.word      0xa00c
	movem.l    (a7)+,d0-d6/a0-a6
	unlk       a6
	rts

	.globl _Adsprit
_Adsprit:
	link       a6,#0
	movem.l    d0-d6/a0-a6,-(a7)
	move.l     8(a6),d0
	move.l     12(a6),d1
	movea.l    16(a6),a0
	movea.l    20(a6),a2
	.word      0xa00d
	movem.l    (a7)+,d0-d6/a0-a6
	unlk       a6
	rts

	.globl _Acraste
_Acraste:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa00e
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Aseedfi
_Aseedfi:
	movem.l    d0-d6/a0-a6,-(a7)
	.word      0xa00f
	movem.l    (a7)+,d0-d6/a0-a6
	rts

	.globl _Aversio
_Aversio:
	move.l     linea_funcs,d7
	rts

	.data
linea_funcs: .long 0
