; a_magic   = 0x9928
; a_text    = 0x0000066c
; a_data    = 0x00000148
; a_bss     = 0x00000000
; a_syms    = 0x000001c2
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x000000a5@0x00000992


_chkx:
[00000000] 4e56 fffe                 link       a6,#-2
[00000004] 48e7 1c0c                 movem.l    d3-d5/a4-a5,-(a7)
[00000008] 2a2e 0008                 move.l     8(a6),d5
[0000000c] 282e 000c                 move.l     12(a6),d4
[00000010] 2a79 0000 0000            movea.l    _pu,a5
[00000016] 287c 0000 00b4            movea.l    #$00000720,a4
[0000001c] 426e fffe                 clr.w      -2(a6)
_chkx_6:
[00000020] 0c6e 0007 fffe            cmpi.w     #$0007,-2(a6)
[00000026] 6c48                      bge.s      _chkx_1
[00000028] 7e01                      moveq.l    #1,d7
[0000002a] 3c2e fffe                 move.w     -2(a6),d6
[0000002e] eda7                      asl.l      d6,d7
[00000030] 7c00                      moveq.l    #0,d6
[00000032] 3c2d 0138                 move.w     312(a5),d6
[00000036] ce86                      and.l      d6,d7
[00000038] 672c                      beq.s      _chkx_2
[0000003a] 4eb9 0000 0000            jsr        _isabs
[00000040] 4a87                      tst.l      d7
[00000042] 6706                      beq.s      _chkx_3
[00000044] 2e2c 0004                 move.l     4(a4),d7
[00000048] 6002                      bra.s      _chkx_4
_chkx_3:
[0000004a] 2e14                      move.l     (a4),d7
_chkx_4:
[0000004c] 2607                      move.l     d7,d3
[0000004e] b685                      cmp.l      d5,d3
[00000050] 6214                      bhi.s      _chkx_2
[00000052] 7e00                      moveq.l    #0,d7
[00000054] 3e2c 0008                 move.w     8(a4),d7
[00000058] 7c09                      moveq.l    #9,d6
[0000005a] eda7                      asl.l      d6,d7
[0000005c] de83                      add.l      d3,d7
[0000005e] b887                      cmp.l      d7,d4
[00000060] 6204                      bhi.s      _chkx_2
[00000062] 7e01                      moveq.l    #1,d7
[00000064] 600c                      bra.s      _chkx_5
_chkx_2:
[00000066] 526e fffe                 addq.w     #1,-2(a6)
[0000006a] 49ec 0010                 lea.l      16(a4),a4
[0000006e] 60b0                      bra.s      _chkx_6
_chkx_1:
[00000070] 7e00                      moveq.l    #0,d7
_chkx_5:
[00000072] 4cdf 3038                 movem.l    (a7)+,d3-d5/a4-a5
[00000076] 4e5e                      unlk       a6
[00000078] 4e75                      rts

_mdclose:
[0000007a] 4e56 0000                 link       a6,#0
[0000007e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000082] 7e00                      moveq.l    #0,d7
[00000084] 3e2e 000a                 move.w     10(a6),d7
[00000088] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000008e] e987                      asl.l      #4,d7
[00000090] 2a47                      movea.l    d7,a5
[00000092] dbfc 0000 00b4            adda.l     #$00000720,a5
[00000098] 7e00                      moveq.l    #0,d7
[0000009a] 3e2e 000a                 move.w     10(a6),d7
[0000009e] 0287 0000 00ff            andi.l     #$000000FF,d7
[000000a4] 2e87                      move.l     d7,(a7)
[000000a6] 2f0d                      move.l     a5,-(a7)
[000000a8] 4eb9 0000 060c            jsr        _unmapxs
[000000ae] 588f                      addq.l     #4,a7
[000000b0] 536d 000e                 subq.w     #1,14(a5)
[000000b4] 6648                      bne.s      _mdclose_1
[000000b6] 4a6d 000c                 tst.w      12(a5)
[000000ba] 6742                      beq.s      _mdclose_1
[000000bc] 082d 0000 000b            btst       #0,11(a5)
[000000c2] 673a                      beq.s      _mdclose_1
[000000c4] 4297                      clr.l      (a7)
[000000c6] 2f3c 0000 00b0            move.l     #$0000071C,-(a7)
[000000cc] 7e00                      moveq.l    #0,d7
[000000ce] 3e2d 000c                 move.w     12(a5),d7
[000000d2] 2f07                      move.l     d7,-(a7)
[000000d4] 7e00                      moveq.l    #0,d7
[000000d6] 3e2d 0008                 move.w     8(a5),d7
[000000da] 2f07                      move.l     d7,-(a7)
[000000dc] 4eb9 0000 0000            jsr        _memfree
[000000e2] 4fef 000c                 lea.l      12(a7),a7
[000000e6] 426d 0008                 clr.w      8(a5)
[000000ea] 426d 000c                 clr.w      12(a5)
[000000ee] 42ad 0004                 clr.l      4(a5)
[000000f2] 082d 0001 000b            btst       #1,11(a5)
[000000f8] 6604                      bne.s      _mdclose_1
[000000fa] 426d 000a                 clr.w      10(a5)
_mdclose_1:
[000000fe] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000102] 4e5e                      unlk       a6
[00000104] 4e75                      rts

