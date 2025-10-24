	.text

	.globl _vdi
_vdi:
	move.l     #_contrl,_vdipb
	move.l     #_vdipb,d1
	moveq.l    #115,d0
	trap       #2
	move.l     d0,d7
	rts

	.globl _i_lptr1
_i_lptr1:
	move.l     4(a7),_contrl+14
	rts

	.globl _i_ptr2
_i_ptr2:
	move.l     4(a7),_contrl+18
	rts

	.globl _m_lptr2
_m_lptr2:
	move.l     a0,-(a7)
	movea.l    8(a7),a0
	move.l     _contrl+18,(a0)
	movea.l    (a7)+,a0
	rts

	.data
	.globl _vdipb
_vdipb:
	.long _contrl
	.long _intin
	.long _ptsin
	.long _intout
	.long _ptsout
