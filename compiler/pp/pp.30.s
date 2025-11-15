; a_magic   = 0x992d
; a_text    = 0x00005550
; a_data    = 0x00001430
; a_bss     = 0x00000000
; a_syms    = 0x000009d0
; a_heap    = 0x0000fffe
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x00000804@0x0000736c

_builtin:
	link       a6,#-8
	movem.l    d0/d5/a3-a5,-(a7)
	movea.l    8(a6),a5
	movea.l    12(a6),a4
	move.l     20(a4),(a7)
	move.l     16(a4),-(a7)
	pea.l      ($00000004).w
	move.l     #_bltintab,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	move.l     d7,d5
	bne.s      _builtin_1
	move.l     a4,d7
	movem.l    (a7)+,d0/d5/a3-a5
	unlk       a6
	rts
_builtin_1:
	move.l     d5,d7
	lea.l      $00025638,a0
	jmp        a.switch
case PBIF:
	lea.l      ($00000014).w,a2
	adda.l     (a4),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _builtin_2
	lea.l      ($00000010).w,a2
	adda.l     (a4),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      _builtin_2
	clr.l      -4(a6)
	pea.l      ($00000001).w
	pea.l      -4(a6)
	move.l     (a4),-(a7)
	jsr        _getargs
	lea.l      12(a7),a7
	move.l     d7,-8(a6)
	move.l     -4(a6),(a7)
	move.l     -8(a6),-(a7)
	jsr        _doif
	addq.l     #4,a7
	move.l     d7,(a5)
	move.l     (a5),d7
	cmp.l      -8(a6),d7
	beq.s      _builtin_3
	movea.l    (a5),a2
	addq.l     #8,a2
	move.l     8(a4),(a2)
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	move.l     12(a4),(a2)
_builtin_3:
	clr.l      (a7)
	move.l     -4(a6),-(a7)
	jsr        _frelst
	addq.l     #4,a7
	move.l     -8(a6),(a7)
	move.l     a4,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	movea.l    (a5),a4
default:
_builtin_2:
x19e_3:
	move.l     a4,d7
	movem.l    (a7)+,d0/d5/a3-a5
	unlk       a6
	rts
case PBFILE:
	clr.l      12(a4)
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	beq.s      x19e_1
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),(a7)
	jsr        _lenstr
	bra.s      x19e_2
x19e_1:
	clr.l      d7
x19e_2:
	move.l     d7,20(a4)
	moveq.l    #8,d0
	move.l     d0,4(a4)
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),16(a4)
	bra.s      x19e_3
case PBLINE:
	pea.l      ($0000000A).w
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     (a2),d7
	ext.l      d7
	move.l     d7,-(a7)
	move.l     #$0002562E,-(a7)
	jsr        _itob
	lea.l      12(a7),a7
	move.l     d7,20(a4)
	moveq.l    #4,d0
	move.l     d0,4(a4)
	move.l     #$0002562E,16(a4)
	bra.s      x19e_3
case PBDEFINED:
	tst.w      _inif
	beq        x19e_3
	movea.l    (a4),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	bne.s      x19e_4
	moveq.l    #1,d0
	move.l     d0,20(a4)
	moveq.l    #4,d0
	move.l     d0,4(a4)
	clr.l      (a7)
	lea.l      ($00000014).w,a2
	adda.l     (a4),a2
	move.l     (a2),-(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a4),a2
	move.l     (a2),-(a7)
	jsr        _lookup
	addq.l     #8,a7
	tst.l      d7
	beq.s      x19e_5
	move.l     #$00025679,d7
	bra.s      x19e_6
x19e_5:
	move.l     #$00025677,d7
x19e_6:
	move.l     d7,16(a4)
	movea.l    (a4),a2
	move.l     (a2),(a7)
	move.l     (a4),-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	move.l     d7,(a4)
	bra        x19e_3
x19e_4:
	movea.l    (a4),a2
	tst.l      (a2)
	beq.s      x19e_7
	movea.l    (a4),a2
	movea.l    (a2),a2
	tst.l      (a2)
	beq.s      x19e_7
	lea.l      ($00000014).w,a2
	adda.l     (a4),a2
	cmpi.l     #$00000001,(a2)
	bne.s      x19e_7
	lea.l      ($00000010).w,a2
	adda.l     (a4),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      x19e_7
	movea.l    (a4),a2
	movea.l    (a2),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	bne.s      x19e_7
	lea.l      ($00000014).w,a2
	movea.l    (a4),a3
	movea.l    (a3),a3
	adda.l     (a3),a2
	cmpi.l     #$00000001,(a2)
	bne.s      x19e_7
	lea.l      ($00000010).w,a2
	movea.l    (a4),a3
	movea.l    (a3),a3
	adda.l     (a3),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	beq.s      x19e_8
x19e_7:
	move.l     #$00025664,(a7) "bad defined syntax"
	jsr        _p0error
	bra        x19e_3
x19e_8:
	moveq.l    #1,d0
	move.l     d0,20(a4)
	moveq.l    #4,d0
	move.l     d0,4(a4)
	clr.l      (a7)
	lea.l      ($00000014).w,a2
	movea.l    (a4),a3
	adda.l     (a3),a2
	move.l     (a2),-(a7)
	lea.l      ($00000010).w,a2
	movea.l    (a4),a3
	adda.l     (a3),a2
	move.l     (a2),-(a7)
	jsr        _lookup
	addq.l     #8,a7
	tst.l      d7
	beq.s      x19e_9
	move.l     #$00025662,d7
	bra.s      x19e_10
x19e_9:
	move.l     #$00025660,d7
x19e_10:
	move.l     d7,16(a4)
	movea.l    (a4),a2
	movea.l    (a2),a2
	movea.l    (a2),a2
	move.l     (a2),(a7)
	move.l     (a4),-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	move.l     d7,(a4)
	bra        x19e_3

_dodef:
	link       a6,#-30
	movem.l    d0/a3-a5,-(a7)
	lea.l      -26(a6),a5
	clr.w      -12(a6)
	clr.w      -14(a6)
	movea.l    8(a6),a1
	tst.l      12(a1)
	bne.s      _dodef_1
	movea.l    8(a6),a1
	cmpi.l     #$00000001,20(a1)
	bne.s      _dodef_1
	movea.l    8(a6),a1
	movea.l    16(a1),a1
	cmpi.b     #$28,(a1)
	beq.s      _dodef_2
_dodef_1:
	movea.l    8(a6),a4
_dodef_9:
	move.l     16(a6),-4(a6)
	clr.w      -10(a6)
_dodef_4:
	tst.l      -4(a6)
	beq        _dodef_3
	movea.l    -4(a6),a1
	move.l     (a1),-4(a6)
	addq.w     #1,-10(a6)
	bra.s      _dodef_4

_dodef_2:
	movea.l    8(a6),a1
	movea.l    (a1),a4
	cmpi.l     #$00000003,4(a4)
	bne.s      _dodef_5
	move.w     #$0001,-12(a6)
	movea.l    (a4),a4
_dodef_5:
	move.l     a4,d7
	beq.s      _dodef_6
	cmpi.l     #$00000001,20(a4)
	bne.s      _dodef_7
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	bne.s      _dodef_7
_dodef_6:
	move.l     a4,d7
	bne        _dodef_8
	move.l     #$000256AD,(a7) "bad #define arguments"
	jsr        _p0error
	clr.w      -12(a6)
	movea.l    8(a6),a4
	bra.s      _dodef_9
_dodef_7:
	tst.l      _stdflag
	bne.s      _dodef_10
	tst.w      -12(a6)
	beq.s      _dodef_10
	cmpi.l     #$00000001,20(a4)
	bne.s      _dodef_10
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0023,d7
	bne.s      _dodef_10
	tst.w      -14(a6)
	bne.s      _dodef_11
	move.w     -12(a6),-14(a6)
	bra.s      _dodef_11
_dodef_10:
	cmpi.l     #$00000001,20(a4)
	bne.s      _dodef_12
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002C,d7
	bne.s      _dodef_12
	movea.l    (a4),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	bne.s      _dodef_12
	movea.l    (a4),a2
	movea.l    (a2),a4
	addq.w     #1,-12(a6)
	bra        _dodef_5
_dodef_11:
	movea.l    (a4),a4
	bra        _dodef_5
_dodef_12:
	suba.l     a4,a4
	bra        _dodef_5
_dodef_8:
	movea.l    (a4),a4
	bra        _dodef_9

_dodef_3:
	tst.l      _stdflag
	beq.s      _dodef_13
	tst.w      -14(a6)
	beq.s      _dodef_14
	move.w     -14(a6),d7
	ext.l      d7
	subq.l     #1,d7
	bra.s      _dodef_15
_dodef_14:
	move.w     -12(a6),d7
	ext.l      d7
_dodef_15:
	move.w     -10(a6),d6
	ext.l      d6
	cmp.l      d7,d6
	bge.s      _dodef_16
	move.l     #$00025695,(a7) "too few macro arguments"
	jsr        _p0error
_dodef_13:
	move.l     a4,-18(a6)
_dodef_30:
	cmpi.l     #$00000002,4(a4)
	beq.s      _dodef_17
	cmpi.l     #$00000001,20(a4)
	bne.s      _dodef_18
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0023,d7
	bne.s      _dodef_18
	move.l     a4,-30(a6)
	movea.l    (a4),a4
	bra.s      _dodef_19
_dodef_16:
	tst.w      -14(a6)
	bne.s      _dodef_13
	move.w     -12(a6),d7
	ext.l      d7
	move.w     -10(a6),d6
	ext.l      d6
	cmp.l      d6,d7
	bge.s      _dodef_13
	move.l     #$0002567C,(a7) "too many macro arguments"
	jsr        _p0error
	bra.s      _dodef_13
_dodef_17:
	move.l     a4,d7
	beq        _dodef_20
	clr.l      (a7)
	move.l     a4,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	bra        _dodef_20
_dodef_18:
	clr.l      -30(a6)
_dodef_19:
	cmpi.l     #$00000003,4(a4)
	bne.s      _dodef_21
	movea.l    8(a6),a2
	movea.l    (a2),a3
	clr.w      -10(a6)
_dodef_29:
	move.w     -10(a6),d7
	ext.l      d7
	move.w     -12(a6),d6
	ext.l      d6
	cmp.l      d6,d7
	bge.s      _dodef_21
	move.l     20(a4),d7
	cmp.l      20(a3),d7
	bne.s      _dodef_22
	move.l     20(a3),(a7)
	move.l     16(a3),-(a7)
	move.l     16(a4),-(a7)
	jsr        _cmpbuf
	addq.l     #8,a7
	tst.l      d7
	beq.s      _dodef_22
_dodef_21:
	cmpi.l     #$00000003,4(a4)
	bne        _dodef_23
	move.w     -10(a6),d7
	ext.l      d7
	move.w     -12(a6),d6
	ext.l      d6
	cmp.l      d6,d7
	bge.s      _dodef_23
	tst.w      -14(a6)
	beq.s      _dodef_24
	move.w     -12(a6),d7
	ext.l      d7
	subq.l     #1,d7
	move.w     -10(a6),d6
	ext.l      d6
	cmp.l      d6,d7
	bne.s      _dodef_24
	moveq.l    #1,d7
	bra.s      _dodef_25
_dodef_24:
	clr.l      d7
_dodef_25:
	move.l     d7,-8(a6)
	move.l     16(a6),-4(a6)
_dodef_27:
	tst.w      -10(a6)
	ble.s      _dodef_26
	tst.l      -4(a6)
	beq.s      _dodef_26
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	subq.w     #1,-10(a6)
	bra.s      _dodef_27
_dodef_22:
	lea.l      ($00000014).w,a2
	adda.l     (a3),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _dodef_28
	lea.l      ($00000010).w,a2
	adda.l     (a3),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0023,d7
	bne.s      _dodef_28
	movea.l    (a3),a3
	bra.s      _dodef_22
_dodef_28:
	movea.l    (a3),a2
	movea.l    (a2),a3
	addq.w     #1,-10(a6)
	bra        _dodef_29
_dodef_23:
	move.l     a4,(a5)
	movea.l    (a5),a5
	movea.l    (a4),a4
	bra        _dodef_30
_dodef_26:
	tst.l      -4(a6)
	beq.s      _dodef_31
	tst.l      -8(a6)
	beq.s      _dodef_32
	move.l     -4(a6),d7
	cmp.l      16(a6),d7
	beq.s      _dodef_32
	clr.l      (a7)
	move.l     #tcomma,-(a7)
	jsr        _buytl
	addq.l     #4,a7
	move.l     d7,(a5)
	tst.l      -30(a6)
	beq.s      _dodef_33
	movea.l    (a5),a2
	addq.l     #4,a2
	moveq.l    #8,d0
	move.l     d0,(a2)
	bra.s      _dodef_33
_dodef_31:
	move.l     (a4),(a7)
	move.l     a4,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	movea.l    d7,a4
	bra        _dodef_30
_dodef_36:
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	bra.s      _dodef_26
_dodef_32:
	movea.l    -4(a6),a2
	addq.l     #4,a2
	move.l     (a2),-22(a6)
_dodef_40:
	movea.l    -4(a6),a2
	addq.l     #8,a2
	move.l     (a2),d7
	cmp.l      -22(a6),d7
	beq.s      _dodef_34
	move.l     (a4),(a7)
	move.l     -22(a6),-(a7)
	jsr        _buytl
	addq.l     #4,a7
	move.l     d7,(a5)
	tst.l      -30(a6)
	beq.s      _dodef_35
	movea.l    (a5),a2
	addq.l     #4,a2
	moveq.l    #8,d0
	move.l     d0,(a2)
	lea.l      ($00000014).w,a2
	adda.l     -30(a6),a2
	clr.l      (a2)
	bra.s      _dodef_35
_dodef_33:
	movea.l    (a5),a5
	bra.s      _dodef_32
_dodef_34:
	tst.l      -8(a6)
	bne.s      _dodef_36
	bra.s      _dodef_31
_dodef_35:
	movea.l    -4(a6),a2
	addq.l     #4,a2
	move.l     (a2),d7
	cmp.l      -22(a6),d7
	bne.s      _dodef_37
	movea.l    (a5),a2
	addq.l     #8,a2
	move.l     8(a4),(a2)
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	move.l     a2,(a7)
	tst.l      -30(a6)
	beq.s      _dodef_38
	tst.l      -8(a6)
	bne.s      _dodef_38
	clr.l      d7
	bra.s      _dodef_39
_dodef_38:
	move.l     12(a4),d7
_dodef_39:
	movea.l    (a7),a1
	move.l     d7,(a1)
_dodef_37:
	movea.l    (a5),a5
	movea.l    -22(a6),a2
	move.l     (a2),-22(a6)
	bra        _dodef_40
_dodef_20:
	move.l     8(a6),d7
	cmp.l      -18(a6),d7
	beq.s      _dodef_41
	movea.l    8(a6),a2
	move.l     (a2),(a7)
	move.l     8(a6),-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	move.l     d7,8(a6)
	bra.s      _dodef_20
_dodef_41:
	move.l     12(a6),(a5)
	move.l     -26(a6),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

_doexp:
	link       a6,#-16
	movem.l    d0/a3-a5,-(a7)
	lea.l      8(a6),a2
	movea.l    a2,a3
_doexp_3:
	movea.l    (a3),a4
	cmpa.l     12(a6),a4
	beq.s      _doexp_1
	cmpi.l     #$00000003,4(a4)
	beq.s      _doexp_2
	movea.l    a4,a3
	bra.s      _doexp_3
_doexp_1:
	move.l     8(a6),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_doexp_2:
	pea.l      -8(a6)
	move.l     20(a4),-(a7)
	move.l     16(a4),-(a7)
	jsr        _lookup
	lea.l      12(a7),a7
	move.l     d7,-12(a6)
	beq.s      _doexp_4
	movea.l    -12(a6),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      _doexp_5
	lea.l      ($00000014).w,a2
	adda.l     (a4),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _doexp_4
	lea.l      ($00000010).w,a2
	adda.l     (a4),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	beq.s      _doexp_5
_doexp_4:
	move.l     a4,(a7)
	move.l     a3,-(a7)
	jsr        _builtin(pc)
	addq.l     #4,a7
	movea.l    d7,a4
	movea.l    a4,a3
	bra.s      _doexp_3
_doexp_5:
	clr.l      (a7)
	move.l     -12(a6),-(a7)
	jsr        _stotl
	addq.l     #4,a7
	movea.l    d7,a5
	clr.l      -4(a6)
	movea.l    -12(a6),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      _doexp_6
	clr.l      (a7)
	pea.l      -4(a6)
	move.l     (a4),-(a7)
	jsr        _getargs
	addq.l     #8,a7
	move.l     d7,-16(a6)
	bra.s      _doexp_7
_doexp_6:
	move.l     (a4),-16(a6)
_doexp_7:
	lea.l      ($0000000C).w,a2
	adda.l     -8(a6),a2
	moveq.l    #1,d0
	move.l     d0,(a2)
	move.l     -4(a6),(a7)
	move.l     -16(a6),-(a7)
	move.l     a5,-(a7)
	jsr        _dodef(pc)
	addq.l     #8,a7
	move.l     d7,(a3)
	move.l     (a3),d7
	cmp.l      -16(a6),d7
	beq.s      _doexp_8
	movea.l    (a3),a2
	addq.l     #8,a2
	move.l     8(a4),(a2)
	lea.l      ($0000000C).w,a2
	adda.l     (a3),a2
	move.l     12(a4),(a2)
_doexp_8:
	clr.l      (a7)
	move.l     -4(a6),-(a7)
	jsr        _frelst
	addq.l     #4,a7
	move.l     -16(a6),(a7)
	move.l     a4,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	move.l     -16(a6),(a7)
	move.l     (a3),-(a7)
	jsr        _doexp(pc)
	addq.l     #4,a7
	move.l     d7,(a3)
_doexp_10:
	move.l     (a3),d7
	cmp.l      -16(a6),d7
	beq.s      _doexp_9
	movea.l    (a3),a3
	bra.s      _doexp_10
_doexp_9:
	lea.l      ($0000000C).w,a2
	adda.l     -8(a6),a2
	clr.l      (a2)
	bra        _doexp_3

_doif:
	link       a6,#-8
	movem.l    d0/a3-a5,-(a7)
	lea.l      -8(a6),a2
	movea.l    a2,a3
	tst.l      12(a6)
	bne.s      _doif_1
	move.l     #$000256D2,(a7) "$if expects arguments"
	jsr        _p0error
	bra.s      _doif_2
_doif_1:
	pea.l      -4(a6)
	movea.l    12(a6),a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _expr
	addq.l     #8,a7
	movea.l    12(a6),a2
	addq.l     #8,a2
	cmp.l      (a2),d7
	beq.s      _doif_3
	move.l     #$000256C4,(a7) "bad $if(test)"
	jsr        _p0error
_doif_2:
	move.l     8(a6),(a3)
	move.l     -8(a6),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_doif_3:
	tst.l      -4(a6)
	beq.s      _doif_2
	movea.l    12(a6),a2
	movea.l    (a2),a5
_doif_6:
	move.l     a5,d7
	beq.s      _doif_2
	movea.l    4(a5),a4
_doif_5:
	cmpa.l     8(a5),a4
	beq.s      _doif_4
	move.l     8(a6),(a7)
	move.l     a4,-(a7)
	jsr        _buytl
	addq.l     #4,a7
	move.l     d7,(a3)
	movea.l    (a3),a3
	movea.l    (a4),a4
	bra.s      _doif_5
_doif_7:
	movea.l    (a5),a5
	bra.s      _doif_6
_doif_4:
	tst.l      (a5)
	beq.s      _doif_7
	move.l     8(a6),(a7)
	move.l     #tcomma,-(a7)
	jsr        _buytl
	addq.l     #4,a7
	move.l     d7,(a3)
	movea.l    (a3),a3
	bra.s      _doif_7

_getargs:
	link       a6,#-10
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a3
	move.l     a3,-10(a6)
	movea.l    12(a6),a5
	movea.l    (a3),a3
_getargs_7:
	move.l     a3,d7
	beq.s      _getargs_1
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_2
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	bne.s      _getargs_2
_getargs_1:
	move.l     a3,d7
	beq        _getargs_3
	move.l     (a3),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_getargs_2:
	clr.l      (a7)
	pea.l      ($0000000C).w
	jsr        _alloc
	addq.l     #4,a7
	movea.l    d7,a4
	move.l     a4,(a5)
	move.l     a3,4(a4)
	move.l     -10(a6),-6(a6)
	clr.w      -2(a6)
_getargs_10:
	move.l     a3,d7
	beq.s      _getargs_4
	tst.w      -2(a6)
	bgt.s      _getargs_5
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_6
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002C,d7
	beq.s      _getargs_4
	bra.s      _getargs_6
_getargs_15:
	movea.l    a4,a5
	bra.s      _getargs_7
_getargs_4:
	move.l     a3,d7
	bne.s      _getargs_8
	bra.s      _getargs_1
_getargs_6:
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_5
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	beq.s      _getargs_4
_getargs_5:
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_9
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      _getargs_9
	addq.w     #1,-2(a6)
_getargs_12:
	movea.l    (a3),a3
	bra.s      _getargs_10
_getargs_9:
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_11
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	bne.s      _getargs_11
	subq.w     #1,-2(a6)
	bra.s      _getargs_12
_getargs_11:
	cmpi.l     #$00000002,4(a3)
	bne.s      _getargs_12
	pea.l      ($00000001).w
	jsr        _getex
	addq.l     #4,a7
	cmp.l      (a3),d7
	bne.s      _getargs_12
	moveq.l    #7,d0
	move.l     d0,4(a3)
	bra.s      _getargs_12
_getargs_8:
	move.l     a3,8(a4)
	cmpi.l     #$00000001,20(a3)
	bne.s      _getargs_13
	movea.l    16(a3),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002C,d7
	bne.s      _getargs_13
	move.l     a3,-10(a6)
	movea.l    (a3),a3
_getargs_13:
	tst.l      16(a6)
	beq.s      _getargs_14
	addq.w     #1,_inif
_getargs_14:
	move.l     8(a4),(a7)
	move.l     -6(a6),-(a7)
	jsr        _doexp(pc)
	addq.l     #4,a7
	movea.l    d7,a2
	move.l     (a2),4(a4)
	tst.l      16(a6)
	beq        _getargs_15
	subq.w     #1,_inif
	clr.l      16(a6)
	bra        _getargs_15
_getargs_3:
	move.l     #$000256E8,(a7) "bad macro arguments"
	jsr        _p0error
	movea.l    12(a6),a2
	clr.l      (a2)
	move.l     8(a6),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

_undef:
	link       a6,#0
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	cmpi.l     #$0000007F,12(a6)
	bcc.s      _undef_1
	move.l     12(a6),d7
	bra.s      _undef_2
_undef_1:
	moveq.l    #127,d7
_undef_2:
	move.l     d7,12(a6)
	move.l     12(a6),(a7)
	move.l     a5,-(a7)
	jsr        _hash
	addq.l     #4,a7
	movea.l    d7,a4
_undef_6:
	movea.l    (a4),a3
	move.l     a3,d7
	beq.s      _undef_3
	move.l     12(a6),d7
	cmp.l      8(a3),d7
	bne.s      _undef_4
	move.l     12(a6),(a7)
	pea.l      16(a3)
	move.l     a5,-(a7)
	jsr        _cmpbuf
	addq.l     #8,a7
	tst.l      d7
	beq.s      _undef_4
_undef_3:
	move.l     a3,d7
	beq.s      _undef_5
	clr.l      (a7)
	move.l     4(a3),-(a7)
	jsr        _free
	addq.l     #4,a7
	move.l     (a3),(a7)
	move.l     a3,-(a7)
	jsr        _free
	addq.l     #4,a7
	move.l     d7,(a4)
	bra.s      _undef_5
_undef_4:
	movea.l    a3,a4
	bra.s      _undef_6
_undef_5:
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

_dobesc:
	link       a6,#-14
	movem.l    d0/d5/a4-a5,-(a7)
	movea.l    8(a6),a5
	movea.l    12(a6),a4
	cmpi.l     #$00000002,16(a6)
	bcc.s      _dobesc_1
	moveq.l    #2,d7
	bra.s      _dobesc_2
_dobesc_1:
	move.l     16(a6),d7
_dobesc_2:
	add.l      a4,d7
	move.l     d7,-4(a6)
	moveq.l    #-2,d0
	move.l     d0,-8(a6)
_dobesc_6:
	cmpa.l     -4(a6),a4
	bcc.s      _dobesc_3
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$005C,d7
	bne.s      _dobesc_4
	lea.l      1(a4),a2
	cmpa.l     -4(a6),a2
	bne.s      _dobesc_5
	bra.s      _dobesc_4
_dobesc_3:
	move.l     -8(a6),d7
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts
_dobesc_4:
	clr.l      d7
	move.b     (a4),d7
	andi.l     #$000000FF,d7
	movea.l    d7,a2
	adda.l     #_cmap,a2
	move.b     (a2),-13(a6)
_dobesc_8:
	move.b     -13(a6),(a5)+
	addq.l     #1,-8(a6)
	addq.l     #1,a4
	bra.s      _dobesc_6
_dobesc_5:
	addq.l     #1,a4
	clr.l      d7
	move.b     (a4),d7
	move.l     d7,(a7)
	move.l     #$00025B64,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.b     d7,-13(a6)
	clr.l      d7
	move.b     -13(a6),d7
	movea.l    d7,a2
	adda.l     #$00025B64,a2
	tst.b      (a2)
	beq.s      _dobesc_7
	movea.l    #$00025B70,a2
	clr.l      d7
	move.b     -13(a6),d7
	adda.l     d7,a2
	clr.l      d7
	move.b     (a2),d7
	andi.l     #$000000FF,d7
	movea.l    d7,a2
	adda.l     #_cmap,a2
	move.b     (a2),-13(a6)
	bra.s      _dobesc_8
_dobesc_7:
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0078,d7
	bne.s      _dobesc_9
	clr.b      -13(a6)
	clr.l      d5
_dobesc_11:
	cmpi.l     #$00000003,d5
	bge.s      _dobesc_8
	addq.l     #1,a4
	cmpa.l     -4(a6),a4
	bcc.s      _dobesc_8
	clr.l      d7
	move.b     (a4),d7
	move.l     d7,(a7)
	move.l     #_digfr,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.l     d7,-12(a6)
	movea.l    -12(a6),a2
	adda.l     #_digfr,a2
	tst.b      (a2)
	beq.s      _dobesc_10
	clr.l      d7
	move.b     -13(a6),d7
	asl.l      #4,d7
	movea.l    #_digto,a2
	adda.l     -12(a6),a2
	clr.l      d6
	move.b     (a2),d6
	or.l       d6,d7
	move.b     d7,-13(a6)
	addq.l     #1,d5
	bra.s      _dobesc_11