_mdopen:
[00000106] 4e56 fffe                 link       a6,#-2
[0000010a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000010e] 7e00                      moveq.l    #0,d7
[00000110] 3e2e 000a                 move.w     10(a6),d7
[00000114] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000011a] 3d47 fffe                 move.w     d7,-2(a6)
[0000011e] 3e2e fffe                 move.w     -2(a6),d7
[00000122] 48c7                      ext.l      d7
[00000124] e987                      asl.l      #4,d7
[00000126] 2a47                      movea.l    d7,a5
[00000128] dbfc 0000 00b4            adda.l     #$00000720,a5
[0000012e] 4ab9 0000 00b0            tst.l      $0000071C
[00000134] 6630                      bne.s      _mdopen_1
[00000136] 4a79 0000 0000            tst.w      _mdpages
[0000013c] 6728                      beq.s      _mdopen_1
[0000013e] 2ebc 0000 00b0            move.l     #$0000071C,(a7)
[00000144] 7e00                      moveq.l    #0,d7
[00000146] 3e39 0000 0000            move.w     _mdbase,d7
[0000014c] 2f07                      move.l     d7,-(a7)
[0000014e] 7e00                      moveq.l    #0,d7
[00000150] 3e39 0000 0000            move.w     _mdpages,d7
[00000156] 2f07                      move.l     d7,-(a7)
[00000158] 4eb9 0000 0000            jsr        _sfree
[0000015e] 508f                      addq.l     #8,a7
[00000160] 4279 0000 0000            clr.w      _mdpages
_mdopen_1:
[00000166] 0c6e 0007 fffe            cmpi.w     #$0007,-2(a6)
[0000016c] 6d0e                      blt.s      _mdopen_2
[0000016e] 4878 0006                 pea.l      ($00000006).w
[00000172] 4eb9 0000 0000            jsr        _uerror
[00000178] 588f                      addq.l     #4,a7
[0000017a] 6048                      bra.s      _mdopen_3
_mdopen_2:
[0000017c] 0c95 ffff ffff            cmpi.l     #$FFFFFFFF,(a5)
[00000182] 672a                      beq.s      _mdopen_4
[00000184] 4eb9 0000 0000            jsr        _isabs
[0000018a] 4a87                      tst.l      d7
[0000018c] 6620                      bne.s      _mdopen_4
[0000018e] 4878 0001                 pea.l      ($00000001).w
[00000192] 2f15                      move.l     (a5),-(a7)
[00000194] 4eb9 0000 0000            jsr        _chkbuf
[0000019a] 508f                      addq.l     #8,a7
[0000019c] 4a87                      tst.l      d7
[0000019e] 670e                      beq.s      _mdopen_4
[000001a0] 4878 000c                 pea.l      ($0000000C).w
[000001a4] 4eb9 0000 0000            jsr        _uerror
[000001aa] 588f                      addq.l     #4,a7
[000001ac] 6016                      bra.s      _mdopen_3
_mdopen_4:
[000001ae] 526d 000e                 addq.w     #1,14(a5)
[000001b2] 3e2e fffe                 move.w     -2(a6),d7
[000001b6] 48c7                      ext.l      d7
[000001b8] 2e87                      move.l     d7,(a7)
[000001ba] 2f0d                      move.l     a5,-(a7)
[000001bc] 4eb9 0000 058c            jsr        _mapxs
[000001c2] 588f                      addq.l     #4,a7
_mdopen_3:
[000001c4] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000001c8] 4e5e                      unlk       a6
[000001ca] 4e75                      rts

_mdread:
[000001cc] 4e56 0000                 link       a6,#0
[000001d0] 4878 0010                 pea.l      ($00000010).w
[000001d4] 7e00                      moveq.l    #0,d7
[000001d6] 3e2e 000a                 move.w     10(a6),d7
[000001da] 2f07                      move.l     d7,-(a7)
[000001dc] 2f3c 0000 0082            move.l     #_rmdbuf,-(a7)
[000001e2] 2f3c 0000 03e8            move.l     #_mdstrat,-(a7)
[000001e8] 4eb9 0000 0000            jsr        _physio
[000001ee] 4fef 0010                 lea.l      16(a7),a7
[000001f2] 4e5e                      unlk       a6
[000001f4] 4e75                      rts

