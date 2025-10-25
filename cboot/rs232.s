; a_magic   = 0x9928
; a_text    = 0x000004d2
; a_data    = 0x000000ea
; a_bss     = 0x00000000
; a_syms    = 0x0000012f
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000083@0x00000707


_rs232init:
[00000000] 4eb9 0000 0496            jsr        $00000496
[00000006] 4e75                      rts

x8:
[00000008] 4e56 fffc                 link       a6,#-4
[0000000c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000010] 7e7f                      moveq.l    #127,d7
[00000012] 7c00                      moveq.l    #0,d6
[00000014] 3c2e 000a                 move.w     10(a6),d6
[00000018] ce86                      and.l      d6,d7
[0000001a] 1d47 ffff                 move.b     d7,-1(a6)
[0000001e] 4247                      clr.w      d7
[00000020] 1e2e ffff                 move.b     -1(a6),d7
[00000024] 7c38                      moveq.l    #56,d6
[00000026] cec6                      mulu.w     d6,d7
[00000028] 2a47                      movea.l    d7,a5
[0000002a] dbfc 0000 0050            adda.l     #$00000522,a5
[00000030] 0c2e 0001 ffff            cmpi.b     #$01,-1(a6)
[00000036] 650e                      bcs.s      x8_1
[00000038] 4878 0006                 pea.l      ($00000006).w
[0000003c] 4eb9 0000 0000            jsr        _uerror
[00000042] 588f                      addq.l     #4,a7
[00000044] 6024                      bra.s      x8_2
x8_1:
[00000046] 7e00                      moveq.l    #0,d7
[00000048] 3e2e 000a                 move.w     10(a6),d7
[0000004c] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000052] 0807 0007                 btst       #7,d7
[00000056] 671a                      beq.s      x8_3
[00000058] 4a6d 0032                 tst.w      50(a5)
[0000005c] 6714                      beq.s      x8_3
[0000005e] 4878 0006                 pea.l      ($00000006).w
[00000062] 4eb9 0000 0000            jsr        _uerror
[00000068] 588f                      addq.l     #4,a7
x8_2:
[0000006a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000006e] 4e5e                      unlk       a6
[00000070] 4e75                      rts
x8_3:
[00000072] 4878 0001                 pea.l      ($00000001).w
[00000076] 7e00                      moveq.l    #0,d7
[00000078] 3e2e 000a                 move.w     10(a6),d7
[0000007c] 2f07                      move.l     d7,-(a7)
[0000007e] 4eb9 0000 0000            jsr        _settyp
[00000084] 508f                      addq.l     #8,a7
[00000086] 7e00                      moveq.l    #0,d7
[00000088] 3e39 0000 0000            move.w     _ttyps,d7
[0000008e] 2e87                      move.l     d7,(a7)
[00000090] 4eb9 0000 0000            jsr        _spl
[00000096] 3d47 fffc                 move.w     d7,-4(a6)
[0000009a] 082d 0003 000d            btst       #3,13(a5)
[000000a0] 6658                      bne.s      x8_4
[000000a2] 227c 0000 008c            movea.l    #$0000055E,a1
[000000a8] 7e00                      moveq.l    #0,d7
[000000aa] 1e2e ffff                 move.b     -1(a6),d7
[000000ae] 4a31 7800                 tst.b      0(a1,d7.l)
[000000b2] 6640                      bne.s      x8_5
[000000b4] 227c 0000 008c            movea.l    #$0000055E,a1
[000000ba] 7e00                      moveq.l    #0,d7
[000000bc] 1e2e ffff                 move.b     -1(a6),d7
[000000c0] 13bc 0001 7800            move.b     #$01,0(a1,d7.l)
[000000c6] 4878 003d                 pea.l      ($0000003D).w
[000000ca] 2f0d                      move.l     a5,-(a7)
[000000cc] 4eb9 0000 0000            jsr        _ttinit
[000000d2] 508f                      addq.l     #8,a7
[000000d4] 7c00                      moveq.l    #0,d6
[000000d6] 1c2e ffff                 move.b     -1(a6),d6
[000000da] e586                      asl.l      #2,d6
[000000dc] 2246                      movea.l    d6,a1
[000000de] d3fc 0000 0088            adda.l     #$0000055A,a1
[000000e4] 2287                      move.l     d7,(a1)
[000000e6] 3b6e 000a 002a            move.w     10(a6),42(a5)
[000000ec] 2b7c 0000 028e 0026       move.l     #$0000028E,38(a5)
x8_5:
[000000f4] 006d 000a 000c            ori.w      #$000A,12(a5)
x8_4:
[000000fa] 526d 0032                 addq.w     #1,50(a5)
[000000fe] 4eb9 0000 0458            jsr        $00000458
[00000104] 7e00                      moveq.l    #0,d7
[00000106] 3e2e fffc                 move.w     -4(a6),d7
[0000010a] 2e87                      move.l     d7,(a7)
[0000010c] 4eb9 0000 0000            jsr        _spl
[00000112] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000116] 4e5e                      unlk       a6
[00000118] 4e75                      rts

