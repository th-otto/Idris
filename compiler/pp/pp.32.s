; a_magic   = 0x992d
; a_text    = 0x000056ae
; a_data    = 0x000024ea
; a_bss     = 0x00000000
; a_syms    = 0x00000a00
; a_heap    = 0x00020000
; a_textoff = 0x00000000
; a_dataoff = 0x000056ae
; a_relocs  = 0x00000848@0x000085b4

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
	lea.l      $0000AE44,a0
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
	clr.l      d7
	move.w     (a2),d7
	move.l     d7,-(a7)
	move.l     #$0000AE3A,-(a7)
	jsr        _itob
	lea.l      12(a7),a7
	move.l     d7,20(a4)
	moveq.l    #4,d0
	move.l     d0,4(a4)
	move.l     #$0000AE3A,16(a4)
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
	move.l     #$0000AE85,d7
	bra.s      x19e_6
x19e_5:
	move.l     #$0000AE83,d7
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
	move.l     #$0000AE70,(a7) "bad defined syntax"
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
	move.l     #$0000AE6E,d7
	bra.s      x19e_10
x19e_9:
	move.l     #$0000AE6C,d7
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
	lea.l      -26(a6),a2
	movea.l    a2,a5
	clr.w      -12(a6)
	clr.w      -14(a6)
	lea.l      ($0000000C).w,a2
	adda.l     8(a6),a2
	tst.l      (a2)
	bne.s      _dodef_1
	lea.l      ($00000014).w,a2
	adda.l     8(a6),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _dodef_1
	lea.l      ($00000010).w,a2
	adda.l     8(a6),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0028,d7
	beq.s      _dodef_2
_dodef_1:
	movea.l    8(a6),a4
_dodef_9:
	move.l     16(a6),-4(a6)
	clr.w      -10(a6)
_dodef_4:
	tst.l      -4(a6)
	beq        _dodef_3
	movea.l    -4(a6),a2
	move.l     (a2),-4(a6)
	addq.w     #1,-10(a6)
	bra.s      _dodef_4
_dodef_2:
	movea.l    8(a6),a2
	movea.l    (a2),a4
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
	move.l     #$0000AEB9,(a7) "bad #define arguments"
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
	move.l     #$0000AEA1,(a7) "too few macro arguments"
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
	move.l     #$0000AE88,(a7) "too many macro arguments"
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
	move.l     #$0000AE20,-(a7)
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
	move.l     #$0000AEDE,(a7) "$if expects arguments"
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
	move.l     #$0000AED0,(a7) "bad $if(test)"
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
	move.l     #$0000AE20,-(a7)
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
	move.l     d7,(a3)
	beq.s      _getargs_12
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
	move.l     #$0000AEF4,(a7) "bad macro arguments"
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
	move.l     #$0000B370,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.b     d7,-13(a6)
	clr.l      d7
	move.b     -13(a6),d7
	movea.l    d7,a2
	adda.l     #$0000B370,a2
	tst.b      (a2)
	beq.s      _dobesc_7
	movea.l    #$0000B37C,a2
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
	move.l     #$0000B388,-(a7) "illegal character: %c"
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
	move.l     #$0000B39E,(a7) "illegal #if expression"
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
	move.l     #$0000AF08,-(a7)
	jsr        _scnstr
	addq.l     #4,a7
	move.l     d7,d4
	movea.l    d4,a2
	adda.l     #$0000AF08,a2
	tst.b      (a2)
	bne.s      _expri_2
_expri_1:
	clr.l      d7
	bra.s      _expri_3
_expri_2:
	movea.l    d4,a2
	adda.l     #$0000AF1C,a2
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
	lea.l      $0000B3B6,a0
	jmp        a.switch
	move.l     -12(a6),d7
	add.l      d7,-4(a6)
_extail_7:
	movea.l    12(a6),a2
	move.l     -4(a6),(a2)
	movea.l    16(a6),a2
	move.l     -16(a6),(a2)
	bra        _extail_6
	move.l     -8(a6),-4(a6)
	bra.s      _extail_7
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.lmul
	move.l     (a7),-4(a6)
	bra.s      _extail_7
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.ldiv
	move.l     (a7),-4(a6)
	bra.s      _extail_7
	move.l     -4(a6),(a7)
	move.l     -12(a6),-(a7)
	jsr        a.lmod
	move.l     (a7),-4(a6)
	bra.s      _extail_7
	move.l     -12(a6),d7
	and.l      d7,-4(a6)
	bra.s      _extail_7
	move.l     -12(a6),d7
	or.l       d7,-4(a6)
	bra.s      _extail_7
	move.l     -12(a6),d7
	eor.l      d7,-4(a6)
	bra.s      _extail_7
	move.l     -4(a6),d7
	move.l     -12(a6),d6
	asl.l      d6,d7
	move.l     d7,-4(a6)
	bra        _extail_7
	move.l     -4(a6),d7
	move.l     -12(a6),d6
	asr.l      d6,d7
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	bge.s      _extail_8
	moveq.l    #1,d7
	bra.s      _extail_9
_extail_8:
	clr.l      d7
_extail_9:
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	bne.s      _extail_10
	moveq.l    #1,d7
	bra.s      _extail_11
_extail_10:
	clr.l      d7
_extail_11:
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	ble.s      _extail_12
	moveq.l    #1,d7
	bra.s      _extail_13
_extail_12:
	clr.l      d7
_extail_13:
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	bgt.s      _extail_14
	moveq.l    #1,d7
	bra.s      _extail_15
_extail_14:
	clr.l      d7
_extail_15:
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	beq.s      _extail_16
	moveq.l    #1,d7
	bra.s      _extail_17
_extail_16:
	clr.l      d7
_extail_17:
	move.l     d7,-4(a6)
	bra        _extail_7
	tst.l      -8(a6)
	blt.s      _extail_18
	moveq.l    #1,d7
	bra.s      _extail_19
_extail_18:
	clr.l      d7
_extail_19:
	move.l     d7,-4(a6)
	bra        _extail_7
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
	move.l     #$0000B46E,(a7) "illegal ? : in #if"
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
	move.l     #$0000B456,(a7) "illegal operator in #if"
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
	move.l     #$0000B49A,(a7) "illegal #if syntax"
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
	move.l     #$0000B4AD,(a7) "missing ) in #if"
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
	move.l     #$0000B482,(a7) "illegal unary op in #if"
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
	move.l     #$0000B6B8,-(a7) "illegal integer %b"
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
	lea.l      $0000D1D4,a0
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
	move.l     #$0000B6CC,-(a7)
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
	move.l     #$0000B6E7,-(a7)
	jsr        _putcode "c8"
	lea.l      12(a7),a7
	cmpa.l     #$0000B6B5,a5 " " space
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
	move.l     #$0000B6D0,(a7) "illegal float constant"
	jsr        _p0error
	bra.s      _lexfloat_12

_lexfnxt:
	link       a6,#0
	movem.l    d0/a5,-(a7)
	movea.l    8(a6),a2
	movea.l    (a2),a5
	move.l     12(a6),d7
	cmpi.l     #$0000B6B5,d7 " " space
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
	move.l     #$0000B6B5,d7 " " space
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
	move.l     #$0000B8B5,-(a7)
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
	move.l     #$0000B6EE,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	bra.s      _lexident_6
_lexident_5:
	move.l     d5,(a7)
	move.l     16(a5),-(a7)
	move.l     d5,-(a7)
	pea.l      ($00000012).w
	move.l     #$0000B6EA,-(a7)
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
	moveq.l    #25,d7
	bra.s      _lexint_4
_lexint_3:
	moveq.l    #21,d7
_lexint_4:
	move.b     d7,-13(a6)
	bra.s      _lexint_5
_lexint_1:
	tst.l      -8(a6)
	beq.s      _lexint_6
	moveq.l    #26,d7
	bra.s      _lexint_7
_lexint_6:
	moveq.l    #22,d7
_lexint_7:
	move.b     d7,-13(a6)
_lexint_5:
	pea.l      -12(a6)
	move.b     -13(a6),d7
	ext.w      d7
	ext.l      d7
	move.l     d7,-(a7)
	move.l     #$0000B6F0,-(a7)
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
	move.l     #$0000B6F4,-(a7)
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
	move.l     #$0000B6F6,-(a7)
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
	move.l     #$0000B6FA,-(a7)
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
	move.w     $0000CF8C,d7
	ext.l      d7
	cmpi.w     #$0200,d7
	bge.s      _putcode_3
	move.w     $0000CF8C,d7
	ext.l      d7
	movea.l    d7,a2
	addq.w     #1,$0000CF8C
	adda.l     #$0000CF94,a2
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
	move.w     $0000CF8C,d7
	ext.l      d7
	cmpi.w     #$0200,d7
	bge.s      _putcode_10
	move.w     $0000CF8C,d7
	ext.l      d7
	movea.l    d7,a2
	addq.w     #1,$0000CF8C
	adda.l     #$0000CF94,a2
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

_putfile:
	link       a6,#0
	movem.l    d0/d5,-(a7)
	tst.l      _xflag
	beq.s      _putfile_1
	tst.l      _pincl
	beq.s      _putfile_1
	tst.l      _pflag
	beq.s      _putfile_1
	tst.w      _inincl
	beq        _putfile_2
	tst.l      _liflag
	bne        _putfile_2
_putfile_1:
	tst.l      _cplusflag
	beq        _putfile_3
	tst.l      _pincl
	beq        _putfile_3
	tst.l      _pflag
	beq        _putfile_3
	tst.l      _xflag
	bne        _putfile_3
	clr.l      _pflag
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	beq        _putfile_4
	pea.l      ($0000000A).w
	movea.l    _pincl,a2
	addq.l     #8,a2
	tst.w      (a2)
	beq.s      _putfile_5
	movea.l    _pincl,a2
	addq.l     #8,a2
	clr.l      d7
	move.w     (a2),d7
	bra.s      _putfile_6
_putfile_5:
	movea.l    _pincl,a2
	addq.l     #8,a2
	clr.l      d7
	move.w     (a2),d7
	addq.l     #1,d7
_putfile_6:
	move.l     d7,-(a7)
	move.l     #$0000B700,-(a7)
	jsr        _itob
	lea.l      12(a7),a7
	movea.l    d7,a2
	adda.l     #$0000B700,a2
	clr.b      (a2)
	clr.l      (a7)
	move.l     #$0000B80C,-(a7) "\"\n"
	movea.l    _pincl,a2
	addq.l     #4,a2
	move.l     (a2),-(a7)
	move.l     #$0000B80F,-(a7) " \""
	move.l     #$0000B700,-(a7) 6052
	move.l     #$0000B812,-(a7) "# "
	move.l     #$0000B70C,-(a7)
	jsr        _cpystr
	lea.l      24(a7),a7
	move.l     #$0000B70C,(a7)
	jsr        _lenstr
	move.l     d7,(a7)
	move.l     #$0000B70C,-(a7)
	jsr        _putlin
	addq.l     #4,a7
	bra.s      _putfile_4
_putfile_2:
	tst.l      _pasline
	bne        _putfile_1
	clr.l      _pflag
	movea.l    _pincl,a2
	addq.l     #4,a2
	tst.l      (a2)
	bne.s      _putfile_7
	clr.l      (a7)
	pea.l      ($00000013).w
	move.l     #$0000B819,-(a7)
	jsr        _putcode(pc) "cc"
	addq.l     #8,a7
	bra.s      _putfile_3
_putfile_7:
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
	move.l     #$0000B815,-(a7)
	jsr        _putcode(pc) "ccp"
	lea.l      12(a7),a7
_putfile_3:
	movem.l    (a7)+,d0/d5
	unlk       a6
	rts
_putfile_4:
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     (a2),_lastln
	bra.s      _putfile_3

; todo: cplusflag
_putls:
	link       a6,#-4
	movem.l    d0/d5/a3-a5,-(a7)
	movea.l    8(a6),a5
	tst.l      _xflag
	bne.s      _putls_1
	tst.l      _cplusflag
	beq.s      _putls_2
	tst.l      _pincl
	beq.s      _putls_2
	clr.l      d7
	move.w     _lastln,d7
	addq.l     #1,d7
	movea.l    _pincl,a2
	addq.l     #8,a2
	clr.l      d6
	move.w     (a2),d6
	cmp.l      d6,d7
	beq.s      _putls_2
	moveq.l    #1,d0
	move.l     d0,_pflag
	jsr        _putfile(pc)
	bra.s      _putls_2
_putls_1:
	movea.l    a5,a4
_putls_4:
	cmpi.l     #$00000007,4(a4)
	bne        _putls_3
	movea.l    (a4),a4
	bra.s      _putls_4
_putls_2:
	movea.l    _pincl,a2
	addq.l     #8,a2
	move.w     (a2),_lastln
	movea.l    a5,a4
	clr.l      -4(a6)
_putls_11:
	move.l     a4,d7
	beq.s      _putls_5
	tst.l      -4(a6)
	bne.s      _putls_6
	cmpi.l     #$00000008,4(a4)
	beq.s      _putls_7
_putls_6:
	tst.l      -4(a6)
	beq.s      _putls_8
	cmpi.l     #$00000008,4(a4)
	beq.s      _putls_8
_putls_7:
	tst.l      -4(a6)
	bne.s      _putls_9
	moveq.l    #1,d7
	bra.s      _putls_10