_mdsgtty:
[000001f6] 4e56 fff2                 link       a6,#-14
[000001fa] 48e7 8004                 movem.l    d0/a5,-(a7)
[000001fe] 7e00                      moveq.l    #0,d7
[00000200] 3e2e 000a                 move.w     10(a6),d7
[00000204] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000020a] e987                      asl.l      #4,d7
[0000020c] 2a47                      movea.l    d7,a5
[0000020e] dbfc 0000 00b4            adda.l     #$00000720,a5
[00000214] 2e2e 000c                 move.l     12(a6),d7
[00000218] 41f9 0000 0124            lea.l      $00000790,a0
[0000021e] 4ef9 0000 0000            jmp        a~jtab
[00000224] 082d 0001 000b            btst       #1,11(a5)
[0000022a] 6710                      beq.s      _mdsgtty_1
[0000022c] 4878 000c                 pea.l      ($0000000C).w
[00000230] 4eb9 0000 0000            jsr        _uerror
[00000236] 588f                      addq.l     #4,a7
[00000238] 6000 01a6                 bra        _mdsgtty_2
_mdsgtty_1:
[0000023c] 4878 0002                 pea.l      ($00000002).w
[00000240] 486e fffe                 pea.l      -2(a6)
[00000244] 2279 0000 0000            movea.l    _pu,a1
[0000024a] 2f29 0028                 move.l     40(a1),-(a7)
[0000024e] 4eb9 0000 0000            jsr        _inbuf
[00000254] 4fef 000c                 lea.l      12(a7),a7
[00000258] 4a87                      tst.l      d7
[0000025a] 6c10                      bge.s      _mdsgtty_3
[0000025c] 4878 000e                 pea.l      ($0000000E).w
[00000260] 4eb9 0000 0000            jsr        _uerror
[00000266] 588f                      addq.l     #4,a7
[00000268] 6000 0176                 bra        _mdsgtty_2
_mdsgtty_3:
[0000026c] 3e2e fffe                 move.w     -2(a6),d7
[00000270] 48c7                      ext.l      d7
[00000272] 2e87                      move.l     d7,(a7)
[00000274] 4eb9 0000 0000            jsr        _mapsize
[0000027a] 3d47 fffe                 move.w     d7,-2(a6)
[0000027e] 4a6e fffe                 tst.w      -2(a6)
[00000282] 660a                      bne.s      _mdsgtty_4
[00000284] 08ed 0000 000b            bset       #0,11(a5)
[0000028a] 6000 0154                 bra        _mdsgtty_2
_mdsgtty_4:
[0000028e] 4a6d 0008                 tst.w      8(a5)
[00000292] 6710                      beq.s      _mdsgtty_5
[00000294] 4878 0006                 pea.l      ($00000006).w
[00000298] 4eb9 0000 0000            jsr        _uerror
[0000029e] 588f                      addq.l     #4,a7
[000002a0] 6000 013e                 bra        _mdsgtty_2
_mdsgtty_5:
[000002a4] 4297                      clr.l      (a7)
[000002a6] 2f3c 0000 00b0            move.l     #$0000071C,-(a7)
[000002ac] 3e2e fffe                 move.w     -2(a6),d7
[000002b0] 48c7                      ext.l      d7
[000002b2] 2f07                      move.l     d7,-(a7)
[000002b4] 4eb9 0000 0000            jsr        _memalloc
[000002ba] 508f                      addq.l     #8,a7
[000002bc] 3b47 000c                 move.w     d7,12(a5)
[000002c0] 671a                      beq.s      _mdsgtty_6
[000002c2] 3e2e fffe                 move.w     -2(a6),d7
[000002c6] 48c7                      ext.l      d7
[000002c8] 2e87                      move.l     d7,(a7)
[000002ca] 7e00                      moveq.l    #0,d7
[000002cc] 3e2d 000c                 move.w     12(a5),d7
[000002d0] 2f07                      move.l     d7,-(a7)
[000002d2] 4eb9 0000 04d2            jsr        $000004D2
[000002d8] 588f                      addq.l     #4,a7
[000002da] 605c                      bra.s      _mdsgtty_7
_mdsgtty_6:
[000002dc] 082e 0000 ffff            btst       #0,-1(a6)
[000002e2] 6610                      bne.s      _mdsgtty_8
[000002e4] 4878 000c                 pea.l      ($0000000C).w
[000002e8] 4eb9 0000 0000            jsr        _uerror
[000002ee] 588f                      addq.l     #4,a7
[000002f0] 6000 00ee                 bra        _mdsgtty_2
_mdsgtty_8:
[000002f4] 4a6e fffe                 tst.w      -2(a6)
[000002f8] 673e                      beq.s      _mdsgtty_7
[000002fa] 4297                      clr.l      (a7)
[000002fc] 2f3c 0000 00b0            move.l     #$0000071C,-(a7)
[00000302] 3e2e fffe                 move.w     -2(a6),d7
[00000306] 48c7                      ext.l      d7
[00000308] 2f07                      move.l     d7,-(a7)
[0000030a] 4eb9 0000 0000            jsr        _memalloc
[00000310] 508f                      addq.l     #8,a7
[00000312] 3b47 000c                 move.w     d7,12(a5)
[00000316] 671a                      beq.s      _mdsgtty_9
[00000318] 3e2e fffe                 move.w     -2(a6),d7
[0000031c] 48c7                      ext.l      d7
[0000031e] 2e87                      move.l     d7,(a7)
[00000320] 7e00                      moveq.l    #0,d7
[00000322] 3e2d 000c                 move.w     12(a5),d7
[00000326] 2f07                      move.l     d7,-(a7)
[00000328] 4eb9 0000 04d2            jsr        $000004D2
[0000032e] 588f                      addq.l     #4,a7
[00000330] 6006                      bra.s      _mdsgtty_7
_mdsgtty_9:
[00000332] 536e fffe                 subq.w     #1,-2(a6)
[00000336] 60bc                      bra.s      _mdsgtty_8
_mdsgtty_7:
[00000338] 4a6d 000c                 tst.w      12(a5)
[0000033c] 6610                      bne.s      _mdsgtty_10
[0000033e] 4878 000c                 pea.l      ($0000000C).w
[00000342] 4eb9 0000 0000            jsr        _uerror
[00000348] 588f                      addq.l     #4,a7
[0000034a] 6000 0094                 bra        _mdsgtty_2
_mdsgtty_10:
[0000034e] 7e00                      moveq.l    #0,d7
[00000350] 3e2d 000c                 move.w     12(a5),d7
[00000354] 7c09                      moveq.l    #9,d6
[00000356] eda7                      asl.l      d6,d7
[00000358] 2b47 0004                 move.l     d7,4(a5)
[0000035c] 3b6e fffe 0008            move.w     -2(a6),8(a5)
[00000362] 7e00                      moveq.l    #0,d7
[00000364] 3e2e 000a                 move.w     10(a6),d7
[00000368] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000036e] 2e87                      move.l     d7,(a7)
[00000370] 2f0d                      move.l     a5,-(a7)
[00000372] 4eb9 0000 058c            jsr        _mapxs
[00000378] 588f                      addq.l     #4,a7
[0000037a] 6064                      bra.s      _mdsgtty_2
[0000037c] 4878 0006                 pea.l      ($00000006).w
[00000380] 2279 0000 0000            movea.l    _pu,a1
[00000386] 2f29 0028                 move.l     40(a1),-(a7)
[0000038a] 486d 0008                 pea.l      8(a5)
[0000038e] 4eb9 0000 0000            jsr        _outbuf
[00000394] 4fef 000c                 lea.l      12(a7),a7
[00000398] 6046                      bra.s      _mdsgtty_2
[0000039a] 7e00                      moveq.l    #0,d7
[0000039c] 3e2d 0008                 move.w     8(a5),d7
[000003a0] 7c09                      moveq.l    #9,d6
[000003a2] eda7                      asl.l      d6,d7
[000003a4] 2d47 fff2                 move.l     d7,-14(a6)
[000003a8] 4eb9 0000 0000            jsr        _isabs
[000003ae] 4a87                      tst.l      d7
[000003b0] 6706                      beq.s      _mdsgtty_11
[000003b2] 2e2d 0004                 move.l     4(a5),d7
[000003b6] 6002                      bra.s      _mdsgtty_12
_mdsgtty_11:
[000003b8] 2e15                      move.l     (a5),d7
_mdsgtty_12:
[000003ba] 2d47 fff6                 move.l     d7,-10(a6)
[000003be] 2d6d 0004 fffa            move.l     4(a5),-6(a6)
[000003c4] 4878 000c                 pea.l      ($0000000C).w
[000003c8] 2279 0000 0000            movea.l    _pu,a1
[000003ce] 2f29 0028                 move.l     40(a1),-(a7)
[000003d2] 486e fff2                 pea.l      -14(a6)
[000003d6] 4eb9 0000 0000            jsr        _outbuf
[000003dc] 4fef 000c                 lea.l      12(a7),a7
_mdsgtty_2:
[000003e0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000003e4] 4e5e                      unlk       a6
[000003e6] 4e75                      rts

