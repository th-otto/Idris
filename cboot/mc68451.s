; a_magic   = 0x9928
; a_text    = 0x000008f6
; a_data    = 0x000000f0
; a_bss     = 0x00000000
; a_syms    = 0x00000196
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x000000df@0x00000b98


x0:
[00000000] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000004] 287c 0000 00a8            movea.l    #$0000099E,a4
x0_2:
[0000000a] 2a54                      movea.l    (a4),a5
[0000000c] 2e0d                      move.l     a5,d7
[0000000e] 6704                      beq.s      x0_1
[00000010] 284d                      movea.l    a5,a4
[00000012] 60f6                      bra.s      x0_2
x0_1:
[00000014] 2e8d                      move.l     a5,(a7)
[00000016] 4878 0010                 pea.l      ($00000010).w
[0000001a] 4eb9 0000 0000            jsr        _alloc
[00000020] 588f                      addq.l     #4,a7
[00000022] 2887                      move.l     d7,(a4)
[00000024] 660c                      bne.s      x0_3
[00000026] 2ebc 0000 00ac            move.l     #$000009A2,(a7)
[0000002c] 4eb9 0000 0000            jsr        _panic
x0_3:
[00000032] 5279 0000 000e            addq.w     #1,_tlistnum
[00000038] 2e14                      move.l     (a4),d7
[0000003a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000003e] 4e75                      rts

x40:
[00000040] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000044] 2279 0000 0000            movea.l    _pu,a1
[0000004a] 2869 0010                 movea.l    16(a1),a4
[0000004e] 266c 0022                 movea.l    34(a4),a3
[00000052] 2e0b                      move.l     a3,d7
[00000054] 6602                      bne.s      x40_1
[00000056] 264c                      movea.l    a4,a3
x40_1:
[00000058] 2a79 0000 00a8            movea.l    $0000099E,a5
x40_5:
[0000005e] 2e0d                      move.l     a5,d7
[00000060] 673a                      beq.s      x40_2
[00000062] 3e2d 000a                 move.w     10(a5),d7
[00000066] be6c 001c                 cmp.w      28(a4),d7
[0000006a] 672c                      beq.s      x40_3
[0000006c] 3e2d 000a                 move.w     10(a5),d7
[00000070] be6b 001c                 cmp.w      28(a3),d7
[00000074] 6722                      beq.s      x40_3
[00000076] 4a2d 000e                 tst.b      14(a5)
[0000007a] 671c                      beq.s      x40_3
[0000007c] 1e2d 000d                 move.b     13(a5),d7
[00000080] 0207 000c                 andi.b     #$0C,d7
[00000084] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000008a] 660c                      bne.s      x40_3
[0000008c] 2e8d                      move.l     a5,(a7)
[0000008e] 4eb9 0000 0872            jsr        $00000872
[00000094] 7e01                      moveq.l    #1,d7
[00000096] 6006                      bra.s      x40_4
x40_3:
[00000098] 2a55                      movea.l    (a5),a5
[0000009a] 60c2                      bra.s      x40_5
x40_2:
[0000009c] 7e00                      moveq.l    #0,d7
x40_4:
[0000009e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000000a2] 4e75                      rts

_mapabs:
[000000a4] 4e56 fffe                 link       a6,#-2
[000000a8] 422e ffff                 clr.b      -1(a6)
[000000ac] 4ab9 0000 0000            tst.l      _mmupres
[000000b2] 6722                      beq.s      _mapabs_1
[000000b4] 2279 0000 0012            movea.l    _mmu,a1
[000000ba] 136e ffff 0004            move.b     -1(a6),4(a1)
[000000c0] 2279 0000 0012            movea.l    _mmu,a1
[000000c6] 13ee ffff 0000 0010       move.b     -1(a6),_curasn
[000000ce] 1379 0000 0010 0002       move.b     _curasn,2(a1)
_mapabs_1:
[000000d6] 4e5e                      unlk       a6
[000000d8] 4e75                      rts

_mapbuf:
[000000da] 4e56 fffe                 link       a6,#-2
[000000de] 2f0d                      move.l     a5,-(a7)
[000000e0] 4ab9 0000 0000            tst.l      _mmupres
[000000e6] 671a                      beq.s      _mapbuf_1
[000000e8] 2279 0000 0000            movea.l    _pu,a1
[000000ee] 2269 0010                 movea.l    16(a1),a1
[000000f2] 1e29 0010                 move.b     16(a1),d7
[000000f6] 0207 0051                 andi.b     #$51,d7
[000000fa] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000100] 670c                      beq.s      _mapbuf_2
_mapbuf_1:
[00000102] 2e2e 0008                 move.l     8(a6),d7
[00000106] deb9 0000 0000            add.l      _uiobase,d7
[0000010c] 6058                      bra.s      _mapbuf_3
_mapbuf_2:
[0000010e] 2a79 0000 0012            movea.l    _mmu,a5
[00000114] 2e2e 0008                 move.l     8(a6),d7
[00000118] e08f                      lsr.l      #8,d7
[0000011a] 3b47 0020                 move.w     d7,32(a5)
[0000011e] 1b79 0000 0010 0026       move.b     _curasn,38(a5)
[00000126] 1d6d 003d ffff            move.b     61(a5),-1(a6)
[0000012c] 6656                      bne.s      _mapbuf_4
[0000012e] 422e ffff                 clr.b      -1(a6)
_mapbuf_6:
[00000132] 0c2e 0004 ffff            cmpi.b     #$04,-1(a6)
[00000138] 644a                      bcc.s      _mapbuf_4
[0000013a] 2e0d                      move.l     a5,d7
[0000013c] 672e                      beq.s      _mapbuf_5
[0000013e] 7e00                      moveq.l    #0,d7
[00000140] 1e2d 002f                 move.b     47(a5),d7
[00000144] 0287 0000 00f0            andi.l     #$000000F0,d7
[0000014a] 0c87 0000 0080            cmpi.l     #$00000080,d7
[00000150] 661a                      bne.s      _mapbuf_5
[00000152] 2e2e 0008                 move.l     8(a6),d7
[00000156] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000015c] 7c00                      moveq.l    #0,d6
[0000015e] 3c2d 0024                 move.w     36(a5),d6
[00000162] e186                      asl.l      #8,d6
[00000164] 8e86                      or.l       d6,d7
_mapbuf_3:
[00000166] 2a5f                      movea.l    (a7)+,a5
[00000168] 4e5e                      unlk       a6
[0000016a] 4e75                      rts
_mapbuf_5:
[0000016c] 522e ffff                 addq.b     #1,-1(a6)
[00000170] 7e00                      moveq.l    #0,d7
[00000172] 1e2e ffff                 move.b     -1(a6),d7
[00000176] e587                      asl.l      #2,d7
[00000178] 2247                      movea.l    d7,a1
[0000017a] d3fc 0000 0012            adda.l     #_mmu,a1
[00000180] 2a51                      movea.l    (a1),a5
[00000182] 60ae                      bra.s      _mapbuf_6
_mapbuf_4:
[00000184] 7eff                      moveq.l    #-1,d7
[00000186] 60de                      bra.s      _mapbuf_3