x11a:
[0000011a] 4e56 fffc                 link       a6,#-4
[0000011e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000122] 7e7f                      moveq.l    #127,d7
[00000124] 7c00                      moveq.l    #0,d6
[00000126] 3c2e 000a                 move.w     10(a6),d6
[0000012a] ce86                      and.l      d6,d7
[0000012c] 1d47 ffff                 move.b     d7,-1(a6)
[00000130] 7e00                      moveq.l    #0,d7
[00000132] 1e2e ffff                 move.b     -1(a6),d7
[00000136] e587                      asl.l      #2,d7
[00000138] 2247                      movea.l    d7,a1
[0000013a] d3fc 0000 0088            adda.l     #$0000055A,a1
[00000140] 2a51                      movea.l    (a1),a5
[00000142] 536d 0032                 subq.w     #1,50(a5)
[00000146] 6624                      bne.s      x11a_1
[00000148] 2e8d                      move.l     a5,(a7)
[0000014a] 4eb9 0000 0000            jsr        _wflush
[00000150] 426d 000c                 clr.w      12(a5)
[00000154] 4297                      clr.l      (a7)
[00000156] 7e00                      moveq.l    #0,d7
[00000158] 3e2e 000a                 move.w     10(a6),d7
[0000015c] 2f07                      move.l     d7,-(a7)
[0000015e] 4eb9 0000 0000            jsr        _settyp
[00000164] 588f                      addq.l     #4,a7
[00000166] 4eb9 0000 0496            jsr        $00000496
x11a_1:
[0000016c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000170] 4e5e                      unlk       a6
[00000172] 4e75                      rts

x174:
[00000174] 4e56 fffc                 link       a6,#-4
[00000178] 7e7f                      moveq.l    #127,d7
[0000017a] 7c00                      moveq.l    #0,d6
[0000017c] 3c2e 000a                 move.w     10(a6),d6
[00000180] ce86                      and.l      d6,d7
[00000182] e587                      asl.l      #2,d7
[00000184] 2247                      movea.l    d7,a1
[00000186] d3fc 0000 0088            adda.l     #$0000055A,a1
[0000018c] 2e91                      move.l     (a1),(a7)
[0000018e] 4eb9 0000 0000            jsr        _ttread
[00000194] 4e5e                      unlk       a6
[00000196] 4e75                      rts

x198:
[00000198] 4e56 fffc                 link       a6,#-4
[0000019c] 7e7f                      moveq.l    #127,d7
[0000019e] 7c00                      moveq.l    #0,d6
[000001a0] 3c2e 000a                 move.w     10(a6),d6
[000001a4] ce86                      and.l      d6,d7
[000001a6] e587                      asl.l      #2,d7
[000001a8] 2247                      movea.l    d7,a1
[000001aa] d3fc 0000 0088            adda.l     #$0000055A,a1
[000001b0] 2e91                      move.l     (a1),(a7)
[000001b2] 4eb9 0000 0000            jsr        _ttwrite
[000001b8] 4e5e                      unlk       a6
[000001ba] 4e75                      rts