_mdstrat:
[000003e8] 4e56 fffa                 link       a6,#-6
[000003ec] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000003f0] 2a6e 0008                 movea.l    8(a6),a5
[000003f4] 3d6d 0026 fffe            move.w     38(a5),-2(a6)
[000003fa] 7e00                      moveq.l    #0,d7
[000003fc] 3e2d 0012                 move.w     18(a5),d7
[00000400] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000406] e987                      asl.l      #4,d7
[00000408] 2847                      movea.l    d7,a4
[0000040a] d9fc 0000 00b4            adda.l     #$00000720,a4
[00000410] 7e00                      moveq.l    #0,d7
[00000412] 3e2d 002c                 move.w     44(a5),d7
[00000416] 7c09                      moveq.l    #9,d6
[00000418] eda7                      asl.l      d6,d7
[0000041a] 8ead 0028                 or.l       40(a5),d7
[0000041e] 2d47 fffa                 move.l     d7,-6(a6)
[00000422] 7e00                      moveq.l    #0,d7
[00000424] 3e2e fffe                 move.w     -2(a6),d7
[00000428] dead 0028                 add.l      40(a5),d7
[0000042c] 0687 0000 01ff            addi.l     #$000001FF,d7
[00000432] 7c09                      moveq.l    #9,d6
[00000434] ecaf                      lsr.l      d6,d7
[00000436] 7c00                      moveq.l    #0,d6
[00000438] 3c2d 002c                 move.w     44(a5),d6
[0000043c] de86                      add.l      d6,d7
[0000043e] 7c00                      moveq.l    #0,d6
[00000440] 3c2c 0008                 move.w     8(a4),d6
[00000444] bc87                      cmp.l      d7,d6
[00000446] 6408                      bcc.s      _mdstrat_1
[00000448] 08ed 0003 0011            bset       #3,17(a5)
[0000044e] 6046                      bra.s      _mdstrat_2
_mdstrat_1:
[00000450] 082d 0004 0011            btst       #4,17(a5)
[00000456] 6720                      beq.s      _mdstrat_3
[00000458] 7e00                      moveq.l    #0,d7
[0000045a] 3e2e fffe                 move.w     -2(a6),d7
[0000045e] 2e87                      move.l     d7,(a7)
[00000460] 2f2d 0020                 move.l     32(a5),-(a7)
[00000464] 2e2c 0004                 move.l     4(a4),d7
[00000468] deae fffa                 add.l      -6(a6),d7
[0000046c] 2f07                      move.l     d7,-(a7)
[0000046e] 4eb9 0000 0000            jsr        __movmem
[00000474] 508f                      addq.l     #8,a7
[00000476] 601e                      bra.s      _mdstrat_2
_mdstrat_3:
[00000478] 7e00                      moveq.l    #0,d7
[0000047a] 3e2e fffe                 move.w     -2(a6),d7
[0000047e] 2e87                      move.l     d7,(a7)
[00000480] 2e2c 0004                 move.l     4(a4),d7
[00000484] deae fffa                 add.l      -6(a6),d7
[00000488] 2f07                      move.l     d7,-(a7)
[0000048a] 2f2d 0020                 move.l     32(a5),-(a7)
[0000048e] 4eb9 0000 0000            jsr        __movmem
[00000494] 508f                      addq.l     #8,a7
_mdstrat_2:
[00000496] 42ad 0028                 clr.l      40(a5)
[0000049a] 2e8d                      move.l     a5,(a7)
[0000049c] 4eb9 0000 0000            jsr        _iodone
[000004a2] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000004a6] 4e5e                      unlk       a6
[000004a8] 4e75                      rts