_mapclr:
[00000188] 4e56 fffc                 link       a6,#-4
[0000018c] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000190] 2279 0000 0000            movea.l    _pu,a1
[00000196] 2669 0010                 movea.l    16(a1),a3
[0000019a] 3e39 0000 000c            move.w     _tlistmax,d7
[000001a0] be79 0000 000e            cmp.w      _tlistnum,d7
[000001a6] 6c04                      bge.s      _mapclr_1
[000001a8] 7e01                      moveq.l    #1,d7
[000001aa] 6002                      bra.s      _mapclr_2
_mapclr_1:
[000001ac] 7e00                      moveq.l    #0,d7
_mapclr_2:
[000001ae] 2d47 fffc                 move.l     d7,-4(a6)
[000001b2] 2a2b 0022                 move.l     34(a3),d5
[000001b6] 670c                      beq.s      _mapclr_3
[000001b8] 2245                      movea.l    d5,a1
[000001ba] 43e9 002c                 lea.l      44(a1),a1
[000001be] 0c51 0001                 cmpi.w     #$0001,(a1)
[000001c2] 6f02                      ble.s      _mapclr_4
_mapclr_3:
[000001c4] 2a0b                      move.l     a3,d5
_mapclr_4:
[000001c6] 287c 0000 00a8            movea.l    #$0000099E,a4
_mapclr_8:
[000001cc] 2a54                      movea.l    (a4),a5
[000001ce] 2e0d                      move.l     a5,d7
[000001d0] 6754                      beq.s      _mapclr_5
[000001d2] 3e2d 000a                 move.w     10(a5),d7
[000001d6] be6b 001c                 cmp.w      28(a3),d7
[000001da] 6724                      beq.s      _mapclr_6
[000001dc] 3e2d 000a                 move.w     10(a5),d7
[000001e0] 2245                      movea.l    d5,a1
[000001e2] 43e9 001c                 lea.l      28(a1),a1
[000001e6] be51                      cmp.w      (a1),d7
[000001e8] 6716                      beq.s      _mapclr_6
[000001ea] 4aae fffc                 tst.l      -4(a6)
[000001ee] 6732                      beq.s      _mapclr_7
[000001f0] 1e2d 000d                 move.b     13(a5),d7
[000001f4] 0207 000c                 andi.b     #$0C,d7
[000001f8] 0287 0000 00ff            andi.l     #$000000FF,d7
[000001fe] 6622                      bne.s      _mapclr_7
_mapclr_6:
[00000200] 2e8d                      move.l     a5,(a7)
[00000202] 4eb9 0000 0872            jsr        $00000872
[00000208] 2e95                      move.l     (a5),(a7)
[0000020a] 2f0d                      move.l     a5,-(a7)
[0000020c] 4878 0010                 pea.l      ($00000010).w
[00000210] 4eb9 0000 0000            jsr        _free
[00000216] 508f                      addq.l     #8,a7
[00000218] 2887                      move.l     d7,(a4)
[0000021a] 5379 0000 000e            subq.w     #1,_tlistnum
[00000220] 60aa                      bra.s      _mapclr_8
_mapclr_7:
[00000222] 284d                      movea.l    a5,a4
[00000224] 60a6                      bra.s      _mapclr_8
_mapclr_5:
[00000226] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[0000022a] 4e5e                      unlk       a6
[0000022c] 4e75                      rts

_mapinit:
[0000022e] 4e56 fffe                 link       a6,#-2
[00000232] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000236] 422e ffff                 clr.b      -1(a6)
[0000023a] 4ab9 0000 0000            tst.l      _mmupres
[00000240] 6718                      beq.s      _mapinit_1
[00000242] 4297                      clr.l      (a7)
[00000244] 2279 0000 0012            movea.l    _mmu,a1
[0000024a] 4869 000a                 pea.l      10(a1)
[0000024e] 4eb9 0000 0000            jsr        _ssbyte
[00000254] 588f                      addq.l     #4,a7
[00000256] 4a87                      tst.l      d7
[00000258] 6c14                      bge.s      _mapinit_2
_mapinit_1:
[0000025a] 42b9 0000 0000            clr.l      _mmupres
[00000260] 2e39 0000 0000            move.l     _mmupres,d7
[00000266] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000026a] 4e5e                      unlk       a6
[0000026c] 4e75                      rts
_mapinit_2:
[0000026e] 4239 0000 0026            clr.b      $0000091C
[00000274] 4279 0000 0022            clr.w      $00000918
[0000027a] 4279 0000 0024            clr.w      $0000091A
[00000280] 7a00                      moveq.l    #0,d5
[00000282] 7801                      moveq.l    #1,d4
_mapinit_6:
[00000284] 0c85 0000 0004            cmpi.l     #$00000004,d5
[0000028a] 6466                      bcc.s      _mapinit_3
[0000028c] 2e05                      move.l     d5,d7
[0000028e] e587                      asl.l      #2,d7
[00000290] 2247                      movea.l    d7,a1
[00000292] d3fc 0000 0012            adda.l     #_mmu,a1
[00000298] 2a51                      movea.l    (a1),a5
[0000029a] 2e0d                      move.l     a5,d7
[0000029c] 6750                      beq.s      _mapinit_4
[0000029e] 486d 002f                 pea.l      47(a5)
[000002a2] 4eb9 0000 0000            jsr        _gsbyte
[000002a8] 588f                      addq.l     #4,a7
[000002aa] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000002b0] 673c                      beq.s      _mapinit_4
_mapinit_5:
[000002b2] 2244                      movea.l    d4,a1
[000002b4] d3fc 0000 0027            adda.l     #$0000091D,a1
[000002ba] 12b9 0000 0026            move.b     $0000091C,(a1)
[000002c0] 13c4 0000 0026            move.b     d4,$0000091C
[000002c6] 7e1f                      moveq.l    #31,d7
[000002c8] ce84                      and.l      d4,d7
[000002ca] 1b47 0029                 move.b     d7,41(a5)
[000002ce] 1b6e ffff 0031            move.b     -1(a6),49(a5)
[000002d4] 5284                      addq.l     #1,d4
[000002d6] 5279 0000 0022            addq.w     #1,$00000918
[000002dc] 5279 0000 0024            addq.w     #1,$0000091A
[000002e2] 7e1f                      moveq.l    #31,d7
[000002e4] ce04                      and.b      d4,d7
[000002e6] 0287 0000 00ff            andi.l     #$000000FF,d7
[000002ec] 66c4                      bne.s      _mapinit_5
_mapinit_4:
[000002ee] 5285                      addq.l     #1,d5
[000002f0] 6092                      bra.s      _mapinit_6
_mapinit_3:
[000002f2] 4a79 0000 0024            tst.w      $0000091A
[000002f8] 6704                      beq.s      _mapinit_7
[000002fa] 7e01                      moveq.l    #1,d7
[000002fc] 6002                      bra.s      _mapinit_8
_mapinit_7:
[000002fe] 7e00                      moveq.l    #0,d7
_mapinit_8:
[00000300] 23c7 0000 0000            move.l     d7,_mmupres
[00000306] 672a                      beq.s      _mapinit_9
[00000308] 4297                      clr.l      (a7)
[0000030a] 2e39 0000 0004            move.l     _map_hi,d7
[00000310] 9eb9 0000 0000            sub.l      _map_lo,d7
[00000316] 2f07                      move.l     d7,-(a7)
[00000318] 2f39 0000 0000            move.l     _map_lo,-(a7)
[0000031e] 2f39 0000 0000            move.l     _map_lo,-(a7)
[00000324] 4878 0004                 pea.l      ($00000004).w
[00000328] 4eb9 0000 0340            jsr        _mapseg
[0000032e] 4fef 0010                 lea.l      16(a7),a7
_mapinit_9:
[00000332] 2e39 0000 0000            move.l     _mmupres,d7
[00000338] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000033c] 4e5e                      unlk       a6
[0000033e] 4e75                      rts