_dobesc_9:
	clr.b      -13(a6)
	clr.l      d5
	subq.l     #1,a4
_dobesc_13:
	cmpi.l     #$00000003,d5
	bge        _dobesc_8
	addq.l     #1,a4
	cmpa.l     -4(a6),a4
	bcc        _dobesc_8
	clr.l      d7
	move.b     (a4),d7
	move.l     d7,(a7)
	move.l     #_digfr,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.l     d7,-12(a6)
	cmpi.l     #$00000008,-12(a6)
	bcc.s      _dobesc_12
	clr.l      d7
	move.b     -13(a6),d7
	asl.l      #3,d7
	or.l       -12(a6),d7
	move.b     d7,-13(a6)
	addq.l     #1,d5
	bra.s      _dobesc_13
_dobesc_10:
	subq.l     #1,a4
	bra        _dobesc_8
_dobesc_12:
	tst.l      d5
	bne.s      _dobesc_14
	clr.l      d7
	move.b     (a4),d7
	andi.l     #$000000FF,d7
	movea.l    d7,a2
	adda.l     #_cmap,a2
	move.b     (a2),-13(a6)
	bra        _dobesc_8
_dobesc_14:
	subq.l     #1,a4
	bra        _dobesc_8

_dopunct:
	link       a6,#-8
	movem.l    d0/d5/a3-a5,-(a7)
	movea.l    8(a6),a2
	movea.l    (a2),a5
	movea.l    16(a5),a2
	move.b     (a2),-3(a6)
	moveq.l    #1,d5
	movea.l    (a5),a4
_dopunct_2:
	cmpi.l     #$00000003,d5
	bge.s      _dopunct_1
	cmpi.l     #$00000005,4(a4)
	bne.s      _dopunct_1
	tst.l      12(a4)
	bne.s      _dopunct_1
	lea.l      -3(a6),a2
	adda.l     d5,a2
	movea.l    16(a4),a3
	move.b     (a3),(a2)
	addq.l     #1,d5
	movea.l    (a4),a4
	bra.s      _dopunct_2
_dopunct_1:
	tst.l      d5
	ble.s      _dopunct_3
	move.l     d5,(a7)
	pea.l      -3(a6)
	pea.l      ($0000002E).w
	move.l     #_optab,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	move.l     d7,-8(a6)
	bne.s      _dopunct_3
	tst.l      _stdflag
	bne.s      _dopunct_4
	move.l     d5,(a7)
	pea.l      -3(a6)
	pea.l      ($00000015).w
	move.l     #_optabold,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	move.l     d7,-8(a6)
	beq.s      _dopunct_4
_dopunct_3:
	tst.l      d5
	bgt.s      _dopunct_5
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	move.l     d7,(a7)
	move.l     #$00025B7C,-(a7) "illegal character: %c"
	jsr        _p0error
	addq.l     #4,a7
	movea.l    8(a6),a2
	move.l     (a5),(a2)
	move.w     #$00DE,d7
	ext.l      d7
	bra.s      _dopunct_6
_dopunct_4:
	subq.l     #1,d5
	bra.s      _dopunct_1
_dopunct_5:
	tst.l      d5
	ble.s      _dopunct_7
	movea.l    (a5),a5
	subq.l     #1,d5
	bra.s      _dopunct_5
_dopunct_7:
	movea.l    8(a6),a2
	move.l     a5,(a2)
	move.l     -8(a6),d7
_dopunct_6:
	movem.l    (a7)+,d0/d5/a3-a5
	unlk       a6
	rts

_eval:
	link       a6,#-4
	movem.l    d0/a5,-(a7)
	movea.l    8(a6),a5
	pea.l      -4(a6)
	move.l     a5,-(a7)
	jsr        _expr
	addq.l     #8,a7
	movea.l    d7,a5
	move.l     a5,d7
	bne.s      _eval_1
	clr.l      d7
	bra.s      _eval_2
_eval_1:
	cmpi.l     #$00000002,4(a5)
	beq.s      _eval_3
	move.l     #$00025B92,(a7) "illegal #if expression"
	jsr        _p0error
	clr.l      d7
_eval_2:
	movem.l    (a7)+,d0/a5
	unlk       a6
	rts
_eval_3:
	tst.l      -4(a6)
	beq.s      _eval_4
	moveq.l    #1,d7
	bra.s      _eval_5
_eval_4:
	clr.l      d7
_eval_5:
	bra.s      _eval_2