x1bc:
[000001bc] 4e56 fffc                 link       a6,#-4
[000001c0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000001c4] 7e7f                      moveq.l    #127,d7
[000001c6] 7c00                      moveq.l    #0,d6
[000001c8] 3c2e 000a                 move.w     10(a6),d6
[000001cc] ce86                      and.l      d6,d7
[000001ce] e587                      asl.l      #2,d7
[000001d0] 2247                      movea.l    d7,a1
[000001d2] d3fc 0000 0088            adda.l     #$0000055A,a1
[000001d8] 2a51                      movea.l    (a1),a5
[000001da] 2eae 000c                 move.l     12(a6),(a7)
[000001de] 2f0d                      move.l     a5,-(a7)
[000001e0] 4eb9 0000 0000            jsr        _ttset
[000001e6] 588f                      addq.l     #4,a7
[000001e8] 4a87                      tst.l      d7
[000001ea] 6708                      beq.s      x1bc_1
[000001ec] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000001f0] 4e5e                      unlk       a6
[000001f2] 4e75                      rts
x1bc_1:
[000001f4] 7e0f                      moveq.l    #15,d7
[000001f6] 7c00                      moveq.l    #0,d6
[000001f8] 3c2d 0008                 move.w     8(a5),d6
[000001fc] ce86                      and.l      d6,d7
[000001fe] 3d47 fffc                 move.w     d7,-4(a6)
[00000202] 677c                      beq.s      x1bc_2
[00000204] 1d78 fa1d ffff            move.b     ($FFFFFA1D).w,-1(a6)
[0000020a] 1e2e ffff                 move.b     -1(a6),d7
[0000020e] 4887                      ext.w      d7
[00000210] 48c7                      ext.l      d7
[00000212] 0287 0000 00f0            andi.l     #$000000F0,d7
[00000218] 11c7 fa1d                 move.b     d7,($FFFFFA1D).w
[0000021c] 7e00                      moveq.l    #0,d7
[0000021e] 3e2e fffc                 move.w     -4(a6),d7
[00000222] de87                      add.l      d7,d7
[00000224] 2247                      movea.l    d7,a1
[00000226] d3fc 0000 00a7            adda.l     #$00000579,a1
[0000022c] 1d51 fffe                 move.b     (a1),-2(a6)
x1bc_3:
[00000230] 11ee fffe fa25            move.b     -2(a6),($FFFFFA25).w
[00000236] 1e38 fa25                 move.b     ($FFFFFA25).w,d7
[0000023a] 4887                      ext.w      d7
[0000023c] 48c7                      ext.l      d7
[0000023e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000244] 1c2e fffe                 move.b     -2(a6),d6
[00000248] 4886                      ext.w      d6
[0000024a] 48c6                      ext.l      d6
[0000024c] 0286 0000 00ff            andi.l     #$000000FF,d6
[00000252] be86                      cmp.l      d6,d7
[00000254] 66da                      bne.s      x1bc_3
[00000256] 7e00                      moveq.l    #0,d7
[00000258] 3e2e fffc                 move.w     -4(a6),d7
[0000025c] de87                      add.l      d7,d7
[0000025e] 2247                      movea.l    d7,a1
[00000260] d3fc 0000 00a6            adda.l     #$00000578,a1
[00000266] 7e00                      moveq.l    #0,d7
[00000268] 1e11                      move.b     (a1),d7
[0000026a] 1c2e ffff                 move.b     -1(a6),d6
[0000026e] 4886                      ext.w      d6
[00000270] 48c6                      ext.l      d6
[00000272] 8e86                      or.l       d6,d7
[00000274] 11c7 fa1d                 move.b     d7,($FFFFFA1D).w
[00000278] 4eb9 0000 0458            jsr        $00000458
[0000027e] 6006                      bra.s      x1bc_4
x1bc_2:
[00000280] 4eb9 0000 0496            jsr        $00000496
x1bc_4:
[00000286] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000028a] 4e5e                      unlk       a6
[0000028c] 4e75                      rts