_mdwrite:
[000004aa] 4e56 fffc                 link       a6,#-4
[000004ae] 4297                      clr.l      (a7)
[000004b0] 7e00                      moveq.l    #0,d7
[000004b2] 3e2e 000a                 move.w     10(a6),d7
[000004b6] 2f07                      move.l     d7,-(a7)
[000004b8] 2f3c 0000 0082            move.l     #_rmdbuf,-(a7)
[000004be] 2f3c 0000 03e8            move.l     #_mdstrat,-(a7)
[000004c4] 4eb9 0000 0000            jsr        _physio
[000004ca] 4fef 000c                 lea.l      12(a7),a7
[000004ce] 4e5e                      unlk       a6
[000004d0] 4e75                      rts

x4d2:
[000004d2] 4e56 fff8                 link       a6,#-8
[000004d6] 7e00                      moveq.l    #0,d7
[000004d8] 3e2e 000a                 move.w     10(a6),d7
[000004dc] 7c09                      moveq.l    #9,d6
[000004de] eda7                      asl.l      d6,d7
[000004e0] 2d47 fffc                 move.l     d7,-4(a6)
[000004e4] 7e00                      moveq.l    #0,d7
[000004e6] 3e2e 000e                 move.w     14(a6),d7
[000004ea] 7c09                      moveq.l    #9,d6
[000004ec] eda7                      asl.l      d6,d7
[000004ee] deae fffc                 add.l      -4(a6),d7
[000004f2] 2d47 fff8                 move.l     d7,-8(a6)
x4d2_2:
[000004f6] 2e2e fffc                 move.l     -4(a6),d7
[000004fa] beae fff8                 cmp.l      -8(a6),d7
[000004fe] 640c                      bcc.s      x4d2_1
[00000500] 226e fffc                 movea.l    -4(a6),a1
[00000504] 58ae fffc                 addq.l     #4,-4(a6)
[00000508] 4291                      clr.l      (a1)
[0000050a] 60ea                      bra.s      x4d2_2
x4d2_1:
[0000050c] 4e5e                      unlk       a6
[0000050e] 4e75                      rts

_mapx:
[00000510] 4e56 fffa                 link       a6,#-6
[00000514] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000518] 2279 0000 0000            movea.l    _pu,a1
[0000051e] 3d69 0138 fffc            move.w     312(a1),-4(a6)
[00000524] 4eb9 0000 0000            jsr        _curpid
[0000052a] 3d47 fffa                 move.w     d7,-6(a6)
[0000052e] 2a7c 0000 00b4            movea.l    #$00000720,a5
[00000534] 426e fffe                 clr.w      -2(a6)
_mapx_3:
[00000538] 0c6e 0007 fffe            cmpi.w     #$0007,-2(a6)
[0000053e] 6c44                      bge.s      _mapx_1
[00000540] 7e01                      moveq.l    #1,d7
[00000542] 3c2e fffe                 move.w     -2(a6),d6
[00000546] eda7                      asl.l      d6,d7
[00000548] 7c00                      moveq.l    #0,d6
[0000054a] 3c2e fffc                 move.w     -4(a6),d6
[0000054e] ce86                      and.l      d6,d7
[00000550] 6728                      beq.s      _mapx_2
[00000552] 3e2e fffa                 move.w     -6(a6),d7
[00000556] 48c7                      ext.l      d7
[00000558] 2e87                      move.l     d7,(a7)
[0000055a] 7e00                      moveq.l    #0,d7
[0000055c] 3e2d 0008                 move.w     8(a5),d7
[00000560] 7c09                      moveq.l    #9,d6
[00000562] eda7                      asl.l      d6,d7
[00000564] 2f07                      move.l     d7,-(a7)
[00000566] 2f2d 0004                 move.l     4(a5),-(a7)
[0000056a] 2f15                      move.l     (a5),-(a7)
[0000056c] 4878 0001                 pea.l      ($00000001).w
[00000570] 4eb9 0000 0000            jsr        _mapseg
[00000576] 4fef 0010                 lea.l      16(a7),a7
_mapx_2:
[0000057a] 526e fffe                 addq.w     #1,-2(a6)
[0000057e] 4bed 0010                 lea.l      16(a5),a5
[00000582] 60b4                      bra.s      _mapx_3
_mapx_1:
[00000584] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000588] 4e5e                      unlk       a6
[0000058a] 4e75                      rts