_putls_9:
	clr.l      d7
_putls_10:
	move.l     d7,-4(a6)
	pea.l      ($00000001).w
	move.l     #$0000B859,-(a7)
	jsr        _putlin
	addq.l     #8,a7
_putls_8:
	move.l     12(a4),(a7)
	move.l     8(a4),-(a7)
	jsr        _putlin
	addq.l     #4,a7
	move.l     20(a4),(a7)
	move.l     16(a4),-(a7)
	jsr        _putlin
	addq.l     #4,a7
	movea.l    (a4),a4
	bra.s      _putls_11
_putls_5:
	movem.l    (a7)+,d0/d5/a3-a5
	unlk       a6
	rts
_putls_3:
	jsr        _putfile(pc)
	jsr        _ptline
_putls_12:
	cmpi.l     #$00000002,4(a5)
	beq.s      _putls_5
	move.l     4(a5),d7
	lea.l      $0000B81C,a0
	jmp        a.switch
case PIDENT:
	move.l     a5,(a7)
	jsr        _lexident(pc)
	movea.l    d7,a5
	bra.s      _putls_12
	bra.s      _putls_12
case PSTRING:
	move.l     a5,(a7)
	jsr        _lexstrin(pc)
	movea.l    d7,a5
	bra.s      _putls_12
case 8:
	move.l     a5,(a7)
	jsr        _lexxstr(pc)
	movea.l    d7,a5
	bra.s      _putls_12
case PCHCON:
	move.l     a5,(a7)
	jsr        _lexchars(pc)
	movea.l    d7,a5
	bra.s      _putls_12
case PNUM:
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	tst.l      (a2)
	bne.s      _putls_13
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _putls_13
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_13
	movea.l    (a5),a2
	tst.l      (a2)
	beq.s      _putls_14
	lea.l      ($0000000C).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	tst.l      (a2)
	bne.s      _putls_14
	lea.l      ($00000014).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	cmpi.l     #$00000001,(a2)
	bne.s      _putls_14
	lea.l      ($00000010).w,a2
	movea.l    (a5),a3
	adda.l     (a3),a2
	movea.l    (a2),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_14
_putls_13:
	move.l     #$0000B854,(a7)
	move.l     20(a5),-(a7)
	move.l     16(a5),-(a7)
	jsr        _inbuf
	addq.l     #8,a7
	move.l     d7,d5
	cmp.l      20(a5),d5
	bcc.s      _putls_15
	movea.l    16(a5),a2
	adda.l     d5,a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0065,d7
	beq.s      _putls_14
	movea.l    16(a5),a2
	adda.l     d5,a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$0045,d7
	bne.s      _putls_15
_putls_14:
	move.l     a5,(a7)
	jsr        _lexfloat(pc)
	movea.l    d7,a5
	bra        _putls_12
_putls_15:
	move.l     a5,(a7)
	jsr        _lexint(pc)
	movea.l    d7,a5
	bra        _putls_12
case 7:
	movea.l    (a5),a5
	bra        _putls_12
default:
	cmpi.l     #$00000001,20(a5)
	bne.s      _putls_16
	movea.l    16(a5),a2
	clr.l      d7
	move.b     (a2),d7
	cmpi.w     #$002E,d7
	bne.s      _putls_16
	lea.l      ($0000000C).w,a2
	adda.l     (a5),a2
	tst.l      (a2)
	bne.s      _putls_16
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000004,(a2)
	bne.s      _putls_16
	move.l     a5,(a7)
	jsr        _lexfloat(pc)
	movea.l    d7,a5
	bra        _putls_12
_putls_16:
	move.l     a5,(a7)
	jsr        _lexpunct(pc)
	movea.l    d7,a5
	bra        _putls_12

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
	move.l     #$0000BB24,(a7) "#line inside macro"
	jsr        _p0error
	bra.s      _getex_5
_getex_4:
	move.l     4(a5),d7
	lea.l      $0000BAD4,a0
	jmp        a.switch