x28e:
[0000028e] 4e56 fffc                 link       a6,#-4
[00000292] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000296] 2a6e 0008                 movea.l    8(a6),a5
[0000029a] 0838 0007 fa2d            btst       #7,($FFFFFA2D).w
[000002a0] 6714                      beq.s      x28e_1
[000002a2] 0838 0002 fa01            btst       #2,($FFFFFA01).w
[000002a8] 6714                      beq.s      x28e_2
[000002aa] 08b8 0002 fa07            bclr       #2,($FFFFFA07).w
[000002b0] 08f8 0002 fa09            bset       #2,($FFFFFA09).w
x28e_1:
[000002b6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000002ba] 4e5e                      unlk       a6
[000002bc] 4e75                      rts
x28e_2:
[000002be] 3e2d 000c                 move.w     12(a5),d7
[000002c2] 0247 0030                 andi.w     #$0030,d7
[000002c6] 4847                      swap       d7
[000002c8] 4247                      clr.w      d7
[000002ca] 4847                      swap       d7
[000002cc] 6612                      bne.s      x28e_3
[000002ce] 486d 0018                 pea.l      24(a5)
[000002d2] 4eb9 0000 0000            jsr        _deqc
[000002d8] 588f                      addq.l     #4,a7
[000002da] 3d47 fffe                 move.w     d7,-2(a6)
[000002de] 6c0e                      bge.s      x28e_4
x28e_3:
[000002e0] 08b8 0002 fa07            bclr       #2,($FFFFFA07).w
[000002e6] 08b8 0002 fa09            bclr       #2,($FFFFFA09).w
[000002ec] 60c8                      bra.s      x28e_1
x28e_4:
[000002ee] 082d 0005 0005            btst       #5,5(a5)
[000002f4] 6710                      beq.s      x28e_5
[000002f6] 11ee ffff fa2f            move.b     -1(a6),($FFFFFA2F).w
[000002fc] 08f8 0002 fa07            bset       #2,($FFFFFA07).w
[00000302] 6000 00a6                 bra        x28e_6
x28e_5:
[00000306] 0c6e 0080 fffe            cmpi.w     #$0080,-2(a6)
[0000030c] 6c74                      bge.s      x28e_7
[0000030e] 7e00                      moveq.l    #0,d7
[00000310] 3e2d 0004                 move.w     4(a5),d7
[00000314] 0287 0000 00c0            andi.l     #$000000C0,d7
[0000031a] 41f9 0000 00c6            lea.l      $00000598,a0
[00000320] 4ef9 0000 0000            jmp        a~jtab
[00000326] 08ee 0007 ffff            bset       #7,-1(a6)
[0000032c] 6046                      bra.s      x28e_8
[0000032e] 227c 0000 0000            movea.l    #_cmaptab,a1
[00000334] 3e2e fffe                 move.w     -2(a6),d7
[00000338] 48c7                      ext.l      d7
[0000033a] 1e31 7800                 move.b     0(a1,d7.l),d7
[0000033e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000344] 0287 0000 0080            andi.l     #$00000080,d7
[0000034a] 8f6e fffe                 or.w       d7,-2(a6)
[0000034e] 6024                      bra.s      x28e_8
[00000350] 227c 0000 0000            movea.l    #_cmaptab,a1
[00000356] 3e2e fffe                 move.w     -2(a6),d7
[0000035a] 48c7                      ext.l      d7
[0000035c] 1e31 7800                 move.b     0(a1,d7.l),d7
[00000360] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000366] 0287 0000 0080            andi.l     #$00000080,d7
[0000036c] 0847 0007                 bchg       #7,d7
[00000370] 8f6e fffe                 or.w       d7,-2(a6)
x28e_8:
[00000374] 11ee ffff fa2f            move.b     -1(a6),($FFFFFA2F).w
[0000037a] 08f8 0002 fa07            bset       #2,($FFFFFA07).w
[00000380] 6028                      bra.s      x28e_6
x28e_7:
[00000382] 7e7f                      moveq.l    #127,d7
[00000384] 3c2e fffe                 move.w     -2(a6),d6
[00000388] 48c6                      ext.l      d6
[0000038a] ce86                      and.l      d6,d7
[0000038c] 2e87                      move.l     d7,(a7)
[0000038e] 2f0d                      move.l     a5,-(a7)
[00000390] 2f3c 0000 0000            move.l     #_ttrstart,-(a7)
[00000396] 4eb9 0000 0000            jsr        _timeout
[0000039c] 508f                      addq.l     #8,a7
[0000039e] 08ed 0005 000d            bset       #5,13(a5)
[000003a4] 08b8 0002 fa07            bclr       #2,($FFFFFA07).w
x28e_6:
[000003aa] 2e8d                      move.l     a5,(a7)
[000003ac] 4eb9 0000 0000            jsr        _ttwake
[000003b2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000003b6] 4e5e                      unlk       a6
[000003b8] 4e75                      rts