_mapxs:
[0000058c] 4e56 fffe                 link       a6,#-2
[00000590] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000594] 2a6e 0008                 movea.l    8(a6),a5
[00000598] 7e01                      moveq.l    #1,d7
[0000059a] 1c2e 000f                 move.b     15(a6),d6
[0000059e] eda7                      asl.l      d6,d7
[000005a0] 3d47 fffe                 move.w     d7,-2(a6)
[000005a4] 2879 0000 0000            movea.l    _pu,a4
[000005aa] 3e2c 0138                 move.w     312(a4),d7
[000005ae] ce6e fffe                 and.w      -2(a6),d7
[000005b2] 4847                      swap       d7
[000005b4] 4247                      clr.w      d7
[000005b6] 4847                      swap       d7
[000005b8] 660e                      bne.s      _mapxs_1
[000005ba] 0c95 ffff ffff            cmpi.l     #$FFFFFFFF,(a5)
[000005c0] 6706                      beq.s      _mapxs_1
[000005c2] 4a6d 0008                 tst.w      8(a5)
[000005c6] 6602                      bne.s      _mapxs_2
_mapxs_1:
[000005c8] 603a                      bra.s      _mapxs_3
_mapxs_2:
[000005ca] 3e2e fffe                 move.w     -2(a6),d7
[000005ce] 8f6c 0138                 or.w       d7,312(a4)
[000005d2] 4eb9 0000 0000            jsr        _isabs
[000005d8] 4a87                      tst.l      d7
[000005da] 6628                      bne.s      _mapxs_3
[000005dc] 4eb9 0000 0000            jsr        _curpid
[000005e2] 2e87                      move.l     d7,(a7)
[000005e4] 7e00                      moveq.l    #0,d7
[000005e6] 3e2d 0008                 move.w     8(a5),d7
[000005ea] 7c09                      moveq.l    #9,d6
[000005ec] eda7                      asl.l      d6,d7
[000005ee] 2f07                      move.l     d7,-(a7)
[000005f0] 2f2d 0004                 move.l     4(a5),-(a7)
[000005f4] 2f15                      move.l     (a5),-(a7)
[000005f6] 4878 0001                 pea.l      ($00000001).w
[000005fa] 4eb9 0000 0000            jsr        _mapseg
[00000600] 4fef 0010                 lea.l      16(a7),a7
_mapxs_3:
[00000604] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000608] 4e5e                      unlk       a6
[0000060a] 4e75                      rts

_unmapxs:
[0000060c] 4e56 fffe                 link       a6,#-2
[00000610] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000614] 2a6e 0008                 movea.l    8(a6),a5
[00000618] 7e01                      moveq.l    #1,d7
[0000061a] 1c2e 000f                 move.b     15(a6),d6
[0000061e] eda7                      asl.l      d6,d7
[00000620] 3d47 fffe                 move.w     d7,-2(a6)
[00000624] 2879 0000 0000            movea.l    _pu,a4
[0000062a] 3e2c 0138                 move.w     312(a4),d7
[0000062e] ce6e fffe                 and.w      -2(a6),d7
[00000632] 4847                      swap       d7
[00000634] 4247                      clr.w      d7
[00000636] 4847                      swap       d7
[00000638] 672a                      beq.s      _unmapxs_1
[0000063a] 7e00                      moveq.l    #0,d7
[0000063c] 3e2e fffe                 move.w     -2(a6),d7
[00000640] 4687                      not.l      d7
[00000642] cf6c 0138                 and.w      d7,312(a4)
[00000646] 4eb9 0000 0000            jsr        _curpid
[0000064c] 2e87                      move.l     d7,(a7)
[0000064e] 7e00                      moveq.l    #0,d7
[00000650] 3e2d 0008                 move.w     8(a5),d7
[00000654] 7c09                      moveq.l    #9,d6
[00000656] eda7                      asl.l      d6,d7
[00000658] 2f07                      move.l     d7,-(a7)
[0000065a] 2f15                      move.l     (a5),-(a7)
[0000065c] 4eb9 0000 0000            jsr        _umapseg
[00000662] 508f                      addq.l     #8,a7
_unmapxs_1:
[00000664] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000668] 4e5e                      unlk       a6
[0000066a] 4e75                      rts

	.data