_mapseg:
[00000340] 4e56 fff6                 link       a6,#-10
[00000344] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000348] 2e2e 000c                 move.l     12(a6),d7
[0000034c] e08f                      lsr.l      #8,d7
[0000034e] 2d47 fff8                 move.l     d7,-8(a6)
[00000352] 2e2e 0010                 move.l     16(a6),d7
[00000356] e08f                      lsr.l      #8,d7
[00000358] 2d47 fffc                 move.l     d7,-4(a6)
[0000035c] 422e fff7                 clr.b      -9(a6)
[00000360] 2879 0000 00a8            movea.l    $0000099E,a4
_mapseg_4:
[00000366] 2e0c                      move.l     a4,d7
[00000368] 6700 00a6                 beq        _mapseg_1
[0000036c] 3e2c 000a                 move.w     10(a4),d7
[00000370] be6e 001a                 cmp.w      26(a6),d7
[00000374] 6612                      bne.s      _mapseg_2
[00000376] 1e2c 000d                 move.b     13(a4),d7
[0000037a] 3c2e 000a                 move.w     10(a6),d6
[0000037e] ce06                      and.b      d6,d7
[00000380] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000386] 6604                      bne.s      _mapseg_3
_mapseg_2:
[00000388] 2854                      movea.l    (a4),a4
[0000038a] 60da                      bra.s      _mapseg_4
_mapseg_3:
[0000038c] 7e00                      moveq.l    #0,d7
[0000038e] 3e2c 0006                 move.w     6(a4),d7
[00000392] beae fff8                 cmp.l      -8(a6),d7
[00000396] 6708                      beq.s      _mapseg_5
[00000398] 1d6c 000c fff7            move.b     12(a4),-9(a6)
[0000039e] 60e8                      bra.s      _mapseg_2
_mapseg_5:
[000003a0] 7e00                      moveq.l    #0,d7
[000003a2] 3e2c 0004                 move.w     4(a4),d7
[000003a6] beae fffc                 cmp.l      -4(a6),d7
[000003aa] 6710                      beq.s      _mapseg_6
[000003ac] 2e8c                      move.l     a4,(a7)
[000003ae] 4eb9 0000 0872            jsr        $00000872
[000003b4] 396e fffe 0004            move.w     -2(a6),4(a4)
[000003ba] 6054                      bra.s      _mapseg_1
_mapseg_6:
[000003bc] 4a2c 000e                 tst.b      14(a4)
[000003c0] 674e                      beq.s      _mapseg_1
[000003c2] 082e 0001 000b            btst       #1,11(a6)
[000003c8] 670c                      beq.s      _mapseg_7
[000003ca] 2279 0000 0012            movea.l    _mmu,a1
[000003d0] 136c 000c 0004            move.b     12(a4),4(a1)
_mapseg_7:
[000003d6] 082e 0000 000b            btst       #0,11(a6)
[000003dc] 6716                      beq.s      _mapseg_8
[000003de] 2279 0000 0012            movea.l    _mmu,a1
[000003e4] 13ec 000c 0000 0010       move.b     12(a4),_curasn
[000003ec] 1379 0000 0010 0002       move.b     _curasn,2(a1)
_mapseg_8:
[000003f4] 082e 0002 000b            btst       #2,11(a6)
[000003fa] 670c                      beq.s      _mapseg_9
[000003fc] 2279 0000 0012            movea.l    _mmu,a1
[00000402] 136c 000c 000a            move.b     12(a4),10(a1)
_mapseg_9:
[00000408] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000040c] 4e5e                      unlk       a6
[0000040e] 4e75                      rts
_mapseg_1:
[00000410] 2e0c                      move.l     a4,d7
[00000412] 6650                      bne.s      _mapseg_10
[00000414] 4eba fbea                 jsr        $00000000(pc)
[00000418] 2847                      movea.l    d7,a4
[0000041a] 396e fffe 0004            move.w     -2(a6),4(a4)
[00000420] 396e fffa 0006            move.w     -6(a6),6(a4)
[00000426] 2e2e 0014                 move.l     20(a6),d7
[0000042a] 7c09                      moveq.l    #9,d6
[0000042c] ecaf                      lsr.l      d6,d7
[0000042e] 2e87                      move.l     d7,(a7)
[00000430] 4eb9 0000 0612            jsr        _mapsize
[00000436] e387                      asl.l      #1,d7
[00000438] 3947 0008                 move.w     d7,8(a4)
[0000043c] 396e 001a 000a            move.w     26(a6),10(a4)
[00000442] 4a2e fff7                 tst.b      -9(a6)
[00000446] 6708                      beq.s      _mapseg_11
[00000448] 7e00                      moveq.l    #0,d7
[0000044a] 1e2e fff7                 move.b     -9(a6),d7
[0000044e] 6006                      bra.s      _mapseg_12
_mapseg_11:
[00000450] 4eb9 0000 073c            jsr        $0000073C
_mapseg_12:
[00000456] 1947 000c                 move.b     d7,12(a4)
[0000045a] 196e 000b 000d            move.b     11(a6),13(a4)
[00000460] 422c 000e                 clr.b      14(a4)
_mapseg_10:
[00000464] 2e8c                      move.l     a4,(a7)
[00000466] 4eb9 0000 05b0            jsr        $000005B0
[0000046c] 3c39 0000 0022            move.w     $00000918,d6
[00000472] 48c6                      ext.l      d6
[00000474] bc87                      cmp.l      d7,d6
[00000476] 6c2c                      bge.s      _mapseg_13
[00000478] 4eba fbc6                 jsr        $00000040(pc)
[0000047c] 4a87                      tst.l      d7
[0000047e] 66e4                      bne.s      _mapseg_10
[00000480] 4eb9 0000 0000            jsr        _curproc
[00000486] 2247                      movea.l    d7,a1
[00000488] 43e9 0014                 lea.l      20(a1),a1
[0000048c] 2e89                      move.l     a1,(a7)
[0000048e] 2f3c 0000 00b4            move.l     #$000009AA,-(a7)
[00000494] 4eb9 0000 0000            jsr        _putfmt
[0000049a] 588f                      addq.l     #4,a7
[0000049c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000004a0] 4e5e                      unlk       a6
[000004a2] 4e75                      rts
_mapseg_13:
[000004a4] 7800                      moveq.l    #0,d4
[000004a6] 382c 0008                 move.w     8(a4),d4
_mapseg_19:
[000004aa] 4a84                      tst.l      d4
[000004ac] 6700 00c6                 beq        _mapseg_14
[000004b0] 262e fffc                 move.l     -4(a6),d3
[000004b4] 86ae fff8                 or.l       -8(a6),d3
[000004b8] 2a03                      move.l     d3,d5
[000004ba] 5385                      subq.l     #1,d5
[000004bc] 4685                      not.l      d5
[000004be] ca83                      and.l      d3,d5
[000004c0] 4a85                      tst.l      d5
[000004c2] 6606                      bne.s      _mapseg_15
[000004c4] 2a3c 0100 0000            move.l     #$01000000,d5
_mapseg_15:
[000004ca] b885                      cmp.l      d5,d4
[000004cc] 6404                      bcc.s      _mapseg_16
[000004ce] e28d                      lsr.l      #1,d5
[000004d0] 60f8                      bra.s      _mapseg_15
_mapseg_16:
[000004d2] 7e00                      moveq.l    #0,d7
[000004d4] 1e39 0000 0026            move.b     $0000091C,d7
[000004da] 2647                      movea.l    d7,a3
[000004dc] 2e0b                      move.l     a3,d7
[000004de] 660c                      bne.s      _mapseg_17
[000004e0] 2ebc 0000 00c2            move.l     #$000009B8,(a7)
[000004e6] 4eb9 0000 0000            jsr        _panic
_mapseg_17:
[000004ec] 224b                      movea.l    a3,a1
[000004ee] d3fc 0000 0027            adda.l     #$0000091D,a1
[000004f4] 13d1 0000 0026            move.b     (a1),$0000091C
[000004fa] 5379 0000 0022            subq.w     #1,$00000918
[00000500] 224b                      movea.l    a3,a1
[00000502] d3fc 0000 0027            adda.l     #$0000091D,a1
[00000508] 12ac 000e                 move.b     14(a4),(a1)
[0000050c] 2e0b                      move.l     a3,d7
[0000050e] 1947 000e                 move.b     d7,14(a4)
[00000512] 2e0b                      move.l     a3,d7
[00000514] ea8f                      lsr.l      #5,d7
[00000516] e587                      asl.l      #2,d7
[00000518] 2247                      movea.l    d7,a1
[0000051a] d3fc 0000 0012            adda.l     #_mmu,a1
[00000520] 2a51                      movea.l    (a1),a5
[00000522] 7e1f                      moveq.l    #31,d7
[00000524] 2c0b                      move.l     a3,d6
[00000526] ce86                      and.l      d6,d7
[00000528] 1b47 0029                 move.b     d7,41(a5)
[0000052c] 3b6e fffa 0020            move.w     -6(a6),32(a5)
[00000532] 3b6e fffe 0024            move.w     -2(a6),36(a5)
[00000538] 2e05                      move.l     d5,d7
[0000053a] 4487                      neg.l      d7
[0000053c] 3b47 0022                 move.w     d7,34(a5)
[00000540] 1b6c 000c 0026            move.b     12(a4),38(a5)
[00000546] 1b7c 00ff 0028            move.b     #$FF,40(a5)
[0000054c] 1b7c 0001 0027            move.b     #$01,39(a5)
[00000552] 1d6d 003f fff6            move.b     63(a5),-10(a6)
[00000558] 670c                      beq.s      _mapseg_18
[0000055a] 2ebc 0000 00d6            move.l     #$000009CC,(a7)
[00000560] 4eb9 0000 0000            jsr        _panic
_mapseg_18:
[00000566] dbae fff8                 add.l      d5,-8(a6)
[0000056a] dbae fffc                 add.l      d5,-4(a6)
[0000056e] 9885                      sub.l      d5,d4
[00000570] 6000 ff38                 bra        _mapseg_19
_mapseg_14:
[00000574] 082e 0001 000b            btst       #1,11(a6)
[0000057a] 6706                      beq.s      _mapseg_20
[0000057c] 1b6c 000c 0004            move.b     12(a4),4(a5)
_mapseg_20:
[00000582] 082e 0000 000b            btst       #0,11(a6)
[00000588] 6710                      beq.s      _mapseg_21
[0000058a] 13ec 000c 0000 0010       move.b     12(a4),_curasn
[00000592] 1b79 0000 0010 0002       move.b     _curasn,2(a5)
_mapseg_21:
[0000059a] 082e 0002 000b            btst       #2,11(a6)
[000005a0] 6706                      beq.s      _mapseg_22
[000005a2] 1b6c 000c 000a            move.b     12(a4),10(a5)
_mapseg_22:
[000005a8] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000005ac] 4e5e                      unlk       a6
[000005ae] 4e75                      rts