_cser_int:
[000003ba] 48e7 8004                 movem.l    d0/a5,-(a7)
[000003be] 2a79 0000 0088            movea.l    $0000055A,a5
[000003c4] 5279 0000 0000            addq.w     #1,_clk_flg
[000003ca] 2e8d                      move.l     a5,(a7)
[000003cc] 4eba fec0                 jsr        $0000028E(pc)
[000003d0] 5379 0000 0000            subq.w     #1,_clk_flg
[000003d6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000003da] 4e75                      rts

_oser_int:
[000003dc] 48e7 8004                 movem.l    d0/a5,-(a7)
[000003e0] 2a79 0000 0088            movea.l    $0000055A,a5
[000003e6] 5279 0000 0000            addq.w     #1,_clk_flg
[000003ec] 2e8d                      move.l     a5,(a7)
[000003ee] 4eba fe9e                 jsr        $0000028E(pc)
[000003f2] 5379 0000 0000            subq.w     #1,_clk_flg
[000003f8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000003fc] 4e75                      rts

_iser_int:
[000003fe] 4e56 fffe                 link       a6,#-2
[00000402] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000406] 2a79 0000 0088            movea.l    $0000055A,a5
[0000040c] 5279 0000 0000            addq.w     #1,_clk_flg
[00000412] 0838 0007 fa2b            btst       #7,($FFFFFA2B).w
[00000418] 6730                      beq.s      _iser_int_1
[0000041a] 1e38 fa2f                 move.b     ($FFFFFA2F).w,d7
[0000041e] 4887                      ext.w      d7
[00000420] 48c7                      ext.l      d7
[00000422] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000428] 3d47 fffe                 move.w     d7,-2(a6)
[0000042c] 2e0d                      move.l     a5,d7
[0000042e] 671a                      beq.s      _iser_int_1
[00000430] 082d 0003 000d            btst       #3,13(a5)
[00000436] 6712                      beq.s      _iser_int_1
[00000438] 2e8d                      move.l     a5,(a7)
[0000043a] 3e2e fffe                 move.w     -2(a6),d7
[0000043e] 48c7                      ext.l      d7
[00000440] 2f07                      move.l     d7,-(a7)
[00000442] 4eb9 0000 0000            jsr        _ttin
[00000448] 588f                      addq.l     #4,a7
_iser_int_1:
[0000044a] 5379 0000 0000            subq.w     #1,_clk_flg
[00000450] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000454] 4e5e                      unlk       a6
[00000456] 4e75                      rts

x458:
[00000458] 4e56 fffe                 link       a6,#-2
[0000045c] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000460] 4eb9 0000 0000            jsr        _spl7
[00000466] 3d47 fffe                 move.w     d7,-2(a6)
[0000046a] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[00000470] 7a00                      moveq.l    #0,d5
[00000472] 1a38 8800                 move.b     ($FFFF8800).w,d5
[00000476] 0285 0000 00ef            andi.l     #$000000EF,d5
[0000047c] 11c5 8802                 move.b     d5,($FFFF8802).w
[00000480] 7e00                      moveq.l    #0,d7
[00000482] 3e2e fffe                 move.w     -2(a6),d7
[00000486] 2e87                      move.l     d7,(a7)
[00000488] 4eb9 0000 0000            jsr        _spl
[0000048e] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000492] 4e5e                      unlk       a6
[00000494] 4e75                      rts