_mdtab:
[0000066c]                           dc.b $00
[0000066d]                           dc.b $00
[0000066e]                           dc.b $00
[0000066f]                           dc.b $00
[00000670]                           dc.b $00
[00000671]                           dc.b $00
[00000672]                           dc.b $00
[00000673]                           dc.b $00
[00000674]                           dc.b $00
[00000675]                           dc.b $00
[00000676]                           dc.b $00
[00000677]                           dc.b $00
[00000678]                           dc.b $00
[00000679]                           dc.b $00
[0000067a]                           dc.b $00
[0000067b]                           dc.b $00
[0000067c]                           dc.b $00
[0000067d]                           dc.b $00
_nmmd:
[0000067e]                           dc.b 'md sd0 sd1 sd2 sd3 sd4 iopage',0
_nmrmd:
[0000069c]                           dc.b 'rmd rsd0 rsd1 rsd2 rsd3 rsd4 riopage',0
[000006c1]                           dc.b $00
_mdbdev:
[000006c2] 00000106                  dc.l _mdopen
[000006c6] 0000007a                  dc.l _mdclose
[000006ca] 000003e8                  dc.l _mdstrat
[000006ce] 00000000                  dc.l _chkx
[000006d2] 00000012                  dc.l $00000012 ; no symbol found
_mdcdev:
[000006d6] 00000106                  dc.l _mdopen
[000006da] 0000007a                  dc.l _mdclose
[000006de] 000001cc                  dc.l _mdread
[000006e2] 000004aa                  dc.l _mdwrite
[000006e6] 000001f6                  dc.l _mdsgtty
[000006ea] 00000030                  dc.l $00000030 ; no symbol found
_rmdbuf:
[000006ee]                           dc.b $00
[000006ef]                           dc.b $00
[000006f0]                           dc.b $00
[000006f1]                           dc.b $00
[000006f2]                           dc.b $00
[000006f3]                           dc.b $00
[000006f4]                           dc.b $00
[000006f5]                           dc.b $00
[000006f6]                           dc.b $00
[000006f7]                           dc.b $00
[000006f8]                           dc.b $00
[000006f9]                           dc.b $00
[000006fa]                           dc.b $00
[000006fb]                           dc.b $00
[000006fc]                           dc.b $00
[000006fd]                           dc.b $00
[000006fe]                           dc.b $00
[000006ff]                           dc.b $00
[00000700]                           dc.b $00
[00000701]                           dc.b $00
[00000702]                           dc.b $00
[00000703]                           dc.b $00
[00000704]                           dc.b $00
[00000705]                           dc.b $00
[00000706]                           dc.b $00
[00000707]                           dc.b $00
[00000708]                           dc.b $00
[00000709]                           dc.b $00
[0000070a]                           dc.b $00
[0000070b]                           dc.b $00
[0000070c]                           dc.b $00
[0000070d]                           dc.b $00
[0000070e]                           dc.b $00
[0000070f]                           dc.b $00
[00000710]                           dc.b $00
[00000711]                           dc.b $00
[00000712]                           dc.b $00
[00000713]                           dc.b $00
[00000714]                           dc.b $00
[00000715]                           dc.b $00
[00000716]                           dc.b $00
[00000717]                           dc.b $00
[00000718]                           dc.b $00
[00000719]                           dc.b $00
[0000071a]                           dc.b $00
[0000071b]                           dc.b $00
[0000071c]                           dc.b $00
[0000071d]                           dc.b $00
[0000071e]                           dc.b $00
[0000071f]                           dc.b $00
[00000720]                           dc.w $ffff
[00000722]                           dc.w $ffff
[00000724]                           dc.b $00
[00000725]                           dc.b $00
[00000726]                           dc.b $00
[00000727]                           dc.b $00
[00000728]                           dc.b $00
[00000729]                           dc.b $00
[0000072a]                           dc.b $00
[0000072b]                           dc.b $00
[0000072c]                           dc.b $00
[0000072d]                           dc.b $00
[0000072e]                           dc.b $00
[0000072f]                           dc.b $00
[00000730]                           dc.b $00
[00000731]                           dc.b $03
[00000732]                           dc.b $00
[00000733]                           dc.b $00
[00000734]                           dc.b $00
[00000735]                           dc.b $00
[00000736]                           dc.b $00
[00000737]                           dc.b $00
[00000738]                           dc.b $00
[00000739]                           dc.b $00
[0000073a]                           dc.b $00
[0000073b]                           dc.b $00
[0000073c]                           dc.b $00
[0000073d]                           dc.b $00
[0000073e]                           dc.b $00
[0000073f]                           dc.b $00
[00000740]                           dc.b $00
[00000741]                           dc.b $04
[00000742]                           dc.b $00
[00000743]                           dc.b $00
[00000744]                           dc.b $00
[00000745]                           dc.b $00
[00000746]                           dc.b $00
[00000747]                           dc.b $00
[00000748]                           dc.b $00
[00000749]                           dc.b $00
[0000074a]                           dc.b $00
[0000074b]                           dc.b $00
[0000074c]                           dc.b $00
[0000074d]                           dc.b $00
[0000074e]                           dc.b $00
[0000074f]                           dc.b $00
[00000750]                           dc.b $00
[00000751]                           dc.b $05
[00000752]                           dc.b $00
[00000753]                           dc.b $00
[00000754]                           dc.b $00
[00000755]                           dc.b $00
[00000756]                           dc.b $00
[00000757]                           dc.b $00
[00000758]                           dc.b $00
[00000759]                           dc.b $00
[0000075a]                           dc.b $00
[0000075b]                           dc.b $00
[0000075c]                           dc.b $00
[0000075d]                           dc.b $00
[0000075e]                           dc.b $00
[0000075f]                           dc.b $00
[00000760]                           dc.b $00
[00000761]                           dc.b $06
[00000762]                           dc.b $00
[00000763]                           dc.b $00
[00000764]                           dc.b $00
[00000765]                           dc.b $00
[00000766]                           dc.b $00
[00000767]                           dc.b $00
[00000768]                           dc.b $00
[00000769]                           dc.b $00
[0000076a]                           dc.b $00
[0000076b]                           dc.b $00
[0000076c]                           dc.b $00
[0000076d]                           dc.b $00
[0000076e]                           dc.b $00
[0000076f]                           dc.b $00
[00000770]                           dc.b $00
[00000771]                           dc.b $07
[00000772]                           dc.b $00
[00000773]                           dc.b $00
[00000774]                           dc.b $00
[00000775]                           dc.b $00
[00000776]                           dc.b $00
[00000777]                           dc.b $00
[00000778]                           dc.b $00
[00000779]                           dc.b $00
[0000077a]                           dc.b $00
[0000077b]                           dc.b $00
[0000077c]                           dc.b $00
[0000077d]                           dc.b $00
[0000077e]                           dc.b $00
[0000077f]                           dc.b $00
[00000780]                           dc.b $00
[00000781]                           dc.b $ff
[00000782]                           dc.w $8000
[00000784]                           dc.b $00
[00000785]                           dc.b $ff
[00000786]                           dc.w $8000
[00000788]                           dc.b $00
[00000789]                           dc.b $40
[0000078a]                           dc.b $00
[0000078b]                           dc.b $02
[0000078c]                           dc.b $00
[0000078d]                           dc.b $00
[0000078e]                           dc.b $00
[0000078f]                           dc.b $00
[00000790]                           dc.b $00
[00000791]                           dc.b $00
[00000792]                           dc.b $00
[00000793]                           dc.b $00
[00000794]                           dc.b $00
[00000795]                           dc.b $00
[00000796]                           dc.b $00
[00000797]                           dc.b $03
[00000798] 00000224                  dc.l $00000224 ; no symbol found
[0000079c]                           dc.b $00
[0000079d]                           dc.b $00
[0000079e]                           dc.b $00
[0000079f]                           dc.b $00
[000007a0] 0000037c                  dc.l $0000037c ; no symbol found
[000007a4]                           dc.b $00
[000007a5]                           dc.b $00
[000007a6]                           dc.b $00
[000007a7]                           dc.b $01
[000007a8] 0000039a                  dc.l $0000039a ; no symbol found
[000007ac]                           dc.b $00
[000007ad]                           dc.b $00
[000007ae]                           dc.b $00
[000007af]                           dc.b $02
[000007b0] 000003e0                  dc.l $000003e0 ; no symbol found
;
         U _uerror
         U _physio
         U _outbuf
         U _sfree
         U _inbuf
         U _isabs
         U _memalloc
         U _curpid
         U _iodone
         U _mapseg
         U _mapsize
         U _chkbuf
         U _umapseg
         U __movmem
         U _mdbase
         U _pu
         U a~jtab
         U _mdpages
         U _memfree