x5b0:
[000005b0] 4e56 fffc                 link       a6,#-4
[000005b4] 48e7 1c1c                 movem.l    d3-d5/a3-a5,-(a7)
[000005b8] 2a6e 0008                 movea.l    8(a6),a5
[000005bc] 7e00                      moveq.l    #0,d7
[000005be] 3e2d 0006                 move.w     6(a5),d7
[000005c2] 2647                      movea.l    d7,a3
[000005c4] 7e00                      moveq.l    #0,d7
[000005c6] 3e2d 0004                 move.w     4(a5),d7
[000005ca] 2847                      movea.l    d7,a4
[000005cc] 7800                      moveq.l    #0,d4
[000005ce] 382d 0008                 move.w     8(a5),d4
[000005d2] 42ae fffc                 clr.l      -4(a6)
x5b0_4:
[000005d6] 4a84                      tst.l      d4
[000005d8] 672c                      beq.s      x5b0_1
[000005da] 260c                      move.l     a4,d3
[000005dc] 2e0b                      move.l     a3,d7
[000005de] 8687                      or.l       d7,d3
[000005e0] 2a03                      move.l     d3,d5
[000005e2] 5385                      subq.l     #1,d5
[000005e4] 4685                      not.l      d5
[000005e6] ca83                      and.l      d3,d5
[000005e8] 4a85                      tst.l      d5
[000005ea] 6606                      bne.s      x5b0_2
[000005ec] 2a3c 0100 0000            move.l     #$01000000,d5
x5b0_2:
[000005f2] b885                      cmp.l      d5,d4
[000005f4] 6404                      bcc.s      x5b0_3
[000005f6] e28d                      lsr.l      #1,d5
[000005f8] 60f8                      bra.s      x5b0_2
x5b0_3:
[000005fa] 52ae fffc                 addq.l     #1,-4(a6)
[000005fe] d7c5                      adda.l     d5,a3
[00000600] d9c5                      adda.l     d5,a4
[00000602] 9885                      sub.l      d5,d4
[00000604] 60d0                      bra.s      x5b0_4
x5b0_1:
[00000606] 2e2e fffc                 move.l     -4(a6),d7
[0000060a] 4cdf 3838                 movem.l    (a7)+,d3-d5/a3-a5
[0000060e] 4e5e                      unlk       a6
[00000610] 4e75                      rts