_getex_5:
	lea.l      ($00000014).w,a2
	adda.l     (a5),a2
	move.l     (a2),(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	pea.l      ($00000018).w
	move.l     #$0000B96E,-(a7)
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
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	bra        _getex_1
	bra        _getex_1
	bra        _getex_1
	bra        _getex_1
	bra        _getex_1
	addq.w     #1,_inif
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	subq.w     #1,_inif
	bra        _getex_1
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	beq.s      _getex_7
	move.l     20(a5),(a7)
	move.l     16(a5),-(a7)
	move.l     #$0000BB1C,-(a7) "bad #%b"
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
	tst.l      8(a6)
	bne        _getex_1
	clr.l      (a7)
	move.l     a5,-(a7)
	jsr        _doexp
	addq.l     #4,a7
	movea.l    d7,a5
	bra        _getex_1

_getinl:
	link       a6,#-8
	tst.l      8(a6)
	bne.s      _getinl_1
	clr.l      getlin.bufstart
_getinl_1:
	tst.l      _pincl
	bne.s      _getinl_2
	jsr        _nxtfile
	move.l     d7,_pincl
	jsr        _putfile
_getinl_2:
	tst.l      _pincl
	bne.s      _getinl_3
	clr.l      d7
	unlk       a6
	rts
_getinl_3:
	move.l     #$00001000,d7
	sub.l      getlin.bufstart,d7
	move.l     d7,(a7)
	move.l     #getinl.linebuf,d7
	add.l      getlin.bufstart,d7
	move.l     d7,-(a7)
	move.l     _pincl,-(a7)
	jsr        _getln
	addq.l     #8,a7
	move.l     d7,-4(a6)
	beq.s      _getinl_4
	move.l     -4(a6),d7
	add.l      d7,getlin.bufstart
	move.l     #$0000BB38,(a7)
	move.l     getlin.bufstart,d7
	sub.l      -4(a6),d7
	move.l     d7,-(a7)
	addi.l     #getinl.linebuf,(a7)
	jsr        _stotl
	addq.l     #4,a7
	unlk       a6
	rts
_getinl_4:
	tst.l      $0000BB38
	beq.s      _getinl_5
	move.l     #$0000CB42,(a7) "unbalanced comment in file"
	jsr        _p0error
	clr.l      $0000BB38
	clr.l      (a7)
	move.l     #$0000CB40,-(a7) "\n"
	jsr        _stotl
	addq.l     #4,a7
	unlk       a6
	rts
_getinl_5:
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
	tst.w      _inincl
	beq        _getinl_1
	subq.w     #1,_inincl
	bra        _getinl_1

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
	move.l     #$0000CB5E,(a7) "folded line"
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

; todo: cplusflag
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
	move.l     #_cplusflag,-(a7)
	move.l     #$0000CBBC,-(a7) "+cplus,d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>"
	move.l     #_argv,-(a7)
	move.l     #_argc,-(a7)
	jsr        _getflags
	lea.l      60(a7),a7
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
	move.l     #$0000CBAE,-(a7) "can't create "
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
	move.l     #$0000CBAC,-(a7)
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
	move.l     #$0000CBA8,-(a7)
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
	move.l     #$0000CB90,-(a7) "can't open map file: %p"
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
	move.l     #$0000CB78,-(a7) "can't read map file: %p"
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
	move.l     #$0000CB6A,-(a7) "misplaced #%b"
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
	move.l     #$0000CBFE,(a7) "missing #endif"
	jsr        _p0error
	bra        _putgr_9

_putns:
	link       a6,#-18
	movem.l    d0/a3-a5,-(a7)
	movea.l    8(a6),a5
	move.l     4(a5),d7
	lea.l      $0000CC0E,a0
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
	move.l     #$0000CCC5,-(a7)
	jsr        _putcode "c"
	addq.l     #4,a7
	lea.l      ($00000010).w,a2
	adda.l     -4(a6),a2
	move.l     (a2),d7
	sub.l      16(a5),d7
	addq.l     #2,d7
	move.w     d7,-14(a6)
	pea.l      -14(a6)
	move.l     #$0000CCC3,-(a7)
	jsr        _putcode "2"
	addq.l     #8,a7
	move.w     -14(a6),d7
	ext.l      d7
	move.l     d7,(a7)
	move.l     16(a5),-(a7)
	subq.l     #1,(a7)
	move.l     #$0000CCC1,-(a7)
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
	move.l     #$0000CCB5,(a7) "bad #define"
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
	move.l     #$0000CCA8,-(a7) "redefined %b"
	jsr        _p0error
	addq.l     #8,a7
	bra        putns_4
case PUNDEF:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000003,(a2)
	beq.s      x25c4_7
	move.l     #$0000CC9D,(a7) "bad #undef"
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
	move.l     #$0000CC8B,-(a7) "can',$27,'t #include %p"
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
	move.l     #$0000CC76,(a7)
	lea.l      ($00000010).w,a2
	adda.l     (a5),a2
	move.l     (a2),-(a7)
	jsr        _error
	addq.l     #4,a7
	bra        putns_4
x25c4_9:
	jsr        _ptline
	moveq.l    #1,d0
	move.l     d0,_pflag
	clr.w      _lastln
	jsr        _putfile
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
	jsr        _putfile
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
	move.l     #$0000CC6C,(a7) "bad #line"
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
	beq.s      x25c4_20
	move.l     #$0000CC5B,(a7) "bad #line syntax"
	jsr        _p0error
	bra.s      x25c4_20
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
	move.l     #$0000CC59,-(a7)
	jsr        _putcode "c"
	addq.l     #8,a7
	move.l     (a5),(a7)
	jsr        _putls
	pea.l      ($0000001D).w
	move.l     #$0000CC57,-(a7)
	jsr        _putcode "c"
	addq.l     #8,a7
	bra        putns_4
case PSHARP:
	movea.l    (a5),a2
	addq.l     #4,a2
	cmpi.l     #$00000002,(a2)
	beq        putns_4
	move.l     #$0000CC4E,(a7) "bad #xxx"
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
	addi.l     #$0000CCC8,d7
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
	move.l     #$0000CECC,-(a7) "can',$27,'t open %p"
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
	move.l     #$0000B8F0,_perr _errbuf+2
	move.l     _argc,d7
	asl.l      #2,d7
	movea.l    d7,a2
	subq.l     #4,a2
	adda.l     _argv,a2
	tst.l      (a2)
	bne.s      _p0error_1
	move.l     #$0000CEFC,(a7) "EOF: "
	jsr        _perrfmt(pc)
	bra.s      _p0error_2
_p0error_1:
	move.l     #$0000CEDF,(a7) "\t"
	tst.l      _pincl
	beq.s      _p0error_3
	movea.l    _pincl,a2
	addq.l     #8,a2
	clr.l      d7
	move.w     (a2),d7
	bra.s      _p0error_4
_p0error_3:
	clr.l      d7
	move.w     _lineno,d7
_p0error_4:
	move.l     d7,-(a7)
	move.l     #$0000CEE1,-(a7) ":"
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
	move.l     #$0000CEE3,-(a7) " "
	move.l     __pname,-(a7)
	move.l     #$0000CEE5,-(a7) "#error "
	move.l     #$0000CEED,-(a7) "%p%p%p%p%p%s%p"
	jsr        _perrfmt(pc)
	lea.l      28(a7),a7
_p0error_2:
	move.l     16(a6),(a7)
	move.l     12(a6),-(a7)
	move.l     8(a6),-(a7)
	jsr        _perrfmt(pc)
	addq.l     #8,a7
	move.l     #$0000CEDD,(a7) "\n"
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
	move.l     #$0000CEDA,-(a7)
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
	move.l     #$0000CF16,(a7)
	move.l     a4,-(a7)
	jsr        _instr
	addq.l     #4,a7
	move.l     d7,d5
	tst.b      0(a4,d5.l)
	bne.s      _predef_2
	move.w     #$0003,-4(a6)
	move.l     #$0000CF12,-8(a6)
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
	move.l     #$0000CF02,-(a7) "-d %b redefined"
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
	move.l     #$0000CF1A,-(a7)
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
	move.l     #$0000CF1E,16(a4) "\n"
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
	move.l     #$0000CF20,-(a7) "unbalanced %c"
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
[000056ae]                           dc.b $00
[000056af]                           dc.b 'idr68k Edition 3.2: Copyright (c) 1981,1983,1987 by Whitesmiths, Ltd. all rights reserved',0
[00005709]                           dc.b '|/bin/|/usr/bin/',0
[0000571a]                           dc.b 'PATH',0
[0000571f]                           dc.b $00
_environ:
[00005720]                           dc.l 0
_errno:
[00005724]                           dc.l 0
__paths:
[00005728] 00005709                  dc.l $00005709 ; no symbol found
[0000572c] 000000aa                  dc.l _onexit
_bltintab:
[00005730] 0000576d                  dc.l $0000576d ; no symbol found
[00005734]                           dc.l 30
[00005738] 00005764                  dc.l $00005764 ; no symbol found
[0000573c]                           dc.l 33
[00005740] 0000575a                  dc.l $0000575a ; no symbol found
[00005744]                           dc.l 31
[00005748] 00005750                  dc.l $00005750 ; no symbol found
[0000574c]                           dc.l 32
[00005750]                           dc.w $085f
[00005752]                           dc.b '_LINE__',0
[0000575a]                           dc.w $085f
[0000575c]                           dc.b '_FILE__',0
[00005764]                           dc.w $0764
[00005766]                           dc.b 'efined',0
[0000576d]                           dc.b $03
[0000576e]                           dc.b '$if',0

; dodef
tcomma:
[00005772]                           dc.l 0,5,0,0,",",1
builtin.linenobuf:
[0000578c]                           ds.b 10
; switchtable in builtin
[00005796] 00000210                  dc.l $00000210 ; no symbol found
[0000579a]                           dc.l 33
[0000579e] 000001da                  dc.l $000001da ; no symbol found
[000057a2]                           dc.l 32
[000057a6] 0000019e                  dc.l $0000019e ; no symbol found
[000057aa]                           dc.l 31
[000057ae] 0000010e                  dc.l $0000010e ; no symbol found
[000057b2]                           dc.l 30
[000057b6]                           dc.l 0
[000057ba] 00000194                  dc.l $00000194 ; no symbol found

[000057be]                           dc.w $3000
[000057c0]                           dc.w $3100
[000057c2]                           dc.b 'bad defined syntax',0
[000057d5]                           dc.b $30
[000057d6]                           dc.b $00
[000057d7]                           dc.b $31
[000057d8]                           dc.b $00
[000057d9]                           dc.b $00
[000057da]                           dc.b 'too many macro arguments',0
[000057f3]                           dc.b 'too few macro arguments',0
[0000580b]                           dc.b 'bad #define arguments',0
[00005821]                           dc.b $00
[00005822]                           dc.b 'bad $if(test)',0
[00005830]                           dc.b '$if expects arguments',0
[00005846]                           dc.b 'bad macro arguments',0
_ipri
[0000585a]                           dc.w $e285
[0000585c]                           dc.w $99de
[0000585e]                           dc.w $d897
[00005860]                           dc.w $a095
[00005862]                           dc.w $968f
[00005864]                           dc.w $9094
[00005866]                           dc.w $9bc1
[00005868]                           dc.w $a39c
[0000586a]                           dc.w $829d
[0000586c]                           dc.w $9f00
_opri
[0000586e]                           dc.w $0e0e
[00005870]                           dc.w $0e0d
[00005872]                           dc.w $0d0c
[00005874]                           dc.w $0c0b
[00005876]                           dc.w $0b0b
[00005878]                           dc.w $0b0a
[0000587a]                           dc.w $0a09
[0000587c]                           dc.w $0807
[0000587e]                           dc.w $0605
[00005880]                           dc.w $0400
_optab:
[00005882] 00005a92                  dc.l $00005a92 ; no symbol found
[00005886]                           dc.b $00
[00005887]                           dc.b $00
[00005888]                           dc.b $00
[00005889]                           dc.b $5a
[0000588a] 00005a8f                  dc.l $00005a8f ; no symbol found
[0000588e]                           dc.b $00
[0000588f]                           dc.b $00
[00005890]                           dc.b $00
[00005891]                           dc.b $99
[00005892] 00005a8c                  dc.l $00005a8c ; no symbol found
[00005896]                           dc.b $00
[00005897]                           dc.b $00
[00005898]                           dc.b $00
[00005899]                           dc.b $c1
[0000589a] 00005a89                  dc.l $00005a89 ; no symbol found
[0000589e]                           dc.b $00
[0000589f]                           dc.b $00
[000058a0]                           dc.b $00
[000058a1]                           dc.b $06
[000058a2] 00005a86                  dc.l $00005a86 ; no symbol found
[000058a6]                           dc.b $00
[000058a7]                           dc.b $00
[000058a8]                           dc.b $00
[000058a9]                           dc.b $0a
[000058aa] 00005a83                  dc.l $00005a83 ; no symbol found
[000058ae]                           dc.b $00
[000058af]                           dc.b $00
[000058b0]                           dc.b $00
[000058b1]                           dc.b $e2
[000058b2] 00005a80                  dc.l $00005a80 ; no symbol found
[000058b6]                           dc.b $00
[000058b7]                           dc.b $00
[000058b8]                           dc.b $00
[000058b9]                           dc.b $de
[000058ba] 00005a7d                  dc.l $00005a7d ; no symbol found
[000058be]                           dc.b $00
[000058bf]                           dc.b $00
[000058c0]                           dc.b $00
[000058c1]                           dc.b $02
[000058c2] 00005a7a                  dc.l $00005a7a ; no symbol found
[000058c6]                           dc.b $00
[000058c7]                           dc.b $00
[000058c8]                           dc.b $00
[000058c9]                           dc.b $d8
[000058ca] 00005a77                  dc.l $00005a77 ; no symbol found
[000058ce]                           dc.b $00
[000058cf]                           dc.b $00
[000058d0]                           dc.b $00
[000058d1]                           dc.b $03
[000058d2] 00005a74                  dc.l $00005a74 ; no symbol found
[000058d6]                           dc.b $00
[000058d7]                           dc.b $00
[000058d8]                           dc.b $00
[000058d9]                           dc.b $85
[000058da] 00005a71                  dc.l $00005a71 ; no symbol found
[000058de]                           dc.b $00
[000058df]                           dc.b $00
[000058e0]                           dc.b $00
[000058e1]                           dc.b $01
[000058e2] 00005a6e                  dc.l $00005a6e ; no symbol found
[000058e6]                           dc.b $00
[000058e7]                           dc.b $00
[000058e8]                           dc.b $00
[000058e9]                           dc.b $0b
[000058ea] 00005a6b                  dc.l $00005a6b ; no symbol found
[000058ee]                           dc.b $00
[000058ef]                           dc.b $00
[000058f0]                           dc.b $00
[000058f1]                           dc.b $95
[000058f2] 00005a68                  dc.l $00005a68 ; no symbol found
[000058f6]                           dc.b $00
[000058f7]                           dc.b $00
[000058f8]                           dc.b $00
[000058f9]                           dc.b $88
[000058fa] 00005a65                  dc.l $00005a65 ; no symbol found
[000058fe]                           dc.b $00
[000058ff]                           dc.b $00
[00005900]                           dc.b $00
[00005901]                           dc.b $8f
[00005902] 00005a62                  dc.l $00005a62 ; no symbol found
[00005906]                           dc.b $00
[00005907]                           dc.b $00
[00005908]                           dc.b $00
[00005909]                           dc.b $9f
[0000590a] 00005a5f                  dc.l $00005a5f ; no symbol found
[0000590e]                           dc.b $00
[0000590f]                           dc.b $00
[00005910]                           dc.b $00
[00005911]                           dc.b $04
[00005912] 00005a5c                  dc.l $00005a5c ; no symbol found
[00005916]                           dc.b $00
[00005917]                           dc.b $00
[00005918]                           dc.b $00
[00005919]                           dc.b $08
[0000591a] 00005a59                  dc.l $00005a59 ; no symbol found
[0000591e]                           dc.b $00
[0000591f]                           dc.b $00
[00005920]                           dc.b $00
[00005921]                           dc.b $a3
[00005922] 00005a56                  dc.l $00005a56 ; no symbol found
[00005926]                           dc.b $00
[00005927]                           dc.b $00
[00005928]                           dc.b $00
[00005929]                           dc.b $05
[0000592a] 00005a53                  dc.l $00005a53 ; no symbol found
[0000592e]                           dc.b $00
[0000592f]                           dc.b $00
[00005930]                           dc.b $00
[00005931]                           dc.b $9c
[00005932] 00005a50                  dc.l $00005a50 ; no symbol found
[00005936]                           dc.b $00
[00005937]                           dc.b $00
[00005938]                           dc.b $00
[00005939]                           dc.b $09
[0000593a] 00005a4d                  dc.l $00005a4d ; no symbol found
[0000593e]                           dc.b $00
[0000593f]                           dc.b $00
[00005940]                           dc.b $00
[00005941]                           dc.b $43
[00005942] 00005a49                  dc.l $00005a49 ; no symbol found
[00005946]                           dc.b $00
[00005947]                           dc.b $00
[00005948]                           dc.b $00
[00005949]                           dc.b $9b
[0000594a] 00005a45                  dc.l $00005a45 ; no symbol found
[0000594e]                           dc.b $00
[0000594f]                           dc.b $00
[00005950]                           dc.b $00
[00005951]                           dc.b $8c
[00005952] 00005a41                  dc.l $00005a41 ; no symbol found
[00005956]                           dc.b $00
[00005957]                           dc.b $00
[00005958]                           dc.b $00
[00005959]                           dc.b $82
[0000595a] 00005a3d                  dc.l $00005a3d ; no symbol found
[0000595e]                           dc.b $00
[0000595f]                           dc.b $00
[00005960]                           dc.b $00
[00005961]                           dc.b $86
[00005962] 00005a39                  dc.l $00005a39 ; no symbol found
[00005966]                           dc.b $00
[00005967]                           dc.b $00
[00005968]                           dc.b $00
[00005969]                           dc.b $91
[0000596a] 00005a35                  dc.l $00005a35 ; no symbol found
[0000596e]                           dc.b $00
[0000596f]                           dc.b $00
[00005970]                           dc.b $00
[00005971]                           dc.b $53
[00005972] 00005a31                  dc.l $00005a31 ; no symbol found
[00005976]                           dc.b $00
[00005977]                           dc.b $00
[00005978]                           dc.b $00
[00005979]                           dc.b $8e
[0000597a] 00005a2d                  dc.l $00005a2d ; no symbol found
[0000597e]                           dc.b $00
[0000597f]                           dc.b $00
[00005980]                           dc.b $00
[00005981]                           dc.b $44
[00005982] 00005a29                  dc.l $00005a29 ; no symbol found
[00005986]                           dc.b $00
[00005987]                           dc.b $00
[00005988]                           dc.b $00
[00005989]                           dc.b $8b
[0000598a] 00005a25                  dc.l $00005a25 ; no symbol found
[0000598e]                           dc.b $00
[0000598f]                           dc.b $00
[00005990]                           dc.b $00
[00005991]                           dc.b $07
[00005992] 00005a21                  dc.l $00005a21 ; no symbol found
[00005996]                           dc.b $00
[00005997]                           dc.b $00
[00005998]                           dc.b $00
[00005999]                           dc.b $87
[0000599a] 00005a1d                  dc.l $00005a1d ; no symbol found
[0000599e]                           dc.b $00
[0000599f]                           dc.b $00
[000059a0]                           dc.b $00
[000059a1]                           dc.b $97
[000059a2] 00005a19                  dc.l $00005a19 ; no symbol found
[000059a6]                           dc.b $00
[000059a7]                           dc.b $00
[000059a8]                           dc.b $00
[000059a9]                           dc.b $96
[000059aa] 00005a15                  dc.l $00005a15 ; no symbol found
[000059ae]                           dc.b $00
[000059af]                           dc.b $00
[000059b0]                           dc.b $00
[000059b1]                           dc.b $94
[000059b2] 00005a11                  dc.l $00005a11 ; no symbol found
[000059b6]                           dc.b $00
[000059b7]                           dc.b $00
[000059b8]                           dc.b $00
[000059b9]                           dc.b $90
[000059ba] 00005a0d                  dc.l $00005a0d ; no symbol found
[000059be]                           dc.b $00
[000059bf]                           dc.b $00
[000059c0]                           dc.b $00
[000059c1]                           dc.b $a0
[000059c2] 00005a09                  dc.l $00005a09 ; no symbol found
[000059c6]                           dc.b $00
[000059c7]                           dc.b $00
[000059c8]                           dc.b $00
[000059c9]                           dc.b $92
[000059ca] 00005a05                  dc.l $00005a05 ; no symbol found
[000059ce]                           dc.b $00
[000059cf]                           dc.b $00
[000059d0]                           dc.b $00
[000059d1]                           dc.b $8d
[000059d2] 00005a01                  dc.l $00005a01 ; no symbol found
[000059d6]                           dc.b $00
[000059d7]                           dc.b $00
[000059d8]                           dc.b $00
[000059d9]                           dc.b $9d
[000059da] 000059fc                  dc.l $000059fc ; no symbol found
[000059de]                           dc.b $00
[000059df]                           dc.b $00
[000059e0]                           dc.b $00
[000059e1]                           dc.b $0d
[000059e2] 000059f7                  dc.l $000059f7 ; no symbol found
[000059e6]                           dc.b $00
[000059e7]                           dc.b $00
[000059e8]                           dc.b $00
[000059e9]                           dc.b $89
[000059ea] 000059f2                  dc.l $000059f2 ; no symbol found
[000059ee]                           dc.b $00
[000059ef]                           dc.b $00
[000059f0]                           dc.b $00
[000059f1]                           dc.b $8a

[000059f2]                           dc.w $033e
[000059f4]                           dc.w $3e3d
[000059f6]                           dc.b $00
[000059f7]                           dc.b $03
[000059f8]                           dc.b '<<=',0
[000059fc]                           dc.w $032e
[000059fe]                           dc.w $2e2e
[00005a00]                           dc.b $00
[00005a01]                           dc.b $02
[00005a02]                           dc.w $7c7c
[00005a04]                           dc.b $00
[00005a05]                           dc.b $02
[00005a06]                           dc.w $7c3d
[00005a08]                           dc.b $00
[00005a09]                           dc.b $02
[00005a0a]                           dc.w $5e3d
[00005a0c]                           dc.b $00
[00005a0d]                           dc.b $02
[00005a0e]                           dc.w $3e3e
[00005a10]                           dc.b $00
[00005a11]                           dc.b $02
[00005a12]                           dc.w $3e3d
[00005a14]                           dc.b $00
[00005a15]                           dc.b $02
[00005a16]                           dc.w $3d3d
[00005a18]                           dc.b $00
[00005a19]                           dc.b $02
[00005a1a]                           dc.w $3c3d
[00005a1c]                           dc.b $00
[00005a1d]                           dc.b $02
[00005a1e]                           dc.w $3c3c
[00005a20]                           dc.b $00
[00005a21]                           dc.b $02
[00005a22]                           dc.w $2f3d
[00005a24]                           dc.b $00
[00005a25]                           dc.b $02
[00005a26]                           dc.w $2d3e
[00005a28]                           dc.b $00
[00005a29]                           dc.b $02
[00005a2a]                           dc.w $2d3d
[00005a2c]                           dc.b $00
[00005a2d]                           dc.b $02
[00005a2e]                           dc.w $2d2d
[00005a30]                           dc.b $00
[00005a31]                           dc.b $02
[00005a32]                           dc.w $2b3d
[00005a34]                           dc.b $00
[00005a35]                           dc.b $02
[00005a36]                           dc.w $2b2b
[00005a38]                           dc.b $00
[00005a39]                           dc.b $02
[00005a3a]                           dc.w $2a3d
[00005a3c]                           dc.b $00
[00005a3d]                           dc.b $02
[00005a3e]                           dc.w $263d
[00005a40]                           dc.b $00
[00005a41]                           dc.b $02
[00005a42]                           dc.w $2626
[00005a44]                           dc.b $00
[00005a45]                           dc.b $02
[00005a46]                           dc.w $253d
[00005a48]                           dc.b $00
[00005a49]                           dc.b $02
[00005a4a]                           dc.w $213d
[00005a4c]                           dc.b $00
[00005a4d]                           dc.b $01
[00005a4e]                           dc.w $7e00
[00005a50]                           dc.w $017d
[00005a52]                           dc.b $00
[00005a53]                           dc.b $01
[00005a54]                           dc.w $7c00
[00005a56]                           dc.w $017b
[00005a58]                           dc.b $00
[00005a59]                           dc.b $01
[00005a5a]                           dc.w $5e00
[00005a5c]                           dc.w $015d
[00005a5e]                           dc.b $00
[00005a5f]                           dc.b $01
[00005a60]                           dc.w $5b00
[00005a62]                           dc.w $013f
[00005a64]                           dc.b $00
[00005a65]                           dc.b $01
[00005a66]                           dc.w $3e00
[00005a68]                           dc.w $013d
[00005a6a]                           dc.b $00
[00005a6b]                           dc.b $01
[00005a6c]                           dc.w $3c00
[00005a6e]                           dc.w $013b
[00005a70]                           dc.b $00
[00005a71]                           dc.b $01
[00005a72]                           dc.w $3a00
[00005a74]                           dc.w $012f
[00005a76]                           dc.b $00
[00005a77]                           dc.b $01
[00005a78]                           dc.w $2e00
[00005a7a]                           dc.w $012d
[00005a7c]                           dc.b $00
[00005a7d]                           dc.b $01
[00005a7e]                           dc.w $2c00
[00005a80]                           dc.w $012b
[00005a82]                           dc.b $00
[00005a83]                           dc.b $01
[00005a84]                           dc.w $2a00
[00005a86]                           dc.w $0129
[00005a88]                           dc.b $00
[00005a89]                           dc.b $01
[00005a8a]                           dc.w $2800
[00005a8c]                           dc.w $0126
[00005a8e]                           dc.b $00
[00005a8f]                           dc.b $01
[00005a90]                           dc.w $2500
[00005a92]                           dc.w $0121
[00005a94]                           dc.b $00
[00005a95]                           dc.b $00
_optabold:
[00005a96] 00005b91                  dc.l $00005b91 ; no symbol found
[00005a9a]                           dc.l 12
[00005a9e] 00005b8d                  dc.l $00005b8d ; no symbol found
[00005aa2]                           dc.l 5
[00005aa6] 00005b89                  dc.l $00005b89 ; no symbol found
[00005aaa]                           dc.l 4
[00005aae] 00005b85                  dc.l $00005b85 ; no symbol found
[00005ab2]                           dc.l 14
[00005ab6] 00005b81                  dc.l $00005b81 ; no symbol found
[00005aba]                           dc.l BINOP | 12
[00005abe] 00005b7d                  dc.l $00005b7d ; no symbol found
[00005ac2]                           dc.l BINOP | 6
[00005ac6] 00005b79                  dc.l $00005b79 ; no symbol found
[00005aca]                           dc.l BINOP | 17
[00005ace] 00005b75                  dc.l $00005b75 ; no symbol found
[00005ad2]                           dc.l BINOP | 14
[00005ad6] 00005b71                  dc.l $00005b71 ; no symbol found
[00005ada]                           dc.l BINOP | 11
[00005ade] 00005b6d                  dc.l $00005b6d ; no symbol found
[00005ae2]                           dc.l BINOP | 7
[00005ae6] 00005b69                  dc.l $00005b69 ; no symbol found
[00005aea]                           dc.l BINOP | 18
[00005aee] 00005b65                  dc.l $00005b65 ; no symbol found
[00005af2]                           dc.l BINOP | 13
[00005af6] 00005b61                  dc.l $00005b61 ; no symbol found
[00005afa]                           dc.l 9
[00005afe] 00005b5d                  dc.l $00005b5d ; no symbol found
[00005b02]                           dc.l BINOP | 28
[00005b06] 00005b59                  dc.l $00005b59 ; no symbol found
[00005b0a]                           dc.l 5
[00005b0e] 00005b55                  dc.l $00005b55 ; no symbol found
[00005b12]                           dc.l 9
[00005b16] 00005b51                  dc.l $00005b51 ; no symbol found
[00005b1a]                           dc.l UNOP | 3
[00005b1e] 00005b4d                  dc.l $00005b4d ; no symbol found
[00005b22]                           dc.l 8
[00005b26] 00005b48                  dc.l $00005b48 ; no symbol found
[00005b2a]                           dc.l BINOP | 9
[00005b2e] 00005b43                  dc.l $00005b43 ; no symbol found
[00005b32]                           dc.l BINOP | 10
[00005b36] 00005b3e                  dc.l $00005b3e ; no symbol found
[00005b3a]                           dc.l BINOP | 29

[00005b3e]                           dc.w $035c
[00005b40]                           dc.w $2121
[00005b42]                           dc.b $00
[00005b43]                           dc.b $03
[00005b44]                           dc.b '=>>',0
[00005b48]                           dc.w $033d
[00005b4a]                           dc.w $3c3c
[00005b4c]                           dc.b $00
[00005b4d]                           dc.b $02
[00005b4e]                           dc.w $7c29
[00005b50]                           dc.b $00
[00005b51]                           dc.b $02
[00005b52]                           dc.w $5c5e
[00005b54]                           dc.b $00
[00005b55]                           dc.b $02
[00005b56]                           dc.w $5c29
[00005b58]                           dc.b $00
[00005b59]                           dc.b $02
[00005b5a]                           dc.w $5c28
[00005b5c]                           dc.b $00
[00005b5d]                           dc.b $02
[00005b5e]                           dc.w $5c21
[00005b60]                           dc.b $00
[00005b61]                           dc.b $02
[00005b62]                           dc.w $3e29
[00005b64]                           dc.b $00
[00005b65]                           dc.b $02
[00005b66]                           dc.w $3d7c
[00005b68]                           dc.b $00
[00005b69]                           dc.b $02
[00005b6a]                           dc.w $3d5e
[00005b6c]                           dc.b $00
[00005b6d]                           dc.b $02
[00005b6e]                           dc.w $3d2f
[00005b70]                           dc.b $00
[00005b71]                           dc.b $02
[00005b72]                           dc.w $3d2d
[00005b74]                           dc.b $00
[00005b75]                           dc.b $02
[00005b76]                           dc.w $3d2b
[00005b78]                           dc.b $00
[00005b79]                           dc.b $02
[00005b7a]                           dc.w $3d2a
[00005b7c]                           dc.b $00
[00005b7d]                           dc.b $02
[00005b7e]                           dc.w $3d26
[00005b80]                           dc.b $00
[00005b81]                           dc.b $02
[00005b82]                           dc.w $3d25
[00005b84]                           dc.b $00
[00005b85]                           dc.b $02
[00005b86]                           dc.w $2e2e
[00005b88]                           dc.b $00
[00005b89]                           dc.b $02
[00005b8a]                           dc.w $287c
[00005b8c]                           dc.b $00
[00005b8d]                           dc.b $02
[00005b8e]                           dc.w $283c
[00005b90]                           dc.b $00
[00005b91]                           dc.b $01
[00005b92]                           dc.w $4000
_cmap:
[00005b94]                           dc.b $00
[00005b95]                           dc.b $01
[00005b96]                           dc.w $0203
[00005b98]                           dc.w $0405
[00005b9a]                           dc.w $0607
[00005b9c]                           dc.w $0809
[00005b9e]                           dc.w $0a0b
[00005ba0]                           dc.w $0c0d
[00005ba2]                           dc.w $0e0f
[00005ba4]                           dc.w $1011
[00005ba6]                           dc.w $1213
[00005ba8]                           dc.w $1415
[00005baa]                           dc.w $1617
[00005bac]                           dc.w $1819
[00005bae]                           dc.w $1a1b
[00005bb0]                           dc.w $1c1d
[00005bb2]                           dc.w $1e1f
[00005bb4]                           dc.b ' !"#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
[00005c13]                           dc.b $7f
[00005c14]                           dc.w $8081
[00005c16]                           dc.w $8283
[00005c18]                           dc.w $8485
[00005c1a]                           dc.w $8687
[00005c1c]                           dc.w $8889
[00005c1e]                           dc.w $8a8b
[00005c20]                           dc.w $8c8d
[00005c22]                           dc.w $8e8f
[00005c24]                           dc.w $9091
[00005c26]                           dc.w $9293
[00005c28]                           dc.w $9495
[00005c2a]                           dc.w $9697
[00005c2c]                           dc.w $9899
[00005c2e]                           dc.w $9a9b
[00005c30]                           dc.w $9c9d
[00005c32]                           dc.w $9e9f
[00005c34]                           dc.w $a0a1
[00005c36]                           dc.w $a2a3
[00005c38]                           dc.w $a4a5
[00005c3a]                           dc.w $a6a7
[00005c3c]                           dc.w $a8a9
[00005c3e]                           dc.w $aaab
[00005c40]                           dc.w $acad
[00005c42]                           dc.w $aeaf
[00005c44]                           dc.w $b0b1
[00005c46]                           dc.w $b2b3
[00005c48]                           dc.w $b4b5
[00005c4a]                           dc.w $b6b7
[00005c4c]                           dc.w $b8b9
[00005c4e]                           dc.w $babb
[00005c50]                           dc.w $bcbd
[00005c52]                           dc.w $bebf
[00005c54]                           dc.w $c0c1
[00005c56]                           dc.w $c2c3
[00005c58]                           dc.w $c4c5
[00005c5a]                           dc.w $c6c7
[00005c5c]                           dc.w $c8c9
[00005c5e]                           dc.w $cacb
[00005c60]                           dc.w $cccd
[00005c62]                           dc.w $cecf
[00005c64]                           dc.w $d0d1
[00005c66]                           dc.w $d2d3
[00005c68]                           dc.w $d4d5
[00005c6a]                           dc.w $d6d7
[00005c6c]                           dc.w $d8d9
[00005c6e]                           dc.w $dadb
[00005c70]                           dc.w $dcdd
[00005c72]                           dc.w $dedf
[00005c74]                           dc.w $e0e1
[00005c76]                           dc.w $e2e3
[00005c78]                           dc.w $e4e5
[00005c7a]                           dc.w $e6e7
[00005c7c]                           dc.w $e8e9
[00005c7e]                           dc.w $eaeb
[00005c80]                           dc.w $eced
[00005c82]                           dc.w $eeef
[00005c84]                           dc.w $f0f1
[00005c86]                           dc.w $f2f3
[00005c88]                           dc.w $f4f5
[00005c8a]                           dc.w $f6f7
[00005c8c]                           dc.w $f8f9
[00005c8e]                           dc.w $fafb
[00005c90]                           dc.w $fcfd
[00005c92]                           dc.w $feff
_digfr:
[00005c94]                           dc.b '0123456789abcdefABCDEF',0
_digto:
[00005cab]                           dc.b $00
[00005cac]                           dc.w $0102
[00005cae]                           dc.w $0304
[00005cb0]                           dc.w $0506
[00005cb2]                           dc.w $0708
[00005cb4]                           dc.w $090a
[00005cb6]                           dc.w $0b0c
[00005cb8]                           dc.w $0d0e
[00005cba]                           dc.w $0f0a
[00005cbc]                           dc.w $0b0c
[00005cbe]                           dc.w $0d0e
[00005cc0]                           dc.w $0f00
[00005cc2]                           dc.b 'abnfrtv(!)^',0
[00005cce]                           dc.w $0708
[00005cd0]                           dc.w $0a0c
[00005cd2]                           dc.w $0d09
[00005cd4]                           dc.w $0b7b
[00005cd6]                           dc.b '|}~',0
[00005cda]                           dc.b 'illegal character: %c',0
[00005cf0]                           dc.b 'illegal #if expression',0
[00005d07]                           dc.b $00

; switchtable in extail
[00005d08] 000010b6                  dc.l $000010b6 ; no symbol found
[00005d0c]                           dc.b $00
[00005d0d]                           dc.b $00
[00005d0e]                           dc.b $00
[00005d0f]                           dc.b $9f
[00005d10] 0000109c                  dc.l $0000109c ; no symbol found
[00005d14]                           dc.b $00
[00005d15]                           dc.b $00
[00005d16]                           dc.b $00
[00005d17]                           dc.b $9d
[00005d18] 00001082                  dc.l $00001082 ; no symbol found
[00005d1c]                           dc.b $00
[00005d1d]                           dc.b $00
[00005d1e]                           dc.b $00
[00005d1f]                           dc.b $82
[00005d20] 0000106e                  dc.l $0000106e ; no symbol found
[00005d24]                           dc.b $00
[00005d25]                           dc.b $00
[00005d26]                           dc.b $00
[00005d27]                           dc.b $90
[00005d28] 0000105a                  dc.l $0000105a ; no symbol found
[00005d2c]                           dc.b $00
[00005d2d]                           dc.b $00
[00005d2e]                           dc.b $00
[00005d2f]                           dc.b $9b
[00005d30] 00001046                  dc.l $00001046 ; no symbol found
[00005d34]                           dc.b $00
[00005d35]                           dc.b $00
[00005d36]                           dc.b $00
[00005d37]                           dc.b $96
[00005d38] 00001032                  dc.l $00001032 ; no symbol found
[00005d3c]                           dc.b $00
[00005d3d]                           dc.b $00
[00005d3e]                           dc.b $00
[00005d3f]                           dc.b $8f
[00005d40] 0000101e                  dc.l $0000101e ; no symbol found
[00005d44]                           dc.b $00
[00005d45]                           dc.b $00
[00005d46]                           dc.b $00
[00005d47]                           dc.b $94
[00005d48] 0000100a                  dc.l $0000100a ; no symbol found
[00005d4c]                           dc.b $00
[00005d4d]                           dc.b $00
[00005d4e]                           dc.b $00
[00005d4f]                           dc.b $95
[00005d50] 00000ff8                  dc.l $00000ff8 ; no symbol found
[00005d54]                           dc.b $00
[00005d55]                           dc.b $00
[00005d56]                           dc.b $00
[00005d57]                           dc.b $a0
[00005d58] 00000fe6                  dc.l $00000fe6 ; no symbol found
[00005d5c]                           dc.b $00
[00005d5d]                           dc.b $00
[00005d5e]                           dc.b $00
[00005d5f]                           dc.b $97
[00005d60] 00000fdc                  dc.l $00000fdc ; no symbol found
[00005d64]                           dc.b $00
[00005d65]                           dc.b $00
[00005d66]                           dc.b $00
[00005d67]                           dc.b $a3
[00005d68] 00000fd2                  dc.l $00000fd2 ; no symbol found
[00005d6c]                           dc.b $00
[00005d6d]                           dc.b $00
[00005d6e]                           dc.b $00
[00005d6f]                           dc.b $9c
[00005d70] 00000fc8                  dc.l $00000fc8 ; no symbol found
[00005d74]                           dc.b $00
[00005d75]                           dc.b $00
[00005d76]                           dc.b $00
[00005d77]                           dc.b $c1
[00005d78] 00000fb4                  dc.l $00000fb4 ; no symbol found
[00005d7c]                           dc.b $00
[00005d7d]                           dc.b $00
[00005d7e]                           dc.b $00
[00005d7f]                           dc.b $99
[00005d80] 00000fa0                  dc.l $00000fa0 ; no symbol found
[00005d84]                           dc.b $00
[00005d85]                           dc.b $00
[00005d86]                           dc.b $00
[00005d87]                           dc.b $85
[00005d88] 00000f8c                  dc.l $00000f8c ; no symbol found
[00005d8c]                           dc.b $00
[00005d8d]                           dc.b $00
[00005d8e]                           dc.b $00
[00005d8f]                           dc.b $e2
[00005d90] 00000f84                  dc.l $00000f84 ; no symbol found
[00005d94]                           dc.b $00
[00005d95]                           dc.b $00
[00005d96]                           dc.b $00
[00005d97]                           dc.b $d8
[00005d98] 00000f68                  dc.l $00000f68 ; no symbol found
[00005d9c]                           dc.b $00
[00005d9d]                           dc.b $00
[00005d9e]                           dc.b $00
[00005d9f]                           dc.b $de
[00005da0]                           dc.b $00
[00005da1]                           dc.b $00
[00005da2]                           dc.b $00
[00005da3]                           dc.b $00
[00005da4] 0000111a                  dc.l $0000111a ; no symbol found

[00005da8]                           dc.b 'illegal operator in #if',0
[00005dc0]                           dc.b 'illegal ? : in #if',0
[00005dd3]                           dc.b $00
[00005dd4]                           dc.b 'illegal unary op in #if',0
[00005dec]                           dc.b 'illegal #if syntax',0
[00005dff]                           dc.b 'missing ) in #if',0
_keytab:
[00005e10] 00006003                  dc.l $00006003 ; no symbol found
[00005e14]                           dc.b $00
[00005e15]                           dc.b $00
[00005e16]                           dc.b $00
[00005e17]                           dc.b $27
[00005e18] 00005fff                  dc.l $00005fff ; no symbol found
[00005e1c]                           dc.b $00
[00005e1d]                           dc.b $00
[00005e1e]                           dc.b $00
[00005e1f]                           dc.b $2e
[00005e20] 00005ffa                  dc.l $00005ffa ; no symbol found
[00005e24]                           dc.b $00
[00005e25]                           dc.b $00
[00005e26]                           dc.b $00
[00005e27]                           dc.b $2c
[00005e28] 00005ff5                  dc.l $00005ff5 ; no symbol found
[00005e2c]                           dc.b $00
[00005e2d]                           dc.b $00
[00005e2e]                           dc.b $00
[00005e2f]                           dc.b $2f
[00005e30] 00005fef                  dc.l $00005fef ; no symbol found
[00005e34]                           dc.b $00
[00005e35]                           dc.b $00
[00005e36]                           dc.b $00
[00005e37]                           dc.b $21
[00005e38] 00005fe9                  dc.l $00005fe9 ; no symbol found
[00005e3c]                           dc.b $00
[00005e3d]                           dc.b $00
[00005e3e]                           dc.b $00
[00005e3f]                           dc.b $23
[00005e40] 00005fe3                  dc.l $00005fe3 ; no symbol found
[00005e44]                           dc.b $00
[00005e45]                           dc.b $00
[00005e46]                           dc.b $00
[00005e47]                           dc.b $24
[00005e48] 00005fdd                  dc.l $00005fdd ; no symbol found
[00005e4c]                           dc.b $00
[00005e4d]                           dc.b $00
[00005e4e]                           dc.b $00
[00005e4f]                           dc.b $29
[00005e50] 00005fd7                  dc.l $00005fd7 ; no symbol found
[00005e54]                           dc.b $00
[00005e55]                           dc.b $00
[00005e56]                           dc.b $00
[00005e57]                           dc.b $3c
[00005e58] 00005fd1                  dc.l $00005fd1 ; no symbol found
[00005e5c]                           dc.b $00
[00005e5d]                           dc.b $00
[00005e5e]                           dc.b $00
[00005e5f]                           dc.b $2d
[00005e60] 00005fcb                  dc.l $00005fcb ; no symbol found
[00005e64]                           dc.b $00
[00005e65]                           dc.b $00
[00005e66]                           dc.b $00
[00005e67]                           dc.b $30
[00005e68] 00005fc5                  dc.l $00005fc5 ; no symbol found
[00005e6c]                           dc.b $00
[00005e6d]                           dc.b $00
[00005e6e]                           dc.b $00
[00005e6f]                           dc.b $3e
[00005e70] 00005fbe                  dc.l $00005fbe ; no symbol found
[00005e74]                           dc.b $00
[00005e75]                           dc.b $00
[00005e76]                           dc.b $00
[00005e77]                           dc.b $22
[00005e78] 00005fb7                  dc.l $00005fb7 ; no symbol found
[00005e7c]                           dc.b $00
[00005e7d]                           dc.b $00
[00005e7e]                           dc.b $00
[00005e7f]                           dc.b $3b
[00005e80] 00005fb0                  dc.l $00005fb0 ; no symbol found
[00005e84]                           dc.b $00
[00005e85]                           dc.b $00
[00005e86]                           dc.b $00
[00005e87]                           dc.b $2b
[00005e88] 00005fa9                  dc.l $00005fa9 ; no symbol found
[00005e8c]                           dc.b $00
[00005e8d]                           dc.b $00
[00005e8e]                           dc.b $00
[00005e8f]                           dc.b $33
[00005e90] 00005fa2                  dc.l $00005fa2 ; no symbol found
[00005e94]                           dc.b $00
[00005e95]                           dc.b $00
[00005e96]                           dc.b $00
[00005e97]                           dc.b $38
[00005e98] 00005f9b                  dc.l $00005f9b ; no symbol found
[00005e9c]                           dc.b $00
[00005e9d]                           dc.b $00
[00005e9e]                           dc.b $00
[00005e9f]                           dc.b $3a
[00005ea0] 00005f93                  dc.l $00005f93 ; no symbol found
[00005ea4]                           dc.b $00
[00005ea5]                           dc.b $00
[00005ea6]                           dc.b $00
[00005ea7]                           dc.b $28
[00005ea8] 00005f8b                  dc.l $00005f8b ; no symbol found
[00005eac]                           dc.b $00
[00005ead]                           dc.b $00
[00005eae]                           dc.b $00
[00005eaf]                           dc.b $2a
[00005eb0] 00005f83                  dc.l $00005f83 ; no symbol found
[00005eb4]                           dc.b $00
[00005eb5]                           dc.b $00
[00005eb6]                           dc.b $00
[00005eb7]                           dc.b $32
[00005eb8] 00005f7b                  dc.l $00005f7b ; no symbol found
[00005ebc]                           dc.b $00
[00005ebd]                           dc.b $00
[00005ebe]                           dc.b $00
[00005ebf]                           dc.b $3d
[00005ec0] 00005f73                  dc.l $00005f73 ; no symbol found
[00005ec4]                           dc.b $00
[00005ec5]                           dc.b $00
[00005ec6]                           dc.b $00
[00005ec7]                           dc.b $61
[00005ec8] 00005f6b                  dc.l $00005f6b ; no symbol found
[00005ecc]                           dc.b $00
[00005ecd]                           dc.b $00
[00005ece]                           dc.b $00
[00005ecf]                           dc.b $34
[00005ed0] 00005f63                  dc.l $00005f63 ; no symbol found
[00005ed4]                           dc.b $00
[00005ed5]                           dc.b $00
[00005ed6]                           dc.b $00
[00005ed7]                           dc.b $35
[00005ed8] 00005f5b                  dc.l $00005f5b ; no symbol found
[00005edc]                           dc.b $00
[00005edd]                           dc.b $00
[00005ede]                           dc.b $00
[00005edf]                           dc.b $36
[00005ee0] 00005f52                  dc.l $00005f52 ; no symbol found
[00005ee4]                           dc.b $00
[00005ee5]                           dc.b $00
[00005ee6]                           dc.b $00
[00005ee7]                           dc.b $60
[00005ee8] 00005f49                  dc.l $00005f49 ; no symbol found
[00005eec]                           dc.b $00
[00005eed]                           dc.b $00
[00005eee]                           dc.b $00
[00005eef]                           dc.b $26
[00005ef0] 00005f40                  dc.l $00005f40 ; no symbol found
[00005ef4]                           dc.b $00
[00005ef5]                           dc.b $00
[00005ef6]                           dc.b $00
[00005ef7]                           dc.b $37
[00005ef8] 00005f36                  dc.l $00005f36 ; no symbol found
[00005efc]                           dc.b $00
[00005efd]                           dc.b $00
[00005efe]                           dc.b $00
[00005eff]                           dc.b $25
[00005f00] 00005f2c                  dc.l $00005f2c ; no symbol found
[00005f04]                           dc.b $00
[00005f05]                           dc.b $00
[00005f06]                           dc.b $00
[00005f07]                           dc.b $31
[00005f08] 00005f22                  dc.l $00005f22 ; no symbol found
[00005f0c]                           dc.b $00
[00005f0d]                           dc.b $00
[00005f0e]                           dc.b $00
[00005f0f]                           dc.b $39
[00005f10] 00005f18                  dc.l $00005f18 ; no symbol found
[00005f14]                           dc.b $00
[00005f15]                           dc.b $00
[00005f16]                           dc.b $00
[00005f17]                           dc.b $3f
[00005f18]                           dc.w $0876
[00005f1a]                           dc.b 'olatile',0
[00005f22]                           dc.w $0875
[00005f24]                           dc.b 'nsigned',0
[00005f2c]                           dc.w $0872
[00005f2e]                           dc.b 'egister',0
[00005f36]                           dc.w $0863
[00005f38]                           dc.b 'ontinue',0
[00005f40]                           dc.w $0774
[00005f42]                           dc.b 'ypedef',0
[00005f49]                           dc.b $07
[00005f4a]                           dc.b 'default',0
[00005f52]                           dc.w $0724
[00005f54]                           dc.b 'noside',0
[00005f5b]                           dc.b $06
[00005f5c]                           dc.b 'switch',0
[00005f63]                           dc.b $06
[00005f64]                           dc.b 'struct',0
[00005f6b]                           dc.b $06
[00005f6c]                           dc.b 'static',0
[00005f73]                           dc.b $06
[00005f74]                           dc.b 'sizeof',0
[00005f7b]                           dc.b $06
[00005f7c]                           dc.b 'signed',0
[00005f83]                           dc.b $06
[00005f84]                           dc.b 'return',0
[00005f8b]                           dc.b $06
[00005f8c]                           dc.b 'extern',0
[00005f93]                           dc.b $06
[00005f94]                           dc.b 'double',0
[00005f9b]                           dc.b $05
[00005f9c]                           dc.b 'while',0
[00005fa2]                           dc.w $0575
[00005fa4]                           dc.b 'nion',0
[00005fa9]                           dc.b $05
[00005faa]                           dc.b 'short',0
[00005fb0]                           dc.w $0566
[00005fb2]                           dc.b 'loat',0
[00005fb7]                           dc.b $05
[00005fb8]                           dc.b 'const',0
[00005fbe]                           dc.w $0562
[00005fc0]                           dc.b 'reak',0
[00005fc5]                           dc.b $04
[00005fc6]                           dc.b 'void',0
[00005fcb]                           dc.b $04
[00005fcc]                           dc.b 'long',0
[00005fd1]                           dc.b $04
[00005fd2]                           dc.b 'goto',0
[00005fd7]                           dc.b $04
[00005fd8]                           dc.b 'enum',0
[00005fdd]                           dc.b $04
[00005fde]                           dc.b 'else',0
[00005fe3]                           dc.b $04
[00005fe4]                           dc.b 'char',0
[00005fe9]                           dc.b $04
[00005fea]                           dc.b 'case',0
[00005fef]                           dc.b $04
[00005ff0]                           dc.b 'auto',0
[00005ff5]                           dc.b $03
[00005ff6]                           dc.b 'int',0
[00005ffa]                           dc.w $0366
[00005ffc]                           dc.w $6f72
[00005ffe]                           dc.b $00
[00005fff]                           dc.b $02
[00006000]                           dc.w $6966
[00006002]                           dc.b $00
[00006003]                           dc.b $02
[00006004]                           dc.w $646f
[00006006]                           dc.b $00
[00006007]                           dc.b $20
[00006008]                           dc.b $00
[00006009]                           dc.b $00
[0000600a]                           dc.b 'illegal integer %b',0
[0000601d]                           dc.b $00
[0000601e]                           dc.w 'c4',0
[00006021]                           dc.b $00
[00006022]                           dc.b 'illegal float constant',0
[00006039]                           dc.b 'c8',0
[0000603c]                           dc.b 'ccb',0
[00006040]                           dc.w 'c',0
[00006042]                           dc.w 'c4',0
[00006045]                           dc.b $00
[00006046]                           dc.w 'c',0
[00006048]                           dc.b 'c2b',0
[0000604c]                           dc.b 'c2bb',0
[00006051]                           dc.b $00

[00006052]                           ds.b 256
[00006152]                           dc.b $00
[00006153]                           dc.b $00
[00006154]                           dc.b $00
[00006155]                           dc.b $00
[00006156]                           dc.b $00
[00006157]                           dc.b $00
[00006158]                           dc.b $00
[00006159]                           dc.b $00
[0000615a]                           dc.b $00
[0000615b]                           dc.b $00
[0000615c]                           dc.b $00
[0000615d]                           dc.b $00
[0000615e]                           dc.w $220a
[00006160]                           dc.b $00
[00006161]                           dc.b $20
[00006162]                           dc.w $2200
[00006164]                           dc.w $2320
[00006166]                           dc.b $00
[00006167]                           dc.b 'ccp',0
[0000616b]                           dc.b 'cc',0

; switchtable in putls
[0000616e] 00001e1c                  dc.l $00001e1c ; no symbol found
[00006172]                           dc.l 7
[00006176] 00001d66                  dc.l $00001d66 ; no symbol found
[0000617a]                           dc.l 4
[0000617e] 00001d5c                  dc.l $00001d5c ; no symbol found
[00006182]                           dc.l 1
[00006186] 00001d52                  dc.l $00001d52 ; no symbol found
[0000618a]                           dc.l 8
[0000618e] 00001d48                  dc.l $00001d48 ; no symbol found
[00006192]                           dc.l 6
[00006196] 00001d3c                  dc.l $00001d3c ; no symbol found
[0000619a]                           dc.l 3
[0000619e]                           dc.l 0
[000061a2] 00001e22                  dc.l $00001e22 ; no symbol found

[000061a6]                           dc.b 'eExX',0
[000061ab]                           dc.b $22
[000061ac]                           dc.b $00
[000061ad]                           dc.b $00
_pdefs:
[000061ae]                           dc.l 10,0,0,0,0,0,0,0,0,0,0
_ofile:
[000061da]                           dc.l 0
_cplusflag:
[000061de]                           dc.l 0
_errflag:
[000061e2]                           dc.l 0
_liflag:
[000061e6]                           dc.l 0
_oldflag:
[000061ea]                           dc.l 0
_pasflag:
[000061ee]                           dc.l 0
_stdflag:
[000061f2]                           dc.l 0
_xflag:
[000061f6]                           dc.l 0
_pchar:
[000061fa]                           dc.l '#'
_schar:
[000061fe]                           dc.l 0
_inif:
[00006202]                           dc.w 0
_inincl:
[00006204]                           dc.w 0
_escname:
[00006206]                           dc.b '\4$esc',0
_iprefix:
[0000620c] 00006210                  dc.l $00006210 ; no symbol found
[00006210]                           dc.w $7c00
_mapfile:
[00006212]                           dc.l 0
__pname:
[00006216] 0000621a                  dc.l $0000621a ; no symbol found
[0000621a]                           dc.w $7070
[0000621c]                           dc.b $00
[0000621d]                           dc.b $00
_pasline:
[0000621e]                           dc.l 0
_failincl:
[00006222]                           dc.l 0
_pflag:
[00006226]                           dc.l 1
_argc:
[0000622a]                           dc.l 0
_lineno:
[0000622e]                           dc.w 0
_nerrors:
[00006230]                           dc.w 0
_errfd:
[00006232]                           dc.w 2
_pincl:
[00006234]                           dc.l 0
_argv:
[00006238]                           dc.l 0
_perr:
[0000623c]                           dc.l 0
_errbuf:
[00006240]                           ds.b 128
_pptab:
[000062c0] 00006422                  dc.l $00006422 ; no symbol found
[000062c4]                           dc.l 14
[000062c8] 0000641e                  dc.l $0000641e ; no symbol found
[000062cc]                           dc.l 14
[000062d0] 00006418                  dc.l $00006418 ; no symbol found
[000062d4]                           dc.l 11
[000062d8] 00006412                  dc.l $00006412 ; no symbol found
[000062dc]                           dc.l 12
[000062e0] 0000640c                  dc.l $0000640c ; no symbol found
[000062e4]                           dc.l 18
[000062e8] 00006406                  dc.l $00006406 ; no symbol found
[000062ec]                           dc.l 11
[000062f0] 00006400                  dc.l $00006400 ; no symbol found
[000062f4]                           dc.l 12
[000062f8] 000063fa                  dc.l $000063fa ; no symbol found
[000062fc]                           dc.l 18
[00006300] 000063f3                  dc.l $000063f3 ; no symbol found
[00006304]                           dc.l 13
[00006308] 000063ec                  dc.l $000063ec ; no symbol found
[0000630c]                           dc.l 22
[00006310] 000063e5                  dc.l $000063e5 ; no symbol found
[00006314]                           dc.l 15
[00006318] 000063de                  dc.l $000063de ; no symbol found
[0000631c]                           dc.l 21
[00006320] 000063d7                  dc.l $000063d7 ; no symbol found
[00006324]                           dc.l 13
[00006328] 000063d0                  dc.l $000063d0 ; no symbol found
[0000632c]                           dc.l 22
[00006330] 000063c9                  dc.l $000063c9 ; no symbol found
[00006334]                           dc.l 15
[00006338] 000063c2                  dc.l $000063c2 ; no symbol found
[0000633c]                           dc.l 21
[00006340] 000063ba                  dc.l $000063ba ; no symbol found
[00006344]                           dc.l 10
[00006348] 000063b2                  dc.l $000063b2 ; no symbol found
[0000634c]                           dc.l 16
[00006350] 000063aa                  dc.l $000063aa ; no symbol found
[00006354]                           dc.l 19
[00006358] 000063a2                  dc.l $000063a2 ; no symbol found
[0000635c]                           dc.l 10
[00006360] 0000639a                  dc.l $0000639a ; no symbol found
[00006364]                           dc.l 16
[00006368] 00006392                  dc.l $00006392 ; no symbol found
[0000636c]                           dc.l 19
[00006370] 00006389                  dc.l $00006389 ; no symbol found
[00006374]                           dc.l 17
[00006378] 00006380                  dc.l $00006380 ; no symbol found
[0000637c]                           dc.l 17

[00006380]                           dc.w $0769
[00006382]                           dc.b 'nclude',0
[00006389]                           dc.b $07
[0000638a]                           dc.b 'INCLUDE',0
[00006392]                           dc.w $0670
[00006394]                           dc.b 'ragma',0
[0000639a]                           dc.w $0669
[0000639c]                           dc.b 'fndef',0
[000063a2]                           dc.w $0664
[000063a4]                           dc.b 'efine',0
[000063aa]                           dc.w $0650
[000063ac]                           dc.b 'RAGMA',0
[000063b2]                           dc.w $0649
[000063b4]                           dc.b 'FNDEF',0
[000063ba]                           dc.w $0644
[000063bc]                           dc.b 'EFINE',0
[000063c2]                           dc.w $0575
[000063c4]                           dc.b 'ndef',0
[000063c9]                           dc.b $05
[000063ca]                           dc.b 'ifdef',0
[000063d0]                           dc.w $0565
[000063d2]                           dc.b 'rror',0
[000063d7]                           dc.b $05
[000063d8]                           dc.b 'endif',0
[000063de]                           dc.w $0555
[000063e0]                           dc.b 'NDEF',0
[000063e5]                           dc.b $05
[000063e6]                           dc.b 'IFDEF',0
[000063ec]                           dc.w $0545
[000063ee]                           dc.b 'RROR',0
[000063f3]                           dc.b $05
[000063f4]                           dc.b 'ENDIF',0
[000063fa]                           dc.w $046c
[000063fc]                           dc.b 'ine',0
[00006400]                           dc.w $0465
[00006402]                           dc.b 'lse',0
[00006406]                           dc.w $0465
[00006408]                           dc.b 'lif',0
[0000640c]                           dc.w $044c
[0000640e]                           dc.b 'INE',0
[00006412]                           dc.w $0445
[00006414]                           dc.b 'LSE',0
[00006418]                           dc.w $0445
[0000641a]                           dc.b 'LIF',0
[0000641e]                           dc.w $0269
[00006420]                           dc.w $6600
[00006422]                           dc.w $0249
[00006424]                           dc.w $4600
; switchtable in getex()
[00006426] 00001f68                  dc.l $00001f68 ; no symbol found
[0000642a]                           dc.b $00
[0000642b]                           dc.b $00
[0000642c]                           dc.b $00
[0000642d]                           dc.b $10
[0000642e] 00001f68                  dc.l $00001f68 ; no symbol found
[00006432]                           dc.b $00
[00006433]                           dc.b $00
[00006434]                           dc.b $00
[00006435]                           dc.b $0f
[00006436] 00001f4a                  dc.l $00001f4a ; no symbol found
[0000643a]                           dc.b $00
[0000643b]                           dc.b $00
[0000643c]                           dc.b $00
[0000643d]                           dc.b $0b
[0000643e] 00001f4a                  dc.l $00001f4a ; no symbol found
[00006442]                           dc.b $00
[00006443]                           dc.b $00
[00006444]                           dc.b $00
[00006445]                           dc.b $0e
[00006446] 00001f46                  dc.l $00001f46 ; no symbol found
[0000644a]                           dc.b $00
[0000644b]                           dc.b $00
[0000644c]                           dc.b $00
[0000644d]                           dc.b $14
[0000644e] 00001f42                  dc.l $00001f42 ; no symbol found
[00006452]                           dc.b $00
[00006453]                           dc.b $00
[00006454]                           dc.b $00
[00006455]                           dc.b $15
[00006456] 00001f3e                  dc.l $00001f3e ; no symbol found
[0000645a]                           dc.b $00
[0000645b]                           dc.b $00
[0000645c]                           dc.b $00
[0000645d]                           dc.b $0a
[0000645e] 00001f28                  dc.l $00001f28 ; no symbol found
[00006462]                           dc.b $00
[00006463]                           dc.b $00
[00006464]                           dc.b $00
[00006465]                           dc.b $11
[00006466]                           dc.b $00
[00006467]                           dc.b $00
[00006468]                           dc.b $00
[00006469]                           dc.b $00
[0000646a] 00001fea                  dc.l $00001fea ; no symbol found

[0000646e]                           dc.b 'bad #%b',0
[00006476]                           dc.b '#line inside macro',0
[00006489]                           dc.b $00

[0000648a]                           dc.l 0
getinl.flag:
[0000648e]                           dc.l 0
getinl.linebuf:
[00006492]                           ds.b 4096

[00007492]                           dc.w $0a00
[00007494]                           dc.b 'unbalanced comment in file',0
[000074af]                           dc.b $00
[000074b0]                           dc.b 'folded line',0
[000074bc]                           dc.b 'misplaced #%b',0
[000074ca]                           dc.b 'can',$27,'t read map file: %p',0
[000074e2]                           dc.b 'can',$27,'t open map file: %p',0
[000074fa]                           dc.b 'ccp',0
[000074fe]                           dc.w 'c',0
[00007500]                           dc.b 'can',$27,'t create ',0
[0000750e]                           dc.b '+cplus,d*>err,i*,+lincl,+map*,+old,o*,+pas,p?,+std,s?,x:F <files>',0
[00007550]                           dc.b 'missing #endif',0
[0000755f]                           dc.b $00

; switchtable in putns
[00007560] 00002b9a                  dc.l $00002b9a ; no symbol found
[00007564]                           dc.l 20
[00007568] 00002b4e                  dc.l $00002b4e ; no symbol found
[0000756c]                           dc.l 19
[00007570] 000028e2                  dc.l $000028e2 ; no symbol found
[00007574]                           dc.l 18
[00007578] 0000280e                  dc.l $0000280e ; no symbol found
[0000757c]                           dc.l 17
[00007580] 000027d6                  dc.l $000027d6 ; no symbol found
[00007584]                           dc.l 21
[00007588] 000026e6                  dc.l $000026e6 ; no symbol found
[0000758c]                           dc.l 10
[00007590] 00002646                  dc.l $00002646 ; no symbol found
[00007594]                           dc.l 22
[00007598]                           dc.l 0
[0000759c] 00002bb8                  dc.l $00002bb8 ; no symbol found

[000075a0]                           dc.b 'bad #xxx',0
[000075a9]                           dc.b 'c',0
[000075ab]                           dc.b 'c',0
[000075ad]                           dc.b 'bad #line syntax',0
[000075be]                           dc.b 'bad #line',0
[000075c8]                           dc.b 'can',$27,'t open #include!',0
[000075dd]                           dc.b 'can',$27,'t #include %p',0
[000075ef]                           dc.b 'bad #undef',0
[000075fa]                           dc.b 'redefined %b',0
[00007607]                           dc.b 'bad #define',0
[00007613]                           dc.b 'b',0
[00007615]                           dc.b '2',0
[00007617]                           dc.b 'c',0
[00007619]                           dc.b $00
[0000761a]                           dc.b $00
[0000761b]                           dc.b $00
[0000761c]                           dc.b $00
[0000761d]                           dc.b $00
[0000761e]                           dc.b $00
[0000761f]                           dc.b $00
[00007620]                           dc.b $00
[00007621]                           dc.b $00
[00007622]                           dc.b $00
[00007623]                           dc.b $00
[00007624]                           dc.b $00
[00007625]                           dc.b $00
[00007626]                           dc.b $00
[00007627]                           dc.b $00
[00007628]                           dc.b $00
[00007629]                           dc.b $00
[0000762a]                           dc.b $00
[0000762b]                           dc.b $00
[0000762c]                           dc.b $00
[0000762d]                           dc.b $00
[0000762e]                           dc.b $00
[0000762f]                           dc.b $00
[00007630]                           dc.b $00
[00007631]                           dc.b $00
[00007632]                           dc.b $00
[00007633]                           dc.b $00
[00007634]                           dc.b $00
[00007635]                           dc.b $00
[00007636]                           dc.b $00
[00007637]                           dc.b $00
[00007638]                           dc.b $00
[00007639]                           dc.b $00
[0000763a]                           dc.b $00
[0000763b]                           dc.b $00
[0000763c]                           dc.b $00
[0000763d]                           dc.b $00
[0000763e]                           dc.b $00
[0000763f]                           dc.b $00
[00007640]                           dc.b $00
[00007641]                           dc.b $00
[00007642]                           dc.b $00
[00007643]                           dc.b $00
[00007644]                           dc.b $00
[00007645]                           dc.b $00
[00007646]                           dc.b $00
[00007647]                           dc.b $00
[00007648]                           dc.b $00
[00007649]                           dc.b $00
[0000764a]                           dc.b $00
[0000764b]                           dc.b $00
[0000764c]                           dc.b $00
[0000764d]                           dc.b $00
[0000764e]                           dc.b $00
[0000764f]                           dc.b $00
[00007650]                           dc.b $00
[00007651]                           dc.b $00
[00007652]                           dc.b $00
[00007653]                           dc.b $00
[00007654]                           dc.b $00
[00007655]                           dc.b $00
[00007656]                           dc.b $00
[00007657]                           dc.b $00
[00007658]                           dc.b $00
[00007659]                           dc.b $00
[0000765a]                           dc.b $00
[0000765b]                           dc.b $00
[0000765c]                           dc.b $00
[0000765d]                           dc.b $00
[0000765e]                           dc.b $00
[0000765f]                           dc.b $00
[00007660]                           dc.b $00
[00007661]                           dc.b $00
[00007662]                           dc.b $00
[00007663]                           dc.b $00
[00007664]                           dc.b $00
[00007665]                           dc.b $00
[00007666]                           dc.b $00
[00007667]                           dc.b $00
[00007668]                           dc.b $00
[00007669]                           dc.b $00
[0000766a]                           dc.b $00
[0000766b]                           dc.b $00
[0000766c]                           dc.b $00
[0000766d]                           dc.b $00
[0000766e]                           dc.b $00
[0000766f]                           dc.b $00
[00007670]                           dc.b $00
[00007671]                           dc.b $00
[00007672]                           dc.b $00
[00007673]                           dc.b $00
[00007674]                           dc.b $00
[00007675]                           dc.b $00
[00007676]                           dc.b $00
[00007677]                           dc.b $00
[00007678]                           dc.b $00
[00007679]                           dc.b $00
[0000767a]                           dc.b $00
[0000767b]                           dc.b $00
[0000767c]                           dc.b $00
[0000767d]                           dc.b $00
[0000767e]                           dc.b $00
[0000767f]                           dc.b $00
[00007680]                           dc.b $00
[00007681]                           dc.b $00
[00007682]                           dc.b $00
[00007683]                           dc.b $00
[00007684]                           dc.b $00
[00007685]                           dc.b $00
[00007686]                           dc.b $00
[00007687]                           dc.b $00
[00007688]                           dc.b $00
[00007689]                           dc.b $00
[0000768a]                           dc.b $00
[0000768b]                           dc.b $00
[0000768c]                           dc.b $00
[0000768d]                           dc.b $00
[0000768e]                           dc.b $00
[0000768f]                           dc.b $00
[00007690]                           dc.b $00
[00007691]                           dc.b $00
[00007692]                           dc.b $00
[00007693]                           dc.b $00
[00007694]                           dc.b $00
[00007695]                           dc.b $00
[00007696]                           dc.b $00
[00007697]                           dc.b $00
[00007698]                           dc.b $00
[00007699]                           dc.b $00
[0000769a]                           dc.b $00
[0000769b]                           dc.b $00
[0000769c]                           dc.b $00
[0000769d]                           dc.b $00
[0000769e]                           dc.b $00
[0000769f]                           dc.b $00
[000076a0]                           dc.b $00
[000076a1]                           dc.b $00
[000076a2]                           dc.b $00
[000076a3]                           dc.b $00
[000076a4]                           dc.b $00
[000076a5]                           dc.b $00
[000076a6]                           dc.b $00
[000076a7]                           dc.b $00
[000076a8]                           dc.b $00
[000076a9]                           dc.b $00
[000076aa]                           dc.b $00
[000076ab]                           dc.b $00
[000076ac]                           dc.b $00
[000076ad]                           dc.b $00
[000076ae]                           dc.b $00
[000076af]                           dc.b $00
[000076b0]                           dc.b $00
[000076b1]                           dc.b $00
[000076b2]                           dc.b $00
[000076b3]                           dc.b $00
[000076b4]                           dc.b $00
[000076b5]                           dc.b $00
[000076b6]                           dc.b $00
[000076b7]                           dc.b $00
[000076b8]                           dc.b $00
[000076b9]                           dc.b $00
[000076ba]                           dc.b $00
[000076bb]                           dc.b $00
[000076bc]                           dc.b $00
[000076bd]                           dc.b $00
[000076be]                           dc.b $00
[000076bf]                           dc.b $00
[000076c0]                           dc.b $00
[000076c1]                           dc.b $00
[000076c2]                           dc.b $00
[000076c3]                           dc.b $00
[000076c4]                           dc.b $00
[000076c5]                           dc.b $00
[000076c6]                           dc.b $00
[000076c7]                           dc.b $00
[000076c8]                           dc.b $00
[000076c9]                           dc.b $00
[000076ca]                           dc.b $00
[000076cb]                           dc.b $00
[000076cc]                           dc.b $00
[000076cd]                           dc.b $00
[000076ce]                           dc.b $00
[000076cf]                           dc.b $00
[000076d0]                           dc.b $00
[000076d1]                           dc.b $00
[000076d2]                           dc.b $00
[000076d3]                           dc.b $00
[000076d4]                           dc.b $00
[000076d5]                           dc.b $00
[000076d6]                           dc.b $00
[000076d7]                           dc.b $00
[000076d8]                           dc.b $00
[000076d9]                           dc.b $00
[000076da]                           dc.b $00
[000076db]                           dc.b $00
[000076dc]                           dc.b $00
[000076dd]                           dc.b $00
[000076de]                           dc.b $00
[000076df]                           dc.b $00
[000076e0]                           dc.b $00
[000076e1]                           dc.b $00
[000076e2]                           dc.b $00
[000076e3]                           dc.b $00
[000076e4]                           dc.b $00
[000076e5]                           dc.b $00
[000076e6]                           dc.b $00
[000076e7]                           dc.b $00
[000076e8]                           dc.b $00
[000076e9]                           dc.b $00
[000076ea]                           dc.b $00
[000076eb]                           dc.b $00
[000076ec]                           dc.b $00
[000076ed]                           dc.b $00
[000076ee]                           dc.b $00
[000076ef]                           dc.b $00
[000076f0]                           dc.b $00
[000076f1]                           dc.b $00
[000076f2]                           dc.b $00
[000076f3]                           dc.b $00
[000076f4]                           dc.b $00
[000076f5]                           dc.b $00
[000076f6]                           dc.b $00
[000076f7]                           dc.b $00
[000076f8]                           dc.b $00
[000076f9]                           dc.b $00
[000076fa]                           dc.b $00
[000076fb]                           dc.b $00
[000076fc]                           dc.b $00
[000076fd]                           dc.b $00
[000076fe]                           dc.b $00
[000076ff]                           dc.b $00
[00007700]                           dc.b $00
[00007701]                           dc.b $00
[00007702]                           dc.b $00
[00007703]                           dc.b $00
[00007704]                           dc.b $00
[00007705]                           dc.b $00
[00007706]                           dc.b $00
[00007707]                           dc.b $00
[00007708]                           dc.b $00
[00007709]                           dc.b $00
[0000770a]                           dc.b $00
[0000770b]                           dc.b $00
[0000770c]                           dc.b $00
[0000770d]                           dc.b $00
[0000770e]                           dc.b $00
[0000770f]                           dc.b $00
[00007710]                           dc.b $00
[00007711]                           dc.b $00
[00007712]                           dc.b $00
[00007713]                           dc.b $00
[00007714]                           dc.b $00
[00007715]                           dc.b $00
[00007716]                           dc.b $00
[00007717]                           dc.b $00
[00007718]                           dc.b $00
[00007719]                           dc.b $00
[0000771a]                           dc.b $00
[0000771b]                           dc.b $00
[0000771c]                           dc.b $00
[0000771d]                           dc.b $00
[0000771e]                           dc.b $00
[0000771f]                           dc.b $00
[00007720]                           dc.b $00
[00007721]                           dc.b $00
[00007722]                           dc.b $00
[00007723]                           dc.b $00
[00007724]                           dc.b $00
[00007725]                           dc.b $00
[00007726]                           dc.b $00
[00007727]                           dc.b $00
[00007728]                           dc.b $00
[00007729]                           dc.b $00
[0000772a]                           dc.b $00
[0000772b]                           dc.b $00
[0000772c]                           dc.b $00
[0000772d]                           dc.b $00
[0000772e]                           dc.b $00
[0000772f]                           dc.b $00
[00007730]                           dc.b $00
[00007731]                           dc.b $00
[00007732]                           dc.b $00
[00007733]                           dc.b $00
[00007734]                           dc.b $00
[00007735]                           dc.b $00
[00007736]                           dc.b $00
[00007737]                           dc.b $00
[00007738]                           dc.b $00
[00007739]                           dc.b $00
[0000773a]                           dc.b $00
[0000773b]                           dc.b $00
[0000773c]                           dc.b $00
[0000773d]                           dc.b $00
[0000773e]                           dc.b $00
[0000773f]                           dc.b $00
[00007740]                           dc.b $00
[00007741]                           dc.b $00
[00007742]                           dc.b $00
[00007743]                           dc.b $00
[00007744]                           dc.b $00
[00007745]                           dc.b $00
[00007746]                           dc.b $00
[00007747]                           dc.b $00
[00007748]                           dc.b $00
[00007749]                           dc.b $00
[0000774a]                           dc.b $00
[0000774b]                           dc.b $00
[0000774c]                           dc.b $00
[0000774d]                           dc.b $00
[0000774e]                           dc.b $00
[0000774f]                           dc.b $00
[00007750]                           dc.b $00
[00007751]                           dc.b $00
[00007752]                           dc.b $00
[00007753]                           dc.b $00
[00007754]                           dc.b $00
[00007755]                           dc.b $00
[00007756]                           dc.b $00
[00007757]                           dc.b $00
[00007758]                           dc.b $00
[00007759]                           dc.b $00
[0000775a]                           dc.b $00
[0000775b]                           dc.b $00
[0000775c]                           dc.b $00
[0000775d]                           dc.b $00
[0000775e]                           dc.b $00
[0000775f]                           dc.b $00
[00007760]                           dc.b $00
[00007761]                           dc.b $00
[00007762]                           dc.b $00
[00007763]                           dc.b $00
[00007764]                           dc.b $00
[00007765]                           dc.b $00
[00007766]                           dc.b $00
[00007767]                           dc.b $00
[00007768]                           dc.b $00
[00007769]                           dc.b $00
[0000776a]                           dc.b $00
[0000776b]                           dc.b $00
[0000776c]                           dc.b $00
[0000776d]                           dc.b $00
[0000776e]                           dc.b $00
[0000776f]                           dc.b $00
[00007770]                           dc.b $00
[00007771]                           dc.b $00
[00007772]                           dc.b $00
[00007773]                           dc.b $00
[00007774]                           dc.b $00
[00007775]                           dc.b $00
[00007776]                           dc.b $00
[00007777]                           dc.b $00
[00007778]                           dc.b $00
[00007779]                           dc.b $00
[0000777a]                           dc.b $00
[0000777b]                           dc.b $00
[0000777c]                           dc.b $00
[0000777d]                           dc.b $00
[0000777e]                           dc.b $00
[0000777f]                           dc.b $00
[00007780]                           dc.b $00
[00007781]                           dc.b $00
[00007782]                           dc.b $00
[00007783]                           dc.b $00
[00007784]                           dc.b $00
[00007785]                           dc.b $00
[00007786]                           dc.b $00
[00007787]                           dc.b $00
[00007788]                           dc.b $00
[00007789]                           dc.b $00
[0000778a]                           dc.b $00
[0000778b]                           dc.b $00
[0000778c]                           dc.b $00
[0000778d]                           dc.b $00
[0000778e]                           dc.b $00
[0000778f]                           dc.b $00
[00007790]                           dc.b $00
[00007791]                           dc.b $00
[00007792]                           dc.b $00
[00007793]                           dc.b $00
[00007794]                           dc.b $00
[00007795]                           dc.b $00
[00007796]                           dc.b $00
[00007797]                           dc.b $00
[00007798]                           dc.b $00
[00007799]                           dc.b $00
[0000779a]                           dc.b $00
[0000779b]                           dc.b $00
[0000779c]                           dc.b $00
[0000779d]                           dc.b $00
[0000779e]                           dc.b $00
[0000779f]                           dc.b $00
[000077a0]                           dc.b $00
[000077a1]                           dc.b $00
[000077a2]                           dc.b $00
[000077a3]                           dc.b $00
[000077a4]                           dc.b $00
[000077a5]                           dc.b $00
[000077a6]                           dc.b $00
[000077a7]                           dc.b $00
[000077a8]                           dc.b $00
[000077a9]                           dc.b $00
[000077aa]                           dc.b $00
[000077ab]                           dc.b $00
[000077ac]                           dc.b $00
[000077ad]                           dc.b $00
[000077ae]                           dc.b $00
[000077af]                           dc.b $00
[000077b0]                           dc.b $00
[000077b1]                           dc.b $00
[000077b2]                           dc.b $00
[000077b3]                           dc.b $00
[000077b4]                           dc.b $00
[000077b5]                           dc.b $00
[000077b6]                           dc.b $00
[000077b7]                           dc.b $00
[000077b8]                           dc.b $00
[000077b9]                           dc.b $00
[000077ba]                           dc.b $00
[000077bb]                           dc.b $00
[000077bc]                           dc.b $00
[000077bd]                           dc.b $00
[000077be]                           dc.b $00
[000077bf]                           dc.b $00
[000077c0]                           dc.b $00
[000077c1]                           dc.b $00
[000077c2]                           dc.b $00
[000077c3]                           dc.b $00
[000077c4]                           dc.b $00
[000077c5]                           dc.b $00
[000077c6]                           dc.b $00
[000077c7]                           dc.b $00
[000077c8]                           dc.b $00
[000077c9]                           dc.b $00
[000077ca]                           dc.b $00
[000077cb]                           dc.b $00
[000077cc]                           dc.b $00
[000077cd]                           dc.b $00
[000077ce]                           dc.b $00
[000077cf]                           dc.b $00
[000077d0]                           dc.b $00
[000077d1]                           dc.b $00
[000077d2]                           dc.b $00
[000077d3]                           dc.b $00
[000077d4]                           dc.b $00
[000077d5]                           dc.b $00
[000077d6]                           dc.b $00
[000077d7]                           dc.b $00
[000077d8]                           dc.b $00
[000077d9]                           dc.b $00
[000077da]                           dc.b $00
[000077db]                           dc.b $00
[000077dc]                           dc.b $00
[000077dd]                           dc.b $00
[000077de]                           dc.b $00
[000077df]                           dc.b $00
[000077e0]                           dc.b $00
[000077e1]                           dc.b $00
[000077e2]                           dc.b $00
[000077e3]                           dc.b $00
[000077e4]                           dc.b $00
[000077e5]                           dc.b $00
[000077e6]                           dc.b $00
[000077e7]                           dc.b $00
[000077e8]                           dc.b $00
[000077e9]                           dc.b $00
[000077ea]                           dc.b $00
[000077eb]                           dc.b $00
[000077ec]                           dc.b $00
[000077ed]                           dc.b $00
[000077ee]                           dc.b $00
[000077ef]                           dc.b $00
[000077f0]                           dc.b $00
[000077f1]                           dc.b $00
[000077f2]                           dc.b $00
[000077f3]                           dc.b $00
[000077f4]                           dc.b $00
[000077f5]                           dc.b $00
[000077f6]                           dc.b $00
[000077f7]                           dc.b $00
[000077f8]                           dc.b $00
[000077f9]                           dc.b $00
[000077fa]                           dc.b $00
[000077fb]                           dc.b $00
[000077fc]                           dc.b $00
[000077fd]                           dc.b $00
[000077fe]                           dc.b $00
[000077ff]                           dc.b $00
[00007800]                           dc.b $00
[00007801]                           dc.b $00
[00007802]                           dc.b $00
[00007803]                           dc.b $00
[00007804]                           dc.b $00
[00007805]                           dc.b $00
[00007806]                           dc.b $00
[00007807]                           dc.b $00
[00007808]                           dc.b $00
[00007809]                           dc.b $00
[0000780a]                           dc.b $00
[0000780b]                           dc.b $00
[0000780c]                           dc.b $00
[0000780d]                           dc.b $00
[0000780e]                           dc.b $00
[0000780f]                           dc.b $00
[00007810]                           dc.b $00
[00007811]                           dc.b $00
[00007812]                           dc.b $00
[00007813]                           dc.b $00
[00007814]                           dc.b $00
[00007815]                           dc.b $00
[00007816]                           dc.b $00
[00007817]                           dc.b $00
[00007818]                           dc.b $00
[00007819]                           dc.b $00
[0000781a]                           dc.b $00
[0000781b]                           dc.b $00
[0000781c]                           dc.b $00
[0000781d]                           dc.b $00
[0000781e]                           dc.b 'can',$27,'t open %p',0
[0000782c]                           dc.w 'c2',0
[0000782f]                           dc.b $0a
[00007830]                           dc.b $00
[00007831]                           dc.b $09
[00007832]                           dc.b $00
[00007833]                           dc.b $3a
[00007834]                           dc.b $00
[00007835]                           dc.b $20
[00007836]                           dc.b $00
[00007837]                           dc.b '#error ',0
[0000783f]                           dc.b '%p%p%p%p%p%s%p',0
[0000784e]                           dc.b 'EOF: ',0
[00007854]                           dc.b '-d %b redefined',0
[00007864]                           dc.b ' 1',$0a,0
[00007868]                           dc.w $283d
[0000786a]                           dc.b $00
[0000786b]                           dc.b $00
[0000786c]                           dc.w 'c2',0
[0000786f]                           dc.b $00
[00007870]                           dc.w $0a00
[00007872]                           dc.b 'unbalanced %c',0
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
00001c34 T _putls
00001e68 T _getex
00002004 T _getinl
00002134 T _getln
000021d8 T _main
0000243e T _putgr
0000262a T _putns
00002bc4 T _buytl
00002c3c T _fatal
00002c5c T _fretlist
00002c92 T _getfinclude
00002f16 T _hash
00002f5e T _install
00002fc6 T _lookup
0000303a T _nxtfile
000030f6 T _perrfmt
0000324a T _p0error
00003372 T _predef
0000345e T _ptline
000034aa T _scntab
0000354a T _stotl
0000392c T _fclose
000039da T _fread
00003a2e T _frelst
00003a60 T _getenv
00003abe T _getfiles
00003c62 T _getflags
0000409e T _inbuf
000040e4 T _itob
0000417e T _putlin
000041b0 T _usage
00004226 T _buybuf
0000425a T _cmpbuf
00004282 T _cmpstr
0000429c T _cpystr
000042ba T _create
00004342 T _doesc
0000449c T _finit
00004534 T _getl
000045ec T _instr
0000462e T a.lmod
00004640 T a.ldiv
0000468e T _lseek
00004708 T _open
00004710 T _putc
000047c8 T _putl
000048aa T _read
000048be T _scnstr
000048d8 T _seek
000048e0 T a.switch
000048f2 T a.ulmod
000048fa T a.uldiv
00004936 T _uname
000049de T _alloc
00004a18 T _nalloc
00004b5c T _free
00004c1e T _btol
00004e54 T _close
00004e5c T _cpybuf
00004e7e T _creat
00004e86 T a.1sub
00004e9a T a.6sub
00004ec4 T a.1add
00004ed8 T a.6add
00004f86 T _dtento
00005114 T _fstat
0000511c T _getpid
00005122 T a.lmul
0000514e T a.1ltd
00005156 T a.6ltd
00005188 T _putstr
000051be T _sbreak
00005202 T a.1div
00005216 T a.6div
00005322 T a.1mul
00005336 T a.6mul
00005416 T _fwrite
00005450 T _lenstr
00005462 T __raise
000054fe T __when
00005544 T a.repk
000055d8 T a.unpk
00005668 T _error
000056a6 T _write

00000000 0000ad5c 000056ae D __data
00000072 0000adce 00005720 D _environ
00000076 0000add2 00005724 D _errno
0000007a 0000add6 00005728 D __paths
00000082 0000adde 00005730 D _bltintab
000004e6 0000b242 00005b94 D _cmap
000005e6 0000b342 00005c94 D _digfr
000005fd 0000b359 00005cab D _digto
0000095a 0000b6b6 00006008 D _lastln
00000b30 0000b88c 000061de D _cplusflag
00000b34 0000b890 000061e2 D _errflag
00000b38 0000b894 000061e6 D _liflag
00000b3c 0000b898 000061ea D _oldflag
00000b40 0000b89c 000061ee D _pasflag
00000b44 0000b8a0 000061f2 D _stdflag
00000b48 0000b8a4 000061f6 D _xflag
00000b4c 0000b8a8 000061fa D _pchar
00000b50 0000b8ac 000061fe D _schar
00000b54 0000b8b0 00006202 D _inif
00000b56 0000b8b2 00006204 D _inincl
00000b58 0000b8b4 00006206 D _escname
00000b5e 0000b8ba 0000620c D _iprefix
00000b64 0000b8c0 00006212 D _mapfile
00000b68 0000b8c4 00006216 D __pname
00000b70 0000b8cc 0000621e D _pasline
00000b74 0000b8d0 00006222 D _failincl
00000b78 0000b8d4 00006226 D _pflag
00000b7c 0000b8d8 0000622a D _argc
00000b80 0000b8dc 0000622e D _lineno
00000b82 0000b8de 00006230 D _nerrors
00000b84 0000b8e0 00006232 D _errfd
00000b86 0000b8e2 00006234 D _pincl
00000b8a 0000b8e6 00006238 D _argv
00000b8e 0000b8ea 0000623c D _perr
00000b92 0000b8ee 00006240 D _errbuf
0000222e 0000cf8a 000078dc D _stdout
00002438 0000d194 00007ae6 D __pfio
00002440 0000d19c 00007aee D _readerr
00002460 0000d1bc 00007b0e D _fioerr
00002464 0000d1c0 00007b12 D __memerr
0000246c 0000d1c8 00007b1a D __stop
00002470 0000d1cc 00007b1e D __dtens
000024c0 0000d21c 00007b6e D __dzero
000024c8 0000d224 00007b76 D __ntens
000024e6 0000d242 00007b94 D _writerr

00007b98 B _end