00000000 T _chkx
0000007a T _mdclose
00000106 T _mdopen
000001cc T _mdread
000001f6 T _mdsgtty
000003e8 T _mdstrat
000004aa T _mdwrite
00000510 T _mapx
0000058c T _mapxs
0000060c T _unmapxs
0000066c D _mdtab
0000067e D _nmmd
0000069c D _nmrmd
000006c2 D _mdbdev
000006d6 D _mdcdev
000006ee D _rmdbuf
;
; a.out Relocations:
00000012: 00000000 _pu
00000018: 0000066c
0000003c: 00000000 _isabs
00000094: 0000066c
000000aa: 00000000
000000c8: 0000066c
000000de: 00000000 _memfree
0000012a: 0000066c
00000130: 0000066c
00000138: 00000000 _mdpages
00000140: 0000066c
00000148: 00000000 _mdbase
00000152: 00000000 _mdpages
0000015a: 00000000 _sfree
00000162: 00000000 _mdpages
00000174: 00000000 _uerror
00000186: 00000000 _isabs
00000196: 00000000 _chkbuf
000001a6: 00000000 _uerror
000001be: 00000000
000001de: 0000066c
000001e4: 00000000
000001ea: 00000000 _physio
00000210: 0000066c
0000021a: 0000066c
00000220: 00000000 a~jtab
00000232: 00000000 _uerror
00000246: 00000000 _pu
00000250: 00000000 _inbuf
00000262: 00000000 _uerror
00000276: 00000000 _mapsize
0000029a: 00000000 _uerror
000002a8: 0000066c
000002b6: 00000000 _memalloc
000002d4: 00000000
000002ea: 00000000 _uerror
000002fe: 0000066c
0000030c: 00000000 _memalloc
0000032a: 00000000
00000344: 00000000 _uerror
00000374: 00000000
00000382: 00000000 _pu
00000390: 00000000 _outbuf
000003aa: 00000000 _isabs
000003ca: 00000000 _pu
000003d8: 00000000 _outbuf
0000040c: 0000066c
00000470: 00000000 __movmem
00000490: 00000000 __movmem
0000049e: 00000000 _iodone
000004ba: 0000066c
000004c0: 00000000
000004c6: 00000000 _physio
0000051a: 00000000 _pu
00000526: 00000000 _curpid
00000530: 0000066c
00000572: 00000000 _mapseg
000005a6: 00000000 _pu
000005d4: 00000000 _isabs
000005de: 00000000 _curpid
000005fc: 00000000 _mapseg
00000626: 00000000 _pu
00000648: 00000000 _curpid
0000065e: 00000000 _umapseg
000006c2: 00000000
000006c6: 00000000
000006ca: 00000000
000006ce: 0000066c
000006d2: 0000066c
000006d6: 00000000
000006da: 00000000
000006de: 00000000
000006e2: 00000000
000006e6: 00000000
000006ea: 0000066c
00000798: 00000000
000007a0: 00000000
000007a8: 00000000
000007b0: 00000000