_mapsize:
[00000612] 4e56 0000                 link       a6,#0
[00000616] 48e7 0c00                 movem.l    d4-d5,-(a7)
[0000061a] 2a2e 0008                 move.l     8(a6),d5
[0000061e] 4ab9 0000 0000            tst.l      _mmupres
[00000624] 6604                      bne.s      _mapsize_1
[00000626] 2e05                      move.l     d5,d7
[00000628] 6016                      bra.s      _mapsize_2
_mapsize_1:
[0000062a] 78f8                      moveq.l    #-8,d4
_mapsize_4:
[0000062c] 2e05                      move.l     d5,d7
[0000062e] ce84                      and.l      d4,d7
[00000630] 6704                      beq.s      _mapsize_3
[00000632] e384                      asl.l      #1,d4
[00000634] 60f6                      bra.s      _mapsize_4
_mapsize_3:
[00000636] e68c                      lsr.l      #3,d4
[00000638] 2e04                      move.l     d4,d7
[0000063a] 4687                      not.l      d7
[0000063c] de85                      add.l      d5,d7
[0000063e] ce84                      and.l      d4,d7
_mapsize_2:
[00000640] 4cdf 0030                 movem.l    (a7)+,d4-d5
[00000644] 4e5e                      unlk       a6
[00000646] 4e75                      rts

_memalloc:
[00000648] 4e56 0000                 link       a6,#0
[0000064c] 48e7 9c04                 movem.l    d0/d3-d5/a5,-(a7)
[00000650] 2e2e 0008                 move.l     8(a6),d7
[00000654] 9eae 0010                 sub.l      16(a6),d7
[00000658] 2e87                      move.l     d7,(a7)
[0000065a] 4eba ffb6                 jsr        _mapsize(pc)
[0000065e] 2a07                      move.l     d7,d5
[00000660] 2e85                      move.l     d5,(a7)
[00000662] 4eb9 0000 0782            jsr        $00000782
[00000668] 2807                      move.l     d7,d4
[0000066a] 5384                      subq.l     #1,d4
[0000066c] 2eae 000c                 move.l     12(a6),(a7)
[00000670] 2e05                      move.l     d5,d7
[00000672] de84                      add.l      d4,d7
[00000674] deae 0010                 add.l      16(a6),d7
[00000678] 2f07                      move.l     d7,-(a7)
[0000067a] 4eb9 0000 0000            jsr        _salloc
[00000680] 588f                      addq.l     #4,a7
[00000682] 2a47                      movea.l    d7,a5
[00000684] 2e0d                      move.l     a5,d7
[00000686] 6744                      beq.s      _memalloc_1
[00000688] 2604                      move.l     d4,d3
[0000068a] 4683                      not.l      d3
[0000068c] 2e04                      move.l     d4,d7
[0000068e] de8d                      add.l      a5,d7
[00000690] ce83                      and.l      d3,d7
[00000692] 2607                      move.l     d7,d3
[00000694] 2eae 000c                 move.l     12(a6),(a7)
[00000698] 2f0d                      move.l     a5,-(a7)
[0000069a] 2e03                      move.l     d3,d7
[0000069c] 9e8d                      sub.l      a5,d7
[0000069e] 2f07                      move.l     d7,-(a7)
[000006a0] 4eb9 0000 0000            jsr        _sfree
[000006a6] 508f                      addq.l     #8,a7
[000006a8] 2eae 000c                 move.l     12(a6),(a7)
[000006ac] 2e03                      move.l     d3,d7
[000006ae] de85                      add.l      d5,d7
[000006b0] deae 0010                 add.l      16(a6),d7
[000006b4] 2f07                      move.l     d7,-(a7)
[000006b6] 2e03                      move.l     d3,d7
[000006b8] 9e8d                      sub.l      a5,d7
[000006ba] 2c04                      move.l     d4,d6
[000006bc] 9c87                      sub.l      d7,d6
[000006be] 2f06                      move.l     d6,-(a7)
[000006c0] 4eb9 0000 0000            jsr        _sfree
[000006c6] 508f                      addq.l     #8,a7
[000006c8] 2a43                      movea.l    d3,a5
[000006ca] 6038                      bra.s      _memalloc_2
_memalloc_1:
[000006cc] 2eae 000c                 move.l     12(a6),(a7)
[000006d0] 2e05                      move.l     d5,d7
[000006d2] deae 0010                 add.l      16(a6),d7
[000006d6] 2f07                      move.l     d7,-(a7)
[000006d8] 4eb9 0000 0000            jsr        _salloc
[000006de] 588f                      addq.l     #4,a7
[000006e0] 2a47                      movea.l    d7,a5
[000006e2] 2e0d                      move.l     a5,d7
[000006e4] 671e                      beq.s      _memalloc_2
[000006e6] 2e0d                      move.l     a5,d7
[000006e8] ce84                      and.l      d4,d7
[000006ea] 6718                      beq.s      _memalloc_2
[000006ec] 2eae 000c                 move.l     12(a6),(a7)
[000006f0] 2f0d                      move.l     a5,-(a7)
[000006f2] 2e05                      move.l     d5,d7
[000006f4] deae 0010                 add.l      16(a6),d7
[000006f8] 2f07                      move.l     d7,-(a7)
[000006fa] 4eb9 0000 0000            jsr        _sfree
[00000700] 508f                      addq.l     #8,a7
[00000702] 9bcd                      suba.l     a5,a5
_memalloc_2:
[00000704] 2e0d                      move.l     a5,d7
[00000706] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[0000070a] 4e5e                      unlk       a6
[0000070c] 4e75                      rts