x496:
[00000496] 4e56 fffe                 link       a6,#-2
[0000049a] 48e7 8400                 movem.l    d0/d5,-(a7)
[0000049e] 4eb9 0000 0000            jsr        _spl7
[000004a4] 3d47 fffe                 move.w     d7,-2(a6)
[000004a8] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[000004ae] 7a00                      moveq.l    #0,d5
[000004b0] 1a38 8800                 move.b     ($FFFF8800).w,d5
[000004b4] 08c5 0004                 bset       #4,d5
[000004b8] 11c5 8802                 move.b     d5,($FFFF8802).w
[000004bc] 7e00                      moveq.l    #0,d7
[000004be] 3e2e fffe                 move.w     -2(a6),d7
[000004c2] 2e87                      move.l     d7,(a7)
[000004c4] 4eb9 0000 0000            jsr        _spl
[000004ca] 4cdf 0021                 movem.l    (a7)+,d0/d5
[000004ce] 4e5e                      unlk       a6
[000004d0] 4e75                      rts

	.data
[000004d2] 00000004                  dc.l $00000004 ; no symbol found
[000004d6]                           dc.b '<rs232.c - Copyright (c) 1986/87 by Computer Tools, Int. - Ver. 1.0>',0
[0000051b]                           dc.b 'rs232',0
[00000521]                           dc.b $00
[00000522]                           dc.b $00
[00000523]                           dc.b $00
[00000524]                           dc.b $00
[00000525]                           dc.b $00
[00000526]                           dc.b $00
[00000527]                           dc.b $00
[00000528]                           dc.b $00
[00000529]                           dc.b $00
[0000052a]                           dc.b $00
[0000052b]                           dc.b $00
[0000052c]                           dc.b $00
[0000052d]                           dc.b $00
[0000052e]                           dc.b $00
[0000052f]                           dc.b $00
[00000530]                           dc.b $00
[00000531]                           dc.b $00
[00000532]                           dc.b $00
[00000533]                           dc.b $00
[00000534]                           dc.b $00
[00000535]                           dc.b $00
[00000536]                           dc.b $00
[00000537]                           dc.b $00
[00000538]                           dc.b $00
[00000539]                           dc.b $00
[0000053a]                           dc.b $00
[0000053b]                           dc.b $00
[0000053c]                           dc.b $00
[0000053d]                           dc.b $00
[0000053e]                           dc.b $00
[0000053f]                           dc.b $00
[00000540]                           dc.b $00
[00000541]                           dc.b $00
[00000542]                           dc.b $00
[00000543]                           dc.b $00
[00000544]                           dc.b $00
[00000545]                           dc.b $00
[00000546]                           dc.b $00
[00000547]                           dc.b $00
[00000548]                           dc.b $00
[00000549]                           dc.b $00
[0000054a]                           dc.b $00
[0000054b]                           dc.b $00
[0000054c]                           dc.b $00
[0000054d]                           dc.b $00
[0000054e]                           dc.b $00
[0000054f]                           dc.b $00
[00000550]                           dc.b $00
[00000551]                           dc.b $00
[00000552]                           dc.b $00
[00000553]                           dc.b $00
[00000554]                           dc.b $00
[00000555]                           dc.b $00
[00000556]                           dc.b $00
[00000557]                           dc.b $00
[00000558]                           dc.b $00
[00000559]                           dc.b $00
[0000055a]                           dc.b $00
[0000055b]                           dc.b $00
[0000055c]                           dc.b $00
[0000055d]                           dc.b $00
[0000055e]                           dc.b $00
[0000055f]                           dc.b $00
_sercdev:
[00000560] 00000008                  dc.l $00000008 ; no symbol found
[00000564] 0000011a                  dc.l $0000011a ; no symbol found
[00000568] 00000174                  dc.l $00000174 ; no symbol found
[0000056c] 00000198                  dc.l $00000198 ; no symbol found
[00000570] 000001bc                  dc.l $000001bc ; no symbol found
[00000574] 00000049                  dc.l $00000049 ; no symbol found
[00000578]                           dc.w $0260
[0000057a]                           dc.w $0260
[0000057c]                           dc.w $0240
[0000057e]                           dc.w $01af
[00000580]                           dc.w $018f
[00000582]                           dc.w $0180
[00000584]                           dc.w $0160
[00000586]                           dc.w $0140
[00000588]                           dc.w $0120
[0000058a]                           dc.w $0110
[0000058c]                           dc.w $010b
[0000058e]                           dc.w $0108
[00000590]                           dc.w $0104
[00000592]                           dc.w $0102
[00000594]                           dc.w $0101
[00000596]                           dc.w $0101
[00000598]                           dc.b $00
[00000599]                           dc.b $00
[0000059a]                           dc.b $00
[0000059b]                           dc.b $00
[0000059c]                           dc.b $00
[0000059d]                           dc.b $00
[0000059e]                           dc.b $00
[0000059f]                           dc.b $03
[000005a0] 00000350                  dc.l $00000350 ; no symbol found
[000005a4]                           dc.b $00
[000005a5]                           dc.b $00
[000005a6]                           dc.b $00
[000005a7]                           dc.b $40
[000005a8] 0000032e                  dc.l $0000032e ; no symbol found
[000005ac]                           dc.b $00
[000005ad]                           dc.b $00
[000005ae]                           dc.b $00
[000005af]                           dc.b $80
[000005b0] 00000326                  dc.l $00000326 ; no symbol found
[000005b4]                           dc.b $00
[000005b5]                           dc.b $00
[000005b6]                           dc.b $00
[000005b7]                           dc.b $c0
[000005b8] 00000374                  dc.l $00000374 ; no symbol found
;
         U _uerror
         U _deqc
         U _ttinit
         U _wflush
         U _cmaptab
         U _ttwrite
         U _clk_flg
         U _ttwake
         U _spl
         U _ttrstart
         U _timeout
         U _spl7
         U _ttread
         U _ttyps
         U _ttin
         U _ttset
         U _settyp
         U a~jtab
