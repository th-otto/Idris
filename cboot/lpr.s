; a_magic   = 0x9928
; a_text    = 0x0000033a
; a_data    = 0x000000a6
; a_bss     = 0x00000000
; a_syms    = 0x000000da
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x0000004f@0x000004d6


x0:
[00000000] 4e56 fffc                 link       a6,#-4
[00000004] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000008] 7e7f                      moveq.l    #127,d7
[0000000a] 7c00                      moveq.l    #0,d6
[0000000c] 3c2e 000a                 move.w     10(a6),d6
[00000010] ce86                      and.l      d6,d7
[00000012] 1d47 ffff                 move.b     d7,-1(a6)
[00000016] 4247                      clr.w      d7
[00000018] 1e2e ffff                 move.b     -1(a6),d7
[0000001c] 7c38                      moveq.l    #56,d6
[0000001e] cec6                      mulu.w     d6,d7
[00000020] 2a47                      movea.l    d7,a5
[00000022] dbfc 0000 0050            adda.l     #$0000038A,a5
[00000028] 0c2e 0001 ffff            cmpi.b     #$01,-1(a6)
[0000002e] 650e                      bcs.s      x0_1
[00000030] 4878 0006                 pea.l      ($00000006).w
[00000034] 4eb9 0000 0000            jsr        _uerror
[0000003a] 588f                      addq.l     #4,a7
[0000003c] 6024                      bra.s      x0_2
x0_1:
[0000003e] 7e00                      moveq.l    #0,d7
[00000040] 3e2e 000a                 move.w     10(a6),d7
[00000044] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000004a] 0807 0007                 btst       #7,d7
[0000004e] 671a                      beq.s      x0_3
[00000050] 4a6d 0032                 tst.w      50(a5)
[00000054] 6714                      beq.s      x0_3
[00000056] 4878 0006                 pea.l      ($00000006).w
[0000005a] 4eb9 0000 0000            jsr        _uerror
[00000060] 588f                      addq.l     #4,a7
x0_2:
[00000062] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000066] 4e5e                      unlk       a6
[00000068] 4e75                      rts
x0_3:
[0000006a] 4878 0001                 pea.l      ($00000001).w
[0000006e] 7e00                      moveq.l    #0,d7
[00000070] 3e2e 000a                 move.w     10(a6),d7
[00000074] 2f07                      move.l     d7,-(a7)
[00000076] 4eb9 0000 0000            jsr        _settyp
[0000007c] 508f                      addq.l     #8,a7
[0000007e] 7e00                      moveq.l    #0,d7
[00000080] 3e39 0000 0000            move.w     _ttyps,d7
[00000086] 2e87                      move.l     d7,(a7)
[00000088] 4eb9 0000 0000            jsr        _spl
[0000008e] 3d47 fffc                 move.w     d7,-4(a6)
[00000092] 082d 0003 000d            btst       #3,13(a5)
[00000098] 6658                      bne.s      x0_4
[0000009a] 227c 0000 008c            movea.l    #$000003C6,a1
[000000a0] 7e00                      moveq.l    #0,d7
[000000a2] 1e2e ffff                 move.b     -1(a6),d7
[000000a6] 4a31 7800                 tst.b      0(a1,d7.l)
[000000aa] 6640                      bne.s      x0_5
[000000ac] 227c 0000 008c            movea.l    #$000003C6,a1
[000000b2] 7e00                      moveq.l    #0,d7
[000000b4] 1e2e ffff                 move.b     -1(a6),d7
[000000b8] 13bc 0001 7800            move.b     #$01,0(a1,d7.l)
[000000be] 4878 003d                 pea.l      ($0000003D).w
[000000c2] 2f0d                      move.l     a5,-(a7)
[000000c4] 4eb9 0000 0000            jsr        _ttinit
[000000ca] 508f                      addq.l     #8,a7
[000000cc] 7c00                      moveq.l    #0,d6
[000000ce] 1c2e ffff                 move.b     -1(a6),d6
[000000d2] e586                      asl.l      #2,d6
[000000d4] 2246                      movea.l    d6,a1
[000000d6] d3fc 0000 0088            adda.l     #$000003C2,a1
[000000dc] 2287                      move.l     d7,(a1)
[000000de] 3b6e 000a 002a            move.w     10(a6),42(a5)
[000000e4] 2b7c 0000 01d4 0026       move.l     #$000001D4,38(a5)
x0_5:
[000000ec] 006d 000a 000c            ori.w      #$000A,12(a5)
x0_4:
[000000f2] 526d 0032                 addq.w     #1,50(a5)
[000000f6] 7e00                      moveq.l    #0,d7
[000000f8] 3e2e fffc                 move.w     -4(a6),d7
[000000fc] 2e87                      move.l     d7,(a7)
[000000fe] 4eb9 0000 0000            jsr        _spl
[00000104] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000108] 4e5e                      unlk       a6
[0000010a] 4e75                      rts