_memfree:
[0000070e] 4e56 fffc                 link       a6,#-4
[00000712] 2eae 0010                 move.l     16(a6),(a7)
[00000716] 2f2e 000c                 move.l     12(a6),-(a7)
[0000071a] 2e2e 0008                 move.l     8(a6),d7
[0000071e] 9eae 0014                 sub.l      20(a6),d7
[00000722] 2f07                      move.l     d7,-(a7)
[00000724] 4eba feec                 jsr        _mapsize(pc)
[00000728] 588f                      addq.l     #4,a7
[0000072a] deae 0014                 add.l      20(a6),d7
[0000072e] 2f07                      move.l     d7,-(a7)
[00000730] 4eb9 0000 0000            jsr        _sfree
[00000736] 508f                      addq.l     #8,a7
[00000738] 4e5e                      unlk       a6
[0000073a] 4e75                      rts

x73c:
[0000073c] 2f0d                      move.l     a5,-(a7)
x73c_4:
[0000073e] 5279 0000 00ee            addq.w     #1,$000009E4
[00000744] 0c79 00ff 0000 00ee       cmpi.w     #$00FF,$000009E4
[0000074c] 6f08                      ble.s      x73c_1
[0000074e] 33fc 0001 0000 00ee       move.w     #$0001,$000009E4
x73c_1:
[00000756] 2a79 0000 00a8            movea.l    $0000099E,a5
x73c_3:
[0000075c] 2e0d                      move.l     a5,d7
[0000075e] 6712                      beq.s      x73c_2
[00000760] 4247                      clr.w      d7
[00000762] 1e2d 000c                 move.b     12(a5),d7
[00000766] be79 0000 00ee            cmp.w      $000009E4,d7
[0000076c] 6704                      beq.s      x73c_2
[0000076e] 2a55                      movea.l    (a5),a5
[00000770] 60ea                      bra.s      x73c_3
x73c_2:
[00000772] 2e0d                      move.l     a5,d7
[00000774] 66c8                      bne.s      x73c_4
[00000776] 3e39 0000 00ee            move.w     $000009E4,d7
[0000077c] 48c7                      ext.l      d7
[0000077e] 2a5f                      movea.l    (a7)+,a5
[00000780] 4e75                      rts

x782:
[00000782] 4e56 0000                 link       a6,#0
[00000786] 48e7 1c00                 movem.l    d3-d5,-(a7)
[0000078a] 2a2e 0008                 move.l     8(a6),d5
[0000078e] 4ab9 0000 0000            tst.l      _mmupres
[00000794] 6604                      bne.s      x782_1
[00000796] 7e01                      moveq.l    #1,d7
[00000798] 6012                      bra.s      x782_2
x782_1:
[0000079a] 7601                      moveq.l    #1,d3
[0000079c] 78f8                      moveq.l    #-8,d4
x782_4:
[0000079e] 2e05                      move.l     d5,d7
[000007a0] ce84                      and.l      d4,d7
[000007a2] 6706                      beq.s      x782_3
[000007a4] e383                      asl.l      #1,d3
[000007a6] e384                      asl.l      #1,d4
[000007a8] 60f4                      bra.s      x782_4
x782_3:
[000007aa] 2e03                      move.l     d3,d7
x782_2:
[000007ac] 4cdf 0038                 movem.l    (a7)+,d3-d5
[000007b0] 4e5e                      unlk       a6
[000007b2] 4e75                      rts

_swpalloc:
[000007b4] 4e56 fffc                 link       a6,#-4
[000007b8] 4ab9 0000 0000            tst.l      _noswap
[000007be] 6716                      beq.s      _swpalloc_1
[000007c0] 2eae 0010                 move.l     16(a6),(a7)
[000007c4] 2f2e 000c                 move.l     12(a6),-(a7)
[000007c8] 2f2e 0008                 move.l     8(a6),-(a7)
[000007cc] 4eba fe7a                 jsr        _memalloc(pc)
[000007d0] 508f                      addq.l     #8,a7
[000007d2] 4e5e                      unlk       a6
[000007d4] 4e75                      rts
_swpalloc_1:
[000007d6] 2eae 000c                 move.l     12(a6),(a7)
[000007da] 2f2e 0008                 move.l     8(a6),-(a7)
[000007de] 4eb9 0000 0000            jsr        _salloc
[000007e4] 588f                      addq.l     #4,a7
[000007e6] 4e5e                      unlk       a6
[000007e8] 4e75                      rts

_swpfree:
[000007ea] 4e56 fffc                 link       a6,#-4
[000007ee] 4ab9 0000 0000            tst.l      _noswap
[000007f4] 6716                      beq.s      _swpfree_1
[000007f6] 2e2e 0008                 move.l     8(a6),d7
[000007fa] 9eae 0014                 sub.l      20(a6),d7
[000007fe] 2e87                      move.l     d7,(a7)
[00000800] 4eba fe10                 jsr        _mapsize(pc)
[00000804] deae 0014                 add.l      20(a6),d7
[00000808] 2d47 0008                 move.l     d7,8(a6)
_swpfree_1:
[0000080c] 2eae 0010                 move.l     16(a6),(a7)
[00000810] 2f2e 000c                 move.l     12(a6),-(a7)
[00000814] 2f2e 0008                 move.l     8(a6),-(a7)
[00000818] 4eb9 0000 0000            jsr        _sfree
[0000081e] 508f                      addq.l     #8,a7
[00000820] 4e5e                      unlk       a6
[00000822] 4e75                      rts

_umapseg:
[00000824] 4e56 fffe                 link       a6,#-2
[00000828] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000082c] 2e2e 0008                 move.l     8(a6),d7
[00000830] e08f                      lsr.l      #8,d7
[00000832] 3d47 fffe                 move.w     d7,-2(a6)
[00000836] 2a79 0000 00a8            movea.l    $0000099E,a5
_umapseg_3:
[0000083c] 2e0d                      move.l     a5,d7
[0000083e] 672a                      beq.s      _umapseg_1
[00000840] 3e2d 000a                 move.w     10(a5),d7
[00000844] be6e 0012                 cmp.w      18(a6),d7
[00000848] 661c                      bne.s      _umapseg_2
[0000084a] 082d 0000 000d            btst       #0,13(a5)
[00000850] 6714                      beq.s      _umapseg_2
[00000852] 3e2d 0006                 move.w     6(a5),d7
[00000856] be6e fffe                 cmp.w      -2(a6),d7
[0000085a] 660a                      bne.s      _umapseg_2
[0000085c] 2e8d                      move.l     a5,(a7)
[0000085e] 4eb9 0000 0872            jsr        $00000872
[00000864] 6004                      bra.s      _umapseg_1
_umapseg_2:
[00000866] 2a55                      movea.l    (a5),a5
[00000868] 60d2                      bra.s      _umapseg_3
_umapseg_1:
[0000086a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000086e] 4e5e                      unlk       a6
[00000870] 4e75                      rts