00000000 T _rs232init
000003ba T _cser_int
000003dc T _oser_int
000003fe T _iser_int
00000560 D _sercdev
;
; a.out Relocations:
00000002: 00000000
0000002c: 000004d2
0000003e: 00000000 _uerror
00000064: 00000000 _uerror
00000080: 00000000 _settyp
0000008a: 00000000 _ttyps
00000092: 00000000 _spl
000000a4: 000004d2
000000b6: 000004d2
000000ce: 00000000 _ttinit
000000e0: 000004d2
000000ee: 00000000
00000100: 00000000
0000010e: 00000000 _spl
0000013c: 000004d2
0000014c: 00000000 _wflush
00000160: 00000000 _settyp
00000168: 00000000
00000188: 000004d2
00000190: 00000000 _ttread
000001ac: 000004d2
000001b4: 00000000 _ttwrite
000001d4: 000004d2
000001e2: 00000000 _ttset
00000228: 000004d2
00000262: 000004d2
0000027a: 00000000
00000282: 00000000
000002d4: 00000000 _deqc
0000031c: 000004d2
00000322: 00000000 a~jtab
00000330: 00000000 _cmaptab
00000352: 00000000 _cmaptab
00000392: 00000000 _ttrstart
00000398: 00000000 _timeout
000003ae: 00000000 _ttwake
000003c0: 000004d2
000003c6: 00000000 _clk_flg
000003d2: 00000000 _clk_flg
000003e2: 000004d2
000003e8: 00000000 _clk_flg
000003f4: 00000000 _clk_flg
00000408: 000004d2
0000040e: 00000000 _clk_flg
00000444: 00000000 _ttin
0000044c: 00000000 _clk_flg
00000462: 00000000 _spl7
0000048a: 00000000 _spl
000004a0: 00000000 _spl7
000004c6: 00000000 _spl
000004d2: 000004d2
00000560: 00000000
00000564: 00000000
00000568: 00000000
0000056c: 00000000
00000570: 00000000
00000574: 000004d2
000005a0: 00000000
000005a8: 00000000
000005b0: 00000000
000005b8: 00000000