x10c:
[0000010c] 4e56 0000                 link       a6,#0
[00000110] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000114] 7e7f                      moveq.l    #127,d7
[00000116] 7c00                      moveq.l    #0,d6
[00000118] 3c2e 000a                 move.w     10(a6),d6
[0000011c] ce86                      and.l      d6,d7
[0000011e] e587                      asl.l      #2,d7
[00000120] 2247                      movea.l    d7,a1
[00000122] d3fc 0000 0088            adda.l     #$000003C2,a1
[00000128] 2a51                      movea.l    (a1),a5
[0000012a] 536d 0032                 subq.w     #1,50(a5)
[0000012e] 661e                      bne.s      x10c_1
[00000130] 2e8d                      move.l     a5,(a7)
[00000132] 4eb9 0000 0000            jsr        _wflush
[00000138] 426d 000c                 clr.w      12(a5)
[0000013c] 4297                      clr.l      (a7)
[0000013e] 7e00                      moveq.l    #0,d7
[00000140] 3e2e 000a                 move.w     10(a6),d7
[00000144] 2f07                      move.l     d7,-(a7)
[00000146] 4eb9 0000 0000            jsr        _settyp
[0000014c] 588f                      addq.l     #4,a7
x10c_1:
[0000014e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000152] 4e5e                      unlk       a6
[00000154] 4e75                      rts

x156:
[00000156] 4e56 fffc                 link       a6,#-4
[0000015a] 7e7f                      moveq.l    #127,d7
[0000015c] 7c00                      moveq.l    #0,d6
[0000015e] 3c2e 000a                 move.w     10(a6),d6
[00000162] ce86                      and.l      d6,d7
[00000164] e587                      asl.l      #2,d7
[00000166] 2247                      movea.l    d7,a1
[00000168] d3fc 0000 0088            adda.l     #$000003C2,a1
[0000016e] 2e91                      move.l     (a1),(a7)
[00000170] 4eb9 0000 0000            jsr        _ttread
[00000176] 4e5e                      unlk       a6
[00000178] 4e75                      rts

x17a:
[0000017a] 4e56 fffc                 link       a6,#-4
[0000017e] 7e7f                      moveq.l    #127,d7
[00000180] 7c00                      moveq.l    #0,d6
[00000182] 3c2e 000a                 move.w     10(a6),d6
[00000186] ce86                      and.l      d6,d7
[00000188] e587                      asl.l      #2,d7
[0000018a] 2247                      movea.l    d7,a1
[0000018c] d3fc 0000 0088            adda.l     #$000003C2,a1
[00000192] 2e91                      move.l     (a1),(a7)
[00000194] 4eb9 0000 0000            jsr        _ttwrite
[0000019a] 4e5e                      unlk       a6
[0000019c] 4e75                      rts

x19e:
[0000019e] 4e56 0000                 link       a6,#0
[000001a2] 48e7 8004                 movem.l    d0/a5,-(a7)
[000001a6] 7e7f                      moveq.l    #127,d7
[000001a8] 7c00                      moveq.l    #0,d6
[000001aa] 3c2e 000a                 move.w     10(a6),d6
[000001ae] ce86                      and.l      d6,d7
[000001b0] e587                      asl.l      #2,d7
[000001b2] 2247                      movea.l    d7,a1
[000001b4] d3fc 0000 0088            adda.l     #$000003C2,a1
[000001ba] 2a51                      movea.l    (a1),a5
[000001bc] 2eae 000c                 move.l     12(a6),(a7)
[000001c0] 2f0d                      move.l     a5,-(a7)
[000001c2] 4eb9 0000 0000            jsr        _ttset
[000001c8] 588f                      addq.l     #4,a7
[000001ca] 4a87                      tst.l      d7
[000001cc] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000001d0] 4e5e                      unlk       a6
[000001d2] 4e75                      rts