_exop:
	link       a6,#-4
	movem.l    d0/d5/a5,-(a7)
	movea.l    8(a6),a5
	move.l     (a5),-4(a6)
	movea.l    -4(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000005,(a2)
	bne.s      _exop_1
	pea.l      -4(a6)
	jsr        _dopunct(pc)
	addq.l     #4,a7
	move.l     d7,d5
	move.l     d5,d7
	and.l      12(a6),d7
	beq.s      _exop_1
	move.l     -4(a6),(a5)
	move.l     d5,d7
	bra.s      _exop_2
_exop_1:
	clr.l      d7
_exop_2:
	movem.l    (a7)+,d0/d5/a5
	unlk       a6
	rts

_expr:
	link       a6,#-8
	move.l     12(a6),(a7)
	move.l     8(a6),-(a7)
	jsr        _exterm
	addq.l     #4,a7
	move.l     d7,8(a6)
	bne.s      _expr_1
	clr.l      d7
	unlk       a6
	rts
_expr_1:
	move.l     #$00000080,(a7)
	pea.l      8(a6)
	jsr        _exop(pc)
	addq.l     #4,a7
	move.l     d7,-4(a6)
	beq.s      _expr_2
	move.l     8(a6),(a7)
	pea.l      -4(a6)
	move.l     12(a6),-(a7)
	clr.l      -(a7)
	jsr        _extail
	lea.l      12(a7),a7
	unlk       a6
	rts
_expr_2:
	move.l     8(a6),d7
	unlk       a6
	rts

_expri:
	link       a6,#0
	movem.l    d0/d4-d5,-(a7)
	move.l     8(a6),d5
	tst.l      d5
	beq.s      _expri_1
	move.l     d5,(a7)
	move.l     #_ipri,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.l     d7,d4
	movea.l    d4,a2
	adda.l     #$000256FC,a2 ; ipri
	tst.b      (a2)
	bne.s      _expri_2
_expri_1:
	clr.l      d7
	bra.s      _expri_3
_expri_2:
	movea.l    d4,a2
	adda.l     #$00025710,a2
	clr.l      d7
	move.b     (a2),d7
_expri_3:
	movem.l    (a7)+,d0/d4-d5
	unlk       a6
	rts

_extail:
	link       a6,#-16
	movem.l    d0/d4-d5,-(a7)
	movea.l    16(a6),a2
	move.l     (a2),-16(a6)
_extail_6:
	move.l     -16(a6),(a7)
	jsr        _expri(pc)
	move.l     d7,d5
	move.l     8(a6),d7
	cmp.l      d5,d7
	bge.s      _extail_1
	pea.l      -12(a6)
	move.l     20(a6),-(a7)
	jsr        _exterm
	addq.l     #8,a7
	move.l     d7,20(a6)
	bne.s      _extail_2
	bra.s      _extail_3
_extail_1:
	move.l     20(a6),d7
	bra.s      _extail_4
_extail_2:
	move.l     #$00000080,(a7)
	pea.l      20(a6)
	jsr        _exop(pc)
	addq.l     #4,a7
	move.l     d7,-16(a6)
	move.l     -16(a6),(a7)
	jsr        _expri(pc)
	cmp.l      d7,d5
	bge.s      _extail_3
	move.l     20(a6),(a7)
	pea.l      -16(a6)
	pea.l      -12(a6)
	move.l     d5,-(a7)
	jsr        _extail(pc)
	lea.l      12(a7),a7
	move.l     d7,20(a6)
_extail_3:
	tst.l      20(a6)
	bne.s      _extail_5
	clr.l      d7
_extail_4:
	movem.l    (a7)+,d0/d4-d5
	unlk       a6
	rts
_extail_5:
	movea.l    16(a6),a2
	move.l     (a2),d4
	movea.l    12(a6),a2
	move.l     (a2),-4(a6)
	move.l     -4(a6),d7
	sub.l      -12(a6),d7
	move.l     d7,-8(a6)
	move.l     d4,d7
	lea.l      $00025BAA,a0
	jmp        a.switch
case LPLUS:
	move.l     -12(a6),d7
	add.l      d7,-4(a6)
_extail_7:
	movea.l    12(a6),a2
	move.l     -4(a6),(a2)
	movea.l    16(a6),a2
	move.l     -16(a6),(a2)
	bra        _extail_6
case LMINUS:
	move.l     -8(a6),-4(a6)
	bra.s      _extail_7
case LTIMES:
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.lmul
	move.l     (a7),-4(a6)
	bra.s      _extail_7
case LDIVIDE:
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.ldiv
	move.l     (a7),-4(a6)
	bra.s      _extail_7
case LMODULO:
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.lmod
	move.l     (a7),-4(a6)
	bra.s      _extail_7
case LAND:
	move.l     -12(a6),d7
	and.l      d7,-4(a6)
	bra.s      _extail_7
case LOR:
	move.l     -12(a6),d7
	or.l       d7,-4(a6)
	bra.s      _extail_7
case LXOR:
	move.l     -12(a6),d7
	eor.l      d7,-4(a6)
	bra.s      _extail_7
case LLSHIFT:
	move.l     -4(a6),d7
	move.l     -12(a6),d6
	asl.l      d6,d7
	move.l     d7,-4(a6)
	bra        _extail_7
case LRSHIFT:
	move.l     -4(a6),d7
	move.l     -12(a6),d6
	asr.l      d6,d7
	move.l     d7,-4(a6)
	bra        _extail_7
case LLESS:
	tst.l      -8(a6)
	bge.s      _extail_8
	moveq.l    #1,d7
	bra.s      _extail_9
_extail_8:
	clr.l      d7
_extail_9:
	move.l     d7,-4(a6)
	bra        _extail_7
case LISEQ:
	tst.l      -8(a6)
	bne.s      _extail_10
	moveq.l    #1,d7
	bra.s      _extail_11
_extail_10:
	clr.l      d7
_extail_11:
	move.l     d7,-4(a6)
	bra        _extail_7
case LGREAT:
	tst.l      -8(a6)
	ble.s      _extail_12
	moveq.l    #1,d7
	bra.s      _extail_13
_extail_12:
	clr.l      d7
_extail_13:
	move.l     d7,-4(a6)
	bra        _extail_7
case LLEQ:
	tst.l      -8(a6)
	bgt.s      _extail_14
	moveq.l    #1,d7
	bra.s      _extail_15
_extail_14:
	clr.l      d7
_extail_15:
	move.l     d7,-4(a6)
	bra        _extail_7
case LNOTEQ:
	tst.l      -8(a6)
	beq.s      _extail_16
	moveq.l    #1,d7
	bra.s      _extail_17
_extail_16:
	clr.l      d7
_extail_17:
	move.l     d7,-4(a6)
	bra        _extail_7
case LGEQ:
	tst.l      -8(a6)
	blt.s      _extail_18
	moveq.l    #1,d7
	bra.s      _extail_19
_extail_18:
	clr.l      d7
_extail_19:
	move.l     d7,-4(a6)
	bra        _extail_7
case LANDAND:
	tst.l      -4(a6)
	beq.s      _extail_20
	tst.l      -12(a6)
	beq.s      _extail_20
	moveq.l    #1,d7
	bra.s      _extail_21
_extail_20:
	clr.l      d7
_extail_21:
	move.l     d7,-4(a6)
	bra        _extail_7
case LOROR:
	tst.l      -4(a6)
	bne.s      _extail_22
	tst.l      -12(a6)
	beq.s      _extail_23
_extail_22:
	moveq.l    #1,d7
	bra.s      _extail_24
_extail_23:
	clr.l      d7
_extail_24:
	move.l     d7,-4(a6)
	bra        _extail_7
case LQUERY:
	lea.l      ($00000014).w,a2
	adda.l     20(a6),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _extail_25
	lea.l      ($00000010).w,a2
	adda.l     20(a6),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$003A,d7
	bne.s      _extail_25
	pea.l      -8(a6)
	movea.l    20(a6),a2
	move.l     (a2),-(a7)
	jsr        _expr(pc)
	addq.l     #8,a7
	move.l     d7,20(a6)
	bne.s      _extail_26
_extail_25:
	move.l     #$00025C62,(a7) "illegal ? : in #if"
	jsr        _p0error
	clr.l      d7
	bra.s      _extail_27
_extail_26:
	tst.l      -4(a6)
	beq.s      _extail_28
	move.l     -12(a6),-4(a6)
	bra        _extail_7
_extail_28:
	move.l     -8(a6),-4(a6)
	bra        _extail_7
default:
	move.l     #$00025C4A,(a7) "illegal operator in #if"
	jsr        _p0error
	clr.l      d7
_extail_27:
	movem.l    (a7)+,d0/d4-d5
	unlk       a6
	rts

_exterm:
	link       a6,#-516
	movem.l    d0/d5/a4-a5,-(a7)
	movea.l    12(a6),a5
	movea.l    8(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000004,(a2)
	bne.s      _exterm_1
	clr.l      (a7)
	clr.l      -(a7)
	move.l     8(a6),-(a7)
	jsr        _bton
	addq.l     #8,a7
	move.l     d7,(a5)
	movea.l    8(a6),a2
	move.l     (a2),d7
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts
_exterm_1:
	movea.l    8(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000001,(a2)
	bne.s      _exterm_2
	lea.l      -511(a6),a2
	movea.l    a2,a4
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	move.l     (a2),-(a7)
	pea.l      -512(a6)
	jsr        _dobesc(pc)
	addq.l     #8,a7
	move.l     d7,d5
	clr.l      (a5)
_exterm_4:
	tst.l      d5
	beq.s      _exterm_3
	move.l     (a5),d7
	asl.l      #8,d7
	clr.l      d6
	move.b     (a4),d6
	andi.l     #$000000FF,d6
	or.l       d6,d7
	move.l     d7,(a5)
	addq.l     #1,a4
	subq.l     #1,d5
	bra.s      _exterm_4
_exterm_2:
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _exterm_5
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	bne.s      _exterm_5
	move.l     a5,(a7)
	movea.l    8(a6),a2
	move.l     (a2),-(a7)
	jsr        _expr(pc)
	addq.l     #4,a7
	move.l     d7,8(a6)
	bne.s      _exterm_6
	clr.l      d7
	bra.s      _exterm_7
_exterm_3:
	movea.l    8(a6),a2
	move.l     (a2),d7
_exterm_7:
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts
_exterm_5:
	pea.l      ($00000040).w
	pea.l      8(a6)
	jsr        _exop(pc)
	addq.l     #8,a7
	move.l     d7,-516(a6)
	bne.s      _exterm_8
	move.l     #$00025C8E,(a7) "illegal #if syntax"
	jsr        _p0error
	clr.l      d7
	bra.s      _exterm_7
_exterm_6:
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _exterm_9
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0029,d7
	beq.s      _exterm_10
_exterm_9:
	move.l     #$00025CA1,(a7) "missing ) in #if"
	jsr        _p0error
	clr.l      d7
	bra.s      _exterm_7
_exterm_10:
	movea.l    8(a6),a2
	move.l     (a2),d7
	bra.s      _exterm_7
_exterm_8:
	move.l     a5,(a7)
	move.l     8(a6),-(a7)
	jsr        _exterm(pc)
	addq.l     #4,a7
	move.l     d7,8(a6)
	bne.s      _exterm_11
	clr.l      d7
	bra.s      _exterm_12
_exterm_11:
	cmpi.l     #$000000D8,-516(a6)
	bne.s      _exterm_13
	move.l     (a5),d7
	neg.l      d7
	move.l     d7,(a5)
	bra.s      _exterm_14
_exterm_13:
	cmpi.l     #$0000005A,-516(a6)
	bne.s      _exterm_15
	tst.l      (a5)
	bne.s      _exterm_16
	moveq.l    #1,d7
	bra.s      _exterm_17
_exterm_16:
	clr.l      d7
_exterm_17:
	move.l     d7,(a5)
_exterm_14:
	move.l     8(a6),d7
_exterm_12:
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts
_exterm_15:
	cmpi.l     #$00000043,-516(a6)
	bne.s      _exterm_18
	move.l     (a5),d7
	not.l      d7
	move.l     d7,(a5)
	bra.s      _exterm_14
_exterm_18:
	cmpi.l     #$000000DE,-516(a6)
	beq.s      _exterm_14
	move.l     #$00025C76,(a7) "illegal unary op in #if"
	jsr        _p0error
	bra.s      _exterm_14

_bton:
	link       a6,#-16
	movem.l    d0/d5/a4-a5,-(a7)
	movea.l    8(a6),a5
	clr.l      -8(a6)
	movea.l    16(a5),a4
	move.l     20(a5),d5
	tst.l      d5
	ble.s      _bton_1
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0030,d7
	beq.s      _bton_1
	move.w     #$000A,-10(a6)
	bra.s      _bton_2
_bton_1:
	cmpi.l     #$00000001,d5
	ble.s      _bton_3
	clr.l      d7
	move.b     1(a4),d7
	cmpi.w     #$0078,d7
	beq        _bton_4
	clr.l      d7
	move.b     1(a4),d7
	cmpi.w     #$0058,d7
	beq        _bton_4
_bton_3:
	move.w     #$0008,-10(a6)
_bton_2:
	clr.l      -16(a6)
_bton_6:
	tst.l      d5
	ble        _bton_5
	clr.l      d7
	move.b     (a4),d7
	move.l     d7,(a7)
	move.l     #_digfr,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.w     d7,-12(a6)
	move.w     -12(a6),d7
	ext.l      d7
	movea.l    d7,a2
	adda.l     #_digfr,a2
	tst.b      (a2)
	beq.s      _bton_5
	movea.l    #_digto,a2
	move.w     -12(a6),d7
	ext.l      d7
	adda.l     d7,a2
	clr.w      d0
	move.b     (a2),d0
	move.w     d0,-12(a6)
	move.w     -12(a6),d7
	ext.l      d7
	move.w     -10(a6),d6
	ext.l      d6
	cmp.l      d6,d7
	bge.s      _bton_5
	move.l     -16(a6),(a7)
	move.w     -10(a6),d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        a.lmul
	move.l     (a7),d7
	move.w     -12(a6),d6
	ext.l      d6
	add.l      d6,d7
	move.l     d7,-16(a6)
	addq.l     #1,a4
	subq.l     #1,d5
	bra.s      _bton_6
_bton_4:
	move.w     #$0010,-10(a6)
	addq.l     #2,a4
	subq.l     #2,d5
	bra        _bton_2
_bton_5:
	clr.l      -8(a6)
	clr.l      -4(a6)
_bton_13:
	tst.l      d5
	ble.s      _bton_7
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$006C,d7
	beq.s      _bton_8
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$004C,d7
	bne.s      _bton_9
	bra.s      _bton_8
_bton_7:
	tst.l      d5
	beq.s      _bton_10
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	move.l     #$00025EAA,-(a7) "illegal integer %b"
	jsr        _p0error
	addq.l     #8,a7
	bra.s      _bton_10
_bton_8:
	tst.l      -4(a6)
	bne.s      _bton_9
	moveq.l    #1,d0
	move.l     d0,-4(a6)
	bra.s      _bton_11
_bton_9:
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0075,d7
	beq.s      _bton_12
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0055,d7
	bne.s      _bton_7
_bton_12:
	tst.l      -8(a6)
	bne.s      _bton_7
	moveq.l    #1,d0
	move.l     d0,-8(a6)
_bton_11:
	addq.l     #1,a4
	subq.l     #1,d5
	bra.s      _bton_13
_bton_10:
	tst.l      12(a6)
	beq.s      _bton_14
	movea.l    12(a6),a2
	move.l     -4(a6),(a2)
_bton_14:
	tst.l      16(a6)
	beq.s      _bton_15
	movea.l    16(a6),a2
	move.l     -8(a6),(a2)
_bton_15:
	move.l     -16(a6),d7
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts

_flaccum:
	link       a6,#0
	movem.l    d0/d3-d5/a4-a5,-(a7)
	movea.l    8(a6),a5
	move.l     16(a6),d5
	clr.l      d4
_flaccum_2:
	cmp.l      d5,d4
	bcc.s      _flaccum_1
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0030,d7
	bcs.s      _flaccum_1
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0039,d7
	bhi.s      _flaccum_1
	movea.l    12(a6),a2
	movea.l    12(a6),a4
	move.l     (a4),d6
	move.l     4(a4),d7
	lea.l      $000268FC,a0
	jsr        a.6mul
	moveq.l    #-48,d3
	clr.l      d2
	move.b     (a5),d2
	add.l      d2,d3
	move.l     d3,d0
	jsr        a.1ltd
	suba.l     a0,a0
	jsr        a.6add
	move.l     d6,(a2)
	move.l     d7,4(a2)
	addq.l     #1,d4
	addq.l     #1,a5
	bra.s      _flaccum_2
_flaccum_1:
	move.l     d4,d7
	movem.l    (a7)+,d0/d3-d5/a4-a5
	unlk       a6
	rts

_lexchars:
	link       a6,#-516
	movem.l    d0/d4-d5/a5,-(a7)
	movea.l    8(a6),a5
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	pea.l      -516(a6)
	jsr        _dobesc
	addq.l     #8,a7
	move.l     d7,d4
	cmpi.l     #$00000004,d4
	bcc.s      _lexchars_1
	moveq.l    #1,d7
	bra.s      _lexchars_2
_lexchars_1:
	movea.l    d4,a2
	subq.l     #3,a2
	move.l     a2,d7
_lexchars_2:
	move.l     d7,d5
	clr.l      -4(a6)
_lexchars_4:
	cmp.l      d4,d5
	bhi.s      _lexchars_3
	move.l     -4(a6),d7
	asl.l      #8,d7
	lea.l      -516(a6),a2
	adda.l     d5,a2
	clr.l      d6
	move.b     (a2),d6
	or.l       d6,d7
	move.l     d7,-4(a6)
	addq.l     #1,d5
	bra.s      _lexchars_4
_lexchars_3:
	pea.l      -4(a6)
	cmpi.l     #$00000001,d4
	bhi.s      _lexchars_5
	moveq.l    #24,d7
	bra.s      _lexchars_6
_lexchars_5:
	moveq.l    #22,d7
_lexchars_6:
	move.l     d7,-(a7)
	move.l     #$00025EBE,-(a7)
	jsr        _putcode "c4"
	lea.l      12(a7),a7
	move.l     (a5),d7
	movem.l    (a7)+,d0/d4-d5/a5
	unlk       a6
	rts

_lexfloat:
	link       a6,#-16
	movem.l    d0/d4-d5/a5,-(a7)
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	movea.l    (a2),a5
	clr.l      -14(a6)
	clr.l      -10(a6)
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	move.l     (a2),(a7)
	pea.l      -14(a6)
	move.l     a5,-(a7)
	jsr        _flaccum(pc)
	addq.l     #8,a7
	adda.l     d7,a5
	move.l     a5,(a7)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #4,a7
	movea.l    d7,a5
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002E,d7
	bne.s      _lexfloat_1
	pea.l      1(a5)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #8,a7
	movea.l    d7,a5
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	move.l     (a2),(a7)
	pea.l      -14(a6)
	move.l     a5,-(a7)
	jsr        _flaccum(pc)
	addq.l     #8,a7
	move.l     d7,d5
	move.l     d5,d7
	neg.l      d7
	move.w     d7,-6(a6)
	adda.l     d5,a5
	move.l     a5,(a7)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #4,a7
	movea.l    d7,a5
	bra.s      _lexfloat_2
_lexfloat_1:
	clr.w      -6(a6)
_lexfloat_2:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0065,d7
	beq.s      _lexfloat_3
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0045,d7
	bne        _lexfloat_4
_lexfloat_3:
	addq.l     #1,a5
	move.l     a5,(a7)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #4,a7
	movea.l    d7,a5
	clr.l      -4(a6)
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002B,d7
	bne.s      _lexfloat_5
	addq.l     #1,a5
	bra.s      _lexfloat_6
_lexfloat_5:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002D,d7
	bne.s      _lexfloat_6
	addq.l     #1,a5
	moveq.l    #1,d0
	move.l     d0,-4(a6)
_lexfloat_6:
	move.l     a5,(a7)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #4,a7
	movea.l    d7,a5
	clr.l      d5
_lexfloat_8:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0030,d7
	bcs.s      _lexfloat_7
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0039,d7
	bhi.s      _lexfloat_7
	moveq.l    #-48,d7
	move.l     d5,(a7)
	pea.l      ($0000000A).w
	jsr        a.lmul
	move.l     (a7),d6
	clr.l      d4
	move.b     (a5),d4
	add.l      d4,d6
	add.l      d6,d7
	move.l     d7,d5
	addq.l     #1,a5
	bra.s      _lexfloat_8
_lexfloat_7:
	tst.l      -4(a6)
	beq.s      _lexfloat_9
	sub.w      d5,-6(a6)
	bra.s      _lexfloat_4
_lexfloat_9:
	add.w      d5,-6(a6)
_lexfloat_4:
	move.w     -6(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	move.l     -10(a6),-(a7)
	move.l     -14(a6),-(a7)
	jsr        _dtento
	addq.l     #8,a7
	move.l     d6,-14(a6)
	move.l     d7,-10(a6)
	move.l     a5,(a7)
	pea.l      8(a6)
	jsr        _lexfnxt
	addq.l     #4,a7
	movea.l    d7,a5
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$006C,d7
	beq.s      _lexfloat_10
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$004C,d7
	bne.s      _lexfloat_11
_lexfloat_10:
	addq.l     #1,a5
	move.b     #$10,-15(a6)
_lexfloat_16:
	pea.l      -14(a6)
	move.b     -15(a6),d7
	ext.w      d7
	ext.l      d7
	move.l     d7,-(a7)
	move.l     #$00025ED9,-(a7)
	jsr        _putcode "c8"
	lea.l      12(a7),a7
	cmpa.l     #$00025EA9,a5 " " space
	beq.s      _lexfloat_12
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	move.l     (a2),d7
	cmp.l      a5,d7
	bne.s      _lexfloat_13
	bra.s      _lexfloat_12
_lexfloat_11:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0066,d7
	beq.s      _lexfloat_14
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0046,d7
	bne.s      _lexfloat_15
_lexfloat_14:
	addq.l     #1,a5
	move.b     #$1E,-15(a6)
	bra.s      _lexfloat_16
_lexfloat_15:
	move.b     #$11,-15(a6)
	bra.s      _lexfloat_16

_lexfloat_13:
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	move.l     (a2),d7
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	add.l      (a2),d7
	cmp.l      a5,d7
	bne.s      _lexfloat_17
	movea.l    8(a6),a2
	move.l     (a2),8(a6)
_lexfloat_12:
	move.l     8(a6),d7
	movem.l    (a7)+,d0/d4-d5/a5
	unlk       a6
	rts
_lexfloat_17:
	movea.l    8(a6),a2
	move.l     (a2),8(a6)
	move.l     #$00025EC2,(a7) "illegal float constant"
	jsr        _p0error
	bra.s      _lexfloat_12

_lexfnxt:
	link       a6,#0
	movem.l    d0/a5,-(a7)
	movea.l    8(a6),a2
	movea.l    (a2),a5
	move.l     12(a6),d7
	cmpi.l     #$00025EA9,d7 " " space
	beq.s      _lexfnxt_1
	move.l     16(a5),d7
	add.l      20(a5),d7
	cmp.l      12(a6),d7
	bhi.s      _lexfnxt_1
	movea.l    (a5),a5
	movea.l    8(a6),a2
	move.l     a5,(a2)
	tst.l      12(a5)
	beq.s      _lexfnxt_2
	move.l     #$00025EA9,d7 " " space
	bra.s      _lexfnxt_3
_lexfnxt_2:
	move.l     16(a5),d7
_lexfnxt_3:
	bra.s      _lexfnxt_4
_lexfnxt_1:
	move.l     12(a6),d7
_lexfnxt_4:
	movem.l    (a7)+,d0/a5
	unlk       a6
	rts

_lexident:
	link       a6,#0
	movem.l    d0/d4-d5/a5,-(a7)
	movea.l    8(a6),a5
	cmpi.l     #$0000007F,20(a5)
	bcc.s      _lexident_1
	move.l     20(a5),d7
	bra.s      _lexident_2
_lexident_1:
	moveq.l    #127,d7
_lexident_2:
	move.l     d7,d5
	clr.l      d7
	move.b     _escname,d7
	cmp.l      d7,d5
	bne.s      _lexident_3
	move.l     d5,(a7)
	move.l     #$00025F8F,-(a7)
	move.l     16(a5),-(a7)
	jsr        _cmpbuf
	addq.l     #8,a7
	tst.l      d7
	beq.s      _lexident_3
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	bne.s      _lexident_3
	movea.l    (a5),a5
	move.l     20(a5),d5
	clr.l      d4
	bra.s      _lexident_4
_lexident_3:
	move.l     d5,(a7)
	move.l     16(a5),-(a7)
	pea.l      ($00000021).w
	move.l     #_keytab,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	move.l     d7,d4
_lexident_4:
	tst.l      d4
	beq.s      _lexident_5
	move.l     d4,(a7)
	move.l     #$00025EE0,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	bra.s      _lexident_6
_lexident_5:
	move.l     d5,(a7)
	move.l     16(a5),-(a7)
	move.l     d5,-(a7)
	pea.l      ($00000012).w
	move.l     #$00025EDC,-(a7)
	jsr        _putcode "ccb"
	lea.l      16(a7),a7
_lexident_6:
	move.l     (a5),d7
	movem.l    (a7)+,d0/d4-d5/a5
	unlk       a6
	rts

_lexint:
	link       a6,#-14
	pea.l      -8(a6)
	pea.l      -4(a6)
	move.l     8(a6),-(a7)
	jsr        _bton(pc)
	lea.l      12(a7),a7
	move.l     d7,-12(a6)
	tst.l      -4(a6)
	beq.s      _lexint_1
	tst.l      -8(a6)
	bne.s      _lexint_2
	tst.l      -12(a6)
	bge.s      _lexint_3
_lexint_2:
	moveq.l    #25,d7 LULNUM
	bra.s      _lexint_4
_lexint_3:
	moveq.l    #21,d7 LLNUM
_lexint_4:
	move.b     d7,-13(a6)
	bra.s      _lexint_5
_lexint_1:
	tst.l      -8(a6)
	beq.s      _lexint_6
	moveq.l    #26,d7 LUSNUM
	bra.s      _lexint_7
_lexint_6:
	moveq.l    #22,d7 LSNUM
_lexint_7:
	move.b     d7,-13(a6)
_lexint_5:
	pea.l      -12(a6)
	move.b     -13(a6),d7
	ext.w      d7
	ext.l      d7
	move.l     d7,-(a7)
	move.l     #$00025EE2,-(a7)
	jsr        _putcode "c4"
	lea.l      12(a7),a7
	movea.l    8(a6),a2
	move.l     (a2),d7
	unlk       a6
	rts

_lexpunct:
	link       a6,#-4
	pea.l      8(a6)
	jsr        _dopunct
	addq.l     #4,a7
	move.l     d7,(a7)
	move.l     #$00025EE6,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	move.l     8(a6),d7
	unlk       a6
	rts

_lexstrin:
	link       a6,#-514
	movem.l    d0/a5,-(a7)
	movea.l    8(a6),a5
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	pea.l      -514(a6)
	jsr        _dobesc
	addq.l     #8,a7
	move.w     d7,-2(a6)
	move.w     -2(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	pea.l      -513(a6)
	pea.l      -2(a6)
	pea.l      ($00000017).w
	move.l     #$00025EE8,-(a7)
	jsr        _putcode "c2b"
	lea.l      16(a7),a7
	move.l     (a5),d7
	movem.l    (a7)+,d0/a5
	unlk       a6
	rts

_lexxstr:
	link       a6,#-2
	movem.l    d0/a5,-(a7)
	movea.l    8(a6),a5
	move.l     12(a5),d7
	add.l      20(a5),d7
	move.w     d7,-2(a6)
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	move.l     12(a5),-(a7)
	move.l     8(a5),-(a7)
	pea.l      -2(a6)
	pea.l      ($00000017).w
	move.l     #$00025EEC,-(a7)
	jsr        _putcode "c2bb"
	lea.l      24(a7),a7
	move.l     (a5),d7
	movem.l    (a7)+,d0/a5
	unlk       a6
	rts

_putcode:
	link       a6,#-2
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a4
	lea.l      12(a6),a2
	movea.l    a2,a5
_putcode_6:
	tst.b      (a4)
	beq.s      _putcode_1
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0063,d7
	bne.s      _putcode_2
	move.w     $00026666,d7
	ext.l      d7
	cmpi.w     #$0200,d7
	bge.s      _putcode_3
	move.w     $00026666,d7
	ext.l      d7
	movea.l    d7,a2
	addq.w     #1,$00026666
	adda.l     #$0002666E,a2
	move.l     (a5)+,d7
	andi.l     #$000000FF,d7
	move.b     d7,(a2)
	clr.l      d7
	move.b     (a2),d7
	bra.s      _putcode_4
_putcode_3:
	move.l     (a5)+,d7
	andi.l     #$000000FF,d7
	move.l     d7,(a7)
	move.l     #_stdout,-(a7)
	jsr        _putc
	addq.l     #4,a7
_putcode_4:
	bra.s      _putcode_5
_putcode_1:
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_putcode_5:
	addq.l     #1,a4
	bra.s      _putcode_6
_putcode_2:
	movea.l    (a5),a3
	move.l     a5,d7
	addq.l     #4,d7
	movea.l    d7,a5
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0062,d7
	bne.s      _putcode_7
	move.l     (a5)+,d7
	bra.s      _putcode_8
_putcode_7:
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0070,d7
	bne.s      _putcode_9
	move.l     a3,(a7)
	jsr        _lenstr
	bra.s      _putcode_8
_putcode_9:
	moveq.l    #-48,d7
	clr.l      d6
	move.b     (a4),d6
	add.l      d6,d7
_putcode_8:
	move.w     d7,-2(a6)
_putcode_12:
	subq.w     #1,-2(a6)
	blt.s      _putcode_5
	move.w     $00026666,d7
	ext.l      d7
	cmpi.w     #$0200,d7
	bge.s      _putcode_10
	move.w     $00026666,d7
	ext.l      d7
	movea.l    d7,a2
	addq.w     #1,$00026666
	adda.l     #$0002666E,a2
	clr.l      d7
	move.b     (a3)+,d7
	andi.l     #$000000FF,d7
	move.b     d7,(a2)
	clr.l      d7
	move.b     (a2),d7
	bra.s      _putcode_11
_putcode_10:
	clr.l      d7
	move.b     (a3)+,d7
	andi.l     #$000000FF,d7
	move.l     d7,(a7)
	move.l     #_stdout,-(a7)
	jsr        _putc
	addq.l     #4,a7
_putcode_11:
	bra.s      _putcode_12

; XXX V3.2 different
_putfile:
	link       a6,#-4
	tst.l      _xflag
	beq.s      _putfile_1
	tst.l      _pincl
	beq.s      _putfile_1
	tst.l      _pflag
	beq.s      _putfile_1
	tst.w      _inincl
	beq.s      _putfile_2
	tst.l      _liflag
	bne.s      _putfile_2
_putfile_1:
	unlk       a6
	rts
_putfile_2:
	tst.l      _pasline
	bne.s      _putfile_1
	clr.l      _pflag
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	bne.s      _putfile_3
	clr.l      (a7)
	pea.l      ($00000013).w
	move.l     #$00025EF6,-(a7)
	jsr        _putcode(pc) "cc"
	addq.l     #8,a7
	bra.s      _putfile_1
_putfile_3:
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),(a7)
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _lenstr
	addq.l     #4,a7
	move.l     d7,-(a7)
	pea.l      ($00000013).w
	move.l     #$00025EF2,-(a7)
	jsr        _putcode(pc) "ccp"
	lea.l      12(a7),a7
	bra.s      _putfile_1

_putls:
	link       a6,#-4
	movem.l    d0/d5/a3-a5,-(a7)
	movea.l    8(a6),a5
	tst.l      _xflag
	bne.s      _putls_1
	movea.l    a5,a4
	clr.l      -4(a6)
_putls_10:
	move.l     a4,d7
	beq.s      _putls_2
	tst.l      -4(a6)
	bne.s      _putls_3
	cmpi.l     #$00000008,4(a4)
	beq.s      _putls_4
	bra.s      _putls_3
_putls_3:
	tst.l      -4(a6)
	beq.s      _putls_7
	cmpi.l     #$00000008,4(a4)
	beq.s      _putls_7
_putls_4:
	tst.l      -4(a6)
	bne.s      _putls_8
	moveq.l    #1,d7
	bra.s      _putls_9
_putls_8:
	clr.l      d7
_putls_9:
	move.l     d7,-4(a6)
	pea.l      ($00000001).w
	move.l     #$00025F37,-(a7) "\""
	jsr        _putlin
	addq.l     #8,a7
_putls_7:
	move.l     12(a4),(a7)
	move.l     8(a4),-(a7)
	jsr        _putlin
	addq.l     #4,a7
	move.l     20(a4),(a7)
	move.l     16(a4),-(a7)
	jsr        _putlin
	addq.l     #4,a7
	movea.l    (a4),a4
	bra.s      _putls_10
_putls_2:
	movem.l    (a7)+,d0/d5/a3-a5
	unlk       a6
	rts
_putls_1:
	movea.l    a5,a4
_putls_6:
	cmpi.l     #$00000007,4(a4)
	bne.s      _putls_5
	movea.l    (a4),a4
	bra.s      _putls_6
_putls_5:
	jsr        _putfile(pc)
	jsr        _ptline
_putls_11:
	cmpi.l     #$00000002,4(a5)
	beq.s      _putls_2
	move.l     4(a5),d7
	lea.l      $00025EFA,a0
	jmp        a.switch
case PIDENT:
	move.l     a5,(a7)
	jsr        _lexident(pc)
	movea.l    d7,a5
	bra.s      _putls_11
	bra.s      _putls_11
case PSTRING:
	move.l     a5,(a7)
	jsr        _lexstrin(pc)
	movea.l    d7,a5
	bra.s      _putls_11
case 8:
	move.l     a5,(a7)
	jsr        _lexxstr(pc)
	movea.l    d7,a5
	bra.s      _putls_11
case PCHCON:
	move.l     a5,(a7)
	jsr        _lexchars(pc)
	movea.l    d7,a5
	bra.s      _putls_11
case PNUM:
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	tst.l      (a2)
	bne.s      _putls_12
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _putls_12
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_12
	movea.l    (a5),a2
	tst.l      (a2)
	beq.s      _putls_13
	lea.l      ($0000000C).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	tst.l      (a2)
	bne.s      _putls_13
	lea.l      ($00000014).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _putls_13
	lea.l      ($00000010).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_13
_putls_12:
	move.l     #$00025F32,(a7) "eExX"
	move.l     20(a5),-(a7)
	move.l     16(a5),-(a7)
	jsr        _inbuf
	addq.l     #8,a7
	move.l     d7,d5
	cmp.l      20(a5),d5
	bcc.s      _putls_14
	movea.l    16(a5),a2
	adda.l     d5,a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0065,d7
	beq.s      _putls_13
	movea.l    16(a5),a2
	adda.l     d5,a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0045,d7
	bne.s      _putls_14
_putls_13:
	move.l     a5,(a7)
	jsr        _lexfloat(pc)
	movea.l    d7,a5
	bra        _putls_11
_putls_14:
	move.l     a5,(a7)
	jsr        _lexint(pc)
	movea.l    d7,a5
	bra        _putls_11
case 7:
	movea.l    (a5),a5
	bra        _putls_11
default:
	cmpi.l     #$00000001,20(a5)
	bne.s      _putls_15
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_15
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	tst.l      (a2)
	bne.s      _putls_15
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000004,(a2)
	bne.s      _putls_15
	move.l     a5,(a7)
	jsr        _lexfloat(pc)
	movea.l    d7,a5
	bra        _putls_11
_putls_15:
	move.l     a5,(a7)
	jsr        _lexpunct(pc)
	movea.l    d7,a5
	bra        _putls_11

_getex:
	link       a6,#0
	movem.l    d0/d5/a5,-(a7)
	move.l     8(a6),(a7)
	jsr        _getinl
	movea.l    d7,a5
	move.l     a5,d7
	beq.s      _getex_1
	cmpi.l     #$00000001,20(a5)
	bne.s      _getex_2
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmp.l      _pchar,d7
	beq.s      _getex_3
	bra.s      _getex_2
_getex_1:
	move.l     a5,d7
	movem.l    (a7)+,d0/d5/a5
	unlk       a6
	rts
_getex_2:
	cmpi.l     #$00000001,20(a5)
	bne.s      _getex_4
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmp.l      _schar,d7
	bne.s      _getex_4
_getex_3:
	tst.l      8(a6)
	beq.s      _getex_5
	move.l     #$000261FE,(a7) "#line inside macro"
	jsr        _p0error
	bra.s      _getex_5
_getex_4:
	move.l     4(a5),d7
	lea.l      $000261AE,a0
	jmp        a.switch
_getex_5:
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	pea.l      ($00000018).w
	move.l     #_pptab,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	move.l     d7,d5
	beq.s      _getex_6
	move.l     (a5),(a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	movea.l    d7,a5
	move.l     d5,4(a5)
	bra.s      _getex_4
_getex_6:
	moveq.l    #20,d0
	move.l     d0,4(a5)
	bra.s      _getex_4
case PINCLUD:
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	bra        _getex_1
	bra        _getex_1
case PDEFINE:
	bra        _getex_1
case PUNDEF:
	bra        _getex_1
case PSHARP:
	bra        _getex_1
case PELIF:
case PIF:
	addq.w     #1,_inif
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	subq.w     #1,_inif
	bra        _getex_1
case PIFDEF:
case PIFNDEF:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	beq.s      _getex_7
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	move.l     #$000261F6,-(a7) "bad #%b"
	jsr        _p0error
	addq.l     #8,a7
	bra        _getex_1
_getex_7:
	clr.l      (a7)
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _lookup
	addq.l     #8,a7
	tst.l      d7
	bne        _getex_1
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	pea.l      ($00000003).w
	move.l     #_bltintab,-(a7)
	jsr        _scntab
	lea.l      12(a7),a7
	tst.l      d7
	bne        _getex_1
	clr.l      (a7)
	move.l     (a5),-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	move.l     d7,(a5)
	bra        _getex_1
default:
	tst.l      8(a6)
	bne        _getex_1
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	bra        _getex_1

; XXX V3.2 different
_getinl:
	link       a6,#-8
	tst.l      getinl.linebuf
	bne.s      _getinl_1
	clr.l      (a7)
	pea.l      ($00000200).w
	jsr        _alloc
	addq.l     #4,a7
	move.l     d7,getinl.linebuf
_getinl_1:
	tst.l      8(a6)
	bne.s      _getinl_2
	clr.l      $00026216
_getinl_2:
	tst.l      _pincl
	bne.s      _getinl_3
	jsr        _nxtfile
	move.l     d7,_pincl
_getinl_3:
	tst.l      _pincl
	bne.s      _getinl_4
	clr.l      d7
	unlk       a6
	rts
_getinl_4:
	move.l     #$00000200,d7
	sub.l      getlin.bufstart,d7
	move.l     d7,(a7)
	move.l     getinl.linebuf,d7
	add.l      getlin.bufstart,d7
	move.l     d7,-(a7)
	move.l     _pincl,-(a7)
	jsr        _getln
	addq.l     #8,a7
	move.l     d7,-4(a6)
	beq.s      _getinl_5
	move.l     -4(a6),d7
	add.l      d7,getlin.bufstart
	move.l     #$00026212,(a7)
	move.l     getlin.bufstart,d7
	sub.l      -4(a6),d7
	add.l      getinl.linebuf,d7
	move.l     d7,-(a7)
	jsr        _stotl
	addq.l     #4,a7
	unlk       a6
	rts
_getinl_5:
	tst.l      $00026212
	beq.s      _getinl_6
	move.l     #$00026220,(a7) "unbalanced comment in file"
	jsr        _p0error
	clr.l      $00026212
	clr.l      (a7)
	move.l     #$0002621E,-(a7) "\n"
	jsr        _stotl
	addq.l     #4,a7
	unlk       a6
	rts
_getinl_6:
	movea.l    _pincl,a2
	addq.l     #8,a2
	addq.w     #1,(a2)
	jsr        _ptline
	moveq.l    #10,d7
	add.l      _pincl,d7
	move.l     d7,(a7)
	jsr        _fclose
	clr.l      (a7)
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _free
	addq.l     #4,a7
	movea.l    _pincl,a2
	move.l     (a2),(a7)
	move.l     _pincl,-(a7)
	jsr        _free
	addq.l     #4,a7
	move.l     d7,_pincl
	moveq.l    #1,d0
	move.l     d0,_pflag
	jsr        _putfile
	tst.w      _inincl
	beq        _getinl_2
	subq.w     #1,_inincl
	bra        _getinl_2

_getln:
	link       a6,#0
	movem.l    d0/d5/a4-a5,-(a7)
	movea.l    12(a6),a5
	subq.l     #1,16(a6)
	movea.l    a5,a4
_getln_5:
	move.l     16(a6),d7
	move.l     a4,d6
	sub.l      a5,d6
	sub.l      d6,d7
	move.l     d7,(a7)
	move.l     a4,-(a7)
	moveq.l    #10,d7
	add.l      8(a6),d7
	move.l     d7,-(a7)
	jsr        _getl
	addq.l     #8,a7
	move.l     d7,d5
	ble.s      _getln_1
	movea.l    8(a6),a2
	addq.l     #8,a2
	addq.w     #1,(a2)
	movea.l    8(a6),a2
	addq.l     #8,a2
	move.w     (a2),_lineno
	adda.l     d5,a4
	cmpi.l     #$00000001,d5
	blt.s      _getln_1
	clr.l      d7
	move.b     -2(a4),d7
	cmpi.w     #$005C,d7
	bne.s      _getln_1
	clr.l      d7
	move.b     -1(a4),d7
	cmpi.w     #$000A,d7
	beq.s      _getln_2
_getln_1:
	clr.b      (a4)
	move.l     a5,d7
	add.l      16(a6),d7
	cmpa.l     d7,a4
	bcc.s      _getln_3
	move.l     a4,d7
	sub.l      a5,d7
	bra.s      _getln_4
_getln_2:
	subq.l     #2,a4
	bra.s      _getln_5
_getln_3:
	move.l     #$0002623C,(a7) "folded line"
	jsr        _p0error
	movea.l    a5,a2
	adda.l     16(a6),a2
	move.b     #$0A,(a2)
	move.l     16(a6),d7
	addq.l     #1,d7
_getln_4:
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts

_main:
	link       a6,#-2
	movem.l    d0/a5,-(a7)
	move.l     12(a6),_argv
	move.l     8(a6),_argc
	move.l     #_xflag,(a7)
	move.l     #_schar,-(a7)
	move.l     #_stdflag,-(a7)
	move.l     #_pchar,-(a7)
	move.l     #_pasflag,-(a7)
	move.l     #_ofile,-(a7)
	move.l     #_oldflag,-(a7)
	move.l     #_mapfile,-(a7)
	move.l     #_liflag,-(a7)
	move.l     #_iprefix,-(a7)
	move.l     #_errflag,-(a7)
	move.l     #_pdefs,-(a7)
	move.l     #$0002629A,-(a7) "d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>"
	move.l     #_argv,-(a7)
	move.l     #_argc,-(a7)
	jsr        _getflags
	lea.l      56(a7),a7
	tst.l      _ofile
	bne.s      _main_1
	move.w     #$0001,-2(a6)
	bra.s      _main_2
_main_1:
	tst.l      _xflag
	beq.s      _main_3
	moveq.l    #1,d7
	bra.s      _main_4
_main_3:
	clr.l      d7
_main_4:
	move.l     d7,(a7)
	pea.l      ($00000001).w
	move.l     _ofile,-(a7)
	jsr        _create
	addq.l     #8,a7
	move.w     d7,-2(a6)
	bge.s      _main_5
	move.l     _ofile,(a7)
	move.l     #$0002628C,-(a7) "can't create "
	jsr        _error
	addq.l     #4,a7
	bra.s      _main_2
_main_5:
	move.w     #$0001,_errfd
_main_2:
	pea.l      ($00000001).w
	move.w     -2(a6),d7
	ext.l      d7
	move.l     d7,-(a7)
	move.l     #_stdout,-(a7)
	jsr        _finit
	lea.l      12(a7),a7
	tst.l      _xflag
	beq.s      _main_6
	tst.l      _oldflag
	bne.s      _main_6
	move.l     #$000000BD,(a7)
	move.l     #$0002628A,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	move.l     _argc,d7
	asl.l      #2,d7
	movea.l    d7,a2
	subq.l     #4,a2
	adda.l     _argv,a2
	move.l     (a2),(a7)
	move.l     _argc,d7
	asl.l      #2,d7
	movea.l    d7,a2
	subq.l     #4,a2
	adda.l     _argv,a2
	move.l     (a2),-(a7)
	jsr        _lenstr
	addq.l     #4,a7
	move.l     d7,-(a7)
	pea.l      ($00000013).w
	move.l     #$00026286,-(a7)
	jsr        _putcode "ccp"
	lea.l      12(a7),a7
_main_6:
	jsr        _nxtfile
	move.l     d7,_pincl
	jsr        _putfile
	move.l     #_pdefs,(a7)
	jsr        _predef
	tst.l      _mapfile
	beq.s      _main_7
	pea.l      ($00000001).w
	clr.l      -(a7)
	move.l     _mapfile,-(a7)
	jsr        _open
	lea.l      12(a7),a7
	move.w     d7,-2(a6)
	bge.s      _main_8
	move.l     _mapfile,(a7)
	move.l     #$0002626E,-(a7) "can't open map file: %p"
	jsr        _fatal
	addq.l     #4,a7
	bra.s      _main_7
_main_8:
	move.l     #$00000100,(a7)
	move.l     #_cmap,-(a7)
	move.w     -2(a6),d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        _fread
	addq.l     #8,a7
	cmpi.l     #$00000100,d7
	beq.s      _main_9
	move.l     _mapfile,(a7)
	move.l     #$00026256,-(a7) "can't read map file: %p"
	jsr        _fatal
	addq.l     #4,a7
	bra.s      _main_7
_main_9:
	move.w     -2(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	jsr        _close
_main_7:
	clr.l      (a7)
	clr.l      -(a7)
	jsr        _getex(pc)
	addq.l     #4,a7
	move.l     d7,-(a7)
	jsr        _putgr
	addq.l     #4,a7
	movea.l    d7,a5
	move.l     a5,d7
	beq.s      _main_10
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	move.l     #$00026248,-(a7) "misplaced #%b"
	jsr        _p0error
	addq.l     #8,a7
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	bra.s      _main_7
_main_10:
	move.l     #_stdout,(a7)
	jsr        _fclose
	tst.w      _nerrors
	beq.s      _main_11
	tst.l      _errflag
	beq.s      _main_12
_main_11:
	moveq.l    #1,d7
	bra.s      _main_13
_main_12:
	clr.l      d7
_main_13:
	movem.l    (a7)+,d0/a5
	unlk       a6
	rts

_putgr:
	link       a6,#0
	movem.l    d0/d4-d5/a5,-(a7)
	movea.l    8(a6),a5
	move.l     12(a6),d5
_putgr_9:
	move.l     a5,d7
	beq.s      _putgr_1
	cmpi.l     #$0000000C,4(a5)
	beq.s      _putgr_1
	cmpi.l     #$0000000D,4(a5)
	beq.s      _putgr_1
	cmpi.l     #$0000000B,4(a5)
	beq.s      _putgr_1
	cmpi.l     #$0000000E,4(a5)
	beq.s      _putgr_2
	cmpi.l     #$0000000F,4(a5)
	beq.s      _putgr_2
	cmpi.l     #$00000010,4(a5)
	beq.s      _putgr_2
	tst.l      d5
	beq.s      _putgr_3
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	bra.s      _putgr_4
_putgr_1:
	move.l     a5,d7
	movem.l    (a7)+,d0/d4-d5/a5
	unlk       a6
	rts
_putgr_2:
	cmpi.l     #$0000000E,4(a5)
	bne.s      _putgr_5
	tst.l      d5
	beq.s      _putgr_6
	clr.l      d7
	bra.s      _putgr_7
_putgr_6:
	move.l     (a5),(a7)
	jsr        _eval
_putgr_7:
	move.l     d7,d4
	bra.s      _putgr_8
_putgr_3:
	move.l     a5,(a7)
	jsr        _putns
_putgr_4:
	clr.l      (a7)
	jsr        _getex(pc)
	movea.l    d7,a5
	bra        _putgr_9
_putgr_5:
	cmpi.l     #$0000000F,4(a5)
	bne.s      _putgr_10
	tst.l      (a5)
	beq.s      _putgr_11
	moveq.l    #1,d7
	bra.s      _putgr_12
_putgr_11:
	clr.l      d7
_putgr_12:
	move.l     d7,d4
	bra.s      _putgr_8
_putgr_10:
	tst.l      (a5)
	bne.s      _putgr_13
	moveq.l    #1,d7
	bra.s      _putgr_14
_putgr_13:
	clr.l      d7
_putgr_14:
	move.l     d7,d4
_putgr_8:
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	tst.l      d5
	bne.s      _putgr_15
	tst.l      d4
	bne.s      _putgr_16
_putgr_15:
	moveq.l    #1,d7
	bra.s      _putgr_17
_putgr_16:
	clr.l      d7
_putgr_17:
	move.l     d7,(a7)
	clr.l      -(a7)
	jsr        _getex(pc)
	addq.l     #4,a7
	move.l     d7,-(a7)
	jsr        _putgr(pc)
	addq.l     #4,a7
	movea.l    d7,a5
_putgr_25:
	move.l     a5,d7
	beq.s      _putgr_18
	cmpi.l     #$0000000B,4(a5)
	bne.s      _putgr_18
	tst.l      d4
	bne        _putgr_19
	tst.l      d5
	beq.s      _putgr_20
	clr.l      d7
	bra.s      _putgr_21
_putgr_20:
	move.l     (a5),(a7)
	jsr        _eval
_putgr_21:
	move.l     d7,d4
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	tst.l      d5
	bne.s      _putgr_22
	tst.l      d4
	bne.s      _putgr_23
_putgr_22:
	moveq.l    #1,d7
	bra.s      _putgr_24
_putgr_23:
	clr.l      d7
_putgr_24:
	move.l     d7,(a7)
	clr.l      -(a7)
	jsr        _getex(pc)
	addq.l     #4,a7
	move.l     d7,-(a7)
	jsr        _putgr(pc)
	addq.l     #4,a7
	movea.l    d7,a5
	bra.s      _putgr_25
_putgr_18:
	move.l     a5,d7
	beq.s      _putgr_26
	cmpi.l     #$0000000C,4(a5)
	bne.s      _putgr_26
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	tst.l      d5
	bne.s      _putgr_27
	tst.l      d4
	beq.s      _putgr_28
_putgr_27:
	moveq.l    #1,d7
	bra.s      _putgr_29
_putgr_28:
	clr.l      d7
_putgr_29:
	move.l     d7,(a7)
	clr.l      -(a7)
	jsr        _getex(pc)
	addq.l     #4,a7
	move.l     d7,-(a7)
	jsr        _putgr(pc)
	addq.l     #4,a7
	movea.l    d7,a5
	bra.s      _putgr_26
_putgr_19:
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	tst.l      d5
	bne.s      _putgr_30
	tst.l      d4
	beq.s      _putgr_31
_putgr_30:
	moveq.l    #1,d7
	bra.s      _putgr_32
_putgr_31:
	clr.l      d7
_putgr_32:
	move.l     d7,(a7)
	clr.l      -(a7)
	jsr        _getex(pc)
	addq.l     #4,a7
	move.l     d7,-(a7)
	jsr        _putgr(pc)
	addq.l     #4,a7
	movea.l    d7,a5
	bra        _putgr_25
_putgr_26:
	move.l     a5,d7
	beq.s      _putgr_33
	cmpi.l     #$0000000D,4(a5)
	bne.s      _putgr_33
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	clr.l      (a7)
	jsr        _getex(pc)
	movea.l    d7,a5
	bra        _putgr_9
_putgr_33:
	move.l     #$000262D6,(a7) "missing #endif"
	jsr        _p0error
	bra        _putgr_9

_putns:
	link       a6,#-18
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	move.l     4(a5),d7
	lea.l      $000262E6,a0
	jmp        a.switch
case PERROR:
	move.l     a5,-4(a6)
_putns_2:
	movea.l    -4(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq.s      _putns_1
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	bra.s      _putns_2
_putns_1:
	tst.l      _xflag
	bne.s      _putns_3
	move.l     a5,(a7)
	jsr        _putls
	bra.s      _putns_4
_putns_3:
	tst.l      _oldflag
	bne.s      _putns_4
	move.l     #$000000FE,(a7)
	move.l     #$0002639D,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),d7
	sub.l      16(a5),d7
	addq.l     #2,d7
	move.w     d7,-14(a6)
	pea.l      -14(a6)
	move.l     #$0002639B,-(a7)
	jsr        _putcode "2"
	addq.l     #8,a7
	move.w     -14(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	move.l     16(a5),-(a7)
	subq.l     #1,(a7)
	move.l     #$00026399,-(a7)
	jsr        _putcode "b"
	addq.l     #8,a7
_putns_4:
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _fretlist
	addq.l     #4,a7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

case PDEFINE:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	beq.s      x25c4_1
	move.l     #$0002638D,(a7) "bad #define"
	jsr        _p0error
	bra.s      putns_4
x25c4_1:
	move.l     (a5),-4(a6)
x25c4_4:
	movea.l    -4(a6),a2
	tst.l      (a2)
	beq.s      x25c4_3
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	bra.s      x25c4_4
x25c4_3:
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),d7
	lea.l      ($00000014).w,a2
	adda.l     -4(a6),a2
	add.l      (a2),d7
	movea.l    (a5),a2
	movea.l    (a2),a2
	addq.l     #8,a2
	sub.l      (a2),d7
	move.w     d7,-14(a6)
	tst.l      _stdflag
	beq.s      x25c4_5
	clr.l      (a7)
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _lookup
	addq.l     #8,a7
	movea.l    d7,a3
	move.l     a3,d7
	bne.s      x25c4_6
x25c4_5:
	move.w     -14(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	movea.l    (a5),a2
	movea.l    (a2),a2
	addq.l     #8,a2
	move.l     (a2),-(a7)
	jsr        _buybuf
	addq.l     #4,a7
	move.l     d7,(a7)
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _install
	addq.l     #8,a7
	bra        putns_4
x25c4_6:
	move.w     -14(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	movea.l    (a5),a2
	movea.l    (a2),a2
	addq.l     #8,a2
	move.l     (a2),-(a7)
	move.l     a3,-(a7)
	jsr        _cmpbuf
	addq.l     #8,a7
	tst.l      d7
	bne        putns_4
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	move.l     #$00026380,-(a7) "redefined %b"
	jsr        _p0error
	addq.l     #8,a7
	bra        putns_4
case PUNDEF:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	beq.s      x25c4_7
	move.l     #$00026375,(a7) "bad #undef"
	jsr        _p0error
	bra        putns_4
x25c4_7:
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _undef
	addq.l     #4,a7
	bra        putns_4
case PINCLUD:
	move.l     (a5),(a7)
	jsr        _getfinclude
	movea.l    d7,a4
	tst.l      _failincl
	beq.s      x25c4_8
	move.l     a4,(a7)
	move.l     #$00026363,-(a7) "can't #include %p"
	jsr        _p0error
	addq.l     #4,a7
	clr.l      _failincl
	bra        putns_4
x25c4_8:
	clr.l      (a7)
	clr.l      -(a7)
	move.l     a4,-(a7)
	jsr        _open
	addq.l     #8,a7
	move.w     d7,-10(a6)
	bge.s      x25c4_9
	move.l     #$0002634E,(a7) "can't open #include!"
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _error
	addq.l     #4,a7
	bra        putns_4
x25c4_9:
	jsr        _ptline
	move.l     _pincl,(a7)
	pea.l      ($00000214).w
	jsr        _alloc
	addq.l     #4,a7
	move.l     d7,_pincl
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     a4,(a2)
	movea.l    _pincl,a2
	addq.l     #8,a2
	clr.w      (a2)
	clr.l      (a7)
	move.w     -10(a6),d7
	ext.l      d7
	move.l     d7,-(a7)
	moveq.l    #10,d7
	add.l      _pincl,d7
	move.l     d7,-(a7)
	jsr        _finit
	addq.l     #8,a7
	moveq.l    #1,d0
	move.l     d0,_pflag
	addq.w     #1,_inincl
	bra        putns_4
case PLINE:
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	cmpi.l     #$00000001,(a2)
	bne.s      x25c4_10
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$003D,d7
	bne.s      x25c4_10
	tst.l      _xflag
	bne.s      x25c4_11
	subq.l     #1,16(a5)
	addq.l     #1,20(a5)
	move.l     a5,(a7)
	jsr        _putls
	bra        putns_4
x25c4_10:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000004,(a2)
	beq        x25c4_12
	move.l     #$00026344,(a7) "bad #line"
	jsr        _p0error
	bra        putns_4
x25c4_11:
	movea.l    (a5),a2
	move.l     (a2),-4(a6)
	move.l     -4(a6),-8(a6)
x25c4_15:
	lea.l      ($00000014).w,a2
	adda.l     -8(a6),a2
	cmpi.l     #$00000001,(a2)
	bne.s      x25c4_13
	lea.l      ($00000010).w,a2
	adda.l     -8(a6),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$003A,d7
	beq.s      x25c4_14
x25c4_13:
	movea.l    -8(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq.s      x25c4_14
	movea.l    -8(a6),a2
	move.l     (a2),-8(a6)
	bra.s      x25c4_15
x25c4_14:
	move.l     -8(a6),d7
	cmp.l      -4(a6),d7
	beq.s      x25c4_16
	clr.l      _pasline
	lea.l      ($00000010).w,a2
	adda.l     -8(a6),a2
	move.l     (a2),d7
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	sub.l      (a2),d7
	move.l     d7,(a7)
	addq.l     #1,(a7)
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),-(a7)
	jsr        _buybuf
	addq.l     #4,a7
	move.l     d7,-18(a6)

	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     -8(a6),a2
	movea.l    (a2),a2
	suba.l     (a7),a2
	adda.l     -18(a6),a2
	clr.b      (a2)
	moveq.l    #1,d0
	move.l     d0,_pflag
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	beq.s      x25c4_17
	clr.l      (a7)
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _free
	addq.l     #4,a7
	bra.s      x25c4_17
x25c4_16:
	movea.l    -8(a6),a2
	move.l     (a2),-8(a6)
	clr.l      (a7)
	clr.l      -(a7)
	move.l     -8(a6),-(a7)
	jsr        _bton
	addq.l     #8,a7
	move.w     d7,-12(a6)
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     -12(a6),(a2)
	clr.l      _pasline
	jsr        _ptline
	moveq.l    #1,d0
	move.l     d0,_pasline
	bra        putns_4
x25c4_17:
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     -18(a6),(a2)
	jsr        _putfile
	bra.s      x25c4_16
x25c4_12:
	clr.l      (a7)
	clr.l      -(a7)
	move.l     (a5),-(a7)
	jsr        _bton
	addq.l     #8,a7
	move.w     d7,-12(a6)
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     -12(a6),(a2)
	movea.l    (a5),a2
	move.l     (a2),-4(a6)
	movea.l    -4(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq        putns_4
	movea.l    -4(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000006,(a2)
	bne.s      x25c4_18
	lea.l      ($00000014).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),(a7)
	subq.l     #1,(a7)
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),-(a7)
	addq.l     #1,(a7)
	jsr        _buybuf
	addq.l     #4,a7
	move.l     d7,-18(a6)

	lea.l      ($00000014).w,a2
	adda.l     -4(a6),a2
	movea.l    (a2),a2
	subq.l     #2,a2
	adda.l     -18(a6),a2
	clr.b      (a2)

	moveq.l    #1,d0
	move.l     d0,_pflag
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	beq.s      x25c4_19
	clr.l      (a7)
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _free
	addq.l     #4,a7
	bra.s      x25c4_19
x25c4_18:
	movea.l    -4(a6),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq.s      putns_40
	move.l     #$00026333,(a7) "bad #line syntax"
	jsr        _p0error
	bra.s      putns_40
x25c4_19:
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     -18(a6),(a2)
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	bra.s      x25c4_18
x25c4_20:
	tst.l      _xflag
	bne        putns_4
	subq.l     #1,16(a5)
	addq.l     #1,20(a5)
	move.l     a5,(a7)
	jsr        _putls
	bra        putns_4
case PPRAGMA:
	tst.l      _xflag
	bne.s      x25c4_21
	subq.l     #1,16(a5)
	addq.l     #1,20(a5)
	move.l     a5,(a7)
	jsr        _putls
	bra        putns_4
x25c4_21:
	pea.l      ($0000001D).w
	move.l     #$00026331,-(a7)
	jsr        _putcode "c"
	addq.l     #8,a7
	move.l     (a5),(a7)
	jsr        _putls
	pea.l      ($0000001D).w
	move.l     #$0002632F,-(a7)
	jsr        _putcode "c"
	addq.l     #8,a7
	bra        putns_4
case PSHARP:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq        putns_4
	move.l     #$00026326,(a7) "bad #xxx"
	jsr        _p0error
	bra        putns_4
default:
	move.l     a5,(a7)
	jsr        _putls
	bra        putns_4

_buytl:
	link       a6,#0
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	movea.l    12(a6),a4
	tst.l      $000265A0
	beq.s      _buytl_1
	movea.l    $000265A0,a3
	move.l     (a3),$000265A0
	move.l     a4,(a3)
	bra.s      _buytl_2
_buytl_1:
	move.l     a4,(a7)
	pea.l      ($00000018).w
	jsr        _alloc
	addq.l     #4,a7
	movea.l    d7,a3
_buytl_2:
	clr.l      4(a3)
	clr.l      8(a3)
	clr.l      12(a3)
	clr.l      20(a3)
	clr.l      16(a3)
	move.l     a5,d7
	beq.s      _buytl_3
	move.l     4(a5),4(a3)
	move.l     8(a5),8(a3)
	move.l     12(a5),12(a3)
	move.l     16(a5),16(a3)
	move.l     20(a5),20(a3)
_buytl_3:
	move.l     a3,d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

_fatal:
	link       a6,#-4
	move.l     12(a6),(a7)
	move.l     8(a6),-(a7)
	jsr        _p0error
	addq.l     #4,a7
	clr.l      (a7)
	jsr        _exit
	unlk       a6
	rts

_fretlist:
	link       a6,#0
	movem.l    d0/a4-a5,-(a7)
	movea.l    12(a6),a5
	movea.l    8(a6),a4
_fretlist_2:
	tst.l      (a4)
	beq.s      _fretlist_1
	move.l     (a4),d7
	cmp.l      a5,d7
	beq.s      _fretlist_1
	movea.l    (a4),a4
	bra.s      _fretlist_2
_fretlist_1:
	move.l     $000265A0,(a4)
	move.l     8(a6),$000265A0
	move.l     a5,d7
	movem.l    (a7)+,d0/a4-a5
	unlk       a6
	rts

_getfinclude:
	link       a6,#-16
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	tst.l      20(a5)
	beq.s      _getfinclude_1
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0022,d7
	beq.s      _getfinclude_2
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$003C,d7
	beq.s      _getfinclude_2
_getfinclude_1:
	moveq.l    #1,d0
	move.l     d0,_failincl
	move.l     16(a5),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_getfinclude_2:
	move.l     12(a5),d7
	neg.l      d7
	move.l     d7,-4(a6)
	movea.l    a5,a3
_getfinclude_4:
	cmpi.l     #$00000002,4(a3)
	beq.s      _getfinclude_3
	move.l     12(a3),d7
	add.l      20(a3),d7
	add.l      d7,-4(a6)
	movea.l    (a3),a3
	bra.s      _getfinclude_4
_getfinclude_3:
	clr.l      (a7)
	move.l     -4(a6),-(a7)
	jsr        _alloc
	addq.l     #4,a7
	move.l     d7,-12(a6)
	movea.l    -12(a6),a4
	movea.l    a5,a3
_getfinclude_10:
	cmpi.l     #$00000002,4(a3)
	beq.s      _getfinclude_5
	cmpa.l     a5,a3
	bne.s      _getfinclude_6
	move.l     20(a5),(a7)
	subq.l     #1,(a7)
	move.l     16(a5),-(a7)
	addq.l     #1,(a7)
	move.l     a4,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	adda.l     d7,a4
	bra.s      _getfinclude_7
_getfinclude_5:
	subq.l     #1,a4
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0022,d7
	bne.s      _getfinclude_8
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0022,d7
	bne.s      _getfinclude_9
	bra.s      _getfinclude_8
_getfinclude_11:
	movea.l    (a3),a3
	bra.s      _getfinclude_10
_getfinclude_6:
	move.l     12(a3),(a7)
	move.l     8(a3),-(a7)
	move.l     a4,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	adda.l     d7,a4
	move.l     20(a3),(a7)
	move.l     16(a3),-(a7)
	move.l     a4,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	adda.l     d7,a4
_getfinclude_7:
	cmpi.l     #$00000006,4(a3)
	bne.s      _getfinclude_11
	movea.l    (a3),a2
	addq.l     #4,a2
	cmpi.l     #$00000006,(a2)
	bne.s      _getfinclude_11
	movea.l    (a3),a3
	move.l     20(a3),(a7)
	subq.l     #1,(a7)
	move.l     16(a3),-(a7)
	addq.l     #1,(a7)
	pea.l      -1(a4)
	jsr        _cpybuf
	addq.l     #8,a7
	subq.l     #1,d7
	adda.l     d7,a4
	bra.s      _getfinclude_7
_getfinclude_8:
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$003C,d7
	bne.s      _getfinclude_12
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$003E,d7
	beq.s      _getfinclude_12
_getfinclude_9:
	moveq.l    #1,d0
	move.l     d0,_failincl
	clr.b      (a4)
	move.l     -12(a6),d7
	bra.s      _getfinclude_13
_getfinclude_12:
	clr.b      (a4)
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0022,d7
	bne.s      _getfinclude_14
	clr.l      (a7)
	clr.l      -(a7)
	move.l     -12(a6),-(a7)
	jsr        _open
	addq.l     #8,a7
	move.w     d7,-8(a6)
	blt.s      _getfinclude_14
	move.w     -8(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	jsr        _close
	move.l     -12(a6),d7
_getfinclude_13:
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_getfinclude_14:
	move.l     a4,d7
	sub.l      -12(a6),d7
	move.l     d7,-4(a6)
	movea.l    _iprefix,a4
_getfinclude_20:
	tst.b      (a4)
	beq        _getfinclude_15
	pea.l      ($0000007C).w
	move.l     a4,-(a7)
	jsr        _scnstr
	addq.l     #8,a7
	move.w     d7,-6(a6)
	clr.l      (a7)
	move.w     -6(a6),d7
	ext.l      d7
	add.l      -4(a6),d7
	move.l     d7,-(a7)
	addq.l     #1,(a7)
	jsr        _alloc
	addq.l     #4,a7
	move.l     d7,-16(a6)
	move.w     -6(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	move.l     a4,-(a7)
	move.l     -16(a6),-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	move.l     -4(a6),(a7)
	addq.l     #1,(a7)
	move.l     -12(a6),-(a7)
	move.l     -16(a6),d7
	move.w     -6(a6),d6
	ext.l      d6
	add.l      d6,d7
	move.l     d7,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	clr.l      (a7)
	clr.l      -(a7)
	move.l     -16(a6),-(a7)
	jsr        _open
	addq.l     #8,a7
	move.w     d7,-8(a6)
	blt.s      _getfinclude_16
	move.w     -8(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	jsr        _close
	move.l     -16(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        _free
	addq.l     #4,a7
	bra.s      _getfinclude_17
_getfinclude_15:
	moveq.l    #1,d0
	move.l     d0,_failincl
	move.l     -12(a6),d7
_getfinclude_17:
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_getfinclude_16:
	clr.l      (a7)
	move.l     -16(a6),-(a7)
	jsr        _free
	addq.l     #4,a7
	movea.l    a4,a2
	move.w     -6(a6),d7
	ext.l      d7
	adda.l     d7,a2
	tst.b      (a2)
	beq.s      _getfinclude_18
	move.w     -6(a6),d7
	ext.l      d7
	addq.l     #1,d7
	bra.s      _getfinclude_19
_getfinclude_18:
	move.w     -6(a6),d7
	ext.l      d7
_getfinclude_19:
	adda.l     d7,a4
	bra        _getfinclude_20

_hash:
	link       a6,#0
	movem.l    d0/d4-d5/a5,-(a7)
	movea.l    8(a6),a5
	move.l     12(a6),d5
	cmpi.l     #$00000008,d5
	bls.s      _hash_1
	moveq.l    #8,d5
_hash_1:
	clr.l      d4
_hash_3:
	tst.l      d5
	beq.s      _hash_2
	clr.l      d7
	move.b     (a5)+,d7
	add.l      d7,d4
	subq.l     #1,d5
	bra.s      _hash_3
_hash_2:
	move.l     d4,(a7)
	pea.l      (_exit).w
	jsr        a.lmod
	move.l     (a7),d7
	asl.l      #2,d7
	addi.l     #$000263A0,d7
	movem.l    (a7)+,d0/d4-d5/a5
	unlk       a6
	rts

_install:
	link       a6,#0
	movem.l    d0/d5/a4-a5,-(a7)
	move.l     12(a6),d5
	cmpi.l     #$0000007F,d5
	bcc.s      _install_1
	move.l     d5,d7
	bra.s      _install_2
_install_1:
	moveq.l    #127,d7
_install_2:
	move.l     d7,d5
	move.l     d5,(a7)
	move.l     8(a6),-(a7)
	jsr        _hash(pc)
	addq.l     #4,a7
	movea.l    d7,a5
	move.l     (a5),(a7)
	move.l     d5,-(a7)
	addi.l     #$00000010,(a7)
	jsr        _alloc
	addq.l     #4,a7
	movea.l    d7,a4
	move.l     a4,(a5)
	clr.l      12(a4)
	move.l     d5,(a7)
	move.l     8(a6),-(a7)
	pea.l      16(a4)
	jsr        _cpybuf
	addq.l     #8,a7
	move.l     d5,8(a4)
	move.l     16(a6),4(a4)
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts

_lookup:
	link       a6,#0
	movem.l    d0/d5/a4-a5,-(a7)
	movea.l    8(a6),a5
	move.l     12(a6),d5
	cmpi.l     #$0000007F,d5
	bcc.s      _lookup_1
	move.l     d5,d7
	bra.s      _lookup_2
_lookup_1:
	moveq.l    #127,d7
_lookup_2:
	move.l     d7,d5
	move.l     d5,(a7)
	move.l     a5,-(a7)
	jsr        _hash(pc)
	addq.l     #4,a7
	movea.l    d7,a2
	movea.l    (a2),a4
_lookup_7:
	move.l     a4,d7
	beq.s      _lookup_3
	tst.l      12(a4)
	bne.s      _lookup_4
	cmp.l      8(a4),d5
	bne.s      _lookup_4
	move.l     d5,(a7)
	pea.l      16(a4)
	move.l     a5,-(a7)
	jsr        _cmpbuf
	addq.l     #8,a7
	tst.l      d7
	beq.s      _lookup_4
	tst.l      16(a6)
	beq.s      _lookup_5
	movea.l    16(a6),a2
	move.l     a4,(a2)
	bra.s      _lookup_5
_lookup_3:
	clr.l      d7
	bra.s      _lookup_6
_lookup_4:
	movea.l    (a4),a4
	bra.s      _lookup_7
_lookup_5:
	move.l     4(a4),d7
_lookup_6:
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts

_nxtfile:
	link       a6,#0
	movem.l    d0/d5/a5,-(a7)
	pea.l      ($00000002).w
	clr.l      -(a7)
	move.l     #_argv,-(a7)
	move.l     #_argc,-(a7)
	jsr        _getfiles
	lea.l      16(a7),a7
	move.l     d7,d5
	cmpi.l     #$00000002,d5
	bne.s      _nxtfile_1
	clr.l      _argc
	movea.l    _argv,a2
	subq.l     #4,a2
	move.l     (a2),(a7)
	move.l     #$000265A4,-(a7) "can't open %p"
	jsr        _fatal(pc)
	addq.l     #4,a7
_nxtfile_1:
	tst.l      d5
	bge.s      _nxtfile_2
	clr.l      d7
	bra.s      _nxtfile_3
_nxtfile_2:
	clr.l      (a7)
	pea.l      ($00000214).w
	jsr        _alloc
	addq.l     #4,a7
	movea.l    d7,a5
	tst.l      d5
	bne.s      _nxtfile_4
	clr.l      4(a5)
	bra.s      _nxtfile_5
_nxtfile_4:
	movea.l    _argv,a2
	subq.l     #4,a2
	move.l     (a2),(a7)
	jsr        _lenstr
	move.l     d7,(a7)
	addq.l     #1,(a7)
	movea.l    _argv,a2
	subq.l     #4,a2
	move.l     (a2),-(a7)
	jsr        _buybuf
	addq.l     #4,a7
	move.l     d7,4(a5)
_nxtfile_5:
	moveq.l    #1,d0
	move.l     d0,_pflag
	clr.w      8(a5)
	clr.l      (a7)
	move.l     d5,-(a7)
	pea.l      10(a5)
	jsr        _finit
	addq.l     #8,a7
	move.l     a5,d7
_nxtfile_3:
	movem.l    (a7)+,d0/d5/a5
	unlk       a6
	rts

_perrfmt:
	link       a6,#-14
	movem.l    d0/a3-a5,-(a7)
	lea.l      12(a6),a2
	movea.l    a2,a5
	movea.l    8(a6),a4
_perrfmt_8:
	tst.b      (a4)
	beq.s      _perrfmt_1
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0025,d7
	beq.s      _perrfmt_2
	pea.l      ($00000001).w
	move.l     a4,-(a7)
	move.w     _errfd,d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        _write
	lea.l      12(a7),a7
	movea.l    _perr,a2
	addq.l     #1,_perr
	move.b     (a4),(a2)
	bra        _perrfmt_3
_perrfmt_1:
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts
_perrfmt_2:
	addq.l     #1,a4
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0063,d7
	bne.s      _perrfmt_4
	move.l     (a5)+,d0
	move.b     d0,-14(a6)
	pea.l      ($00000001).w
	pea.l      -14(a6)
	move.w     _errfd,d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        _write
	lea.l      12(a7),a7
	movea.l    _perr,a2
	addq.l     #1,_perr
	move.b     -14(a6),(a2)
	bra        _perrfmt_3
_perrfmt_4:
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0073,d7
	bne.s      _perrfmt_5
	pea.l      ($0000000A).w
	move.l     (a5)+,-(a7)
	pea.l      -14(a6)
	jsr        _itob
	lea.l      12(a7),a7
	move.l     d7,-4(a6)
	lea.l      -14(a6),a2
	adda.l     -4(a6),a2
	clr.b      (a2)
	move.l     -4(a6),(a7)
	pea.l      -14(a6)
	move.w     _errfd,d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        _write
	addq.l     #8,a7
	move.l     -4(a6),(a7)
	pea.l      -14(a6)
	move.l     _perr,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	add.l      d7,_perr
	bra.s      _perrfmt_3
_perrfmt_5:
	movea.l    (a5),a3
	move.l     a5,d7
	addq.l     #4,d7
	movea.l    d7,a5
	clr.l      d7
	move.b     (a4),d7
	cmpi.w     #$0062,d7
	bne.s      _perrfmt_6
	move.l     (a5)+,d7
	bra.s      _perrfmt_7
_perrfmt_6:
	move.l     a3,(a7)
	jsr        _lenstr
_perrfmt_7:
	move.l     d7,-4(a6)
	move.l     -4(a6),(a7)
	move.l     a3,-(a7)
	move.w     _errfd,d7
	ext.l      d7
	move.l     d7,-(a7)
	jsr        _write
	addq.l     #8,a7
	move.l     -4(a6),(a7)
	move.l     a3,-(a7)
	move.l     _perr,-(a7)
	jsr        _cpybuf
	addq.l     #8,a7
	add.l      d7,_perr
_perrfmt_3:
	addq.l     #1,a4
	bra        _perrfmt_8

_p0error:
	link       a6,#-8
	move.l     #$00025FCA,_perr _errbuf+2
	move.l     _argc,d7
	asl.l      #2,d7
	movea.l    d7,a2
	subq.l     #4,a2
	adda.l     _argv,a2
	tst.l      (a2)
	bne.s      _p0error_1
	move.l     #$000265D4,(a7) "EOF: "
	jsr        _perrfmt(pc)
	bra.s      _p0error_2
_p0error_1:
	move.l     #$000265B7,(a7) "\t"
	tst.l      _pincl
	beq.s      _p0error_3
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     (a2),d7
	ext.l      d7
	bra.s      _p0error_4
_p0error_3:
	move.w     _lineno,d7
	ext.l      d7
_p0error_4:
	move.l     d7,-(a7)
	move.l     #$000265B9,-(a7) ":"
	tst.l      _pincl
	beq.s      _p0error_5
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),d7
	bra.s      _p0error_6
_p0error_5:
	move.l     _argc,d7
	asl.l      #2,d7
	movea.l    d7,a2
	subq.l     #4,a2
	adda.l     _argv,a2
	move.l     (a2),d7
_p0error_6:
	move.l     d7,-(a7)
	move.l     #$000265BB,-(a7) " "
	move.l     __pname,-(a7)
	move.l     #$000265BD,-(a7) "#error "
	move.l     #$000265C5,-(a7) "%p%p%p%p%p%s%p"
	jsr        _perrfmt(pc)
	lea.l      28(a7),a7
_p0error_2:
	move.l     16(a6),(a7)
	move.l     12(a6),-(a7)
	move.l     8(a6),-(a7)
	jsr        _perrfmt(pc)
	addq.l     #8,a7
	move.l     #$000265B5,(a7) "\n"
	jsr        _perrfmt(pc)
	addq.w     #1,_nerrors
	movea.l    _perr,a2
	clr.b      (a2)
	move.l     _perr,d7
	subi.l     #_errbuf,d7
	subq.l     #2,d7
	move.l     d7,-4(a6)
	pea.l      ($00000002).w
	pea.l      -4(a6)
	move.l     #_errbuf,-(a7)
	jsr        _cpybuf
	lea.l      12(a7),a7
	addq.l     #2,-4(a6)
	tst.l      _xflag
	beq.s      _p0error_7
	move.l     -4(a6),(a7)
	move.l     #_errbuf,-(a7)
	pea.l      ($000000FE).w
	move.l     #$000265B2,-(a7)
	jsr        _putcode "cb"
	lea.l      12(a7),a7
_p0error_7:
	unlk       a6
	rts

_predef:
	link       a6,#-8
	movem.l    d0/d4-d5/a3-a5,-(a7)
	movea.l    8(a6),a5
	clr.w      -2(a6)
_predef_7:
	move.l     (a5),d7
	moveq.l    #10,d6
	move.w     -2(a6),d4
	ext.l      d4
	sub.l      d4,d6
	cmp.l      d6,d7
	bcc.s      _predef_1
	moveq.l    #9,d7
	move.w     -2(a6),d6
	ext.l      d6
	sub.l      d6,d7
	asl.l      #2,d7
	movea.l    d7,a2
	lea.l      4(a5),a3
	adda.l     a3,a2
	movea.l    (a2),a4
	move.l     #$000265EE,(a7)
	move.l     a4,-(a7)
	jsr        _instr
	addq.l     #4,a7
	move.l     d7,d5
	tst.b      0(a4,d5.l)
	bne.s      _predef_2
	move.w     #$0003,-4(a6)
	move.l     #$000265EA,-8(a6)
	bra.s      _predef_3
_predef_1:
	movem.l    (a7)+,d0/d4-d5/a3-a5
	unlk       a6
	rts
_predef_2:
	clr.l      d7
	move.b     0(a4,d5.l),d7
	cmpi.w     #$003D,d7
	bne.s      _predef_4
	move.b     #$20,0(a4,d5.l)
_predef_4:
	move.l     a4,(a7)
	jsr        _lenstr
	sub.l      d5,d7
	addq.l     #1,d7
	move.w     d7,-4(a6)
	move.l     a4,d7
	add.l      d5,d7
	move.l     d7,-8(a6)
	move.w     -4(a6),d7
	ext.l      d7
	movea.l    d7,a2
	subq.l     #1,a2
	adda.l     -8(a6),a2
	move.b     #$0A,(a2)
_predef_3:
	clr.l      (a7)
	move.l     d5,-(a7)
	move.l     a4,-(a7)
	jsr        _lookup(pc)
	addq.l     #8,a7
	tst.l      d7
	beq.s      _predef_5
	move.l     d5,(a7)
	move.l     a4,-(a7)
	move.l     #$000265DA,-(a7) "-d %b redefined"
	jsr        _p0error(pc)
	addq.l     #8,a7
	bra.s      _predef_6
_predef_5:
	move.w     -4(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	move.l     -8(a6),-(a7)
	jsr        _buybuf
	addq.l     #4,a7
	move.l     d7,(a7)
	move.l     d5,-(a7)
	move.l     a4,-(a7)
	jsr        _install(pc)
	addq.l     #8,a7
_predef_6:
	addq.w     #1,-2(a6)
	bra        _predef_7

_ptline:
	link       a6,#-4
	tst.l      _pincl
	beq.s      _ptline_1
	tst.l      _xflag
	beq.s      _ptline_1
	tst.l      _pasline
	bne.s      _ptline_1
	tst.l      _liflag
	bne.s      _ptline_2
	tst.w      _inincl
	beq.s      _ptline_2
_ptline_1:
	unlk       a6
	rts
_ptline_2:
	move.l     _pincl,(a7)
	addq.l     #8,(a7)
	pea.l      ($00000014).w
	move.l     #$000265F2,-(a7)
	jsr        _putcode "c2"
	addq.l     #8,a7
	bra.s      _ptline_1

_scntab:
	link       a6,#-10
	movem.l    d0/d5/a4-a5,-(a7)
	clr.l      -8(a6)
_scntab_6:
	move.l     -8(a6),d7
	cmp.l      12(a6),d7
	bcc.s      _scntab_1
	move.l     12(a6),d7
	add.l      -8(a6),d7
	lsr.l      #1,d7
	move.l     d7,-4(a6)
	move.l     -4(a6),d7
	asl.l      #3,d7
	movea.l    d7,a2
	adda.l     8(a6),a2
	movea.l    (a2),a4
	clr.l      d7
	move.b     (a4)+,d7
	sub.l      20(a6),d7
	move.w     d7,-10(a6)
	bne.s      _scntab_2
	clr.l      d5
	movea.l    16(a6),a5
_scntab_7:
	cmp.l      20(a6),d5
	bcc.s      _scntab_2
	clr.l      d7
	move.b     (a4)+,d7
	clr.l      d6
	move.b     (a5)+,d6
	sub.l      d6,d7
	move.w     d7,-10(a6)
	beq.s      _scntab_3
	bra.s      _scntab_2
_scntab_1:
	clr.l      d7
	bra.s      _scntab_4
_scntab_2:
	tst.w      -10(a6)
	bge.s      _scntab_5
	move.l     -4(a6),d7
	addq.l     #1,d7
	move.l     d7,-8(a6)
	bra.s      _scntab_6
_scntab_3:
	addq.l     #1,d5
	bra.s      _scntab_7
_scntab_5:
	tst.w      -10(a6)
	bne.s      _scntab_8
	move.l     -4(a6),d7
	asl.l      #3,d7
	movea.l    d7,a2
	adda.l     8(a6),a2
	addq.l     #4,a2
	move.l     (a2),d7
_scntab_4:
	movem.l    (a7)+,d0/d5/a4-a5
	unlk       a6
	rts
_scntab_8:
	move.l     -4(a6),12(a6)
	bra        _scntab_6

_stotl:
	link       a6,#-8
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	tst.l      12(a6)
	bne.s      _stotl_1
	lea.l      -8(a6),a2
	move.l     a2,12(a6)
	clr.l      -8(a6)
_stotl_1:
	lea.l      -4(a6),a2
	movea.l    a2,a3
_stotl_47:
	clr.l      (a7)
	clr.l      -(a7)
	jsr        _buytl(pc)
	addq.l     #4,a7
	movea.l    d7,a4
	move.l     a5,8(a4) q->white = s;
_stotl_7:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$000A,d7
	beq.s      _stotl_2
	clr.l      d7        ISWHITE(*s)
	move.b     (a5),d7
	cmpi.w     #$0020,d7
	bls.s      _stotl_3
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007F,d7
	bcs.s      _stotl_4
	bra.s      _stotl_3
_stotl_2:
	move.l     a5,d7
	sub.l      8(a4),d7
	move.l     d7,12(a4) q->nwhite = s - q->white;
	move.l     a5,16(a4)  q->text = s;
	clr.l      20(a4)     q->ntext = 0
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$000A,d7
	bne        _stotl_5
	addq.l     #1,a5
	moveq.l    #2,d0
	move.l     d0,4(a4) q->type = PEOL;
	bra        _stotl_6
_stotl_3:
	addq.l     #1,a5
	bra.s      _stotl_7
_stotl_4:
	movea.l    12(a6),a2
	tst.l      (a2)
	bne.s      _stotl_8
	tst.l      _pasflag
	bne.s      _stotl_9
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002F,d7 '/'
	bne.s      _stotl_9
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$002A,d7
	bne.s      _stotl_9
_stotl_8:
	movea.l    12(a6),a2
	tst.l      (a2)
	bne.s      _stotl_10
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007B,d7
	bne.s      _stotl_11
	moveq.l    #1,d7
	bra.s      _stotl_12
_stotl_11:
	moveq.l    #2,d7
_stotl_12:
	adda.l     d7,a5
	bra.s      _stotl_10
_stotl_9:
	tst.l      _pasflag
	beq.s      _stotl_2
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007B,d7
	beq.s      _stotl_8
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0028,d7
	bne        _stotl_2
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$002A,d7
	beq.s      _stotl_8
	bra        _stotl_2
_stotl_10:
	movea.l    12(a6),a2
	moveq.l    #1,d0
	move.l     d0,(a2)
_stotl_15:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$000A,d7
	beq        _stotl_7
	tst.l      _pasflag
	bne.s      _stotl_13
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002A,d7
	bne.s      _stotl_13
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$002F,d7
	beq.s      _stotl_14
	bra.s      _stotl_13
_stotl_16:
	addq.l     #1,a5
	bra.s      _stotl_15
_stotl_13:
	tst.l      _pasflag
	beq.s      _stotl_16
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007D,d7
	beq.s      _stotl_14
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$002A,d7
	bne.s      _stotl_16
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$0029,d7
	bne.s      _stotl_16
_stotl_14:
	movea.l    12(a6),a2
	clr.l      (a2)
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007D,d7
	bne.s      _stotl_17
	moveq.l    #1,d7
	bra.s      _stotl_18
_stotl_17:
	moveq.l    #2,d7
_stotl_18:
	adda.l     d7,a5
	bra        _stotl_7
_stotl_5:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0061,d7
	bcs.s      _stotl_19
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007A,d7
	bls.s      _stotl_20
_stotl_19:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0041,d7
	bcs.s      _stotl_21
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005A,d7
	bls.s      _stotl_20
_stotl_21:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005F,d7
	beq.s      _stotl_20
	tst.l      _stdflag
	bne.s      _stotl_22
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0024,d7
	beq.s      _stotl_20
_stotl_22:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0030,d7
	bcs        _stotl_23
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0039,d7
	bhi        _stotl_23
_stotl_37:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0061,d7
	bcs        _stotl_24
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007A,d7
	bls        _stotl_25
	bra        _stotl_24
_stotl_20:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0061,d7
	bcs.s      _stotl_26
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$007A,d7
	bls.s      _stotl_27
_stotl_26:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0041,d7
	bcs.s      _stotl_28
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005A,d7
	bhi.s      _stotl_28
_stotl_27:
	addq.l     #1,a5
	bra.s      _stotl_20
_stotl_28:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005F,d7
	beq.s      _stotl_27
	tst.l      _stdflag
	bne.s      _stotl_29
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0024,d7
	beq.s      _stotl_27
_stotl_29:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0030,d7
	bcs.s      _stotl_30
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0039,d7
	bls.s      _stotl_27
_stotl_30:
	moveq.l    #3,d0
	move.l     d0,4(a4)  q->type = PIDENT;
_stotl_6:
	tst.l      20(a4)
	bne        _stotl_31
	move.l     a5,d7
	sub.l      16(a4),d7
	move.l     d7,20(a4)
	bra        _stotl_31
_stotl_23:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0022,d7
	beq        _stotl_32
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0027,d7
	bne.s      _stotl_33
	bra        _stotl_32
_stotl_24:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0041,d7
	bcs.s      _stotl_34
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005A,d7
	bls.s      _stotl_25
_stotl_34:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0030,d7
	bcs.s      _stotl_35
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$0039,d7
	bls.s      _stotl_25
_stotl_35:
	tst.l      _stdflag
	bne.s      _stotl_36
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005F,d7
	bne.s      _stotl_36
_stotl_25:
	addq.l     #1,a5
	bra        _stotl_37
_stotl_36:
	moveq.l    #4,d0
	move.l     d0,4(a4) q->type = PNUM;
	bra.s      _stotl_6
_stotl_33:
	tst.l      _xflag
	bne        _stotl_38
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005C,d7
	bne        _stotl_38
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$006E,d7
	bne        _stotl_38
	addq.l     #2,a5
	move.l     #$000265F6,16(a4) "\n"
	moveq.l    #1,d0
	move.l     d0,20(a4)
	moveq.l    #5,d0
	move.l     d0,4(a4) q->type = PPUNCT;
	bra        _stotl_6
_stotl_32:
	addq.l     #1,a5
	clr.l      d7
	move.b     (a5),d7
	movea.l    16(a4),a2
	clr.l      d6
	move.b     (a2),d6
	cmp.l      d6,d7
	beq.s      _stotl_39
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$000A,d7
	beq.s      _stotl_39
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005C,d7
	bne.s      _stotl_40
	clr.l      d7
	move.b     1(a5),d7
	cmpi.w     #$000A,d7
	beq.s      _stotl_40
	addq.l     #1,a5
	bra.s      _stotl_32
_stotl_39:
	clr.l      d7
	move.b     (a5),d7
	movea.l    16(a4),a2
	clr.l      d6
	move.b     (a2),d6
	cmp.l      d6,d7
	bne.s      _stotl_41
	addq.l     #1,a5
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0022,d7
	bne.s      _stotl_42
	moveq.l    #6,d7 q->type = PSTRING
	bra.s      _stotl_43
_stotl_42:
	moveq.l    #1,d7 q->type = PCHCON
_stotl_43:
	move.l     d7,4(a4)
	bra        _stotl_6
_stotl_40:
	clr.l      d7
	move.b     (a5),d7
	cmpi.w     #$005C,d7
	bne.s      _stotl_32
	bra.s      _stotl_39
_stotl_41:
	tst.l      _xflag
	beq.s      _stotl_44
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0022,d7
	bne.s      _stotl_45
	moveq.l    #6,d7 q->type = PSTRING
	bra.s      _stotl_46
_stotl_45:
	moveq.l    #1,d7 q->type = PCHCON
_stotl_46:
	move.l     d7,4(a4)
	movea.l    16(a4),a2
	clr.l      d7
	move.b     (a2),d7
	move.l     d7,(a7)
	move.l     #$000265F8,-(a7) "unbalanced %c"
	jsr        _p0error(pc)
	addq.l     #4,a7
	bra        _stotl_6
_stotl_44:
	moveq.l    #5,d0 q->type = PPUNCT;
	move.l     d0,4(a4)
	move.l     16(a4),d7
	addq.l     #1,d7
	movea.l    d7,a5
	bra        _stotl_6
_stotl_38:
	addq.l     #1,a5
	moveq.l    #5,d0
	move.l     d0,4(a4) q->type = PPUNCT;
	bra        _stotl_6
_stotl_31:
	move.l     a4,(a3)
	movea.l    a4,a3
	cmpi.l     #$00000002,4(a4)
	bne        _stotl_47
	move.l     -4(a6),d7
	movem.l    (a7)+,d0/a3-a5
	unlk       a6
	rts

	.data
__data:
[00020000 00025550]                           dc.b $00
[00020001 00025551]                           dc.b 'idr68k Edition 3.0: Copyright (c) 1981,1983,1985 by Whitesmiths, Ltd. all rights reserved',0
[0002005b 000255ab]                           dc.b '|/bin/|/usr/bin/',0
[0002006c 000255bc]                           dc.b 'PATH',0
[00020071 000255c1]                           dc.b $00
_environ:
[00020072 000255c2]                           dc.l 0
_errno:
[00020076 000255c6]                           dc.l 0
__paths:
[0002007a 000255ca] 0002005b                  dc.l $0002005b ; no symbol found
[0002007e 000255ce] 000000aa                  dc.l _onexit
_bltintab:
[00020082 000255d2] 000200bf                  dc.l $000200bf ; no symbol found
[00020086 000255d6]                           dc.l 30
[0002008a 000255da] 000200b6                  dc.l $000200b6 ; no symbol found
[0002008e 000255de]                           dc.l 33
[00020092 000255e2] 000200ac                  dc.l $000200ac ; no symbol found
[00020096 000255e6]                           dc.l 31
[0002009a 000255ea] 000200a2                  dc.l $000200a2 ; no symbol found
[0002009e 000255ee]                           dc.l 32
[000200a2 000255f2]                           dc.w $085f
[000200a4 000255f4]                           dc.b '_LINE__',0
[000200ac 000255fc]                           dc.w $085f
[000200ae 000255fe]                           dc.b '_FILE__',0
[000200b6 00025606]                           dc.w $0764
[000200b8 00025608]                           dc.b 'efined',0
[000200bf 0002560f]                           dc.b $03
[000200c0 00025610]                           dc.b '$if',0

; dodef
tcomma:
[000200c4 00025614]                           dc.l 0,5,0,0,",",1
builtin.linenobuf:
[000200de 0002562e]                           ds.b 10
; switchtable in builtin
[000200e8 00025638] 00000210                  dc.l $00000210 ; no symbol found
[000200ec 0002563c]                           dc.l 33
[000200f0 00025640] 000001da                  dc.l $000001da ; no symbol found
[000200f4 00025644]                           dc.l 32
[000200f8 00025648] 0000019e                  dc.l $0000019e ; no symbol found
[000200fc 0002564c]                           dc.l 31
[00020100 00025650] 0000010e                  dc.l $0000010e ; no symbol found
[00020104 00025654]                           dc.l 30
[00020108 00025658]                           dc.l 0
[0002010c 0002565c] 00000194                  dc.l $00000194 ; no symbol found

[00020110 00025660]                           dc.w $3000
[00020112 00025662]                           dc.w $3100
[00020114 00025664]                           dc.b 'bad defined syntax',0
[00020127 00025677]                           dc.b $30
[00020128 00025678]                           dc.b $00
[00020129 00025679]                           dc.b $31
[0002012a 0002567a]                           dc.b $00
[0002012b 0002567b]                           dc.b $00
[0002012c 0002567c]                           dc.b 'too many macro arguments',0
[00020145 00025695]                           dc.b 'too few macro arguments',0
[0002015d 000256ad]                           dc.b 'bad #define arguments',0
[00020173 000256c3]                           dc.b $00
[00020174 000256c4]                           dc.b 'bad $if(test)',0
[00020182 000256d2]                           dc.b '$if expects arguments',0
[00020198 000256e8]                           dc.b 'bad macro arguments',0
_ipri:
[000201ac 000256fc]                           dc.w $e285
[000201ae 000256fe]                           dc.w $99de
[000201b0 00025700]                           dc.w $d897
[000201b2 00025702]                           dc.w $a095
[000201b4 00025704]                           dc.w $968f
[000201b6 00025706]                           dc.w $9094
[000201b8 00025708]                           dc.w $9bc1
[000201ba 0002570a]                           dc.w $a39c
[000201bc 0002570c]                           dc.w $829d
[000201be 0002570e]                           dc.w $9f00
_opri:
[000201c0 00025710]                           dc.w $0e0e
[000201c2 00025712]                           dc.w $0e0d
[000201c4 00025714]                           dc.w $0d0c
[000201c6 00025716]                           dc.w $0c0b
[000201c8 00025718]                           dc.w $0b0b
[000201ca 0002571a]                           dc.w $0b0a
[000201cc 0002571c]                           dc.w $0a09
[000201ce 0002571e]                           dc.w $0807
[000201d0 00025720]                           dc.w $0605
[000201d2 00025722]                           dc.w $0400
_optab:
[000201d4 00025724] 000203e4                  dc.l $000203e4 ; "\1!"
[000201d8 00025728]                           dc.l UNOP | 26
[000201dc 0002572c] 000203e1                  dc.l $000203e1 ; "\1%
[000201e0 00025730]                           dc.l BINOP | 25
[000201e4 00025734] 000203de                  dc.l $000203de ; "\1&"
[000201e8 00025738]                           dc.l BINOP | UNOP | 1
[000201ec 0002573c] 000203db                  dc.l $000203db ; "\1("
[000201f0 00025740]                           dc.l 6
[000201f4 00025744] 000203d8                  dc.l $000203d8 ; "\1)"
[000201f8 00025748]                           dc.l 10
[000201fc 0002574c] 000203d5                  dc.l $000203d5 ; "\1*"
[00020200 00025750]                           dc.l BINOP | UNOP | 34
[00020204 00025754] 000203d2                  dc.l $000203d2 "\1-"
[00020208 00025758]                           dc.l BINOP | UNOP | 30
[0002020c 0002575c] 000203cf                  dc.l $000203cf ; "\1,"
[00020210 00025760]                           dc.l 2
[00020214 00025764] 000203cc                  dc.l $000203cc ; "\1-"
[00020218 00025768]                           dc.l BINOP | UNOP | 24
[0002021c 0002576c] 000203c9                  dc.l $000203c9 ; "\1."
[00020220 00025770]                           dc.l 3
[00020224 00025774] 000203c6                  dc.l $000203c6 ; "\1/"
[00020228 00025778]                           dc.l BINOP | 5
[0002022c 0002577c] 000203c3                  dc.l $000203c3 ; "\1:"
[00020230 00025780]                           dc.l 1
[00020234 00025784] 000203c0                  dc.l $000203c0 ; "\1;"
[00020238 00025788]                           dc.l 11
[0002023c 0002578c] 000203bd                  dc.l $000203bd ; "\1>"
[00020240 00025790]                           dc.l BINOP | 21
[00020244 00025794] 000203ba                  dc.l $000203ba ; "\1="
[00020248 00025798]                           dc.l BINOP | 8
[0002024c 0002579c] 000203b7                  dc.l $000203b7 ; "\1>"
[00020250 000257a0]                           dc.l BINNOP | 15
[00020254 000257a4] 000203b4                  dc.l $000203b4 ; "\1?"
[00020258 000257a8]                           dc.l BINOP | 31
[0002025c 000257ac] 000203b1                  dc.l $000203b1 ; "\1["
[00020260 000257b0]                           dc.l 4
[00020264 000257b4] 000203ae                  dc.l $000203ae ; "\1]"
[00020268 000257b8]                           dc.l 8
[0002026c 000257bc] 000203ab                  dc.l $000203ab ; "\1^"
[00020270 000257c0]                           dc.l BINOP | 35
[00020274 000257c4] 000203a8                  dc.l $000203a8 ; "\1{"
[00020278 000257c8]                           dc.l 5
[0002027c 000257cc] 000203a5                  dc.l $000203a5 ; "\1|"
[00020280 000257d0]                           dc.l BINOP | 28
[00020284 000257d4] 000203a2                  dc.l $000203a2 ; "\1}"
[00020288 000257d8]                           dc.l 9
[0002028c 000257dc] 0002039f                  dc.l $0002039f ; "\1~"
[00020290 000257e0]                           dc.l UNOP | 3
[00020294 000257e4] 0002039b                  dc.l $0002039b ; "\1!="
[00020298 000257e8]                           dc.l BINOP | 27
[0002029c 000257ec] 00020397                  dc.l $00020397 ; "\2%="
[000202a0 000257f0]                           dc.l BINOP | 12
[000202a4 000257f4] 00020393                  dc.l $00020393 ; "\2&&"
[000202a8 000257f8]                           dc.l BINOP | 2
[000202ac 000257fc] 0002038f                  dc.l $0002038f ; "\2&="
[000202b0 00025800]                           dc.l BINOP | 6
[000202b4 00025804] 0002038b                  dc.l $0002038b ; "\2*="
[000202b8 00025808]                           dc.l BINOP | 17
[000202bc 0002580c] 00020387                  dc.l $00020387 ; "\2++"
[000202c0 00025810]                           dc.l UNOP | 19
[000202c4 00025814] 00020383                  dc.l $00020383 ; "\2+=
[000202c8 00025818]                           dc.l BINOP | 14
[000202cc 0002581c] 0002037f                  dc.l $0002037f ; "\2--"
[000202d0 00025820]                           dc.l UNOP | 4
[000202d4 00025824] 0002037b                  dc.l $0002037b ; "\2-="
[000202d8 00025828]                           dc.l BINOP | 11
[000202dc 0002582c] 00020377                  dc.l $00020377 ; "\2->"
[000202e0 00025830]                           dc.l 7
[000202e4 00025834] 00020373                  dc.l $00020373 ; "\2/="
[000202e8 00025838]                           dc.l BINOP | 7
[000202ec 0002583c] 0002036f                  dc.l $0002036f ; "\2<<"
[000202f0 00025840]                           dc.l BINOP | 23
[000202f4 00025844] 0002036b                  dc.l $0002036b ; "\2<="
[000202f8 00025848]                           dc.l BINOP | 22
[000202fc 0002584c] 00020367                  dc.l $00020367 ; "\2=="
[00020300 00025850]                           dc.l BINOP | 20
[00020304 00025854] 00020363                  dc.l $00020363 ; "\2>="
[00020308 00025858]                           dc.l BINOP | 16
[0002030c 0002585c] 0002035f                  dc.l $0002035f ; "\2>>"
[00020310 00025860]                           dc.l BINOP | 32
[00020314 00025864] 0002035b                  dc.l $0002035b ; "\2^="
[00020318 00025868]                           dc.l BINOP | 18
[0002031c 0002586c] 00020357                  dc.l $00020357 ; "\2|="
[00020320 00025870]                           dc.l BINOP | 13
[00020324 00025874] 00020353                  dc.l $00020353 ; "\2||"
[00020328 00025878]                           dc.l BINOP | 29
[0002032c 0002587c] 0002034e                  dc.l $0002034e ; "\3..."
[00020330 00025880]                           dc.l 13
[00020334 00025884] 00020349                  dc.l $00020349 ; "\3<<="
[00020338 00025888]                           dc.l BINOP | 9
[0002033c 0002588c] 00020344                  dc.l $00020344 ; "\3>>="
[00020340 00025890]                           dc.l BINOP | 10

[00020344 00025894]                           dc.w $033e
[00020346 00025896]                           dc.w $3e3d
[00020348 00025898]                           dc.b $00
[00020349 00025899]                           dc.b $03
[0002034a 0002589a]                           dc.b '<<=',0
[0002034e 0002589e]                           dc.w $032e
[00020350 000258a0]                           dc.w $2e2e
[00020352 000258a2]                           dc.b $00
[00020353 000258a3]                           dc.b $02
[00020354 000258a4]                           dc.w $7c7c
[00020356 000258a6]                           dc.b $00
[00020357 000258a7]                           dc.b $02
[00020358 000258a8]                           dc.w $7c3d
[0002035a 000258aa]                           dc.b $00
[0002035b 000258ab]                           dc.b $02
[0002035c 000258ac]                           dc.w $5e3d
[0002035e 000258ae]                           dc.b $00
[0002035f 000258af]                           dc.b $02
[00020360 000258b0]                           dc.w $3e3e
[00020362 000258b2]                           dc.b $00
[00020363 000258b3]                           dc.b $02
[00020364 000258b4]                           dc.w $3e3d
[00020366 000258b6]                           dc.b $00
[00020367 000258b7]                           dc.b $02
[00020368 000258b8]                           dc.w $3d3d
[0002036a 000258ba]                           dc.b $00
[0002036b 000258bb]                           dc.b $02
[0002036c 000258bc]                           dc.w $3c3d
[0002036e 000258be]                           dc.b $00
[0002036f 000258bf]                           dc.b $02
[00020370 000258c0]                           dc.w $3c3c
[00020372 000258c2]                           dc.b $00
[00020373 000258c3]                           dc.b $02
[00020374 000258c4]                           dc.w $2f3d
[00020376 000258c6]                           dc.b $00
[00020377 000258c7]                           dc.b $02
[00020378 000258c8]                           dc.w $2d3e
[0002037a 000258ca]                           dc.b $00
[0002037b 000258cb]                           dc.b $02
[0002037c 000258cc]                           dc.w $2d3d
[0002037e 000258ce]                           dc.b $00
[0002037f 000258cf]                           dc.b $02
[00020380 000258d0]                           dc.w $2d2d
[00020382 000258d2]                           dc.b $00
[00020383 000258d3]                           dc.b $02
[00020384 000258d4]                           dc.w $2b3d
[00020386 000258d6]                           dc.b $00
[00020387 000258d7]                           dc.b $02
[00020388 000258d8]                           dc.w $2b2b
[0002038a 000258da]                           dc.b $00
[0002038b 000258db]                           dc.b $02
[0002038c 000258dc]                           dc.w $2a3d
[0002038e 000258de]                           dc.b $00
[0002038f 000258df]                           dc.b $02
[00020390 000258e0]                           dc.w $263d
[00020392 000258e2]                           dc.b $00
[00020393 000258e3]                           dc.b $02
[00020394 000258e4]                           dc.w $2626
[00020396 000258e6]                           dc.b $00
[00020397 000258e7]                           dc.b $02
[00020398 000258e8]                           dc.w $253d
[0002039a 000258ea]                           dc.b $00
[0002039b 000258eb]                           dc.b $02
[0002039c 000258ec]                           dc.w $213d
[0002039e 000258ee]                           dc.b $00
[0002039f 000258ef]                           dc.b $01
[000203a0 000258f0]                           dc.w $7e00
[000203a2 000258f2]                           dc.w $017d
[000203a4 000258f4]                           dc.b $00
[000203a5 000258f5]                           dc.b $01
[000203a6 000258f6]                           dc.w $7c00
[000203a8 000258f8]                           dc.w $017b
[000203aa 000258fa]                           dc.b $00
[000203ab 000258fb]                           dc.b $01
[000203ac 000258fc]                           dc.w $5e00
[000203ae 000258fe]                           dc.w $015d
[000203b0 00025900]                           dc.b $00
[000203b1 00025901]                           dc.b $01
[000203b2 00025902]                           dc.w $5b00
[000203b4 00025904]                           dc.w $013f
[000203b6 00025906]                           dc.b $00
[000203b7 00025907]                           dc.b $01
[000203b8 00025908]                           dc.w $3e00
[000203ba 0002590a]                           dc.w $013d
[000203bc 0002590c]                           dc.b $00
[000203bd 0002590d]                           dc.b $01
[000203be 0002590e]                           dc.w $3c00
[000203c0 00025910]                           dc.w $013b
[000203c2 00025912]                           dc.b $00
[000203c3 00025913]                           dc.b $01
[000203c4 00025914]                           dc.w $3a00
[000203c6 00025916]                           dc.w $012f
[000203c8 00025918]                           dc.b $00
[000203c9 00025919]                           dc.b $01
[000203ca 0002591a]                           dc.w $2e00
[000203cc 0002591c]                           dc.w $012d
[000203ce 0002591e]                           dc.b $00
[000203cf 0002591f]                           dc.b $01
[000203d0 00025920]                           dc.w $2c00
[000203d2 00025922]                           dc.w $012b
[000203d4 00025924]                           dc.b $00
[000203d5 00025925]                           dc.b $01
[000203d6 00025926]                           dc.w $2a00
[000203d8 00025928]                           dc.w $0129
[000203da 0002592a]                           dc.b $00
[000203db 0002592b]                           dc.b $01
[000203dc 0002592c]                           dc.w $2800
[000203de 0002592e]                           dc.w $0126
[000203e0 00025930]                           dc.b $00
[000203e1 00025931]                           dc.b $01
[000203e2 00025932]                           dc.w $2500
[000203e4 00025934]                           dc.w $0121
[000203e6 00025936]                           dc.b $00
[000203e7 00025937]                           dc.b $00

_optabold:
[000203e8 00025938] 000204e3                  dc.l $000204e3 "\1@"
[000203ec 0002593c]                           dc.l 12 LAT
[000203f0 00025940] 000204df                  dc.l $000204df "\2(<"
[000203f4 00025944]                           dc.l 5 LLCURLY
[000203f8 00025948] 000204db                  dc.l $000204db "\2(|"
[000203fc 0002594c]                           dc.l 4 LLBRACK
[00020400 00025950] 000204d7                  dc.l $000204d7 "\2.."
[00020404 00025954]                           dc.l 14 LRANGE
[00020408 00025958] 000204d3                  dc.l $000204d3 "\2=%"
[0002040c 0002595c]                           dc.l BINOP | 12
[00020410 00025960] 000204cf                  dc.l $000204cf "\2=&"
[00020414 00025964]                           dc.l BINOP | 6
[00020418 00025968] 000204cb                  dc.l $000204cb "\2=*"
[0002041c 0002596c]                           dc.l BINOP | 17
[00020420 00025970] 000204c7                  dc.l $000204c7 "\2=+"
[00020424 00025974]                           dc.l BINOP | 14
[00020428 00025978] 000204c3                  dc.l $000204c3 "\2=-"
[0002042c 0002597c]                           dc.l BINOP | 11
[00020430 00025980] 000204bf                  dc.l $000204bf "\2=/"
[00020434 00025984]                           dc.l BINOP | 7
[00020438 00025988] 000204bb                  dc.l $000204bb "\2=^"
[0002043c 0002598c]                           dc.l BINOP | 18
[00020440 00025990] 000204b7                  dc.l $000204b7 "\2=|"
[00020444 00025994]                           dc.l BINOP | 13
[00020448 00025998] 000204b3                  dc.l $000204b3 "\2>)"
[0002044c 0002599c]                           dc.l 9 LRCURLY
[00020450 000259a0] 000204af                  dc.l $000204af "\2\!"
[00020454 000259a4]                           dc.l BINOP | 28
[00020458 000259a8] 000204ab                  dc.l $000204ab "\2\("
[0002045c 000259ac]                           dc.l 5 LLCURLY
[00020460 000259b0] 000204a7                  dc.l $000204a7 "\2\)"
[00020464 000259b4]                           dc.l 9 LRCURLY
[00020468 000259b8] 000204a3                  dc.l $000204a3 "\2\^"
[0002046c 000259bc]                           dc.l UNOP | 3
[00020470 000259c0] 0002049f                  dc.l $0002049f "\2|)"
[00020474 000259c4]                           dc.l 8 LRBRACK
[00020478 000259c8] 0002049a                  dc.l $0002049a "\3=<<"
[0002047c 000259cc]                           dc.l BINOP | 9
[00020480 000259d0] 00020495                  dc.l $00020495 "\3=>>"
[00020484 000259d4]                           dc.l BINOP | 10
[00020488 000259d8] 00020490                  dc.l $00020490 "\3\!!"
[0002048c 000259dc]                           dc.l BINOP | 29

[00020490 000259e0]                           dc.w $035c
[00020492 000259e2]                           dc.w $2121
[00020494 000259e4]                           dc.b $00
[00020495 000259e5]                           dc.b $03
[00020496 000259e6]                           dc.b '=>>',0
[0002049a 000259ea]                           dc.w $033d
[0002049c 000259ec]                           dc.w $3c3c
[0002049e 000259ee]                           dc.b $00
[0002049f 000259ef]                           dc.b $02
[000204a0 000259f0]                           dc.w $7c29
[000204a2 000259f2]                           dc.b $00
[000204a3 000259f3]                           dc.b $02
[000204a4 000259f4]                           dc.w $5c5e
[000204a6 000259f6]                           dc.b $00
[000204a7 000259f7]                           dc.b $02
[000204a8 000259f8]                           dc.w $5c29
[000204aa 000259fa]                           dc.b $00
[000204ab 000259fb]                           dc.b $02
[000204ac 000259fc]                           dc.w $5c28
[000204ae 000259fe]                           dc.b $00
[000204af 000259ff]                           dc.b $02
[000204b0 00025a00]                           dc.w $5c21
[000204b2 00025a02]                           dc.b $00
[000204b3 00025a03]                           dc.b $02
[000204b4 00025a04]                           dc.w $3e29
[000204b6 00025a06]                           dc.b $00
[000204b7 00025a07]                           dc.b $02
[000204b8 00025a08]                           dc.w $3d7c
[000204ba 00025a0a]                           dc.b $00
[000204bb 00025a0b]                           dc.b $02
[000204bc 00025a0c]                           dc.w $3d5e
[000204be 00025a0e]                           dc.b $00
[000204bf 00025a0f]                           dc.b $02
[000204c0 00025a10]                           dc.w $3d2f
[000204c2 00025a12]                           dc.b $00
[000204c3 00025a13]                           dc.b $02
[000204c4 00025a14]                           dc.w $3d2d
[000204c6 00025a16]                           dc.b $00
[000204c7 00025a17]                           dc.b $02
[000204c8 00025a18]                           dc.w $3d2b
[000204ca 00025a1a]                           dc.b $00
[000204cb 00025a1b]                           dc.b $02
[000204cc 00025a1c]                           dc.w $3d2a
[000204ce 00025a1e]                           dc.b $00
[000204cf 00025a1f]                           dc.b $02
[000204d0 00025a20]                           dc.w $3d26
[000204d2 00025a22]                           dc.b $00
[000204d3 00025a23]                           dc.b $02
[000204d4 00025a24]                           dc.w $3d25
[000204d6 00025a26]                           dc.b $00
[000204d7 00025a27]                           dc.b $02
[000204d8 00025a28]                           dc.w $2e2e
[000204da 00025a2a]                           dc.b $00
[000204db 00025a2b]                           dc.b $02
[000204dc 00025a2c]                           dc.w $287c
[000204de 00025a2e]                           dc.b $00
[000204df 00025a2f]                           dc.b $02
[000204e0 00025a30]                           dc.w $283c
[000204e2 00025a32]                           dc.b $00
[000204e3 00025a33]                           dc.b $01
[000204e4 00025a34]                           dc.w $4000
_cmap:
[000204e6 00025a36]                           dc.b $00
[000204e7 00025a37]                           dc.b $01
[000204e8 00025a38]                           dc.w $0203
[000204ea 00025a3a]                           dc.w $0405
[000204ec 00025a3c]                           dc.w $0607
[000204ee 00025a3e]                           dc.w $0809
[000204f0 00025a40]                           dc.w $0a0b
[000204f2 00025a42]                           dc.w $0c0d
[000204f4 00025a44]                           dc.w $0e0f
[000204f6 00025a46]                           dc.w $1011
[000204f8 00025a48]                           dc.w $1213
[000204fa 00025a4a]                           dc.w $1415
[000204fc 00025a4c]                           dc.w $1617
[000204fe 00025a4e]                           dc.w $1819
[00020500 00025a50]                           dc.w $1a1b
[00020502 00025a52]                           dc.w $1c1d
[00020504 00025a54]                           dc.w $1e1f
[00020506 00025a56]                           dc.b ' !"#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
[00020565 00025ab5]                           dc.b $7f
[00020566 00025ab6]                           dc.w $8081
[00020568 00025ab8]                           dc.w $8283
[0002056a 00025aba]                           dc.w $8485
[0002056c 00025abc]                           dc.w $8687
[0002056e 00025abe]                           dc.w $8889
[00020570 00025ac0]                           dc.w $8a8b
[00020572 00025ac2]                           dc.w $8c8d
[00020574 00025ac4]                           dc.w $8e8f
[00020576 00025ac6]                           dc.w $9091
[00020578 00025ac8]                           dc.w $9293
[0002057a 00025aca]                           dc.w $9495
[0002057c 00025acc]                           dc.w $9697
[0002057e 00025ace]                           dc.w $9899
[00020580 00025ad0]                           dc.w $9a9b
[00020582 00025ad2]                           dc.w $9c9d
[00020584 00025ad4]                           dc.w $9e9f
[00020586 00025ad6]                           dc.w $a0a1
[00020588 00025ad8]                           dc.w $a2a3
[0002058a 00025ada]                           dc.w $a4a5
[0002058c 00025adc]                           dc.w $a6a7
[0002058e 00025ade]                           dc.w $a8a9
[00020590 00025ae0]                           dc.w $aaab
[00020592 00025ae2]                           dc.w $acad
[00020594 00025ae4]                           dc.w $aeaf
[00020596 00025ae6]                           dc.w $b0b1
[00020598 00025ae8]                           dc.w $b2b3
[0002059a 00025aea]                           dc.w $b4b5
[0002059c 00025aec]                           dc.w $b6b7
[0002059e 00025aee]                           dc.w $b8b9
[000205a0 00025af0]                           dc.w $babb
[000205a2 00025af2]                           dc.w $bcbd
[000205a4 00025af4]                           dc.w $bebf
[000205a6 00025af6]                           dc.w $c0c1
[000205a8 00025af8]                           dc.w $c2c3
[000205aa 00025afa]                           dc.w $c4c5
[000205ac 00025afc]                           dc.w $c6c7
[000205ae 00025afe]                           dc.w $c8c9
[000205b0 00025b00]                           dc.w $cacb
[000205b2 00025b02]                           dc.w $cccd
[000205b4 00025b04]                           dc.w $cecf
[000205b6 00025b06]                           dc.w $d0d1
[000205b8 00025b08]                           dc.w $d2d3
[000205ba 00025b0a]                           dc.w $d4d5
[000205bc 00025b0c]                           dc.w $d6d7
[000205be 00025b0e]                           dc.w $d8d9
[000205c0 00025b10]                           dc.w $dadb
[000205c2 00025b12]                           dc.w $dcdd
[000205c4 00025b14]                           dc.w $dedf
[000205c6 00025b16]                           dc.w $e0e1
[000205c8 00025b18]                           dc.w $e2e3
[000205ca 00025b1a]                           dc.w $e4e5
[000205cc 00025b1c]                           dc.w $e6e7
[000205ce 00025b1e]                           dc.w $e8e9
[000205d0 00025b20]                           dc.w $eaeb
[000205d2 00025b22]                           dc.w $eced
[000205d4 00025b24]                           dc.w $eeef
[000205d6 00025b26]                           dc.w $f0f1
[000205d8 00025b28]                           dc.w $f2f3
[000205da 00025b2a]                           dc.w $f4f5
[000205dc 00025b2c]                           dc.w $f6f7
[000205de 00025b2e]                           dc.w $f8f9
[000205e0 00025b30]                           dc.w $fafb
[000205e2 00025b32]                           dc.w $fcfd
[000205e4 00025b34]                           dc.w $feff
_digfr:
[000205e6 00025b36]                           dc.b '0123456789abcdefABCDEF',0
_digto:
[000205fd 00025b4d]                           dc.b $00
[000205fe 00025b4e]                           dc.w $0102
[00020600 00025b50]                           dc.w $0304
[00020602 00025b52]                           dc.w $0506
[00020604 00025b54]                           dc.w $0708
[00020606 00025b56]                           dc.w $090a
[00020608 00025b58]                           dc.w $0b0c
[0002060a 00025b5a]                           dc.w $0d0e
[0002060c 00025b5c]                           dc.w $0f0a
[0002060e 00025b5e]                           dc.w $0b0c
[00020610 00025b60]                           dc.w $0d0e
[00020612 00025b62]                           dc.w $0f00
_eschars:
[00020614 00025b64]                           dc.b 'abnfrtv(!)^',0
_escodes:
[00020620 00025b70]                           dc.w $0708
[00020622 00025b72]                           dc.w $0a0c
[00020624 00025b74]                           dc.w $0d09
[00020626 00025b76]                           dc.w $0b7b
[00020628 00025b78]                           dc.b '|}~',0
[0002062c 00025b7c]                           dc.b 'illegal character: %c',0
[00020642 00025b92]                           dc.b 'illegal #if expression',0
[00020659 00025ba9]                           dc.b $00

; switchtable in extail()
[0002065a 00025baa] 000010b6                  dc.l $000010b6 ; no symbol found
[0002065e 00025bae]                           dc.l BINOP | 31
[00020662 00025bb2] 0000109c                  dc.l $0000109c ; no symbol found
[00020666 00025bb6]                           dc.l BINOP | 29
[0002066a 00025bba] 00001082                  dc.l $00001082 ; no symbol found
[0002066e 00025bbe]                           dc.l BINOP | 2
[00020672 00025bc2] 0000106e                  dc.l $0000106e ; no symbol found
[00020676 00025bc6]                           dc.l BINOP | 16
[0002067a 00025bca] 0000105a                  dc.l $0000105a ; no symbol found
[0002067e 00025bce]                           dc.l BINOP | 27
[00020682 00025bd2] 00001046                  dc.l $00001046 ; no symbol found
[00020686 00025bd6]                           dc.l BINOP | 22
[0002068a 00025bda] 00001032                  dc.l $00001032 ; no symbol found
[0002068e 00025bde]                           dc.l BINOP | 15
[00020692 00025be2] 0000101e                  dc.l $0000101e ; no symbol found
[00020696 00025be6]                           dc.l BINOP | 20
[0002069a 00025bea] 0000100a                  dc.l $0000100a ; no symbol found
[0002069e 00025bee]                           dc.l BINOP | 21
[000206a2 00025bf2] 00000ff8                  dc.l $00000ff8 ; no symbol found
[000206a6 00025bf6]                           dc.l BINOP | 32
[000206aa 00025bfa] 00000fe6                  dc.l $00000fe6 ; no symbol found
[000206ae 00025bfe]                           dc.l BINOP | 23
[000206b2 00025c02] 00000fdc                  dc.l $00000fdc ; no symbol found
[000206b6 00025c06]                           dc.l BINOP | 35
[000206ba 00025c0a] 00000fd2                  dc.l $00000fd2 ; no symbol found
[000206be 00025c0e]                           dc.l BINOP | 28
[000206c2 00025c12] 00000fc8                  dc.l $00000fc8 ; no symbol found
[000206c6 00025c16]                           dc.l BINOP | UNOP | 1
[000206ca 00025c1a] 00000fb4                  dc.l $00000fb4 ; no symbol found
[000206ce 00025c1e]                           dc.l BINOP | 25
[000206d2 00025c22] 00000fa0                  dc.l $00000fa0 ; no symbol found
[000206d6 00025c26]                           dc.l BINOP | 5
[000206da 00025c2a] 00000f8c                  dc.l $00000f8c ; no symbol found
[000206de 00025c2e]                           dc.l BINOP | UNOP | 34
[000206e2 00025c32] 00000f84                  dc.l $00000f84 ; no symbol found
[000206e6 00025c36]                           dc.l BINOP | UNOP | 24
[000206ea 00025c3a] 00000f68                  dc.l $00000f68 ; no symbol found
[000206ee 00025c3e]                           dc.l BINOP | UNOP | 30
[000206f2 00025c42]                           dc.l 0
[000206f6 00025c46] 0000111a                  dc.l $0000111a ; no symbol found

[000206fa 00025c4a]                           dc.b 'illegal operator in #if',0
[00020712 00025c62]                           dc.b 'illegal ? : in #if',0
[00020725 00025c75]                           dc.b $00
[00020726 00025c76]                           dc.b 'illegal unary op in #if',0
[0002073e 00025c8e]                           dc.b 'illegal #if syntax',0
[00020751 00025ca1]                           dc.b 'missing ) in #if',0
_keytab:
[00020762 00025cb2] 00020955                  dc.l $00020955 ; no symbol found
[00020766 00025cb6]                           dc.b $00
[00020767 00025cb7]                           dc.b $00
[00020768 00025cb8]                           dc.b $00
[00020769 00025cb9]                           dc.b $27
[0002076a 00025cba] 00020951                  dc.l $00020951 ; no symbol found
[0002076e 00025cbe]                           dc.b $00
[0002076f 00025cbf]                           dc.b $00
[00020770 00025cc0]                           dc.b $00
[00020771 00025cc1]                           dc.b $2e
[00020772 00025cc2] 0002094c                  dc.l $0002094c ; no symbol found
[00020776 00025cc6]                           dc.b $00
[00020777 00025cc7]                           dc.b $00
[00020778 00025cc8]                           dc.b $00
[00020779 00025cc9]                           dc.b $2c
[0002077a 00025cca] 00020947                  dc.l $00020947 ; no symbol found
[0002077e 00025cce]                           dc.b $00
[0002077f 00025ccf]                           dc.b $00
[00020780 00025cd0]                           dc.b $00
[00020781 00025cd1]                           dc.b $2f
[00020782 00025cd2] 00020941                  dc.l $00020941 ; no symbol found
[00020786 00025cd6]                           dc.b $00
[00020787 00025cd7]                           dc.b $00
[00020788 00025cd8]                           dc.b $00
[00020789 00025cd9]                           dc.b $21
[0002078a 00025cda] 0002093b                  dc.l $0002093b ; no symbol found
[0002078e 00025cde]                           dc.b $00
[0002078f 00025cdf]                           dc.b $00
[00020790 00025ce0]                           dc.b $00
[00020791 00025ce1]                           dc.b $23
[00020792 00025ce2] 00020935                  dc.l $00020935 ; no symbol found
[00020796 00025ce6]                           dc.b $00
[00020797 00025ce7]                           dc.b $00
[00020798 00025ce8]                           dc.b $00
[00020799 00025ce9]                           dc.b $24
[0002079a 00025cea] 0002092f                  dc.l $0002092f ; no symbol found
[0002079e 00025cee]                           dc.b $00
[0002079f 00025cef]                           dc.b $00
[000207a0 00025cf0]                           dc.b $00
[000207a1 00025cf1]                           dc.b $29
[000207a2 00025cf2] 00020929                  dc.l $00020929 ; no symbol found
[000207a6 00025cf6]                           dc.b $00
[000207a7 00025cf7]                           dc.b $00
[000207a8 00025cf8]                           dc.b $00
[000207a9 00025cf9]                           dc.b $3c
[000207aa 00025cfa] 00020923                  dc.l $00020923 ; no symbol found
[000207ae 00025cfe]                           dc.b $00
[000207af 00025cff]                           dc.b $00
[000207b0 00025d00]                           dc.b $00
[000207b1 00025d01]                           dc.b $2d
[000207b2 00025d02] 0002091d                  dc.l $0002091d ; no symbol found
[000207b6 00025d06]                           dc.b $00
[000207b7 00025d07]                           dc.b $00
[000207b8 00025d08]                           dc.b $00
[000207b9 00025d09]                           dc.b $30
[000207ba 00025d0a] 00020917                  dc.l $00020917 ; no symbol found
[000207be 00025d0e]                           dc.b $00
[000207bf 00025d0f]                           dc.b $00
[000207c0 00025d10]                           dc.b $00
[000207c1 00025d11]                           dc.b $3e
[000207c2 00025d12] 00020910                  dc.l $00020910 ; no symbol found
[000207c6 00025d16]                           dc.b $00
[000207c7 00025d17]                           dc.b $00
[000207c8 00025d18]                           dc.b $00
[000207c9 00025d19]                           dc.b $22
[000207ca 00025d1a] 00020909                  dc.l $00020909 ; no symbol found
[000207ce 00025d1e]                           dc.b $00
[000207cf 00025d1f]                           dc.b $00
[000207d0 00025d20]                           dc.b $00
[000207d1 00025d21]                           dc.b $3b
[000207d2 00025d22] 00020902                  dc.l $00020902 ; no symbol found
[000207d6 00025d26]                           dc.b $00
[000207d7 00025d27]                           dc.b $00
[000207d8 00025d28]                           dc.b $00
[000207d9 00025d29]                           dc.b $2b
[000207da 00025d2a] 000208fb                  dc.l $000208fb ; no symbol found
[000207de 00025d2e]                           dc.b $00
[000207df 00025d2f]                           dc.b $00
[000207e0 00025d30]                           dc.b $00
[000207e1 00025d31]                           dc.b $33
[000207e2 00025d32] 000208f4                  dc.l $000208f4 ; no symbol found
[000207e6 00025d36]                           dc.b $00
[000207e7 00025d37]                           dc.b $00
[000207e8 00025d38]                           dc.b $00
[000207e9 00025d39]                           dc.b $38
[000207ea 00025d3a] 000208ed                  dc.l $000208ed ; no symbol found
[000207ee 00025d3e]                           dc.b $00
[000207ef 00025d3f]                           dc.b $00
[000207f0 00025d40]                           dc.b $00
[000207f1 00025d41]                           dc.b $3a
[000207f2 00025d42] 000208e5                  dc.l $000208e5 ; no symbol found
[000207f6 00025d46]                           dc.b $00
[000207f7 00025d47]                           dc.b $00
[000207f8 00025d48]                           dc.b $00
[000207f9 00025d49]                           dc.b $28
[000207fa 00025d4a] 000208dd                  dc.l $000208dd ; no symbol found
[000207fe 00025d4e]                           dc.b $00
[000207ff 00025d4f]                           dc.b $00
[00020800 00025d50]                           dc.b $00
[00020801 00025d51]                           dc.b $2a
[00020802 00025d52] 000208d5                  dc.l $000208d5 ; no symbol found
[00020806 00025d56]                           dc.b $00
[00020807 00025d57]                           dc.b $00
[00020808 00025d58]                           dc.b $00
[00020809 00025d59]                           dc.b $32
[0002080a 00025d5a] 000208cd                  dc.l $000208cd ; no symbol found
[0002080e 00025d5e]                           dc.b $00
[0002080f 00025d5f]                           dc.b $00
[00020810 00025d60]                           dc.b $00
[00020811 00025d61]                           dc.b $3d
[00020812 00025d62] 000208c5                  dc.l $000208c5 ; no symbol found
[00020816 00025d66]                           dc.b $00
[00020817 00025d67]                           dc.b $00
[00020818 00025d68]                           dc.b $00
[00020819 00025d69]                           dc.b $61
[0002081a 00025d6a] 000208bd                  dc.l $000208bd ; no symbol found
[0002081e 00025d6e]                           dc.b $00
[0002081f 00025d6f]                           dc.b $00
[00020820 00025d70]                           dc.b $00
[00020821 00025d71]                           dc.b $34
[00020822 00025d72] 000208b5                  dc.l $000208b5 ; no symbol found
[00020826 00025d76]                           dc.b $00
[00020827 00025d77]                           dc.b $00
[00020828 00025d78]                           dc.b $00
[00020829 00025d79]                           dc.b $35
[0002082a 00025d7a] 000208ad                  dc.l $000208ad ; no symbol found
[0002082e 00025d7e]                           dc.b $00
[0002082f 00025d7f]                           dc.b $00
[00020830 00025d80]                           dc.b $00
[00020831 00025d81]                           dc.b $36
[00020832 00025d82] 000208a4                  dc.l $000208a4 ; no symbol found
[00020836 00025d86]                           dc.b $00
[00020837 00025d87]                           dc.b $00
[00020838 00025d88]                           dc.b $00
[00020839 00025d89]                           dc.b $60
[0002083a 00025d8a] 0002089b                  dc.l $0002089b ; no symbol found
[0002083e 00025d8e]                           dc.b $00
[0002083f 00025d8f]                           dc.b $00
[00020840 00025d90]                           dc.b $00
[00020841 00025d91]                           dc.b $26
[00020842 00025d92] 00020892                  dc.l $00020892 ; no symbol found
[00020846 00025d96]                           dc.b $00
[00020847 00025d97]                           dc.b $00
[00020848 00025d98]                           dc.b $00
[00020849 00025d99]                           dc.b $37
[0002084a 00025d9a] 00020888                  dc.l $00020888 ; no symbol found
[0002084e 00025d9e]                           dc.b $00
[0002084f 00025d9f]                           dc.b $00
[00020850 00025da0]                           dc.b $00
[00020851 00025da1]                           dc.b $25
[00020852 00025da2] 0002087e                  dc.l $0002087e ; no symbol found
[00020856 00025da6]                           dc.b $00
[00020857 00025da7]                           dc.b $00
[00020858 00025da8]                           dc.b $00
[00020859 00025da9]                           dc.b $31
[0002085a 00025daa] 00020874                  dc.l $00020874 ; no symbol found
[0002085e 00025dae]                           dc.b $00
[0002085f 00025daf]                           dc.b $00
[00020860 00025db0]                           dc.b $00
[00020861 00025db1]                           dc.b $39
[00020862 00025db2] 0002086a                  dc.l $0002086a ; no symbol found
[00020866 00025db6]                           dc.b $00
[00020867 00025db7]                           dc.b $00
[00020868 00025db8]                           dc.b $00
[00020869 00025db9]                           dc.b $3f
[0002086a 00025dba]                           dc.w $0876
[0002086c 00025dbc]                           dc.b 'olatile',0
[00020874 00025dc4]                           dc.w $0875
[00020876 00025dc6]                           dc.b 'nsigned',0
[0002087e 00025dce]                           dc.w $0872
[00020880 00025dd0]                           dc.b 'egister',0
[00020888 00025dd8]                           dc.w $0863
[0002088a 00025dda]                           dc.b 'ontinue',0
[00020892 00025de2]                           dc.w $0774
[00020894 00025de4]                           dc.b 'ypedef',0
[0002089b 00025deb]                           dc.b $07
[0002089c 00025dec]                           dc.b 'default',0
[000208a4 00025df4]                           dc.w $0724
[000208a6 00025df6]                           dc.b 'noside',0
[000208ad 00025dfd]                           dc.b $06
[000208ae 00025dfe]                           dc.b 'switch',0
[000208b5 00025e05]                           dc.b $06
[000208b6 00025e06]                           dc.b 'struct',0
[000208bd 00025e0d]                           dc.b $06
[000208be 00025e0e]                           dc.b 'static',0
[000208c5 00025e15]                           dc.b $06
[000208c6 00025e16]                           dc.b 'sizeof',0
[000208cd 00025e1d]                           dc.b $06
[000208ce 00025e1e]                           dc.b 'signed',0
[000208d5 00025e25]                           dc.b $06
[000208d6 00025e26]                           dc.b 'return',0
[000208dd 00025e2d]                           dc.b $06
[000208de 00025e2e]                           dc.b 'extern',0
[000208e5 00025e35]                           dc.b $06
[000208e6 00025e36]                           dc.b 'double',0
[000208ed 00025e3d]                           dc.b $05
[000208ee 00025e3e]                           dc.b 'while',0
[000208f4 00025e44]                           dc.w $0575
[000208f6 00025e46]                           dc.b 'nion',0
[000208fb 00025e4b]                           dc.b $05
[000208fc 00025e4c]                           dc.b 'short',0
[00020902 00025e52]                           dc.w $0566
[00020904 00025e54]                           dc.b 'loat',0
[00020909 00025e59]                           dc.b $05
[0002090a 00025e5a]                           dc.b 'const',0
[00020910 00025e60]                           dc.w $0562
[00020912 00025e62]                           dc.b 'reak',0
[00020917 00025e67]                           dc.b $04
[00020918 00025e68]                           dc.b 'void',0
[0002091d 00025e6d]                           dc.b $04
[0002091e 00025e6e]                           dc.b 'long',0
[00020923 00025e73]                           dc.b $04
[00020924 00025e74]                           dc.b 'goto',0
[00020929 00025e79]                           dc.b $04
[0002092a 00025e7a]                           dc.b 'enum',0
[0002092f 00025e7f]                           dc.b $04
[00020930 00025e80]                           dc.b 'else',0
[00020935 00025e85]                           dc.b $04
[00020936 00025e86]                           dc.b 'char',0
[0002093b 00025e8b]                           dc.b $04
[0002093c 00025e8c]                           dc.b 'case',0
[00020941 00025e91]                           dc.b $04
[00020942 00025e92]                           dc.b 'auto',0
[00020947 00025e97]                           dc.b $03
[00020948 00025e98]                           dc.b 'int',0
[0002094c 00025e9c]                           dc.w $0366
[0002094e 00025e9e]                           dc.w $6f72
[00020950 00025ea0]                           dc.b $00
[00020951 00025ea1]                           dc.b $02
[00020952 00025ea2]                           dc.w $6966
[00020954 00025ea4]                           dc.b $00
[00020955 00025ea5]                           dc.b $02
[00020956 00025ea6]                           dc.w $646f
[00020958 00025ea8]                           dc.b $00

[00020959 00025ea9]                           dc.b ' '
[0002095a 00025eaa]                           dc.b 'illegal integer %b',0
[0002096d 00025ebd]                           dc.b $00
[0002096e 00025ebe]                           dc.b 'c4',0
[00020972 00025ec2]                           dc.b 'illegal float constant',0
[00020989 00025ed9]                           dc.b 'c8',0
[0002098c 00025edc]                           dc.b 'ccb',0
[00020990 00025ee0]                           dc.b 'c',0
[00020992 00025ee2]                           dc.b 'c4',0
[00020996 00025ee6]                           dc.b 'c',0
[00020998 00025ee8]                           dc.b 'c2b',0
[0002099c 00025eec]                           dc.b 'c2bb',0
[000209a2 00025ef2]                           dc.b 'ccp',0
[000209a6 00025ef6]                           dc.w 'cc',0

; switchtable in putls
[000209aa 00025efa] 00001ce4                  dc.l $00001ce4 ; no symbol found
[000209ae 00025efe]                           dc.l 7
[000209b2 00025f02] 00001c2e                  dc.l $00001c2e ; no symbol found
[000209b6 00025f06]                           dc.l 4
[000209ba 00025f0a] 00001c24                  dc.l $00001c24 ; no symbol found
[000209be 00025f0e]                           dc.l 1
[000209c2 00025f12] 00001c1a                  dc.l $00001c1a ; no symbol found
[000209c6 00025f16]                           dc.l 8
[000209ca 00025f1a] 00001c10                  dc.l $00001c10 ; no symbol found
[000209ce 00025f1e]                           dc.l 6
[000209d2 00025f22] 00001c04                  dc.l $00001c04 ; no symbol found
[000209d6 00025f26]                           dc.l 3
[000209da 00025f2a]                           dc.l 0
[000209de 00025f2e] 00001cea                  dc.l $00001cea ; no symbol found

[000209e2 00025f32]                           dc.b 'eExX',0
[000209e7 00025f37]                           dc.b $22
[000209e8 00025f38]                           dc.b $00
[000209e9 00025f39]                           dc.b $00
_pdefs:
[000209ea 00025f3a]                           dc.l 10,0,0,0,0,0,0,0,0,0,0
_ofile:
[00020a16 00025f66]                           dc.l 0
_errflag:
[00020a1a 00025f6a]                           dc.l 0
_liflag:
[00020a1e 00025f6e]                           dc.l 0
_oldflag:
[00020a22 00025f72]                           dc.l 0
_pasflag:
[00020a26 00025f76]                           dc.l 0
_stdflag:
[00020a2a 00025f7a]                           dc.l 0
_xflag:
[00020a2e 00025f7e]                           dc.l 0
_pchar:
[00020a32 00025f82]                           dc.l '#'
_schar:
[00020a36 00025f86]                           dc.l 0
_inif:
[00020a3a 00025f8a]                           dc.w 0
_inincl:
[00020a3c 00025f8c]                           dc.w 0
_escname:
[00020a3e 00025f8e]                           dc.b '\4$esc',0
_iprefix:
[00020a44 00025f94] 00020a48                  dc.l $00020a48 ; no symbol found
[00020a48 00025f98]                           dc.w $7c00
_mapfile:
[00020a4a 00025f9a]                           dc.l 0
__pname:
[00020a4e 00025f9e] 00020a52                  dc.l $00020a52 ; no symbol found
[00020a52 00025fa2]                           dc.w $7070
[00020a54 00025fa4]                           dc.b $00
[00020a55 00025fa5]                           dc.b $00
_pasline:
[00020a56 00025fa6]                           dc.l 0
_failincl:
[00020a5a 00025faa]                           dc.l 0
_pflag:
[00020a5e 00025fae]                           dc.l 1
_argc:
[00020a62 00025fb2]                           dc.l 0
_lineno:
[00020a66 00025fb6]                           dc.w 0
_nerrors:
[00020a68 00025fb8]                           dc.w 0
_errfd:
[00020a6a 00025fba]                           dc.w 2
_pincl:
[00020a6c 00025fbc]                           dc.l 0
_argv:
[00020a70 00025fc0]                           dc.l 0
_perr:
[00020a74 00025fc4]                           dc.l 0
_errbuf:
[00020a78 00025fc8]                           ds.b 128
_pptab:
[00020af8 00026048] 00020c5a                  dc.l $00020c5a ; "\2IF"
[00020afc 0002604c]                           dc.l 14
[00020b00 00026050] 00020c56                  dc.l $00020c56 ; "\2if"
[00020b04 00026054]                           dc.l 14
[00020b08 00026058] 00020c50                  dc.l $00020c50 ; "\4ELIF"
[00020b0c 0002605c]                           dc.l 11
[00020b10 00026060] 00020c4a                  dc.l $00020c4a ; "\4ELSE"
[00020b14 00026064]                           dc.l 12
[00020b18 00026068] 00020c44                  dc.l $00020c44 ; "\4LINE
[00020b1c 0002606c]                           dc.l 18
[00020b20 00026070] 00020c3e                  dc.l $00020c3e ; "\4elif"
[00020b24 00026074]                           dc.l 11
[00020b28 00026078] 00020c38                  dc.l $00020c38 ; "\4else"
[00020b2c 0002607c]                           dc.l 12
[00020b30 00026080] 00020c32                  dc.l $00020c32 ; "\4line"
[00020b34 00026084]                           dc.l 18
[00020b38 00026088] 00020c2b                  dc.l $00020c2b ; "\5ENDIF"
[00020b3c 0002608c]                           dc.l 13
[00020b40 00026090] 00020c24                  dc.l $00020c24 ; "\5ERROR"
[00020b44 00026094]                           dc.l 22
[00020b48 00026098] 00020c1d                  dc.l $00020c1d ; "\5IFDEF"
[00020b4c 0002609c]                           dc.l 15
[00020b50 000260a0] 00020c16                  dc.l $00020c16 ; "\5UNDEF"
[00020b54 000260a4]                           dc.l 21
[00020b58 000260a8] 00020c0f                  dc.l $00020c0f ; "\5endif"
[00020b5c 000260ac]                           dc.l 13
[00020b60 000260b0] 00020c08                  dc.l $00020c08 ; "\5error"
[00020b64 000260b4]                           dc.l 22
[00020b68 000260b8] 00020c01                  dc.l $00020c01 ; "\5ifdef"
[00020b6c 000260bc]                           dc.l 15
[00020b70 000260c0] 00020bfa                  dc.l $00020bfa ; "\5undef"
[00020b74 000260c4]                           dc.l 21
[00020b78 000260c8] 00020bf2                  dc.l $00020bf2 ; "\6DEFINE"
[00020b7c 000260cc]                           dc.l 10
[00020b80 000260d0] 00020bea                  dc.l $00020bea ; "\6IFNDEF"
[00020b84 000260d4]                           dc.l 16
[00020b88 000260d8] 00020be2                  dc.l $00020be2 ; "\6PRAGMA"
[00020b8c 000260dc]                           dc.l 19
[00020b90 000260e0] 00020bda                  dc.l $00020bda ; "\6define"
[00020b94 000260e4]                           dc.l 10
[00020b98 000260e8] 00020bd2                  dc.l $00020bd2 ; "\6ifndef"
[00020b9c 000260ec]                           dc.l 16
[00020ba0 000260f0] 00020bca                  dc.l $00020bca ; "\6pragma"
[00020ba4 000260f4]                           dc.l 19
[00020ba8 000260f8] 00020bc1                  dc.l $00020bc1 ; "\7INCLUDE"
[00020bac 000260fc]                           dc.l 17
[00020bb0 00026100] 00020bb8                  dc.l $00020bb8 ; "\7include"
[00020bb4 00026104]                           dc.l 17

[00020bb8 00026108]                           dc.w $0769
[00020bba 0002610a]                           dc.b 'nclude',0
[00020bc1 00026111]                           dc.b $07
[00020bc2 00026112]                           dc.b 'INCLUDE',0
[00020bca 0002611a]                           dc.w $0670
[00020bcc 0002611c]                           dc.b 'ragma',0
[00020bd2 00026122]                           dc.w $0669
[00020bd4 00026124]                           dc.b 'fndef',0
[00020bda 0002612a]                           dc.w $0664
[00020bdc 0002612c]                           dc.b 'efine',0
[00020be2 00026132]                           dc.w $0650
[00020be4 00026134]                           dc.b 'RAGMA',0
[00020bea 0002613a]                           dc.w $0649
[00020bec 0002613c]                           dc.b 'FNDEF',0
[00020bf2 00026142]                           dc.w $0644
[00020bf4 00026144]                           dc.b 'EFINE',0
[00020bfa 0002614a]                           dc.w $0575
[00020bfc 0002614c]                           dc.b 'ndef',0
[00020c01 00026151]                           dc.b $05
[00020c02 00026152]                           dc.b 'ifdef',0
[00020c08 00026158]                           dc.w $0565
[00020c0a 0002615a]                           dc.b 'rror',0
[00020c0f 0002615f]                           dc.b $05
[00020c10 00026160]                           dc.b 'endif',0
[00020c16 00026166]                           dc.w $0555
[00020c18 00026168]                           dc.b 'NDEF',0
[00020c1d 0002616d]                           dc.b $05
[00020c1e 0002616e]                           dc.b 'IFDEF',0
[00020c24 00026174]                           dc.w $0545
[00020c26 00026176]                           dc.b 'RROR',0
[00020c2b 0002617b]                           dc.b $05
[00020c2c 0002617c]                           dc.b 'ENDIF',0
[00020c32 00026182]                           dc.w $046c
[00020c34 00026184]                           dc.b 'ine',0
[00020c38 00026188]                           dc.w $0465
[00020c3a 0002618a]                           dc.b 'lse',0
[00020c3e 0002618e]                           dc.w $0465
[00020c40 00026190]                           dc.b 'lif',0
[00020c44 00026194]                           dc.w $044c
[00020c46 00026196]                           dc.b 'INE',0
[00020c4a 0002619a]                           dc.w $0445
[00020c4c 0002619c]                           dc.b 'LSE',0
[00020c50 000261a0]                           dc.w $0445
[00020c52 000261a2]                           dc.b 'LIF',0
[00020c56 000261a6]                           dc.w $0269
[00020c58 000261a8]                           dc.w $6600
[00020c5a 000261aa]                           dc.w $0249
[00020c5c 000261ac]                           dc.w $4600

; switchtable in getex()
[00020c5e 000261ae] 00001e30                  dc.l $00001e30 ; no symbol found
[00020c62 000261b2]                           dc.l 16
[00020c66 000261b6] 00001e30                  dc.l $00001e30 ; no symbol found
[00020c6a 000261ba]                           dc.l 15
[00020c6e 000261be] 00001e12                  dc.l $00001e12 ; no symbol found
[00020c72 000261c2]                           dc.l 11
[00020c76 000261c6] 00001e12                  dc.l $00001e12 ; no symbol found
[00020c7a 000261ca]                           dc.l 14
[00020c7e 000261ce] 00001e0e                  dc.l $00001e0e ; no symbol found
[00020c82 000261d2]                           dc.l 20
[00020c86 000261d6] 00001e0a                  dc.l $00001e0a ; no symbol found
[00020c8a 000261da]                           dc.l 21
[00020c8e 000261de] 00001e06                  dc.l $00001e06 ; no symbol found
[00020c92 000261e2]                           dc.l 10
[00020c96 000261e6] 00001df0                  dc.l $00001df0 ; no symbol found
[00020c9a 000261ea]                           dc.l 17
[00020c9e 000261ee]                           dc.l 0
[00020ca2 000261f2] 00001eb2                  dc.l $00001eb2 ; no symbol found

[00020ca6 000261f6]                           dc.b 'bad #%b',0
[00020cae 000261fe]                           dc.b '#line inside macro',0
[00020cc1 00026211]                           dc.b $00
[00020cc2 00026212]                           dc.l 0
getinl.flag:
[00020cc6 00026216]                           dc.l 0
getinl.linebuf:
[00020cca 0002621a]                           dc.l 0
[00020cce 0002621e]                           dc.w $0a00
[00020cd0 00026220]                           dc.b 'unbalanced comment in file',0
[00020ceb 0002623b]                           dc.b $00
[00020cec 0002623c]                           dc.b 'folded line',0
[00020cf8 00026248]                           dc.b 'misplaced #%b',0
[00020d06 00026256]                           dc.b 'can',$27,'t read map file: %p',0
[00020d1e 0002626e]                           dc.b 'can',$27,'t open map file: %p',0
[00020d36 00026286]                           dc.b 'ccp',0
[00020d3a 0002628a]                           dc.w 'c',0
[00020d3c 0002628c]                           dc.b 'can',$27,'t create ',0
[00020d4a 0002629a]                           dc.b 'd*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>',0
[00020d85 000262d5]                           dc.b $00
[00020d86 000262d6]                           dc.b 'missing #endif',0
[00020d95 000262e5]                           dc.b $00

; switchtable in putns
[00020d96 000262e6] 00002a5e                  dc.l $00002a5e ; no symbol found
[00020d9a 000262ea]                           dc.l 20
[00020d9e 000262ee] 00002a12                  dc.l $00002a12 ; no symbol found
[00020da2 000262f2]                           dc.l 19
[00020da6 000262f6] 000027a6                  dc.l $000027a6 ; no symbol found
[00020daa 000262fa]                           dc.l 18
[00020dae 000262fe] 000026ec                  dc.l $000026ec ; no symbol found
[00020db2 00026302]                           dc.l 17
[00020db6 00026306] 000026b4                  dc.l $000026b4 ; no symbol found
[00020dba 0002630a]                           dc.l 21
[00020dbe 0002630e] 000025c4                  dc.l $000025c4 ; no symbol found
[00020dc2 00026312]                           dc.l 10
[00020dc6 00026316] 00002524                  dc.l $00002524 ; no symbol found
[00020dca 0002631a]                           dc.l 22
[00020dce 0002631e]                           dc.l 0
[00020dd2 00026322] 00002a7c                  dc.l $00002a7c ; no symbol found

[00020dd6 00026326]                           dc.b 'bad #xxx',0
[00020ddf 0002632f]                           dc.b 'c',0
[00020de1 00026331]                           dc.b 'c',0
[00020de3 00026333]                           dc.b 'bad #line syntax',0
[00020df4 00026344]                           dc.b 'bad #line',0
[00020dfe 0002634e]                           dc.b 'can',$27,'t open #include!',0
[00020e13 00026363]                           dc.b 'can',$27,'t #include %p',0
[00020e25 00026375]                           dc.b 'bad #undef',0
[00020e30 00026380]                           dc.b 'redefined %b',0
[00020e3d 0002638d]                           dc.b 'bad #define',0
[00020e49 00026399]                           dc.b 'b',0
[00020e4b 0002639b]                           dc.b '2',0
[00020e4d 0002639d]                           dc.b 'c',0
[00020e4f 0002639f]                           dc.b $00
[00020e50 000263a0]                           dc.b $00
[00020e51 000263a1]                           dc.b $00
[00020e52 000263a2]                           dc.b $00
[00020e53 000263a3]                           dc.b $00
[00020e54 000263a4]                           dc.b $00
[00020e55 000263a5]                           dc.b $00
[00020e56 000263a6]                           dc.b $00
[00020e57 000263a7]                           dc.b $00
[00020e58 000263a8]                           dc.b $00
[00020e59 000263a9]                           dc.b $00
[00020e5a 000263aa]                           dc.b $00
[00020e5b 000263ab]                           dc.b $00
[00020e5c 000263ac]                           dc.b $00
[00020e5d 000263ad]                           dc.b $00
[00020e5e 000263ae]                           dc.b $00
[00020e5f 000263af]                           dc.b $00
[00020e60 000263b0]                           dc.b $00
[00020e61 000263b1]                           dc.b $00
[00020e62 000263b2]                           dc.b $00
[00020e63 000263b3]                           dc.b $00
[00020e64 000263b4]                           dc.b $00
[00020e65 000263b5]                           dc.b $00
[00020e66 000263b6]                           dc.b $00
[00020e67 000263b7]                           dc.b $00
[00020e68 000263b8]                           dc.b $00
[00020e69 000263b9]                           dc.b $00
[00020e6a 000263ba]                           dc.b $00
[00020e6b 000263bb]                           dc.b $00
[00020e6c 000263bc]                           dc.b $00
[00020e6d 000263bd]                           dc.b $00
[00020e6e 000263be]                           dc.b $00
[00020e6f 000263bf]                           dc.b $00
[00020e70 000263c0]                           dc.b $00
[00020e71 000263c1]                           dc.b $00
[00020e72 000263c2]                           dc.b $00
[00020e73 000263c3]                           dc.b $00
[00020e74 000263c4]                           dc.b $00
[00020e75 000263c5]                           dc.b $00
[00020e76 000263c6]                           dc.b $00
[00020e77 000263c7]                           dc.b $00
[00020e78 000263c8]                           dc.b $00
[00020e79 000263c9]                           dc.b $00
[00020e7a 000263ca]                           dc.b $00
[00020e7b 000263cb]                           dc.b $00
[00020e7c 000263cc]                           dc.b $00
[00020e7d 000263cd]                           dc.b $00
[00020e7e 000263ce]                           dc.b $00
[00020e7f 000263cf]                           dc.b $00
[00020e80 000263d0]                           dc.b $00
[00020e81 000263d1]                           dc.b $00
[00020e82 000263d2]                           dc.b $00
[00020e83 000263d3]                           dc.b $00
[00020e84 000263d4]                           dc.b $00
[00020e85 000263d5]                           dc.b $00
[00020e86 000263d6]                           dc.b $00
[00020e87 000263d7]                           dc.b $00
[00020e88 000263d8]                           dc.b $00
[00020e89 000263d9]                           dc.b $00
[00020e8a 000263da]                           dc.b $00
[00020e8b 000263db]                           dc.b $00
[00020e8c 000263dc]                           dc.b $00
[00020e8d 000263dd]                           dc.b $00
[00020e8e 000263de]                           dc.b $00
[00020e8f 000263df]                           dc.b $00
[00020e90 000263e0]                           dc.b $00
[00020e91 000263e1]                           dc.b $00
[00020e92 000263e2]                           dc.b $00
[00020e93 000263e3]                           dc.b $00
[00020e94 000263e4]                           dc.b $00
[00020e95 000263e5]                           dc.b $00
[00020e96 000263e6]                           dc.b $00
[00020e97 000263e7]                           dc.b $00
[00020e98 000263e8]                           dc.b $00
[00020e99 000263e9]                           dc.b $00
[00020e9a 000263ea]                           dc.b $00
[00020e9b 000263eb]                           dc.b $00
[00020e9c 000263ec]                           dc.b $00
[00020e9d 000263ed]                           dc.b $00
[00020e9e 000263ee]                           dc.b $00
[00020e9f 000263ef]                           dc.b $00
[00020ea0 000263f0]                           dc.b $00
[00020ea1 000263f1]                           dc.b $00
[00020ea2 000263f2]                           dc.b $00
[00020ea3 000263f3]                           dc.b $00
[00020ea4 000263f4]                           dc.b $00
[00020ea5 000263f5]                           dc.b $00
[00020ea6 000263f6]                           dc.b $00
[00020ea7 000263f7]                           dc.b $00
[00020ea8 000263f8]                           dc.b $00
[00020ea9 000263f9]                           dc.b $00
[00020eaa 000263fa]                           dc.b $00
[00020eab 000263fb]                           dc.b $00
[00020eac 000263fc]                           dc.b $00
[00020ead 000263fd]                           dc.b $00
[00020eae 000263fe]                           dc.b $00
[00020eaf 000263ff]                           dc.b $00
[00020eb0 00026400]                           dc.b $00
[00020eb1 00026401]                           dc.b $00
[00020eb2 00026402]                           dc.b $00
[00020eb3 00026403]                           dc.b $00
[00020eb4 00026404]                           dc.b $00
[00020eb5 00026405]                           dc.b $00
[00020eb6 00026406]                           dc.b $00
[00020eb7 00026407]                           dc.b $00
[00020eb8 00026408]                           dc.b $00
[00020eb9 00026409]                           dc.b $00
[00020eba 0002640a]                           dc.b $00
[00020ebb 0002640b]                           dc.b $00
[00020ebc 0002640c]                           dc.b $00
[00020ebd 0002640d]                           dc.b $00
[00020ebe 0002640e]                           dc.b $00
[00020ebf 0002640f]                           dc.b $00
[00020ec0 00026410]                           dc.b $00
[00020ec1 00026411]                           dc.b $00
[00020ec2 00026412]                           dc.b $00
[00020ec3 00026413]                           dc.b $00
[00020ec4 00026414]                           dc.b $00
[00020ec5 00026415]                           dc.b $00
[00020ec6 00026416]                           dc.b $00
[00020ec7 00026417]                           dc.b $00
[00020ec8 00026418]                           dc.b $00
[00020ec9 00026419]                           dc.b $00
[00020eca 0002641a]                           dc.b $00
[00020ecb 0002641b]                           dc.b $00
[00020ecc 0002641c]                           dc.b $00
[00020ecd 0002641d]                           dc.b $00
[00020ece 0002641e]                           dc.b $00
[00020ecf 0002641f]                           dc.b $00
[00020ed0 00026420]                           dc.b $00
[00020ed1 00026421]                           dc.b $00
[00020ed2 00026422]                           dc.b $00
[00020ed3 00026423]                           dc.b $00
[00020ed4 00026424]                           dc.b $00
[00020ed5 00026425]                           dc.b $00
[00020ed6 00026426]                           dc.b $00
[00020ed7 00026427]                           dc.b $00
[00020ed8 00026428]                           dc.b $00
[00020ed9 00026429]                           dc.b $00
[00020eda 0002642a]                           dc.b $00
[00020edb 0002642b]                           dc.b $00
[00020edc 0002642c]                           dc.b $00
[00020edd 0002642d]                           dc.b $00
[00020ede 0002642e]                           dc.b $00
[00020edf 0002642f]                           dc.b $00
[00020ee0 00026430]                           dc.b $00
[00020ee1 00026431]                           dc.b $00
[00020ee2 00026432]                           dc.b $00
[00020ee3 00026433]                           dc.b $00
[00020ee4 00026434]                           dc.b $00
[00020ee5 00026435]                           dc.b $00
[00020ee6 00026436]                           dc.b $00
[00020ee7 00026437]                           dc.b $00
[00020ee8 00026438]                           dc.b $00
[00020ee9 00026439]                           dc.b $00
[00020eea 0002643a]                           dc.b $00
[00020eeb 0002643b]                           dc.b $00
[00020eec 0002643c]                           dc.b $00
[00020eed 0002643d]                           dc.b $00
[00020eee 0002643e]                           dc.b $00
[00020eef 0002643f]                           dc.b $00
[00020ef0 00026440]                           dc.b $00
[00020ef1 00026441]                           dc.b $00
[00020ef2 00026442]                           dc.b $00
[00020ef3 00026443]                           dc.b $00
[00020ef4 00026444]                           dc.b $00
[00020ef5 00026445]                           dc.b $00
[00020ef6 00026446]                           dc.b $00
[00020ef7 00026447]                           dc.b $00
[00020ef8 00026448]                           dc.b $00
[00020ef9 00026449]                           dc.b $00
[00020efa 0002644a]                           dc.b $00
[00020efb 0002644b]                           dc.b $00
[00020efc 0002644c]                           dc.b $00
[00020efd 0002644d]                           dc.b $00
[00020efe 0002644e]                           dc.b $00
[00020eff 0002644f]                           dc.b $00
[00020f00 00026450]                           dc.b $00
[00020f01 00026451]                           dc.b $00
[00020f02 00026452]                           dc.b $00
[00020f03 00026453]                           dc.b $00
[00020f04 00026454]                           dc.b $00
[00020f05 00026455]                           dc.b $00
[00020f06 00026456]                           dc.b $00
[00020f07 00026457]                           dc.b $00
[00020f08 00026458]                           dc.b $00
[00020f09 00026459]                           dc.b $00
[00020f0a 0002645a]                           dc.b $00
[00020f0b 0002645b]                           dc.b $00
[00020f0c 0002645c]                           dc.b $00
[00020f0d 0002645d]                           dc.b $00
[00020f0e 0002645e]                           dc.b $00
[00020f0f 0002645f]                           dc.b $00
[00020f10 00026460]                           dc.b $00
[00020f11 00026461]                           dc.b $00
[00020f12 00026462]                           dc.b $00
[00020f13 00026463]                           dc.b $00
[00020f14 00026464]                           dc.b $00
[00020f15 00026465]                           dc.b $00
[00020f16 00026466]                           dc.b $00
[00020f17 00026467]                           dc.b $00
[00020f18 00026468]                           dc.b $00
[00020f19 00026469]                           dc.b $00
[00020f1a 0002646a]                           dc.b $00
[00020f1b 0002646b]                           dc.b $00
[00020f1c 0002646c]                           dc.b $00
[00020f1d 0002646d]                           dc.b $00
[00020f1e 0002646e]                           dc.b $00
[00020f1f 0002646f]                           dc.b $00
[00020f20 00026470]                           dc.b $00
[00020f21 00026471]                           dc.b $00
[00020f22 00026472]                           dc.b $00
[00020f23 00026473]                           dc.b $00
[00020f24 00026474]                           dc.b $00
[00020f25 00026475]                           dc.b $00
[00020f26 00026476]                           dc.b $00
[00020f27 00026477]                           dc.b $00
[00020f28 00026478]                           dc.b $00
[00020f29 00026479]                           dc.b $00
[00020f2a 0002647a]                           dc.b $00
[00020f2b 0002647b]                           dc.b $00
[00020f2c 0002647c]                           dc.b $00
[00020f2d 0002647d]                           dc.b $00
[00020f2e 0002647e]                           dc.b $00
[00020f2f 0002647f]                           dc.b $00
[00020f30 00026480]                           dc.b $00
[00020f31 00026481]                           dc.b $00
[00020f32 00026482]                           dc.b $00
[00020f33 00026483]                           dc.b $00
[00020f34 00026484]                           dc.b $00
[00020f35 00026485]                           dc.b $00
[00020f36 00026486]                           dc.b $00
[00020f37 00026487]                           dc.b $00
[00020f38 00026488]                           dc.b $00
[00020f39 00026489]                           dc.b $00
[00020f3a 0002648a]                           dc.b $00
[00020f3b 0002648b]                           dc.b $00
[00020f3c 0002648c]                           dc.b $00
[00020f3d 0002648d]                           dc.b $00
[00020f3e 0002648e]                           dc.b $00
[00020f3f 0002648f]                           dc.b $00
[00020f40 00026490]                           dc.b $00
[00020f41 00026491]                           dc.b $00
[00020f42 00026492]                           dc.b $00
[00020f43 00026493]                           dc.b $00
[00020f44 00026494]                           dc.b $00
[00020f45 00026495]                           dc.b $00
[00020f46 00026496]                           dc.b $00
[00020f47 00026497]                           dc.b $00
[00020f48 00026498]                           dc.b $00
[00020f49 00026499]                           dc.b $00
[00020f4a 0002649a]                           dc.b $00
[00020f4b 0002649b]                           dc.b $00
[00020f4c 0002649c]                           dc.b $00
[00020f4d 0002649d]                           dc.b $00
[00020f4e 0002649e]                           dc.b $00
[00020f4f 0002649f]                           dc.b $00
[00020f50 000264a0]                           dc.b $00
[00020f51 000264a1]                           dc.b $00
[00020f52 000264a2]                           dc.b $00
[00020f53 000264a3]                           dc.b $00
[00020f54 000264a4]                           dc.b $00
[00020f55 000264a5]                           dc.b $00
[00020f56 000264a6]                           dc.b $00
[00020f57 000264a7]                           dc.b $00
[00020f58 000264a8]                           dc.b $00
[00020f59 000264a9]                           dc.b $00
[00020f5a 000264aa]                           dc.b $00
[00020f5b 000264ab]                           dc.b $00
[00020f5c 000264ac]                           dc.b $00
[00020f5d 000264ad]                           dc.b $00
[00020f5e 000264ae]                           dc.b $00
[00020f5f 000264af]                           dc.b $00
[00020f60 000264b0]                           dc.b $00
[00020f61 000264b1]                           dc.b $00
[00020f62 000264b2]                           dc.b $00
[00020f63 000264b3]                           dc.b $00
[00020f64 000264b4]                           dc.b $00
[00020f65 000264b5]                           dc.b $00
[00020f66 000264b6]                           dc.b $00
[00020f67 000264b7]                           dc.b $00
[00020f68 000264b8]                           dc.b $00
[00020f69 000264b9]                           dc.b $00
[00020f6a 000264ba]                           dc.b $00
[00020f6b 000264bb]                           dc.b $00
[00020f6c 000264bc]                           dc.b $00
[00020f6d 000264bd]                           dc.b $00
[00020f6e 000264be]                           dc.b $00
[00020f6f 000264bf]                           dc.b $00
[00020f70 000264c0]                           dc.b $00
[00020f71 000264c1]                           dc.b $00
[00020f72 000264c2]                           dc.b $00
[00020f73 000264c3]                           dc.b $00
[00020f74 000264c4]                           dc.b $00
[00020f75 000264c5]                           dc.b $00
[00020f76 000264c6]                           dc.b $00
[00020f77 000264c7]                           dc.b $00
[00020f78 000264c8]                           dc.b $00
[00020f79 000264c9]                           dc.b $00
[00020f7a 000264ca]                           dc.b $00
[00020f7b 000264cb]                           dc.b $00
[00020f7c 000264cc]                           dc.b $00
[00020f7d 000264cd]                           dc.b $00
[00020f7e 000264ce]                           dc.b $00
[00020f7f 000264cf]                           dc.b $00
[00020f80 000264d0]                           dc.b $00
[00020f81 000264d1]                           dc.b $00
[00020f82 000264d2]                           dc.b $00
[00020f83 000264d3]                           dc.b $00
[00020f84 000264d4]                           dc.b $00
[00020f85 000264d5]                           dc.b $00
[00020f86 000264d6]                           dc.b $00
[00020f87 000264d7]                           dc.b $00
[00020f88 000264d8]                           dc.b $00
[00020f89 000264d9]                           dc.b $00
[00020f8a 000264da]                           dc.b $00
[00020f8b 000264db]                           dc.b $00
[00020f8c 000264dc]                           dc.b $00
[00020f8d 000264dd]                           dc.b $00
[00020f8e 000264de]                           dc.b $00
[00020f8f 000264df]                           dc.b $00
[00020f90 000264e0]                           dc.b $00
[00020f91 000264e1]                           dc.b $00
[00020f92 000264e2]                           dc.b $00
[00020f93 000264e3]                           dc.b $00
[00020f94 000264e4]                           dc.b $00
[00020f95 000264e5]                           dc.b $00
[00020f96 000264e6]                           dc.b $00
[00020f97 000264e7]                           dc.b $00
[00020f98 000264e8]                           dc.b $00
[00020f99 000264e9]                           dc.b $00
[00020f9a 000264ea]                           dc.b $00
[00020f9b 000264eb]                           dc.b $00
[00020f9c 000264ec]                           dc.b $00
[00020f9d 000264ed]                           dc.b $00
[00020f9e 000264ee]                           dc.b $00
[00020f9f 000264ef]                           dc.b $00
[00020fa0 000264f0]                           dc.b $00
[00020fa1 000264f1]                           dc.b $00
[00020fa2 000264f2]                           dc.b $00
[00020fa3 000264f3]                           dc.b $00
[00020fa4 000264f4]                           dc.b $00
[00020fa5 000264f5]                           dc.b $00
[00020fa6 000264f6]                           dc.b $00
[00020fa7 000264f7]                           dc.b $00
[00020fa8 000264f8]                           dc.b $00
[00020fa9 000264f9]                           dc.b $00
[00020faa 000264fa]                           dc.b $00
[00020fab 000264fb]                           dc.b $00
[00020fac 000264fc]                           dc.b $00
[00020fad 000264fd]                           dc.b $00
[00020fae 000264fe]                           dc.b $00
[00020faf 000264ff]                           dc.b $00
[00020fb0 00026500]                           dc.b $00
[00020fb1 00026501]                           dc.b $00
[00020fb2 00026502]                           dc.b $00
[00020fb3 00026503]                           dc.b $00
[00020fb4 00026504]                           dc.b $00
[00020fb5 00026505]                           dc.b $00
[00020fb6 00026506]                           dc.b $00
[00020fb7 00026507]                           dc.b $00
[00020fb8 00026508]                           dc.b $00
[00020fb9 00026509]                           dc.b $00
[00020fba 0002650a]                           dc.b $00
[00020fbb 0002650b]                           dc.b $00
[00020fbc 0002650c]                           dc.b $00
[00020fbd 0002650d]                           dc.b $00
[00020fbe 0002650e]                           dc.b $00
[00020fbf 0002650f]                           dc.b $00
[00020fc0 00026510]                           dc.b $00
[00020fc1 00026511]                           dc.b $00
[00020fc2 00026512]                           dc.b $00
[00020fc3 00026513]                           dc.b $00
[00020fc4 00026514]                           dc.b $00
[00020fc5 00026515]                           dc.b $00
[00020fc6 00026516]                           dc.b $00
[00020fc7 00026517]                           dc.b $00
[00020fc8 00026518]                           dc.b $00
[00020fc9 00026519]                           dc.b $00
[00020fca 0002651a]                           dc.b $00
[00020fcb 0002651b]                           dc.b $00
[00020fcc 0002651c]                           dc.b $00
[00020fcd 0002651d]                           dc.b $00
[00020fce 0002651e]                           dc.b $00
[00020fcf 0002651f]                           dc.b $00
[00020fd0 00026520]                           dc.b $00
[00020fd1 00026521]                           dc.b $00
[00020fd2 00026522]                           dc.b $00
[00020fd3 00026523]                           dc.b $00
[00020fd4 00026524]                           dc.b $00
[00020fd5 00026525]                           dc.b $00
[00020fd6 00026526]                           dc.b $00
[00020fd7 00026527]                           dc.b $00
[00020fd8 00026528]                           dc.b $00
[00020fd9 00026529]                           dc.b $00
[00020fda 0002652a]                           dc.b $00
[00020fdb 0002652b]                           dc.b $00
[00020fdc 0002652c]                           dc.b $00
[00020fdd 0002652d]                           dc.b $00
[00020fde 0002652e]                           dc.b $00
[00020fdf 0002652f]                           dc.b $00
[00020fe0 00026530]                           dc.b $00
[00020fe1 00026531]                           dc.b $00
[00020fe2 00026532]                           dc.b $00
[00020fe3 00026533]                           dc.b $00
[00020fe4 00026534]                           dc.b $00
[00020fe5 00026535]                           dc.b $00
[00020fe6 00026536]                           dc.b $00
[00020fe7 00026537]                           dc.b $00
[00020fe8 00026538]                           dc.b $00
[00020fe9 00026539]                           dc.b $00
[00020fea 0002653a]                           dc.b $00
[00020feb 0002653b]                           dc.b $00
[00020fec 0002653c]                           dc.b $00
[00020fed 0002653d]                           dc.b $00
[00020fee 0002653e]                           dc.b $00
[00020fef 0002653f]                           dc.b $00
[00020ff0 00026540]                           dc.b $00
[00020ff1 00026541]                           dc.b $00
[00020ff2 00026542]                           dc.b $00
[00020ff3 00026543]                           dc.b $00
[00020ff4 00026544]                           dc.b $00
[00020ff5 00026545]                           dc.b $00
[00020ff6 00026546]                           dc.b $00
[00020ff7 00026547]                           dc.b $00
[00020ff8 00026548]                           dc.b $00
[00020ff9 00026549]                           dc.b $00
[00020ffa 0002654a]                           dc.b $00
[00020ffb 0002654b]                           dc.b $00
[00020ffc 0002654c]                           dc.b $00
[00020ffd 0002654d]                           dc.b $00
[00020ffe 0002654e]                           dc.b $00
[00020fff 0002654f]                           dc.b $00
[00021000 00026550]                           dc.b $00
[00021001 00026551]                           dc.b $00
[00021002 00026552]                           dc.b $00
[00021003 00026553]                           dc.b $00
[00021004 00026554]                           dc.b $00
[00021005 00026555]                           dc.b $00
[00021006 00026556]                           dc.b $00
[00021007 00026557]                           dc.b $00
[00021008 00026558]                           dc.b $00
[00021009 00026559]                           dc.b $00
[0002100a 0002655a]                           dc.b $00
[0002100b 0002655b]                           dc.b $00
[0002100c 0002655c]                           dc.b $00
[0002100d 0002655d]                           dc.b $00
[0002100e 0002655e]                           dc.b $00
[0002100f 0002655f]                           dc.b $00
[00021010 00026560]                           dc.b $00
[00021011 00026561]                           dc.b $00
[00021012 00026562]                           dc.b $00
[00021013 00026563]                           dc.b $00
[00021014 00026564]                           dc.b $00
[00021015 00026565]                           dc.b $00
[00021016 00026566]                           dc.b $00
[00021017 00026567]                           dc.b $00
[00021018 00026568]                           dc.b $00
[00021019 00026569]                           dc.b $00
[0002101a 0002656a]                           dc.b $00
[0002101b 0002656b]                           dc.b $00
[0002101c 0002656c]                           dc.b $00
[0002101d 0002656d]                           dc.b $00
[0002101e 0002656e]                           dc.b $00
[0002101f 0002656f]                           dc.b $00
[00021020 00026570]                           dc.b $00
[00021021 00026571]                           dc.b $00
[00021022 00026572]                           dc.b $00
[00021023 00026573]                           dc.b $00
[00021024 00026574]                           dc.b $00
[00021025 00026575]                           dc.b $00
[00021026 00026576]                           dc.b $00
[00021027 00026577]                           dc.b $00
[00021028 00026578]                           dc.b $00
[00021029 00026579]                           dc.b $00
[0002102a 0002657a]                           dc.b $00
[0002102b 0002657b]                           dc.b $00
[0002102c 0002657c]                           dc.b $00
[0002102d 0002657d]                           dc.b $00
[0002102e 0002657e]                           dc.b $00
[0002102f 0002657f]                           dc.b $00
[00021030 00026580]                           dc.b $00
[00021031 00026581]                           dc.b $00
[00021032 00026582]                           dc.b $00
[00021033 00026583]                           dc.b $00
[00021034 00026584]                           dc.b $00
[00021035 00026585]                           dc.b $00
[00021036 00026586]                           dc.b $00
[00021037 00026587]                           dc.b $00
[00021038 00026588]                           dc.b $00
[00021039 00026589]                           dc.b $00
[0002103a 0002658a]                           dc.b $00
[0002103b 0002658b]                           dc.b $00
[0002103c 0002658c]                           dc.b $00
[0002103d 0002658d]                           dc.b $00
[0002103e 0002658e]                           dc.b $00
[0002103f 0002658f]                           dc.b $00
[00021040 00026590]                           dc.b $00
[00021041 00026591]                           dc.b $00
[00021042 00026592]                           dc.b $00
[00021043 00026593]                           dc.b $00
[00021044 00026594]                           dc.b $00
[00021045 00026595]                           dc.b $00
[00021046 00026596]                           dc.b $00
[00021047 00026597]                           dc.b $00
[00021048 00026598]                           dc.b $00
[00021049 00026599]                           dc.b $00
[0002104a 0002659a]                           dc.b $00
[0002104b 0002659b]                           dc.b $00
[0002104c 0002659c]                           dc.b $00
[0002104d 0002659d]                           dc.b $00
[0002104e 0002659e]                           dc.b $00
[0002104f 0002659f]                           dc.b $00
[00021050 000265a0]                           dc.b $00
[00021051 000265a1]                           dc.b $00
[00021052 000265a2]                           dc.b $00
[00021053 000265a3]                           dc.b $00
[00021054 000265a4]                           dc.b 'can',$27,'t open %p',0
[00021062 000265b2]                           dc.w 'cb',0
[00021065 000265b5]                           dc.b '\n',0
[00021067 000265b7]                           dc.b '\t',0
[00021069 000265b9]                           dc.b ':',0
[0002106b 000265bb]                           dc.b ' ',0
[0002106d 000265bd]                           dc.b '#error ',0
[00021075 000265c5]                           dc.b '%p%p%p%p%p%s%p',0
[00021084 000265d4]                           dc.b 'EOF: ',0
[0002108a 000265da]                           dc.b '-d %b redefined',0
[0002109a 000265ea]                           dc.b ' 1',$0a,0
[0002109e 000265ee]                           dc.w $283d
[000210a0 000265f0]                           dc.b $00
[000210a1 000265f1]                           dc.b $00
[000210a2 000265f2]                           dc.w 'c2',0
[000210a5 000265f5]                           dc.b $00
[000210a6 000265f6]                           dc.w $0a00
[000210a8 000265f8]                           dc.b 'unbalanced %c',0
;
00000000 T start
00000080 T _exit
000000aa T _onexit
000000ba T seterr
000000c6 T _builtin
00000342 T _dodef
00000708 T _doexp
0000084a T _doif
000008f6 T _getargs
00000a74 T _undef
00000afa T _dobesc
00000ca6 T _dopunct
00000d80 T _eval
00000dd2 T _exop
00000e16 T _expr
00000e70 T _expri
00000eb6 T _extail
00001130 T _exterm
000012da T _bton
0000145a T _flaccum
000014cc T _lexchars
00001552 T _lexfloat
00001772 T _lexfnxt
000017c2 T _lexident
00001874 T _lexint
000018e6 T _lexpunct
0000190e T _lexstrin
00001960 T _lexxstr
000019aa T _putcode
00001ab2 T _putfile
00001b42 T _putls
00001d30 T _getex
00001ecc T _getinl
00002018 T _getln
000020bc T _main
0000231c T _putgr
00002508 T _putns
00002a88 T _buytl
00002b00 T _fatal
00002b20 T _fretlist
00002b56 T _getfinclude
00002dda T _hash
00002e22 T _install
00002e8a T _lookup
00002efe T _nxtfile
00002fba T _perrfmt
0000310e T _p0error
00003236 T _predef
00003322 T _ptline
0000336e T _scntab
0000340e T _stotl
000037f0 T _fclose
0000389e T _fread
000038f2 T _frelst
00003924 T _getfiles
00003ac8 T _getflags
00003f04 T _inbuf
00003f4a T _itob
00003fe4 T _putlin
0000400c T _usage
00004082 T _buybuf
000040b6 T _cmpstr
000040ec T _create
00004166 T _doesc
000042c0 T _finit
00004358 T _getenv
000043b4 T _getl
0000446c T _instr
000044ae T a.lmod
000044c0 T a.ldiv
0000450e T _lseek
00004588 T _open
00004590 T _putc
00004648 T _putl
0000472a T _read
00004732 T _scnstr
00004768 T _seek
00004770 T a.switch
00004782 T a.ulmod
0000478a T a.uldiv
000047c6 T _uname
0000486e T _alloc
000048a8 T _nalloc
000049de T _free
00004aa0 T _btol
00004cd6 T _close
00004cde T _cmpbuf
00004d14 T _cpybuf
00004d3e T _creat
00004d46 T a.1sub
00004d5a T a.6sub
00004d84 T a.1add
00004d98 T a.6add
00004e46 T _dtento
00004fc2 T _fstat
00004fca T _getpid
00004fd0 T a.lmul
00004ffc T a.1ltd
00005004 T a.6ltd
0000502c T _putstr
00005062 T _sbreak
000050a6 T a.1div
000050ba T a.6div
000051c6 T a.1mul
000051da T a.6mul
000052ba T _fwrite
000052f4 T _lenstr
00005316 T __raise
000053b2 T __when
000053f8 T a.repk
0000548c T a.unpk
0000550a T _error
00005548 T _write

00020000 00025550 D __data
00020072 000255c2 D _environ
00020076 000255c6 D _errno
0002007a 000255ca D __paths
00020082 000255d2 D _bltintab
000204e6 00025a36 D _cmap
000205e6 00025b36 D _digfr
000205fd 00025b4d D _digto
00020a1a 00025f6a D _errflag
00020a1e 00025f6e D _liflag
00020a22 00025f72 D _oldflag
00020a26 00025f76 D _pasflag
00020a2a 00025f7a D _stdflag
00020a2e 00025f7e D _xflag
00020a32 00025f82 D _pchar
00020a36 00025f86 D _schar
00020a3a 00025f8a D _inif
00020a3c 00025f8c D _inincl
00020a3e 00025f8e D _escname
00020a44 00025f94 D _iprefix
00020a4a 00025f9a D _mapfile
00020a4e 00025f9e D __pname
00020a56 00025fa6 D _pasline
00020a5a 00025faa D _failincl
00020a5e 00025fae D _pflag
00020a62 00025fb2 D _argc
00020a66 00025fb6 D _lineno
00020a68 00025fb8 D _nerrors
00020a6a 00025fba D _errfd
00020a6c 00025fbc D _pincl
00020a70 00025fc0 D _argv
00020a74 00025fc4 D _perr
00020a78 00025fc8 D _errbuf
00021114 00026664 D _stdout
00021336 00026886 D __pfio
0002133e 0002688e D _readerr
00021378 000268c8 D _fioerr
0002138e 000268de D __memerr
000213a0 000268f0 D __stop
000213a4 000268f4 D __dtens
000213f4 00026944 D __dzero
000213fc 0002694c D __ntens
0002141a 0002696a D _writerr

00021430 00026980 B _end