x872:
[00000872] 4e56 fffe                 link       a6,#-2
[00000876] 48e7 041c                 movem.l    d5/a3-a5,-(a7)
[0000087a] 2a6e 0008                 movea.l    8(a6),a5
[0000087e] 287c 0000 0027            movea.l    #$0000091D,a4
[00000884] 7a00                      moveq.l    #0,d5
[00000886] 1d6d 000e ffff            move.b     14(a5),-1(a6)
x872_2:
[0000088c] 4a2e ffff                 tst.b      -1(a6)
[00000890] 6756                      beq.s      x872_1
[00000892] 7e00                      moveq.l    #0,d7
[00000894] 1e2e ffff                 move.b     -1(a6),d7
[00000898] ea87                      asr.l      #5,d7
[0000089a] e587                      asl.l      #2,d7
[0000089c] 2247                      movea.l    d7,a1
[0000089e] d3fc 0000 0012            adda.l     #_mmu,a1
[000008a4] 2651                      movea.l    (a1),a3
[000008a6] 7e1f                      moveq.l    #31,d7
[000008a8] 7c00                      moveq.l    #0,d6
[000008aa] 1c2e ffff                 move.b     -1(a6),d6
[000008ae] ce86                      and.l      d6,d7
[000008b0] 1747 0029                 move.b     d7,41(a3)
[000008b4] 1745 0031                 move.b     d5,49(a3)
[000008b8] 4247                      clr.w      d7
[000008ba] 1e2e ffff                 move.b     -1(a6),d7
[000008be] 1d74 7000 fffe            move.b     0(a4,d7.w),-2(a6)
[000008c4] 4247                      clr.w      d7
[000008c6] 1e2e ffff                 move.b     -1(a6),d7
[000008ca] 19b9 0000 0026 7000       move.b     $0000091C,0(a4,d7.w)
[000008d2] 13ee ffff 0000 0026       move.b     -1(a6),$0000091C
[000008da] 5279 0000 0022            addq.w     #1,$00000918
[000008e0] 1d6e fffe ffff            move.b     -2(a6),-1(a6)
[000008e6] 60a4                      bra.s      x872_2
x872_1:
[000008e8] 422d 000e                 clr.b      14(a5)
[000008ec] 2e0d                      move.l     a5,d7
[000008ee] 4cdf 3820                 movem.l    (a7)+,d5/a3-a5
[000008f2] 4e5e                      unlk       a6
[000008f4] 4e75                      rts

	.data
_map_lo:
[000008f6]                           dc.b $00
[000008f7]                           dc.b $00
[000008f8]                           dc.b $00
[000008f9]                           dc.b $00
_map_hi:
[000008fa]                           dc.b $00
[000008fb]                           dc.b $80
[000008fc]                           dc.b $00
[000008fd]                           dc.b $00
_xpage:
[000008fe]                           dc.b $00
[000008ff]                           dc.b $01
[00000900]                           dc.w $ffff
_tlistmax:
[00000902]                           dc.b $00
[00000903]                           dc.b $32
_tlistnum:
[00000904]                           dc.b $00
[00000905]                           dc.b $00
_curasn:
[00000906]                           dc.b $00
[00000907]                           dc.b $00
_mmu:
[00000908]                           dc.b $00
[00000909]                           dc.b $01
[0000090a]                           dc.w $ff00
[0000090c]                           dc.b $00
[0000090d]                           dc.b $01
[0000090e]                           dc.w $ff40
[00000910]                           dc.b $00
[00000911]                           dc.b $01
[00000912]                           dc.w $ff80
[00000914]                           dc.b $00
[00000915]                           dc.b $01
[00000916]                           dc.w $ffc0
[00000918]                           dc.b $00
[00000919]                           dc.b $00
[0000091a]                           dc.b $00
[0000091b]                           dc.b $00
[0000091c]                           dc.b $00
[0000091d]                           dc.b $00
[0000091e]                           dc.b $00
[0000091f]                           dc.b $00
[00000920]                           dc.b $00
[00000921]                           dc.b $00
[00000922]                           dc.b $00
[00000923]                           dc.b $00
[00000924]                           dc.b $00
[00000925]                           dc.b $00
[00000926]                           dc.b $00
[00000927]                           dc.b $00
[00000928]                           dc.b $00
[00000929]                           dc.b $00
[0000092a]                           dc.b $00
[0000092b]                           dc.b $00
[0000092c]                           dc.b $00
[0000092d]                           dc.b $00
[0000092e]                           dc.b $00
[0000092f]                           dc.b $00
[00000930]                           dc.b $00
[00000931]                           dc.b $00
[00000932]                           dc.b $00
[00000933]                           dc.b $00
[00000934]                           dc.b $00
[00000935]                           dc.b $00
[00000936]                           dc.b $00
[00000937]                           dc.b $00
[00000938]                           dc.b $00
[00000939]                           dc.b $00
[0000093a]                           dc.b $00
[0000093b]                           dc.b $00
[0000093c]                           dc.b $00
[0000093d]                           dc.b $00
[0000093e]                           dc.b $00
[0000093f]                           dc.b $00
[00000940]                           dc.b $00
[00000941]                           dc.b $00
[00000942]                           dc.b $00
[00000943]                           dc.b $00
[00000944]                           dc.b $00
[00000945]                           dc.b $00
[00000946]                           dc.b $00
[00000947]                           dc.b $00
[00000948]                           dc.b $00
[00000949]                           dc.b $00
[0000094a]                           dc.b $00
[0000094b]                           dc.b $00
[0000094c]                           dc.b $00
[0000094d]                           dc.b $00
[0000094e]                           dc.b $00
[0000094f]                           dc.b $00
[00000950]                           dc.b $00
[00000951]                           dc.b $00
[00000952]                           dc.b $00
[00000953]                           dc.b $00
[00000954]                           dc.b $00
[00000955]                           dc.b $00
[00000956]                           dc.b $00
[00000957]                           dc.b $00
[00000958]                           dc.b $00
[00000959]                           dc.b $00
[0000095a]                           dc.b $00
[0000095b]                           dc.b $00
[0000095c]                           dc.b $00
[0000095d]                           dc.b $00
[0000095e]                           dc.b $00
[0000095f]                           dc.b $00
[00000960]                           dc.b $00
[00000961]                           dc.b $00
[00000962]                           dc.b $00
[00000963]                           dc.b $00
[00000964]                           dc.b $00
[00000965]                           dc.b $00
[00000966]                           dc.b $00
[00000967]                           dc.b $00
[00000968]                           dc.b $00
[00000969]                           dc.b $00
[0000096a]                           dc.b $00
[0000096b]                           dc.b $00
[0000096c]                           dc.b $00
[0000096d]                           dc.b $00
[0000096e]                           dc.b $00
[0000096f]                           dc.b $00
[00000970]                           dc.b $00
[00000971]                           dc.b $00
[00000972]                           dc.b $00
[00000973]                           dc.b $00
[00000974]                           dc.b $00
[00000975]                           dc.b $00
[00000976]                           dc.b $00
[00000977]                           dc.b $00
[00000978]                           dc.b $00
[00000979]                           dc.b $00
[0000097a]                           dc.b $00
[0000097b]                           dc.b $00
[0000097c]                           dc.b $00
[0000097d]                           dc.b $00
[0000097e]                           dc.b $00
[0000097f]                           dc.b $00
[00000980]                           dc.b $00
[00000981]                           dc.b $00
[00000982]                           dc.b $00
[00000983]                           dc.b $00
[00000984]                           dc.b $00
[00000985]                           dc.b $00
[00000986]                           dc.b $00
[00000987]                           dc.b $00
[00000988]                           dc.b $00
[00000989]                           dc.b $00
[0000098a]                           dc.b $00
[0000098b]                           dc.b $00
[0000098c]                           dc.b $00
[0000098d]                           dc.b $00
[0000098e]                           dc.b $00
[0000098f]                           dc.b $00
[00000990]                           dc.b $00
[00000991]                           dc.b $00
[00000992]                           dc.b $00
[00000993]                           dc.b $00
[00000994]                           dc.b $00
[00000995]                           dc.b $00
[00000996]                           dc.b $00
[00000997]                           dc.b $00
[00000998]                           dc.b $00
[00000999]                           dc.b $00
[0000099a]                           dc.b $00
[0000099b]                           dc.b $00
[0000099c]                           dc.b $00
[0000099d]                           dc.b $00
[0000099e]                           dc.b $00
[0000099f]                           dc.b $00
[000009a0]                           dc.b $00
[000009a1]                           dc.b $00
[000009a2]                           dc.b 'addtask',0
[000009aa]                           dc.b 'can',$27,'t map %s',$0a,0
[000009b8]                           dc.b 'bad decriptor table',0
[000009cc]                           dc.b 'descriptor load failed',0
[000009e3]                           dc.b $00
[000009e4]                           dc.b $00
[000009e5]                           dc.b $00
;
         U _putfmt
         U _ssbyte
         U _noswap
         U _sfree
         U _gsbyte
         U _panic
         U _alloc
         U _mmupres
         U _salloc
         U _curproc
         U _uiobase
         U _pu
         U _free