x1d4:
[000001d4] 4e56 fffa                 link       a6,#-6
[000001d8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000001dc] 2a6e 0008                 movea.l    8(a6),a5
[000001e0] 0838 0000 fa01            btst       #0,($FFFFFA01).w
[000001e6] 6628                      bne.s      x1d4_1
[000001e8] 3e2d 000c                 move.w     12(a5),d7
[000001ec] 0247 0030                 andi.w     #$0030,d7
[000001f0] 4847                      swap       d7
[000001f2] 4247                      clr.w      d7
[000001f4] 4847                      swap       d7
[000001f6] 6612                      bne.s      x1d4_2
[000001f8] 486d 0018                 pea.l      24(a5)
[000001fc] 4eb9 0000 0000            jsr        _deqc
[00000202] 588f                      addq.l     #4,a7
[00000204] 3d47 fffe                 move.w     d7,-2(a6)
[00000208] 6c0e                      bge.s      x1d4_3
x1d4_2:
[0000020a] 08b8 0000 fa09            bclr       #0,($FFFFFA09).w
x1d4_1:
[00000210] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000214] 4e5e                      unlk       a6
[00000216] 4e75                      rts
x1d4_3:
[00000218] 082d 0005 0005            btst       #5,5(a5)
[0000021e] 660a                      bne.s      x1d4_4
[00000220] 0c6e 0080 fffe            cmpi.w     #$0080,-2(a6)
[00000226] 6c00 00c6                 bge        x1d4_5
x1d4_4:
[0000022a] 7e00                      moveq.l    #0,d7
[0000022c] 3e39 0000 0000            move.w     _ttyps,d7
[00000232] 2e87                      move.l     d7,(a7)
[00000234] 4eb9 0000 0000            jsr        _spl7
[0000023a] 3d47 fffa                 move.w     d7,-6(a6)
[0000023e] 11fc 0007 8800            move.b     #$07,($FFFF8800).w
[00000244] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[0000024a] 11fc 0007 8800            move.b     #$07,($FFFF8800).w
[00000250] 1e2e fffd                 move.b     -3(a6),d7
[00000254] 4887                      ext.w      d7
[00000256] 48c7                      ext.l      d7
[00000258] 08c7 0007                 bset       #7,d7
[0000025c] 11c7 8802                 move.b     d7,($FFFF8802).w
[00000260] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[00000266] 11fc 000f 8800            move.b     #$0F,($FFFF8800).w
[0000026c] 11ee ffff 8802            move.b     -1(a6),($FFFF8802).w
[00000272] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[00000278] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[0000027e] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[00000284] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[0000028a] 1e2e fffd                 move.b     -3(a6),d7
[0000028e] 4887                      ext.w      d7
[00000290] 48c7                      ext.l      d7
[00000292] 0287 0000 00df            andi.l     #$000000DF,d7
[00000298] 11c7 8802                 move.b     d7,($FFFF8802).w
[0000029c] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[000002a2] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[000002a8] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[000002ae] 11fc 000e 8800            move.b     #$0E,($FFFF8800).w
[000002b4] 1e2e fffd                 move.b     -3(a6),d7
[000002b8] 4887                      ext.w      d7
[000002ba] 48c7                      ext.l      d7
[000002bc] 08c7 0005                 bset       #5,d7
[000002c0] 11c7 8802                 move.b     d7,($FFFF8802).w
[000002c4] 1d78 8800 fffd            move.b     ($FFFF8800).w,-3(a6)
[000002ca] 08f8 0000 fa09            bset       #0,($FFFFFA09).w
[000002d0] 7e00                      moveq.l    #0,d7
[000002d2] 3e2e fffa                 move.w     -6(a6),d7
[000002d6] 2e87                      move.l     d7,(a7)
[000002d8] 4eb9 0000 0000            jsr        _spl
x1d4_6:
[000002de] 2e8d                      move.l     a5,(a7)
[000002e0] 4eb9 0000 0000            jsr        _ttwake
[000002e6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000002ea] 4e5e                      unlk       a6
[000002ec] 4e75                      rts
x1d4_5:
[000002ee] 7e7f                      moveq.l    #127,d7
[000002f0] 3c2e fffe                 move.w     -2(a6),d6
[000002f4] 48c6                      ext.l      d6
[000002f6] ce86                      and.l      d6,d7
[000002f8] 2e87                      move.l     d7,(a7)
[000002fa] 2f0d                      move.l     a5,-(a7)
[000002fc] 2f3c 0000 0000            move.l     #_ttrstart,-(a7)
[00000302] 4eb9 0000 0000            jsr        _timeout
[00000308] 508f                      addq.l     #8,a7
[0000030a] 08ed 0005 000d            bset       #5,13(a5)
[00000310] 08b8 0000 fa09            bclr       #0,($FFFFFA09).w
[00000316] 60c6                      bra.s      x1d4_6

_lpr_int:
[00000318] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000031c] 2a79 0000 0088            movea.l    $000003C2,a5
[00000322] 5279 0000 0000            addq.w     #1,_clk_flg
[00000328] 2e8d                      move.l     a5,(a7)
[0000032a] 4eba fea8                 jsr        $000001D4(pc)
[0000032e] 5379 0000 0000            subq.w     #1,_clk_flg
[00000334] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000338] 4e75                      rts

	.data
[0000033a] 00000004                  dc.l $00000004 ; no symbol found
[0000033e]                           dc.b '<lpr.c - Copyright (c) 1986/87 by Computer Tools, Int. - Ver. 1.0>',0
[00000381]                           dc.b 'parallel',0
[0000038a]                           dc.b $00
[0000038b]                           dc.b $00
[0000038c]                           dc.b $00
[0000038d]                           dc.b $00
[0000038e]                           dc.b $00
[0000038f]                           dc.b $00
[00000390]                           dc.b $00
[00000391]                           dc.b $00
[00000392]                           dc.b $00
[00000393]                           dc.b $00
[00000394]                           dc.b $00
[00000395]                           dc.b $00
[00000396]                           dc.b $00
[00000397]                           dc.b $00
[00000398]                           dc.b $00
[00000399]                           dc.b $00
[0000039a]                           dc.b $00
[0000039b]                           dc.b $00
[0000039c]                           dc.b $00
[0000039d]                           dc.b $00
[0000039e]                           dc.b $00
[0000039f]                           dc.b $00
[000003a0]                           dc.b $00
[000003a1]                           dc.b $00
[000003a2]                           dc.b $00
[000003a3]                           dc.b $00
[000003a4]                           dc.b $00
[000003a5]                           dc.b $00
[000003a6]                           dc.b $00
[000003a7]                           dc.b $00
[000003a8]                           dc.b $00
[000003a9]                           dc.b $00
[000003aa]                           dc.b $00
[000003ab]                           dc.b $00
[000003ac]                           dc.b $00
[000003ad]                           dc.b $00
[000003ae]                           dc.b $00
[000003af]                           dc.b $00
[000003b0]                           dc.b $00
[000003b1]                           dc.b $00
[000003b2]                           dc.b $00
[000003b3]                           dc.b $00
[000003b4]                           dc.b $00
[000003b5]                           dc.b $00
[000003b6]                           dc.b $00
[000003b7]                           dc.b $00
[000003b8]                           dc.b $00
[000003b9]                           dc.b $00
[000003ba]                           dc.b $00
[000003bb]                           dc.b $00
[000003bc]                           dc.b $00
[000003bd]                           dc.b $00
[000003be]                           dc.b $00
[000003bf]                           dc.b $00
[000003c0]                           dc.b $00
[000003c1]                           dc.b $00
[000003c2]                           dc.b $00
[000003c3]                           dc.b $00
[000003c4]                           dc.b $00
[000003c5]                           dc.b $00
[000003c6]                           dc.b $00
[000003c7]                           dc.b $00
_lpcdev:
[000003c8] 00000000                  dc.l $00000000 ; no symbol found
[000003cc] 0000010c                  dc.l $0000010c ; no symbol found
[000003d0] 00000156                  dc.l $00000156 ; no symbol found
[000003d4] 0000017a                  dc.l $0000017a ; no symbol found
[000003d8] 0000019e                  dc.l $0000019e ; no symbol found
[000003dc] 00000047                  dc.l $00000047 ; no symbol found
;
         U _uerror
         U _deqc
         U _ttinit
         U _wflush
         U _ttwrite
         U _clk_flg
         U _ttwake
         U _spl
         U _ttrstart
         U _timeout
         U _spl7
         U _ttread
         U _ttyps
         U _ttset
         U _settyp
00000318 T _lpr_int
000003c8 D _lpcdev
;
; a.out Relocations:
00000024: 0000033a
00000036: 00000000 _uerror
0000005c: 00000000 _uerror
00000078: 00000000 _settyp
00000082: 00000000 _ttyps
0000008a: 00000000 _spl
0000009c: 0000033a
000000ae: 0000033a
000000c6: 00000000 _ttinit
000000d8: 0000033a
000000e6: 00000000
00000100: 00000000 _spl
00000124: 0000033a
00000134: 00000000 _wflush
00000148: 00000000 _settyp
0000016a: 0000033a
00000172: 00000000 _ttread
0000018e: 0000033a
00000196: 00000000 _ttwrite
000001b6: 0000033a
000001c4: 00000000 _ttset
000001fe: 00000000 _deqc
0000022e: 00000000 _ttyps
00000236: 00000000 _spl7
000002da: 00000000 _spl
000002e2: 00000000 _ttwake
000002fe: 00000000 _ttrstart
00000304: 00000000 _timeout
0000031e: 0000033a
00000324: 00000000 _clk_flg
00000330: 00000000 _clk_flg
0000033a: 0000033a
000003c8: 00000000
000003cc: 00000000
000003d0: 00000000
000003d4: 00000000
000003d8: 00000000
000003dc: 0000033a