000000a4 T _mapabs
000000da T _mapbuf
00000188 T _mapclr
0000022e T _mapinit
00000340 T _mapseg
00000612 T _mapsize
00000648 T _memalloc
0000070e T _memfree
000007b4 T _swpalloc
000007ea T _swpfree
00000824 T _umapseg
000008f6 D _map_lo
000008fa D _map_hi
000008fe D _xpage
00000902 D _tlistmax
00000904 D _tlistnum
00000906 D _curasn
00000908 D _mmu
;
; a.out Relocations:
00000006: 000008f6
0000001c: 00000000 _alloc
00000028: 000008f6
0000002e: 00000000 _panic
00000034: 000008f6
00000046: 00000000 _pu
0000005a: 000008f6
00000090: 00000000
000000ae: 00000000 _mmupres
000000b6: 000008f6
000000c2: 000008f6
000000ca: 000008f6
000000d0: 000008f6
000000e2: 00000000 _mmupres
000000ea: 00000000 _pu
00000108: 00000000 _uiobase
00000110: 000008f6
00000120: 000008f6
0000017c: 000008f6
00000192: 00000000 _pu
0000019c: 000008f6
000001a2: 000008f6
000001c8: 000008f6
00000204: 00000000
00000212: 00000000 _free
0000021c: 000008f6
0000023c: 00000000 _mmupres
00000246: 000008f6
00000250: 00000000 _ssbyte
0000025c: 00000000 _mmupres
00000262: 00000000 _mmupres
00000270: 000008f6
00000276: 000008f6
0000027c: 000008f6
00000294: 000008f6
000002a4: 00000000 _gsbyte
000002b6: 000008f6
000002bc: 000008f6
000002c2: 000008f6
000002d8: 000008f6
000002de: 000008f6
000002f4: 000008f6
00000302: 00000000 _mmupres
0000030c: 000008f6
00000312: 000008f6
0000031a: 000008f6
00000320: 000008f6
0000032a: 00000000
00000334: 00000000 _mmupres
00000362: 000008f6
000003b0: 00000000
000003cc: 000008f6
000003e0: 000008f6
000003e8: 000008f6
000003ee: 000008f6
000003fe: 000008f6
00000432: 00000000
00000452: 00000000
00000468: 00000000
0000046e: 000008f6
00000482: 00000000 _curproc
00000490: 000008f6
00000496: 00000000 _putfmt
000004d6: 000008f6
000004e2: 000008f6
000004e8: 00000000 _panic
000004f0: 000008f6
000004f6: 000008f6
000004fc: 000008f6
00000504: 000008f6
0000051c: 000008f6
0000055c: 000008f6
00000562: 00000000 _panic
0000058e: 000008f6
00000594: 000008f6
00000620: 00000000 _mmupres
00000664: 00000000
0000067c: 00000000 _salloc
000006a2: 00000000 _sfree
000006c2: 00000000 _sfree
000006da: 00000000 _salloc
000006fc: 00000000 _sfree
00000732: 00000000 _sfree
00000740: 000008f6
00000748: 000008f6
00000752: 000008f6
00000758: 000008f6
00000768: 000008f6
00000778: 000008f6
00000790: 00000000 _mmupres
000007ba: 00000000 _noswap
000007e0: 00000000 _salloc
000007f0: 00000000 _noswap
0000081a: 00000000 _sfree
00000838: 000008f6
00000860: 00000000
00000880: 000008f6
000008a0: 000008f6
000008cc: 000008f6
000008d6: 000008f6
000008dc: 000008f6
