; a_magic   = 0x9928
; a_text    = 0x00001b12
; a_data    = 0x00000156
; a_bss     = 0x00000000
; a_syms    = 0x00000814
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00001b12
; a_relocs  = 0x0000020e@0x00002498


_mapmsd:
[00000000] 4e56 0000                 link       a6,#0
[00000004] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000008] 2eae 0008                 move.l     8(a6),(a7)
[0000000c] 4eb9 0000 0000            jsr        _mapfd
[00000012] 2a47                      movea.l    d7,a5
[00000014] 2e0d                      move.l     a5,d7
[00000016] 6604                      bne.s      _mapmsd_1
[00000018] 7e00                      moveq.l    #0,d7
[0000001a] 602e                      bra.s      _mapmsd_2
_mapmsd_1:
[0000001c] 2855                      movea.l    (a5),a4
[0000001e] 7e00                      moveq.l    #0,d7
[00000020] 3e2c 001a                 move.w     26(a4),d7
[00000024] 0287 0000 6000            andi.l     #$00006000,d7
[0000002a] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00000030] 6704                      beq.s      _mapmsd_3
[00000032] 7e01                      moveq.l    #1,d7
[00000034] 6002                      bra.s      _mapmsd_4
_mapmsd_3:
[00000036] 7e00                      moveq.l    #0,d7
_mapmsd_4:
[00000038] 4a87                      tst.l      d7
[0000003a] 6716                      beq.s      _mapmsd_5
[0000003c] 4878 0019                 pea.l      ($00000019).w
[00000040] 4eb9 0000 0000            jsr        _uerror
[00000046] 588f                      addq.l     #4,a7
[00000048] 7e00                      moveq.l    #0,d7
_mapmsd_2:
[0000004a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000004e] 4e5e                      unlk       a6
[00000050] 4e75                      rts
_mapmsd_5:
[00000052] 7e00                      moveq.l    #0,d7
[00000054] 3e2c 0022                 move.w     34(a4),d7
[00000058] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000005e] 2a07                      move.l     d7,d5
[00000060] 0c85 0000 0004            cmpi.l     #$00000004,d5
[00000066] 6c18                      bge.s      _mapmsd_6
[00000068] 2e85                      move.l     d5,(a7)
[0000006a] 4878 0006                 pea.l      ($00000006).w
[0000006e] 4eb9 0000 0000            jsr        a~lmul
[00000074] 2257                      movea.l    (a7),a1
[00000076] d3fc 0000 1b80            adda.l     #$00003692,a1
[0000007c] 4a51                      tst.w      (a1)
[0000007e] 6610                      bne.s      _mapmsd_7
_mapmsd_6:
[00000080] 4878 0006                 pea.l      ($00000006).w
[00000084] 4eb9 0000 0000            jsr        _uerror
[0000008a] 588f                      addq.l     #4,a7
[0000008c] 7e00                      moveq.l    #0,d7
[0000008e] 60ba                      bra.s      _mapmsd_2
_mapmsd_7:
[00000090] 2e85                      move.l     d5,(a7)
[00000092] 4878 0006                 pea.l      ($00000006).w
[00000096] 4eb9 0000 0000            jsr        a~lmul
[0000009c] 2257                      movea.l    (a7),a1
[0000009e] d3fc 0000 1b82            adda.l     #$00003694,a1
[000000a4] 2e11                      move.l     (a1),d7
[000000a6] 60a2                      bra.s      _mapmsd_2

_msgclose:
[000000a8] 4e56 fff6                 link       a6,#-10
[000000ac] 48e7 8004                 movem.l    d0/a5,-(a7)
[000000b0] 2e2e 0008                 move.l     8(a6),d7
[000000b4] 0287 0000 00ff            andi.l     #$000000FF,d7
[000000ba] 2e87                      move.l     d7,(a7)
[000000bc] 4878 0006                 pea.l      ($00000006).w
[000000c0] 4eb9 0000 0000            jsr        a~lmul
[000000c6] 2e17                      move.l     (a7),d7
[000000c8] 0687 0000 1b80            addi.l     #$00003692,d7
[000000ce] 2a47                      movea.l    d7,a5
[000000d0] 2d6d 0002 fffc            move.l     2(a5),-4(a6)
[000000d6] 2eae fffc                 move.l     -4(a6),(a7)
[000000da] 4eb9 0000 0836            jsr        _findmp
[000000e0] 2d47 fff8                 move.l     d7,-8(a6)
[000000e4] 672a                      beq.s      _msgclose_1
[000000e6] 226e fffc                 movea.l    -4(a6),a1
[000000ea] 3d69 009e fff6            move.w     158(a1),-10(a6)
_msgclose_2:
[000000f0] 536e fff6                 subq.w     #1,-10(a6)
[000000f4] 6d1a                      blt.s      _msgclose_1
[000000f6] 3e2e fff6                 move.w     -10(a6),d7
[000000fa] 48c7                      ext.l      d7
[000000fc] 2e87                      move.l     d7,(a7)
[000000fe] 2f2e fff8                 move.l     -8(a6),-(a7)
[00000102] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000106] 4eb9 0000 05f8            jsr        _cdiscon
[0000010c] 508f                      addq.l     #8,a7
[0000010e] 60e0                      bra.s      _msgclose_2
_msgclose_1:
[00000110] 2eae fffc                 move.l     -4(a6),(a7)
[00000114] 4eb9 0000 05ae            jsr        _bufree
[0000011a] 5355                      subq.w     #1,(a5)
[0000011c] 666e                      bne.s      _msgclose_3
[0000011e] 226e fffc                 movea.l    -4(a6),a1
[00000122] 0829 0000 009d            btst       #0,157(a1)
[00000128] 6762                      beq.s      _msgclose_3
_msgclose_5:
[0000012a] 226e fffc                 movea.l    -4(a6),a1
[0000012e] 0829 0002 00a7            btst       #2,167(a1)
[00000134] 671c                      beq.s      _msgclose_4
[00000136] 226e fffc                 movea.l    -4(a6),a1
[0000013a] 08e9 0001 00a7            bset       #1,167(a1)
[00000140] 4878 fffd                 pea.l      ($FFFFFFFD).w
[00000144] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000148] 4eb9 0000 0000            jsr        _sleep
[0000014e] 508f                      addq.l     #8,a7
[00000150] 60d8                      bra.s      _msgclose_5
_msgclose_4:
[00000152] 226e fffc                 movea.l    -4(a6),a1
[00000156] 4aa9 0004                 tst.l      4(a1)
[0000015a] 671a                      beq.s      _msgclose_6
[0000015c] 4297                      clr.l      (a7)
[0000015e] 226e fffc                 movea.l    -4(a6),a1
[00000162] 2f29 0004                 move.l     4(a1),-(a7)
[00000166] 226e fffc                 movea.l    -4(a6),a1
[0000016a] 2f29 0008                 move.l     8(a1),-(a7)
[0000016e] 4eb9 0000 0000            jsr        _free
[00000174] 508f                      addq.l     #8,a7
_msgclose_6:
[00000176] 4297                      clr.l      (a7)
[00000178] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000017c] 4878 00a8                 pea.l      (_msgclose).w
[00000180] 4eb9 0000 0000            jsr        _free
[00000186] 508f                      addq.l     #8,a7
[00000188] 42ad 0002                 clr.l      2(a5)
_msgclose_3:
[0000018c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000190] 4e5e                      unlk       a6
[00000192] 4e75                      rts

_msgopen:
[00000194] 4e56 0000                 link       a6,#0
[00000198] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[0000019c] 2e2e 0008                 move.l     8(a6),d7
[000001a0] 0287 0000 00ff            andi.l     #$000000FF,d7
[000001a6] 2a07                      move.l     d7,d5
[000001a8] 2e85                      move.l     d5,(a7)
[000001aa] 4878 0006                 pea.l      ($00000006).w
[000001ae] 4eb9 0000 0000            jsr        a~lmul
[000001b4] 2e17                      move.l     (a7),d7
[000001b6] 0687 0000 1b80            addi.l     #$00003692,d7
[000001bc] 2a47                      movea.l    d7,a5
[000001be] 0c85 0000 0004            cmpi.l     #$00000004,d5
[000001c4] 6d0e                      blt.s      _msgopen_1
[000001c6] 4878 0006                 pea.l      ($00000006).w
[000001ca] 4eb9 0000 0000            jsr        _uerror
[000001d0] 588f                      addq.l     #4,a7
[000001d2] 604a                      bra.s      _msgopen_2
_msgopen_1:
[000001d4] 4aad 0002                 tst.l      2(a5)
[000001d8] 6704                      beq.s      _msgopen_3
[000001da] 5255                      addq.w     #1,(a5)
[000001dc] 6040                      bra.s      _msgopen_2
_msgopen_3:
[000001de] 4297                      clr.l      (a7)
[000001e0] 4878 00a8                 pea.l      (_msgclose).w
[000001e4] 4eb9 0000 0000            jsr        _alloc
[000001ea] 588f                      addq.l     #4,a7
[000001ec] 2b47 0002                 move.l     d7,2(a5)
[000001f0] 660e                      bne.s      _msgopen_4
[000001f2] 4878 000b                 pea.l      ($0000000B).w
[000001f6] 4eb9 0000 0000            jsr        _uerror
[000001fc] 588f                      addq.l     #4,a7
[000001fe] 601e                      bra.s      _msgopen_2
_msgopen_4:
[00000200] 5255                      addq.w     #1,(a5)
[00000202] 283c 0000 00a8            move.l     #$000000A8,d4
[00000208] 286d 0002                 movea.l    2(a5),a4
_msgopen_6:
[0000020c] 5384                      subq.l     #1,d4
[0000020e] 6d04                      blt.s      _msgopen_5
[00000210] 421c                      clr.b      (a4)+
[00000212] 60f8                      bra.s      _msgopen_6
_msgopen_5:
[00000214] 226d 0002                 movea.l    2(a5),a1
[00000218] 45ed 0002                 lea.l      2(a5),a2
[0000021c] 228a                      move.l     a2,(a1)
_msgopen_2:
[0000021e] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00000222] 4e5e                      unlk       a6
[00000224] 4e75                      rts

_msgread:
[00000226] 4e56 ffec                 link       a6,#-20
[0000022a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000022e] 2e2e 0008                 move.l     8(a6),d7
[00000232] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000238] 2e87                      move.l     d7,(a7)
[0000023a] 4878 0006                 pea.l      ($00000006).w
[0000023e] 4eb9 0000 0000            jsr        a~lmul
[00000244] 2e17                      move.l     (a7),d7
[00000246] 0687 0000 1b80            addi.l     #$00003692,d7
[0000024c] 2a47                      movea.l    d7,a5
[0000024e] 286d 0002                 movea.l    2(a5),a4
[00000252] 2e0c                      move.l     a4,d7
[00000254] 660e                      bne.s      _msgread_1
[00000256] 4878 0006                 pea.l      ($00000006).w
[0000025a] 4eb9 0000 0000            jsr        _uerror
[00000260] 588f                      addq.l     #4,a7
[00000262] 6042                      bra.s      _msgread_2
_msgread_1:
[00000264] 2d4c ffec                 move.l     a4,-20(a6)
[00000268] 2d7c 0000 00a8 fff0       move.l     #$000000A8,-16(a6)
[00000270] 7001                      moveq.l    #1,d0
[00000272] 2d40 fff4                 move.l     d0,-12(a6)
[00000276] 3e15                      move.w     (a5),d7
[00000278] 48c7                      ext.l      d7
[0000027a] 2d47 fff8                 move.l     d7,-8(a6)
[0000027e] 2e2c 0008                 move.l     8(a4),d7
[00000282] 0687 0000 00bc            addi.l     #$000000BC,d7
[00000288] 2d47 fffc                 move.l     d7,-4(a6)
[0000028c] 4eb9 0000 0000            jsr        _iocount
[00000292] 0c87 0000 0014            cmpi.l     #$00000014,d7
[00000298] 6c14                      bge.s      _msgread_3
[0000029a] 4878 000c                 pea.l      ($0000000C).w
[0000029e] 4eb9 0000 0000            jsr        _uerror
[000002a4] 588f                      addq.l     #4,a7
_msgread_2:
[000002a6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000002aa] 4e5e                      unlk       a6
[000002ac] 4e75                      rts
_msgread_3:
[000002ae] 4eb9 0000 0000            jsr        _ioseek
[000002b4] 4a87                      tst.l      d7
[000002b6] 6620                      bne.s      _msgread_4
[000002b8] 2ebc 0000 0000            move.l     #_outbuf,(a7)
[000002be] 4878 0014                 pea.l      ($00000014).w
[000002c2] 4eb9 0000 0000            jsr        _iobase
[000002c8] 2f07                      move.l     d7,-(a7)
[000002ca] 486e ffec                 pea.l      -20(a6)
[000002ce] 4eb9 0000 0000            jsr        _movio
[000002d4] 4fef 000c                 lea.l      12(a7),a7
_msgread_4:
[000002d8] 4eb9 0000 0000            jsr        _ioseek
[000002de] 0c87 0000 0014            cmpi.l     #$00000014,d7
[000002e4] 6652                      bne.s      _msgread_5
[000002e6] 4eb9 0000 0000            jsr        _iocount
[000002ec] 2c2c 0008                 move.l     8(a4),d6
[000002f0] 0686 0000 00a8            addi.l     #$000000A8,d6
[000002f6] bc87                      cmp.l      d7,d6
[000002f8] 623e                      bhi.s      _msgread_5
[000002fa] 2ebc 0000 0000            move.l     #_outbuf,(a7)
[00000300] 4878 00a8                 pea.l      (_msgclose).w
[00000304] 4eb9 0000 0000            jsr        _iobase
[0000030a] 2f07                      move.l     d7,-(a7)
[0000030c] 2f0c                      move.l     a4,-(a7)
[0000030e] 4eb9 0000 0000            jsr        _movio
[00000314] 4fef 000c                 lea.l      12(a7),a7
[00000318] 2ebc 0000 0000            move.l     #_outbuf,(a7)
[0000031e] 2f2c 0008                 move.l     8(a4),-(a7)
[00000322] 4eb9 0000 0000            jsr        _iobase
[00000328] 2f07                      move.l     d7,-(a7)
[0000032a] 2f2c 0004                 move.l     4(a4),-(a7)
[0000032e] 4eb9 0000 0000            jsr        _movio
[00000334] 4fef 000c                 lea.l      12(a7),a7
_msgread_5:
[00000338] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000033c] 4e5e                      unlk       a6
[0000033e] 4e75                      rts

_mbfree:
[00000340] 4e56 0000                 link       a6,#0
[00000344] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000348] 7e0c                      moveq.l    #12,d7
[0000034a] deae 0008                 add.l      8(a6),d7
[0000034e] 2847                      movea.l    d7,a4
[00000350] 2a54                      movea.l    (a4),a5
_mbfree_2:
[00000352] 2e0d                      move.l     a5,d7
[00000354] 6710                      beq.s      _mbfree_1
[00000356] 2e2d 0004                 move.l     4(a5),d7
[0000035a] beae 000c                 cmp.l      12(a6),d7
[0000035e] 6406                      bcc.s      _mbfree_1
[00000360] 284d                      movea.l    a5,a4
[00000362] 2a55                      movea.l    (a5),a5
[00000364] 60ec                      bra.s      _mbfree_2
_mbfree_1:
[00000366] 7e24                      moveq.l    #36,d7
[00000368] deae 0008                 add.l      8(a6),d7
[0000036c] 2e87                      move.l     d7,(a7)
[0000036e] 2f0d                      move.l     a5,-(a7)
[00000370] 4878 000e                 pea.l      ($0000000E).w
[00000374] 4eb9 0000 0000            jsr        _halloc
[0000037a] 508f                      addq.l     #8,a7
[0000037c] 2887                      move.l     d7,(a4)
[0000037e] 6730                      beq.s      _mbfree_3
[00000380] 2254                      movea.l    (a4),a1
[00000382] 236e 000c 0004            move.l     12(a6),4(a1)
[00000388] 2254                      movea.l    (a4),a1
[0000038a] 236e 0010 0008            move.l     16(a6),8(a1)
[00000390] 4eb9 0000 0000            jsr        _curpid
[00000396] 2254                      movea.l    (a4),a1
[00000398] 3347 000c                 move.w     d7,12(a1)
[0000039c] 4297                      clr.l      (a7)
[0000039e] 2f2e 000c                 move.l     12(a6),-(a7)
[000003a2] 2f2e 0008                 move.l     8(a6),-(a7)
[000003a6] 4eb9 0000 04c4            jsr        _mbchown
[000003ac] 508f                      addq.l     #8,a7
[000003ae] 600c                      bra.s      _mbfree_4
_mbfree_3:
[000003b0] 2ebc 0000 1b98            move.l     #$000036AA,(a7)
[000003b6] 4eb9 0000 0000            jsr        _putfmt
_mbfree_4:
[000003bc] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000003c0] 4e5e                      unlk       a6
[000003c2] 4e75                      rts

_mballoc:
[000003c4] 4e56 0000                 link       a6,#0
[000003c8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000003cc] 2eae 000c                 move.l     12(a6),(a7)
[000003d0] 226e 0008                 movea.l    8(a6),a1
[000003d4] 2f29 0018                 move.l     24(a1),-(a7)
[000003d8] 4eb9 0000 0492            jsr        _mbgran
[000003de] 588f                      addq.l     #4,a7
[000003e0] 2d47 000c                 move.l     d7,12(a6)
[000003e4] 7a00                      moveq.l    #0,d5
[000003e6] 226e 0008                 movea.l    8(a6),a1
[000003ea] 2a69 000c                 movea.l    12(a1),a5
_mballoc_3:
[000003ee] 2e0d                      move.l     a5,d7
[000003f0] 6714                      beq.s      _mballoc_1
[000003f2] 4a6d 000c                 tst.w      12(a5)
[000003f6] 660a                      bne.s      _mballoc_2
[000003f8] 2e2e 000c                 move.l     12(a6),d7
[000003fc] bead 0008                 cmp.l      8(a5),d7
[00000400] 6304                      bls.s      _mballoc_1
_mballoc_2:
[00000402] 2a55                      movea.l    (a5),a5
[00000404] 60e8                      bra.s      _mballoc_3
_mballoc_1:
[00000406] 49f8 0001                 lea.l      ($00000001).w,a4
[0000040a] 2e0d                      move.l     a5,d7
[0000040c] 6764                      beq.s      _mballoc_4
[0000040e] 4aae 000c                 tst.l      12(a6)
[00000412] 675e                      beq.s      _mballoc_4
[00000414] 2a2d 0004                 move.l     4(a5),d5
[00000418] 670a                      beq.s      _mballoc_5
[0000041a] 2e2d 0008                 move.l     8(a5),d7
[0000041e] beae 000c                 cmp.l      12(a6),d7
[00000422] 674e                      beq.s      _mballoc_4
_mballoc_5:
[00000424] 7e24                      moveq.l    #36,d7
[00000426] deae 0008                 add.l      8(a6),d7
[0000042a] 2e87                      move.l     d7,(a7)
[0000042c] 2f15                      move.l     (a5),-(a7)
[0000042e] 4878 000e                 pea.l      ($0000000E).w
[00000432] 4eb9 0000 0000            jsr        _halloc
[00000438] 508f                      addq.l     #8,a7
[0000043a] 2847                      movea.l    d7,a4
[0000043c] 2e0c                      move.l     a4,d7
[0000043e] 660e                      bne.s      _mballoc_6
[00000440] 2ebc 0000 1ba1            move.l     #$000036B3,(a7)
[00000446] 4eb9 0000 0000            jsr        _putfmt
[0000044c] 6024                      bra.s      _mballoc_4
_mballoc_6:
[0000044e] 2e2d 0008                 move.l     8(a5),d7
[00000452] 9eae 000c                 sub.l      12(a6),d7
[00000456] 2947 0008                 move.l     d7,8(a4)
[0000045a] 2e2d 0004                 move.l     4(a5),d7
[0000045e] deae 000c                 add.l      12(a6),d7
[00000462] 2947 0004                 move.l     d7,4(a4)
[00000466] 426c 000c                 clr.w      12(a4)
[0000046a] 2b6e 000c 0008            move.l     12(a6),8(a5)
[00000470] 2a8c                      move.l     a4,(a5)
_mballoc_4:
[00000472] 2e0d                      move.l     a5,d7
[00000474] 6712                      beq.s      _mballoc_7
[00000476] 2e0c                      move.l     a4,d7
[00000478] 670e                      beq.s      _mballoc_7
[0000047a] 4a85                      tst.l      d5
[0000047c] 670a                      beq.s      _mballoc_7
[0000047e] 3b6e 0012 000c            move.w     18(a6),12(a5)
[00000484] 2e05                      move.l     d5,d7
[00000486] 6002                      bra.s      _mballoc_8
_mballoc_7:
[00000488] 7e00                      moveq.l    #0,d7
_mballoc_8:
[0000048a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000048e] 4e5e                      unlk       a6
[00000490] 4e75                      rts

_mbgran:
[00000492] 4e56 fffc                 link       a6,#-4
[00000496] 2e2e 0008                 move.l     8(a6),d7
[0000049a] 5387                      subq.l     #1,d7
[0000049c] deae 000c                 add.l      12(a6),d7
[000004a0] 2e87                      move.l     d7,(a7)
[000004a2] 2f2e 0008                 move.l     8(a6),-(a7)
[000004a6] 4eb9 0000 0000            jsr        a~uldiv
[000004ac] 2f2e 0008                 move.l     8(a6),-(a7)
[000004b0] 4eb9 0000 0000            jsr        a~lmul
[000004b6] 2e17                      move.l     (a7),d7
[000004b8] 2d47 000c                 move.l     d7,12(a6)
[000004bc] 2e2e 000c                 move.l     12(a6),d7
[000004c0] 4e5e                      unlk       a6
[000004c2] 4e75                      rts

_mbchown:
[000004c4] 4e56 0000                 link       a6,#0
[000004c8] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[000004cc] 2a6e 0008                 movea.l    8(a6),a5
[000004d0] 2a2e 000c                 move.l     12(a6),d5
[000004d4] 4a85                      tst.l      d5
[000004d6] 671c                      beq.s      _mbchown_1
[000004d8] 97cb                      suba.l     a3,a3
[000004da] 286d 000c                 movea.l    12(a5),a4
_mbchown_3:
[000004de] 2e0c                      move.l     a4,d7
[000004e0] 670e                      beq.s      _mbchown_2
[000004e2] 2e2c 0004                 move.l     4(a4),d7
[000004e6] be85                      cmp.l      d5,d7
[000004e8] 6706                      beq.s      _mbchown_2
[000004ea] 264c                      movea.l    a4,a3
[000004ec] 2854                      movea.l    (a4),a4
[000004ee] 60ee                      bra.s      _mbchown_3
_mbchown_2:
[000004f0] 2e0c                      move.l     a4,d7
[000004f2] 6608                      bne.s      _mbchown_4
_mbchown_1:
[000004f4] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000004f8] 4e5e                      unlk       a6
[000004fa] 4e75                      rts
_mbchown_4:
[000004fc] 4eb9 0000 0000            jsr        _curpid
[00000502] 3c2c 000c                 move.w     12(a4),d6
[00000506] 48c6                      ext.l      d6
[00000508] be86                      cmp.l      d6,d7
[0000050a] 66e8                      bne.s      _mbchown_1
[0000050c] 396e 0012 000c            move.w     18(a6),12(a4)
[00000512] 66e0                      bne.s      _mbchown_1
[00000514] 2e0b                      move.l     a3,d7
[00000516] 6736                      beq.s      _mbchown_5
[00000518] 4a6b 000c                 tst.w      12(a3)
[0000051c] 6630                      bne.s      _mbchown_5
[0000051e] 2e2b 0004                 move.l     4(a3),d7
[00000522] deab 0008                 add.l      8(a3),d7
[00000526] beac 0004                 cmp.l      4(a4),d7
[0000052a] 6622                      bne.s      _mbchown_5
[0000052c] 2e2c 0008                 move.l     8(a4),d7
[00000530] dfab 0008                 add.l      d7,8(a3)
[00000534] 486d 0024                 pea.l      36(a5)
[00000538] 2f14                      move.l     (a4),-(a7)
[0000053a] 2f0c                      move.l     a4,-(a7)
[0000053c] 4878 000e                 pea.l      ($0000000E).w
[00000540] 4eb9 0000 0000            jsr        _hfree
[00000546] 4fef 0010                 lea.l      16(a7),a7
[0000054a] 2687                      move.l     d7,(a3)
[0000054c] 284b                      movea.l    a3,a4
_mbchown_5:
[0000054e] 2654                      movea.l    (a4),a3
[00000550] 2e0b                      move.l     a3,d7
[00000552] 6734                      beq.s      _mbchown_6
[00000554] 4a6b 000c                 tst.w      12(a3)
[00000558] 662e                      bne.s      _mbchown_6
[0000055a] 2e2c 0004                 move.l     4(a4),d7
[0000055e] deac 0008                 add.l      8(a4),d7
[00000562] beab 0004                 cmp.l      4(a3),d7
[00000566] 6620                      bne.s      _mbchown_6
[00000568] 2e2b 0008                 move.l     8(a3),d7
[0000056c] dfac 0008                 add.l      d7,8(a4)
[00000570] 486d 0024                 pea.l      36(a5)
[00000574] 2f13                      move.l     (a3),-(a7)
[00000576] 2f0b                      move.l     a3,-(a7)
[00000578] 4878 000e                 pea.l      ($0000000E).w
[0000057c] 4eb9 0000 0000            jsr        _hfree
[00000582] 4fef 0010                 lea.l      16(a7),a7
[00000586] 2887                      move.l     d7,(a4)
_mbchown_6:
[00000588] 082d 0004 00a7            btst       #4,167(a5)
[0000058e] 6716                      beq.s      _mbchown_7
[00000590] 08ad 0004 00a7            bclr       #4,167(a5)
[00000596] 486d 0014                 pea.l      20(a5)
[0000059a] 486d 000c                 pea.l      12(a5)
[0000059e] 4eb9 0000 0000            jsr        _wakeupl
[000005a4] 508f                      addq.l     #8,a7
_mbchown_7:
[000005a6] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000005aa] 4e5e                      unlk       a6
[000005ac] 4e75                      rts

_bufree:
[000005ae] 4e56 0000                 link       a6,#0
[000005b2] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000005b6] 4eb9 0000 0000            jsr        _curpid
[000005bc] 2a07                      move.l     d7,d5
[000005be] 7800                      moveq.l    #0,d4
[000005c0] 226e 0008                 movea.l    8(a6),a1
[000005c4] 2a69 000c                 movea.l    12(a1),a5
_bufree_3:
[000005c8] 2e0d                      move.l     a5,d7
[000005ca] 6722                      beq.s      _bufree_1
[000005cc] 3e2d 000c                 move.w     12(a5),d7
[000005d0] 48c7                      ext.l      d7
[000005d2] be85                      cmp.l      d5,d7
[000005d4] 6614                      bne.s      _bufree_2
[000005d6] 4297                      clr.l      (a7)
[000005d8] 2f2d 0004                 move.l     4(a5),-(a7)
[000005dc] 2f2e 0008                 move.l     8(a6),-(a7)
[000005e0] 4eb9 0000 04c4            jsr        _mbchown
[000005e6] 508f                      addq.l     #8,a7
[000005e8] 7801                      moveq.l    #1,d4
_bufree_2:
[000005ea] 2a55                      movea.l    (a5),a5
[000005ec] 60da                      bra.s      _bufree_3
_bufree_1:
[000005ee] 2e04                      move.l     d4,d7
[000005f0] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000005f4] 4e5e                      unlk       a6
[000005f6] 4e75                      rts

_cdiscon:
[000005f8] 4e56 fff0                 link       a6,#-16
[000005fc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000600] 2a6e 0008                 movea.l    8(a6),a5
[00000604] 286e 000c                 movea.l    12(a6),a4
[00000608] 2eae 0010                 move.l     16(a6),(a7)
[0000060c] 2f0d                      move.l     a5,-(a7)
[0000060e] 4eb9 0000 06b8            jsr        _chkchan
[00000614] 588f                      addq.l     #4,a7
[00000616] 4a87                      tst.l      d7
[00000618] 6608                      bne.s      _cdiscon_1
[0000061a] 2e3c ffff fc17            move.l     #$FFFFFC17,d7
[00000620] 6018                      bra.s      _cdiscon_2
_cdiscon_1:
[00000622] 2eae 0010                 move.l     16(a6),(a7)
[00000626] 2f0c                      move.l     a4,-(a7)
[00000628] 2f0d                      move.l     a5,-(a7)
[0000062a] 4eb9 0000 0800            jsr        _findmcon
[00000630] 508f                      addq.l     #8,a7
[00000632] 2d47 fffc                 move.l     d7,-4(a6)
[00000636] 660a                      bne.s      _cdiscon_3
[00000638] 7e00                      moveq.l    #0,d7
_cdiscon_2:
[0000063a] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000063e] 4e5e                      unlk       a6
[00000640] 4e75                      rts
_cdiscon_3:
[00000642] 4297                      clr.l      (a7)
[00000644] 486e fff0                 pea.l      -16(a6)
[00000648] 2f2e 0010                 move.l     16(a6),-(a7)
[0000064c] 2f0c                      move.l     a4,-(a7)
[0000064e] 2f0d                      move.l     a5,-(a7)
[00000650] 4eb9 0000 072e            jsr        _findm
[00000656] 4fef 0010                 lea.l      16(a7),a7
[0000065a] 4a87                      tst.l      d7
[0000065c] 6712                      beq.s      _cdiscon_4
[0000065e] 4297                      clr.l      (a7)
[00000660] 2f2e fff8                 move.l     -8(a6),-(a7)
[00000664] 2f0d                      move.l     a5,-(a7)
[00000666] 4eb9 0000 04c4            jsr        _mbchown
[0000066c] 508f                      addq.l     #8,a7
[0000066e] 60d2                      bra.s      _cdiscon_3
_cdiscon_4:
[00000670] 536d 0094                 subq.w     #1,148(a5)
[00000674] 2e2e 0010                 move.l     16(a6),d7
[00000678] e787                      asl.l      #3,d7
[0000067a] dead 001c                 add.l      28(a5),d7
[0000067e] 2e87                      move.l     d7,(a7)
[00000680] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000684] 4878 000e                 pea.l      ($0000000E).w
[00000688] 2f0d                      move.l     a5,-(a7)
[0000068a] 4eb9 0000 08b6            jsr        _msfrelst
[00000690] 4fef 000c                 lea.l      12(a7),a7
[00000694] 536c 0012                 subq.w     #1,18(a4)
[00000698] 661a                      bne.s      _cdiscon_5
[0000069a] 536d 0098                 subq.w     #1,152(a5)
[0000069e] 486d 0010                 pea.l      16(a5)
[000006a2] 2f0c                      move.l     a4,-(a7)
[000006a4] 4878 0016                 pea.l      ($00000016).w
[000006a8] 2f0d                      move.l     a5,-(a7)
[000006aa] 4eb9 0000 08b6            jsr        _msfrelst
[000006b0] 4fef 0010                 lea.l      16(a7),a7
_cdiscon_5:
[000006b4] 7e00                      moveq.l    #0,d7
[000006b6] 6082                      bra.s      _cdiscon_2

_chkchan:
[000006b8] 4e56 0000                 link       a6,#0
[000006bc] 0cae 0000 0001 000c       cmpi.l     #$00000001,12(a6)
[000006c4] 6d16                      blt.s      _chkchan_1
[000006c6] 226e 0008                 movea.l    8(a6),a1
[000006ca] 7e00                      moveq.l    #0,d7
[000006cc] 3e29 009e                 move.w     158(a1),d7
[000006d0] 2c2e 000c                 move.l     12(a6),d6
[000006d4] bc87                      cmp.l      d7,d6
[000006d6] 6e04                      bgt.s      _chkchan_1
[000006d8] 7e01                      moveq.l    #1,d7
[000006da] 6002                      bra.s      _chkchan_2
_chkchan_1:
[000006dc] 7e00                      moveq.l    #0,d7
_chkchan_2:
[000006de] 4e5e                      unlk       a6
[000006e0] 4e75                      rts

_chkev:
[000006e2] 4e56 0000                 link       a6,#0
[000006e6] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000006ea] 2a6e 0008                 movea.l    8(a6),a5
[000006ee] 2a2e 000c                 move.l     12(a6),d5
[000006f2] 0c85 0000 0001            cmpi.l     #$00000001,d5
[000006f8] 6d1e                      blt.s      _chkev_1
[000006fa] 7e00                      moveq.l    #0,d7
[000006fc] 3e2d 00a2                 move.w     162(a5),d7
[00000700] ba87                      cmp.l      d7,d5
[00000702] 6e14                      bgt.s      _chkev_1
[00000704] 2e85                      move.l     d5,(a7)
[00000706] 4878 0006                 pea.l      ($00000006).w
[0000070a] 4eb9 0000 0000            jsr        a~lmul
[00000710] 2e17                      move.l     (a7),d7
[00000712] dead 0020                 add.l      32(a5),d7
[00000716] 600e                      bra.s      _chkev_2
_chkev_1:
[00000718] 4878 03e8                 pea.l      ($000003E8).w
[0000071c] 4eb9 0000 0000            jsr        _uerror
[00000722] 588f                      addq.l     #4,a7
[00000724] 7e00                      moveq.l    #0,d7
_chkev_2:
[00000726] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000072a] 4e5e                      unlk       a6
[0000072c] 4e75                      rts

_findm:
[0000072e] 4e56 0000                 link       a6,#0
[00000732] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000736] 2a2e 0010                 move.l     16(a6),d5
[0000073a] 266e 0014                 movea.l    20(a6),a3
[0000073e] 2e2e 000c                 move.l     12(a6),d7
[00000742] 5887                      addq.l     #4,d7
[00000744] 2847                      movea.l    d7,a4
_findm_3:
[00000746] 2a54                      movea.l    (a4),a5
[00000748] 2e0d                      move.l     a5,d7
[0000074a] 6700 00aa                 beq        _findm_1
[0000074e] 4a85                      tst.l      d5
[00000750] 6712                      beq.s      _findm_2
[00000752] 226d 0010                 movea.l    16(a5),a1
[00000756] 3e29 000c                 move.w     12(a1),d7
[0000075a] 48c7                      ext.l      d7
[0000075c] be85                      cmp.l      d5,d7
[0000075e] 6704                      beq.s      _findm_2
[00000760] 284d                      movea.l    a5,a4
[00000762] 60e2                      bra.s      _findm_3
_findm_2:
[00000764] 276d 0008 0008            move.l     8(a5),8(a3)
[0000076a] 276d 000c 0004            move.l     12(a5),4(a3)
[00000770] 226d 0010                 movea.l    16(a5),a1
[00000774] 3a29 000c                 move.w     12(a1),d5
[00000778] 48c5                      ext.l      d5
[0000077a] 2685                      move.l     d5,(a3)
[0000077c] 4aae 0018                 tst.l      24(a6)
[00000780] 6670                      bne.s      _findm_4
[00000782] 4aad 0004                 tst.l      4(a5)
[00000786] 671a                      beq.s      _findm_5
[00000788] 226d 0004                 movea.l    4(a5),a1
[0000078c] 5369 0004                 subq.w     #1,4(a1)
[00000790] 6610                      bne.s      _findm_5
[00000792] 2ead 0004                 move.l     4(a5),(a7)
[00000796] 2f2d 0004                 move.l     4(a5),-(a7)
[0000079a] 4eb9 0000 0000            jsr        _wakeupl
[000007a0] 588f                      addq.l     #4,a7
_findm_5:
[000007a2] 2895                      move.l     (a5),(a4)
[000007a4] 226e 000c                 movea.l    12(a6),a1
[000007a8] 2e29 0008                 move.l     8(a1),d7
[000007ac] be8d                      cmp.l      a5,d7
[000007ae] 6608                      bne.s      _findm_6
[000007b0] 226e 000c                 movea.l    12(a6),a1
[000007b4] 234c 0008                 move.l     a4,8(a1)
_findm_6:
[000007b8] 226d 0010                 movea.l    16(a5),a1
[000007bc] 5369 0008                 subq.w     #1,8(a1)
[000007c0] 4297                      clr.l      (a7)
[000007c2] 2f0d                      move.l     a5,-(a7)
[000007c4] 4878 0014                 pea.l      ($00000014).w
[000007c8] 2f2e 0008                 move.l     8(a6),-(a7)
[000007cc] 4eb9 0000 086a            jsr        _msfree
[000007d2] 4fef 000c                 lea.l      12(a7),a7
[000007d6] 226e 0008                 movea.l    8(a6),a1
[000007da] 2e29 001c                 move.l     28(a1),d7
[000007de] 2c05                      move.l     d5,d6
[000007e0] e786                      asl.l      #3,d6
[000007e2] de86                      add.l      d6,d7
[000007e4] 2f07                      move.l     d7,-(a7)
[000007e6] 5897                      addq.l     #4,(a7)
[000007e8] 2f05                      move.l     d5,-(a7)
[000007ea] 4eb9 0000 0000            jsr        _wakeupl
[000007f0] 508f                      addq.l     #8,a7
_findm_4:
[000007f2] 7e01                      moveq.l    #1,d7
[000007f4] 6002                      bra.s      _findm_7
_findm_1:
[000007f6] 7e00                      moveq.l    #0,d7
_findm_7:
[000007f8] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000007fc] 4e5e                      unlk       a6
[000007fe] 4e75                      rts

_findmcon:
[00000800] 4e56 0000                 link       a6,#0
[00000804] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000808] 226e 0008                 movea.l    8(a6),a1
[0000080c] 2269 001c                 movea.l    28(a1),a1
[00000810] 2e2e 0010                 move.l     16(a6),d7
[00000814] e787                      asl.l      #3,d7
[00000816] 2a71 7800                 movea.l    0(a1,d7.l),a5
_findmcon_2:
[0000081a] 2e0d                      move.l     a5,d7
[0000081c] 670e                      beq.s      _findmcon_1
[0000081e] 2e2d 0004                 move.l     4(a5),d7
[00000822] beae 000c                 cmp.l      12(a6),d7
[00000826] 6704                      beq.s      _findmcon_1
[00000828] 2a55                      movea.l    (a5),a5
[0000082a] 60ee                      bra.s      _findmcon_2
_findmcon_1:
[0000082c] 2e0d                      move.l     a5,d7
[0000082e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000832] 4e5e                      unlk       a6
[00000834] 4e75                      rts

_findmp:
[00000836] 4e56 0000                 link       a6,#0
[0000083a] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000083e] 4eb9 0000 0000            jsr        _curpid
[00000844] 2a07                      move.l     d7,d5
[00000846] 226e 0008                 movea.l    8(a6),a1
[0000084a] 2a69 0010                 movea.l    16(a1),a5
_findmp_2:
[0000084e] 2e0d                      move.l     a5,d7
[00000850] 670e                      beq.s      _findmp_1
[00000852] 3e2d 0010                 move.w     16(a5),d7
[00000856] 48c7                      ext.l      d7
[00000858] be85                      cmp.l      d5,d7
[0000085a] 6704                      beq.s      _findmp_1
[0000085c] 2a55                      movea.l    (a5),a5
[0000085e] 60ee                      bra.s      _findmp_2
_findmp_1:
[00000860] 2e0d                      move.l     a5,d7
[00000862] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000866] 4e5e                      unlk       a6
[00000868] 4e75                      rts

_msfree:
[0000086a] 4e56 0000                 link       a6,#0
[0000086e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000872] 2a6e 0008                 movea.l    8(a6),a5
[00000876] 082d 0003 00a7            btst       #3,167(a5)
[0000087c] 6716                      beq.s      _msfree_1
[0000087e] 08ad 0003 00a7            bclr       #3,167(a5)
[00000884] 486d 0014                 pea.l      20(a5)
[00000888] 486d 0024                 pea.l      36(a5)
[0000088c] 4eb9 0000 0000            jsr        _wakeupl
[00000892] 508f                      addq.l     #8,a7
_msfree_1:
[00000894] 486d 0024                 pea.l      36(a5)
[00000898] 2f2e 0014                 move.l     20(a6),-(a7)
[0000089c] 2f2e 0010                 move.l     16(a6),-(a7)
[000008a0] 2f2e 000c                 move.l     12(a6),-(a7)
[000008a4] 4eb9 0000 0000            jsr        _hfree
[000008aa] 4fef 0010                 lea.l      16(a7),a7
[000008ae] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000008b2] 4e5e                      unlk       a6
[000008b4] 4e75                      rts

_msfrelst:
[000008b6] 4e56 0000                 link       a6,#0
[000008ba] 48e7 8004                 movem.l    d0/a5,-(a7)
[000008be] 2a6e 0008                 movea.l    8(a6),a5
[000008c2] 082d 0003 00a7            btst       #3,167(a5)
[000008c8] 6716                      beq.s      _msfrelst_1
[000008ca] 08ad 0003 00a7            bclr       #3,167(a5)
[000008d0] 486d 0014                 pea.l      20(a5)
[000008d4] 486d 0024                 pea.l      36(a5)
[000008d8] 4eb9 0000 0000            jsr        _wakeupl
[000008de] 508f                      addq.l     #8,a7
_msfrelst_1:
[000008e0] 486d 0024                 pea.l      36(a5)
[000008e4] 2f2e 0014                 move.l     20(a6),-(a7)
[000008e8] 2f2e 0010                 move.l     16(a6),-(a7)
[000008ec] 2f2e 000c                 move.l     12(a6),-(a7)
[000008f0] 4eb9 0000 0000            jsr        _hfrelst
[000008f6] 4fef 0010                 lea.l      16(a7),a7
[000008fa] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000008fe] 4e5e                      unlk       a6
[00000900] 4e75                      rts

_symnone:
[00000902] 4878 0023                 pea.l      ($00000023).w
[00000906] 4eb9 0000 0000            jsr        _uerror
[0000090c] 588f                      addq.l     #4,a7
[0000090e] 4e75                      rts

_symconnect:
[00000910] 4e56 fff6                 link       a6,#-10
[00000914] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000918] 226e 0008                 movea.l    8(a6),a1
[0000091c] 3d69 0006 fffe            move.w     6(a1),-2(a6)
[00000922] 226e 0008                 movea.l    8(a6),a1
[00000926] 2e91                      move.l     (a1),(a7)
[00000928] 4eb9 0000 0000            jsr        _mapmsd
[0000092e] 2a47                      movea.l    d7,a5
[00000930] 2e0d                      move.l     a5,d7
[00000932] 6722                      beq.s      _symconnect_1
[00000934] 3e2e fffe                 move.w     -2(a6),d7
[00000938] 48c7                      ext.l      d7
[0000093a] 2e87                      move.l     d7,(a7)
[0000093c] 2f0d                      move.l     a5,-(a7)
[0000093e] 4eb9 0000 06b8            jsr        _chkchan
[00000944] 588f                      addq.l     #4,a7
[00000946] 4a87                      tst.l      d7
[00000948] 6614                      bne.s      _symconnect_2
[0000094a] 4878 03e9                 pea.l      ($000003E9).w
[0000094e] 4eb9 0000 0000            jsr        _uerror
[00000954] 588f                      addq.l     #4,a7
_symconnect_1:
[00000956] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000095a] 4e5e                      unlk       a6
[0000095c] 4e75                      rts
_symconnect_2:
[0000095e] 2e8d                      move.l     a5,(a7)
[00000960] 4eb9 0000 0836            jsr        _findmp
[00000966] 2847                      movea.l    d7,a4
[00000968] 2e0c                      move.l     a4,d7
[0000096a] 671a                      beq.s      _symconnect_3
[0000096c] 3e2e fffe                 move.w     -2(a6),d7
[00000970] 48c7                      ext.l      d7
[00000972] 2e87                      move.l     d7,(a7)
[00000974] 2f0c                      move.l     a4,-(a7)
[00000976] 2f0d                      move.l     a5,-(a7)
[00000978] 4eb9 0000 0800            jsr        _findmcon
[0000097e] 508f                      addq.l     #8,a7
[00000980] 2d47 fffa                 move.l     d7,-6(a6)
[00000984] 66d0                      bne.s      _symconnect_1
_symconnect_3:
[00000986] 3e2d 0096                 move.w     150(a5),d7
[0000098a] be6d 0094                 cmp.w      148(a5),d7
[0000098e] 620e                      bhi.s      _symconnect_4
[00000990] 4878 03ea                 pea.l      ($000003EA).w
[00000994] 4eb9 0000 0000            jsr        _uerror
[0000099a] 588f                      addq.l     #4,a7
[0000099c] 60b8                      bra.s      _symconnect_1
_symconnect_4:
[0000099e] 3e2e fffe                 move.w     -2(a6),d7
[000009a2] 48c7                      ext.l      d7
[000009a4] e787                      asl.l      #3,d7
[000009a6] dead 001c                 add.l      28(a5),d7
[000009aa] 2d47 fff6                 move.l     d7,-10(a6)
[000009ae] 486d 0024                 pea.l      36(a5)
[000009b2] 226e fff6                 movea.l    -10(a6),a1
[000009b6] 2f11                      move.l     (a1),-(a7)
[000009b8] 4878 000e                 pea.l      ($0000000E).w
[000009bc] 4eb9 0000 0000            jsr        _halloc
[000009c2] 4fef 000c                 lea.l      12(a7),a7
[000009c6] 2d47 fffa                 move.l     d7,-6(a6)
[000009ca] 660e                      bne.s      _symconnect_5
[000009cc] 4878 03ec                 pea.l      ($000003EC).w
[000009d0] 4eb9 0000 0000            jsr        _uerror
[000009d6] 588f                      addq.l     #4,a7
[000009d8] 603a                      bra.s      _symconnect_6
_symconnect_5:
[000009da] 2e0c                      move.l     a4,d7
[000009dc] 6708                      beq.s      _symconnect_7
[000009de] 526c 0012                 addq.w     #1,18(a4)
[000009e2] 6000 00a6                 bra        _symconnect_8
_symconnect_7:
[000009e6] 3e2d 009a                 move.w     154(a5),d7
[000009ea] be6d 0098                 cmp.w      152(a5),d7
[000009ee] 622c                      bhi.s      _symconnect_9
[000009f0] 486d 0024                 pea.l      36(a5)
[000009f4] 42a7                      clr.l      -(a7)
[000009f6] 2f2e fffa                 move.l     -6(a6),-(a7)
[000009fa] 4878 000e                 pea.l      ($0000000E).w
[000009fe] 4eb9 0000 0000            jsr        _hfree
[00000a04] 4fef 0010                 lea.l      16(a7),a7
[00000a08] 4878 03eb                 pea.l      ($000003EB).w
[00000a0c] 4eb9 0000 0000            jsr        _uerror
[00000a12] 588f                      addq.l     #4,a7
_symconnect_6:
[00000a14] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000a18] 4e5e                      unlk       a6
[00000a1a] 4e75                      rts
_symconnect_9:
[00000a1c] 486d 0024                 pea.l      36(a5)
[00000a20] 2f2d 0010                 move.l     16(a5),-(a7)
[00000a24] 4878 0016                 pea.l      ($00000016).w
[00000a28] 4eb9 0000 0000            jsr        _halloc
[00000a2e] 4fef 000c                 lea.l      12(a7),a7
[00000a32] 2847                      movea.l    d7,a4
[00000a34] 2e0c                      move.l     a4,d7
[00000a36] 6626                      bne.s      _symconnect_10
[00000a38] 486d 0024                 pea.l      36(a5)
[00000a3c] 42a7                      clr.l      -(a7)
[00000a3e] 2f2e fffa                 move.l     -6(a6),-(a7)
[00000a42] 4878 000e                 pea.l      ($0000000E).w
[00000a46] 4eb9 0000 0000            jsr        _hfree
[00000a4c] 4fef 0010                 lea.l      16(a7),a7
[00000a50] 4878 03ec                 pea.l      ($000003EC).w
[00000a54] 4eb9 0000 0000            jsr        _uerror
[00000a5a] 588f                      addq.l     #4,a7
[00000a5c] 60b6                      bra.s      _symconnect_6
_symconnect_10:
[00000a5e] 2b4c 0010                 move.l     a4,16(a5)
[00000a62] 526d 0098                 addq.w     #1,152(a5)
[00000a66] 42ac 0004                 clr.l      4(a4)
[00000a6a] 42ac 0008                 clr.l      8(a4)
[00000a6e] 42ac 000c                 clr.l      12(a4)
[00000a72] 4eb9 0000 0000            jsr        _curpid
[00000a78] 3947 0010                 move.w     d7,16(a4)
[00000a7c] 397c 0001 0012            move.w     #$0001,18(a4)
[00000a82] 422c 0014                 clr.b      20(a4)
[00000a86] 422c 0015                 clr.b      21(a4)
_symconnect_8:
[00000a8a] 526d 0094                 addq.w     #1,148(a5)
[00000a8e] 226e fff6                 movea.l    -10(a6),a1
[00000a92] 22ae fffa                 move.l     -6(a6),(a1)
[00000a96] 226e fffa                 movea.l    -6(a6),a1
[00000a9a] 234c 0004                 move.l     a4,4(a1)
[00000a9e] 226e fffa                 movea.l    -6(a6),a1
[00000aa2] 4269 0008                 clr.w      8(a1)
[00000aa6] 226e fffa                 movea.l    -6(a6),a1
[00000aaa] 336d 00a4 000a            move.w     164(a5),10(a1)
[00000ab0] 226e fffa                 movea.l    -6(a6),a1
[00000ab4] 336e fffe 000c            move.w     -2(a6),12(a1)
[00000aba] 2e2e fff6                 move.l     -10(a6),d7
[00000abe] 2f07                      move.l     d7,-(a7)
[00000ac0] 5897                      addq.l     #4,(a7)
[00000ac2] 3e2e fffe                 move.w     -2(a6),d7
[00000ac6] 48c7                      ext.l      d7
[00000ac8] 2f07                      move.l     d7,-(a7)
[00000aca] 4eb9 0000 0000            jsr        _wakeupl
[00000ad0] 508f                      addq.l     #8,a7
[00000ad2] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000ad6] 4e5e                      unlk       a6
[00000ad8] 4e75                      rts

_symcreat:
[00000ada] 4e56 fffc                 link       a6,#-4
[00000ade] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00000ae2] 226e 0008                 movea.l    8(a6),a1
[00000ae6] 2e91                      move.l     (a1),(a7)
[00000ae8] 4eb9 0000 0000            jsr        _mapmsd
[00000aee] 2a47                      movea.l    d7,a5
[00000af0] 2e0d                      move.l     a5,d7
[00000af2] 6714                      beq.s      _symcreat_1
[00000af4] 082d 0000 00a7            btst       #0,167(a5)
[00000afa] 6714                      beq.s      _symcreat_2
[00000afc] 4878 03ed                 pea.l      ($000003ED).w
[00000b00] 4eb9 0000 0000            jsr        _uerror
[00000b06] 588f                      addq.l     #4,a7
_symcreat_1:
[00000b08] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000b0c] 4e5e                      unlk       a6
[00000b0e] 4e75                      rts
_symcreat_2:
[00000b10] 08ed 0000 009d            bset       #0,157(a5)
[00000b16] 226e 0008                 movea.l    8(a6),a1
[00000b1a] 2b69 0004 0008            move.l     4(a1),8(a5)
[00000b20] 4297                      clr.l      (a7)
[00000b22] 2f2d 0008                 move.l     8(a5),-(a7)
[00000b26] 4eb9 0000 0000            jsr        _alloc
[00000b2c] 588f                      addq.l     #4,a7
[00000b2e] 2b47 0004                 move.l     d7,4(a5)
[00000b32] 660e                      bne.s      _symcreat_3
[00000b34] 4878 000b                 pea.l      ($0000000B).w
[00000b38] 4eb9 0000 0000            jsr        _uerror
[00000b3e] 588f                      addq.l     #4,a7
[00000b40] 60c6                      bra.s      _symcreat_1
_symcreat_3:
[00000b42] 4878 000a                 pea.l      ($0000000A).w
[00000b46] 2f2d 0008                 move.l     8(a5),-(a7)
[00000b4a] 2f2d 0004                 move.l     4(a5),-(a7)
[00000b4e] 486d 0024                 pea.l      36(a5)
[00000b52] 4eb9 0000 0000            jsr        _hinit
[00000b58] 4fef 0010                 lea.l      16(a7),a7
[00000b5c] 486d 0024                 pea.l      36(a5)
[00000b60] 42a7                      clr.l      -(a7)
[00000b62] 2f2d 0004                 move.l     4(a5),-(a7)
[00000b66] 2f2d 0008                 move.l     8(a5),-(a7)
[00000b6a] 4eb9 0000 0000            jsr        _hfree
[00000b70] 4fef 0010                 lea.l      16(a7),a7
[00000b74] 486d 0024                 pea.l      36(a5)
[00000b78] 42a7                      clr.l      -(a7)
[00000b7a] 226e 0008                 movea.l    8(a6),a1
[00000b7e] 2e29 0008                 move.l     8(a1),d7
[00000b82] e787                      asl.l      #3,d7
[00000b84] 2f07                      move.l     d7,-(a7)
[00000b86] 5297                      addq.l     #1,(a7)
[00000b88] 4eb9 0000 0000            jsr        _halloc
[00000b8e] 4fef 000c                 lea.l      12(a7),a7
[00000b92] 2b47 001c                 move.l     d7,28(a5)
[00000b96] 672e                      beq.s      _symcreat_4
[00000b98] 486d 0024                 pea.l      36(a5)
[00000b9c] 42a7                      clr.l      -(a7)
[00000b9e] 226e 0008                 movea.l    8(a6),a1
[00000ba2] 2f29 000c                 move.l     12(a1),-(a7)
[00000ba6] 4878 0006                 pea.l      ($00000006).w
[00000baa] 4eb9 0000 0000            jsr        a~lmul
[00000bb0] 2e1f                      move.l     (a7)+,d7
[00000bb2] 2f07                      move.l     d7,-(a7)
[00000bb4] 5297                      addq.l     #1,(a7)
[00000bb6] 4eb9 0000 0000            jsr        _halloc
[00000bbc] 4fef 000c                 lea.l      12(a7),a7
[00000bc0] 2b47 0020                 move.l     d7,32(a5)
[00000bc4] 6624                      bne.s      _symcreat_5
_symcreat_4:
[00000bc6] 4297                      clr.l      (a7)
[00000bc8] 2f2d 0004                 move.l     4(a5),-(a7)
[00000bcc] 2f2d 0008                 move.l     8(a5),-(a7)
[00000bd0] 4eb9 0000 0000            jsr        _free
[00000bd6] 508f                      addq.l     #8,a7
[00000bd8] 2b47 0004                 move.l     d7,4(a5)
[00000bdc] 4878 03ec                 pea.l      ($000003EC).w
[00000be0] 4eb9 0000 0000            jsr        _uerror
[00000be6] 588f                      addq.l     #4,a7
[00000be8] 606a                      bra.s      _symcreat_6
_symcreat_5:
[00000bea] 286d 001c                 movea.l    28(a5),a4
[00000bee] 226e 0008                 movea.l    8(a6),a1
[00000bf2] 2e29 0008                 move.l     8(a1),d7
[00000bf6] 5287                      addq.l     #1,d7
[00000bf8] 2a07                      move.l     d7,d5
_symcreat_8:
[00000bfa] 5385                      subq.l     #1,d5
[00000bfc] 6d06                      blt.s      _symcreat_7
[00000bfe] 4294                      clr.l      (a4)
[00000c00] 508c                      addq.l     #8,a4
[00000c02] 60f6                      bra.s      _symcreat_8
_symcreat_7:
[00000c04] 266d 0020                 movea.l    32(a5),a3
[00000c08] 226e 0008                 movea.l    8(a6),a1
[00000c0c] 2e29 000c                 move.l     12(a1),d7
[00000c10] 5287                      addq.l     #1,d7
[00000c12] 2a07                      move.l     d7,d5
_symcreat_10:
[00000c14] 5385                      subq.l     #1,d5
[00000c16] 6d0a                      blt.s      _symcreat_9
[00000c18] 4293                      clr.l      (a3)
[00000c1a] 426b 0004                 clr.w      4(a3)
[00000c1e] 5c8b                      addq.l     #6,a3
[00000c20] 60f2                      bra.s      _symcreat_10
_symcreat_9:
[00000c22] 226e 0008                 movea.l    8(a6),a1
[00000c26] 3b69 000a 009e            move.w     10(a1),158(a5)
[00000c2c] 226e 0008                 movea.l    8(a6),a1
[00000c30] 3b69 000e 00a2            move.w     14(a1),162(a5)
[00000c36] 7010                      moveq.l    #16,d0
[00000c38] 2b40 0018                 move.l     d0,24(a5)
[00000c3c] 3b7c ffff 0096            move.w     #$FFFF,150(a5)
[00000c42] 3b7c ffff 009a            move.w     #$FFFF,154(a5)
[00000c48] 3b7c ffff 00a4            move.w     #$FFFF,164(a5)
[00000c4e] 08ed 0000 00a7            bset       #0,167(a5)
_symcreat_6:
[00000c54] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00000c58] 4e5e                      unlk       a6
[00000c5a] 4e75                      rts

_symdiscon:
[00000c5c] 4e56 fff6                 link       a6,#-10
[00000c60] 226e 0008                 movea.l    8(a6),a1
[00000c64] 2e91                      move.l     (a1),(a7)
[00000c66] 4eb9 0000 0000            jsr        _mapmsd
[00000c6c] 4a87                      tst.l      d7
[00000c6e] 6738                      beq.s      _symdiscon_1
[00000c70] 518f                      subq.l     #8,a7
[00000c72] 2f2e 0008                 move.l     8(a6),-(a7)
[00000c76] 203c 0000 0008            move.l     #$00000008,d0
[00000c7c] 4eb9 0000 0000            jsr        a~pushstr
[00000c82] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000c86] 4eb9 0000 0836            jsr        _findmp
[00000c8c] 588f                      addq.l     #4,a7
[00000c8e] 2f07                      move.l     d7,-(a7)
[00000c90] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000c94] 4eb9 0000 05f8            jsr        _cdiscon
[00000c9a] 4fef 0010                 lea.l      16(a7),a7
[00000c9e] 3d47 fffa                 move.w     d7,-6(a6)
[00000ca2] 6704                      beq.s      _symdiscon_1
[00000ca4] 7e01                      moveq.l    #1,d7
[00000ca6] 6002                      bra.s      _symdiscon_2
_symdiscon_1:
[00000ca8] 7e00                      moveq.l    #0,d7
_symdiscon_2:
[00000caa] 2d47 fffc                 move.l     d7,-4(a6)
[00000cae] 670e                      beq.s      _symdiscon_3
[00000cb0] 3e2e fffa                 move.w     -6(a6),d7
[00000cb4] 48c7                      ext.l      d7
[00000cb6] 2e87                      move.l     d7,(a7)
[00000cb8] 4eb9 0000 0000            jsr        _uerror
_symdiscon_3:
[00000cbe] 4e5e                      unlk       a6
[00000cc0] 4e75                      rts

_symevclr:
[00000cc2] 4e56 fffc                 link       a6,#-4
[00000cc6] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000cca] 2a6e 0008                 movea.l    8(a6),a5
[00000cce] 2e95                      move.l     (a5),(a7)
[00000cd0] 4eb9 0000 0000            jsr        _mapmsd
[00000cd6] 2d47 fffc                 move.l     d7,-4(a6)
[00000cda] 6722                      beq.s      _symevclr_1
[00000cdc] 2ead 0004                 move.l     4(a5),(a7)
[00000ce0] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000ce4] 4eb9 0000 06e2            jsr        _chkev
[00000cea] 588f                      addq.l     #4,a7
[00000cec] 2847                      movea.l    d7,a4
[00000cee] 2e0c                      move.l     a4,d7
[00000cf0] 6614                      bne.s      _symevclr_2
[00000cf2] 4878 03e8                 pea.l      ($000003E8).w
[00000cf6] 4eb9 0000 0000            jsr        _uerror
[00000cfc] 588f                      addq.l     #4,a7
_symevclr_1:
[00000cfe] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000d02] 4e5e                      unlk       a6
[00000d04] 4e75                      rts
_symevclr_2:
[00000d06] 7a00                      moveq.l    #0,d5
[00000d08] 3a2c 0004                 move.w     4(a4),d5
[00000d0c] 2e2d 0008                 move.l     8(a5),d7
[00000d10] 4687                      not.l      d7
[00000d12] cf6c 0004                 and.w      d7,4(a4)
[00000d16] 7e00                      moveq.l    #0,d7
[00000d18] 3e2c 0004                 move.w     4(a4),d7
[00000d1c] be85                      cmp.l      d5,d7
[00000d1e] 6704                      beq.s      _symevclr_3
[00000d20] 7e01                      moveq.l    #1,d7
[00000d22] 6002                      bra.s      _symevclr_4
_symevclr_3:
[00000d24] 7e00                      moveq.l    #0,d7
_symevclr_4:
[00000d26] 2e87                      move.l     d7,(a7)
[00000d28] 2f2d 0004                 move.l     4(a5),-(a7)
[00000d2c] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000d30] 4eb9 0000 0f14            jsr        _evpost
[00000d36] 508f                      addq.l     #8,a7
[00000d38] 60c4                      bra.s      _symevclr_1

_symevget:
[00000d3a] 4e56 fffc                 link       a6,#-4
[00000d3e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000d42] 2a6e 0008                 movea.l    8(a6),a5
[00000d46] 2e95                      move.l     (a5),(a7)
[00000d48] 4eb9 0000 0000            jsr        _mapmsd
[00000d4e] 2d47 fffc                 move.l     d7,-4(a6)
[00000d52] 672c                      beq.s      _symevget_1
[00000d54] 2ead 0004                 move.l     4(a5),(a7)
[00000d58] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000d5c] 4eb9 0000 06e2            jsr        _chkev
[00000d62] 588f                      addq.l     #4,a7
[00000d64] 2847                      movea.l    d7,a4
[00000d66] 2e0c                      move.l     a4,d7
[00000d68] 660e                      bne.s      _symevget_2
[00000d6a] 4878 03e8                 pea.l      ($000003E8).w
[00000d6e] 4eb9 0000 0000            jsr        _uerror
[00000d74] 588f                      addq.l     #4,a7
[00000d76] 6008                      bra.s      _symevget_1
_symevget_2:
[00000d78] 7e00                      moveq.l    #0,d7
[00000d7a] 3e2c 0004                 move.w     4(a4),d7
[00000d7e] 2a87                      move.l     d7,(a5)
_symevget_1:
[00000d80] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000d84] 4e5e                      unlk       a6
[00000d86] 4e75                      rts

_symevmon:
[00000d88] 4e56 fff4                 link       a6,#-12
[00000d8c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000d90] 226e 0008                 movea.l    8(a6),a1
[00000d94] 2e91                      move.l     (a1),(a7)
[00000d96] 4eb9 0000 0000            jsr        _mapmsd
[00000d9c] 2a47                      movea.l    d7,a5
[00000d9e] 2e0d                      move.l     a5,d7
[00000da0] 672a                      beq.s      _symevmon_1
[00000da2] 4878 000a                 pea.l      ($0000000A).w
[00000da6] 486e fff6                 pea.l      -10(a6)
[00000daa] 226e 0008                 movea.l    8(a6),a1
[00000dae] 2f29 0004                 move.l     4(a1),-(a7)
[00000db2] 4eb9 0000 0000            jsr        _inbuf
[00000db8] 4fef 000c                 lea.l      12(a7),a7
[00000dbc] 4a87                      tst.l      d7
[00000dbe] 6714                      beq.s      _symevmon_2
[00000dc0] 4878 000e                 pea.l      ($0000000E).w
[00000dc4] 4eb9 0000 0000            jsr        _uerror
[00000dca] 588f                      addq.l     #4,a7
_symevmon_1:
[00000dcc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000dd0] 4e5e                      unlk       a6
[00000dd2] 4e75                      rts
_symevmon_2:
[00000dd4] 3e2e fff6                 move.w     -10(a6),d7
[00000dd8] 48c7                      ext.l      d7
[00000dda] 2e87                      move.l     d7,(a7)
[00000ddc] 2f0d                      move.l     a5,-(a7)
[00000dde] 4eb9 0000 06e2            jsr        _chkev
[00000de4] 588f                      addq.l     #4,a7
[00000de6] 2647                      movea.l    d7,a3
[00000de8] 2e0b                      move.l     a3,d7
[00000dea] 660e                      bne.s      _symevmon_3
[00000dec] 4878 03e8                 pea.l      ($000003E8).w
[00000df0] 4eb9 0000 0000            jsr        _uerror
[00000df6] 588f                      addq.l     #4,a7
[00000df8] 60d2                      bra.s      _symevmon_1
_symevmon_3:
[00000dfa] 3e2e fffe                 move.w     -2(a6),d7
[00000dfe] 48c7                      ext.l      d7
[00000e00] 2e87                      move.l     d7,(a7)
[00000e02] 3e2e fff6                 move.w     -10(a6),d7
[00000e06] 48c7                      ext.l      d7
[00000e08] 2f07                      move.l     d7,-(a7)
[00000e0a] 2f0d                      move.l     a5,-(a7)
[00000e0c] 4eb9 0000 0ed0            jsr        _findemon
[00000e12] 508f                      addq.l     #8,a7
[00000e14] 2847                      movea.l    d7,a4
[00000e16] 2e0c                      move.l     a4,d7
[00000e18] 6728                      beq.s      _symevmon_4
[00000e1a] 3e2e fffa                 move.w     -6(a6),d7
[00000e1e] 0247 0007                 andi.w     #$0007,d7
[00000e22] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000e28] 664a                      bne.s      _symevmon_5
[00000e2a] 486d 0024                 pea.l      36(a5)
[00000e2e] 2f0b                      move.l     a3,-(a7)
[00000e30] 2f0c                      move.l     a4,-(a7)
[00000e32] 4878 000a                 pea.l      ($0000000A).w
[00000e36] 4eb9 0000 0000            jsr        _hfrelst
[00000e3c] 4fef 0010                 lea.l      16(a7),a7
[00000e40] 6026                      bra.s      _symevmon_6
_symevmon_4:
[00000e42] 486d 0024                 pea.l      36(a5)
[00000e46] 42a7                      clr.l      -(a7)
[00000e48] 4878 000a                 pea.l      ($0000000A).w
[00000e4c] 4eb9 0000 0000            jsr        _halloc
[00000e52] 4fef 000c                 lea.l      12(a7),a7
[00000e56] 2847                      movea.l    d7,a4
[00000e58] 2e0c                      move.l     a4,d7
[00000e5a] 6614                      bne.s      _symevmon_7
[00000e5c] 4878 03ec                 pea.l      ($000003EC).w
[00000e60] 4eb9 0000 0000            jsr        _uerror
[00000e66] 588f                      addq.l     #4,a7
_symevmon_6:
[00000e68] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000e6c] 4e5e                      unlk       a6
[00000e6e] 4e75                      rts
_symevmon_7:
[00000e70] 2893                      move.l     (a3),(a4)
[00000e72] 268c                      move.l     a4,(a3)
_symevmon_5:
[00000e74] 396e fffe 0004            move.w     -2(a6),4(a4)
[00000e7a] 396e fff8 0006            move.w     -8(a6),6(a4)
[00000e80] 7e57                      moveq.l    #87,d7
[00000e82] 7c00                      moveq.l    #0,d6
[00000e84] 3c2e fffa                 move.w     -6(a6),d6
[00000e88] ce86                      and.l      d6,d7
[00000e8a] 3947 0008                 move.w     d7,8(a4)
[00000e8e] 082e 0003 fffb            btst       #3,-5(a6)
[00000e94] 670c                      beq.s      _symevmon_8
[00000e96] 3d6b 0004 fff4            move.w     4(a3),-12(a6)
[00000e9c] 376e fffc 0004            move.w     -4(a6),4(a3)
_symevmon_8:
[00000ea2] 082e 0005 fffb            btst       #5,-5(a6)
[00000ea8] 6624                      bne.s      _symevmon_9
[00000eaa] 3e2b 0004                 move.w     4(a3),d7
[00000eae] be6e fff4                 cmp.w      -12(a6),d7
[00000eb2] 6704                      beq.s      _symevmon_10
[00000eb4] 7e01                      moveq.l    #1,d7
[00000eb6] 6002                      bra.s      _symevmon_11
_symevmon_10:
[00000eb8] 7e00                      moveq.l    #0,d7
_symevmon_11:
[00000eba] 2e87                      move.l     d7,(a7)
[00000ebc] 3e2e fff6                 move.w     -10(a6),d7
[00000ec0] 48c7                      ext.l      d7
[00000ec2] 2f07                      move.l     d7,-(a7)
[00000ec4] 2f0d                      move.l     a5,-(a7)
[00000ec6] 4eb9 0000 0f14            jsr        _evpost
[00000ecc] 508f                      addq.l     #8,a7
_symevmon_9:
[00000ece] 6098                      bra.s      _symevmon_6

_findemon:
[00000ed0] 4e56 0000                 link       a6,#0
[00000ed4] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000ed8] 2a2e 0010                 move.l     16(a6),d5
[00000edc] 226e 0008                 movea.l    8(a6),a1
[00000ee0] 2269 0020                 movea.l    32(a1),a1
[00000ee4] 2eae 000c                 move.l     12(a6),(a7)
[00000ee8] 4878 0006                 pea.l      ($00000006).w
[00000eec] 4eb9 0000 0000            jsr        a~lmul
[00000ef2] 2e17                      move.l     (a7),d7
[00000ef4] 2a71 7800                 movea.l    0(a1,d7.l),a5
_findemon_2:
[00000ef8] 2e0d                      move.l     a5,d7
[00000efa] 670e                      beq.s      _findemon_1
[00000efc] 3e2d 0004                 move.w     4(a5),d7
[00000f00] 48c7                      ext.l      d7
[00000f02] be85                      cmp.l      d5,d7
[00000f04] 6704                      beq.s      _findemon_1
[00000f06] 2a55                      movea.l    (a5),a5
[00000f08] 60ee                      bra.s      _findemon_2
_findemon_1:
[00000f0a] 2e0d                      move.l     a5,d7
[00000f0c] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000f10] 4e5e                      unlk       a6
[00000f12] 4e75                      rts

_evpost:
[00000f14] 4e56 fffa                 link       a6,#-6
[00000f18] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000f1c] 2a6e 0008                 movea.l    8(a6),a5
[00000f20] 2eae 000c                 move.l     12(a6),(a7)
[00000f24] 4878 0006                 pea.l      ($00000006).w
[00000f28] 4eb9 0000 0000            jsr        a~lmul
[00000f2e] 2e17                      move.l     (a7),d7
[00000f30] dead 0020                 add.l      32(a5),d7
[00000f34] 2847                      movea.l    d7,a4
[00000f36] 3d6c 0004 fffa            move.w     4(a4),-6(a6)
[00000f3c] 2654                      movea.l    (a4),a3
_evpost_5:
[00000f3e] 2e0b                      move.l     a3,d7
[00000f40] 6700 008e                 beq        _evpost_1
[00000f44] 4aae 0010                 tst.l      16(a6)
[00000f48] 6608                      bne.s      _evpost_2
[00000f4a] 082b 0004 0009            btst       #4,9(a3)
[00000f50] 6778                      beq.s      _evpost_3
_evpost_2:
[00000f52] 7e07                      moveq.l    #7,d7
[00000f54] 7c00                      moveq.l    #0,d6
[00000f56] 3c2b 0008                 move.w     8(a3),d6
[00000f5a] ce86                      and.l      d6,d7
[00000f5c] 2e87                      move.l     d7,(a7)
[00000f5e] 7e00                      moveq.l    #0,d7
[00000f60] 3e2b 0006                 move.w     6(a3),d7
[00000f64] 2f07                      move.l     d7,-(a7)
[00000f66] 7e00                      moveq.l    #0,d7
[00000f68] 3e2e fffa                 move.w     -6(a6),d7
[00000f6c] 2f07                      move.l     d7,-(a7)
[00000f6e] 4eb9 0000 0fd8            jsr        _eeval
[00000f74] 508f                      addq.l     #8,a7
[00000f76] 4a87                      tst.l      d7
[00000f78] 6750                      beq.s      _evpost_3
[00000f7a] 4297                      clr.l      (a7)
[00000f7c] 7e00                      moveq.l    #0,d7
[00000f7e] 3e2c 0004                 move.w     4(a4),d7
[00000f82] 2f07                      move.l     d7,-(a7)
[00000f84] 42a7                      clr.l      -(a7)
[00000f86] 3e2b 0004                 move.w     4(a3),d7
[00000f8a] 48c7                      ext.l      d7
[00000f8c] 2f07                      move.l     d7,-(a7)
[00000f8e] 2f0d                      move.l     a5,-(a7)
[00000f90] 4eb9 0000 1806            jsr        _msend
[00000f96] 4fef 0010                 lea.l      16(a7),a7
[00000f9a] 082b 0006 0009            btst       #6,9(a3)
[00000fa0] 6722                      beq.s      _evpost_4
[00000fa2] 2d4b fffc                 move.l     a3,-4(a6)
[00000fa6] 2653                      movea.l    (a3),a3
[00000fa8] 486d 0024                 pea.l      36(a5)
[00000fac] 2f0c                      move.l     a4,-(a7)
[00000fae] 2f2e fffc                 move.l     -4(a6),-(a7)
[00000fb2] 4878 000a                 pea.l      ($0000000A).w
[00000fb6] 4eb9 0000 0000            jsr        _hfrelst
[00000fbc] 4fef 0010                 lea.l      16(a7),a7
[00000fc0] 6000 ff7c                 bra        _evpost_5
_evpost_4:
[00000fc4] 2653                      movea.l    (a3),a3
[00000fc6] 6000 ff76                 bra        _evpost_5
_evpost_3:
[00000fca] 2653                      movea.l    (a3),a3
[00000fcc] 6000 ff70                 bra        _evpost_5
_evpost_1:
[00000fd0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000fd4] 4e5e                      unlk       a6
[00000fd6] 4e75                      rts

_eeval:
[00000fd8] 4e56 fff4                 link       a6,#-12
[00000fdc] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00000fe0] 2a2e 0008                 move.l     8(a6),d5
[00000fe4] 282e 000c                 move.l     12(a6),d4
[00000fe8] 2e2e 0010                 move.l     16(a6),d7
[00000fec] 41f9 0000 1bac            lea.l      $000036BE,a0
[00000ff2] 4ef9 0000 0000            jmp        a~jtab
[00000ff8] 2e04                      move.l     d4,d7
[00000ffa] ce85                      and.l      d5,d7
[00000ffc] be84                      cmp.l      d4,d7
[00000ffe] 6604                      bne.s      _eeval_1
[00001000] 7e01                      moveq.l    #1,d7
[00001002] 6002                      bra.s      _eeval_2
_eeval_1:
[00001004] 7e00                      moveq.l    #0,d7
_eeval_2:
[00001006] 2d47 fffc                 move.l     d7,-4(a6)
[0000100a] 6078                      bra.s      _eeval_3
[0000100c] 2e04                      move.l     d4,d7
[0000100e] ce85                      and.l      d5,d7
[00001010] 2d47 fffc                 move.l     d7,-4(a6)
[00001014] 606e                      bra.s      _eeval_3
[00001016] 2e05                      move.l     d5,d7
[00001018] 4687                      not.l      d7
[0000101a] 2a07                      move.l     d7,d5
[0000101c] ca84                      and.l      d4,d5
[0000101e] 7801                      moveq.l    #1,d4
[00001020] 426e fff8                 clr.w      -8(a6)
[00001024] 3d7c 0010 fffa            move.w     #$0010,-6(a6)
_eeval_6:
[0000102a] 536e fffa                 subq.w     #1,-6(a6)
[0000102e] 6d0e                      blt.s      _eeval_4
[00001030] 2e05                      move.l     d5,d7
[00001032] ce84                      and.l      d4,d7
[00001034] 6704                      beq.s      _eeval_5
[00001036] 526e fff8                 addq.w     #1,-8(a6)
_eeval_5:
[0000103a] e384                      asl.l      #1,d4
[0000103c] 60ec                      bra.s      _eeval_6
_eeval_4:
[0000103e] 0c6e 0001 fff8            cmpi.w     #$0001,-8(a6)
[00001044] 6604                      bne.s      _eeval_7
[00001046] 7e01                      moveq.l    #1,d7
[00001048] 6002                      bra.s      _eeval_8
_eeval_7:
[0000104a] 7e00                      moveq.l    #0,d7
_eeval_8:
[0000104c] 2d47 fffc                 move.l     d7,-4(a6)
[00001050] 6032                      bra.s      _eeval_3
[00001052] 7001                      moveq.l    #1,d0
[00001054] 2d40 fffc                 move.l     d0,-4(a6)
[00001058] 602a                      bra.s      _eeval_3
[0000105a] 2e04                      move.l     d4,d7
[0000105c] ce85                      and.l      d5,d7
[0000105e] be84                      cmp.l      d4,d7
[00001060] 6704                      beq.s      _eeval_9
[00001062] 7e01                      moveq.l    #1,d7
[00001064] 6002                      bra.s      _eeval_10
_eeval_9:
[00001066] 7e00                      moveq.l    #0,d7
_eeval_10:
[00001068] 2d47 fffc                 move.l     d7,-4(a6)
[0000106c] 6016                      bra.s      _eeval_3
[0000106e] 2e04                      move.l     d4,d7
[00001070] ce85                      and.l      d5,d7
[00001072] 6604                      bne.s      _eeval_11
[00001074] 7e01                      moveq.l    #1,d7
[00001076] 6002                      bra.s      _eeval_12
_eeval_11:
[00001078] 7e00                      moveq.l    #0,d7
_eeval_12:
[0000107a] 2d47 fffc                 move.l     d7,-4(a6)
[0000107e] 6004                      bra.s      _eeval_3
[00001080] 42ae fffc                 clr.l      -4(a6)
_eeval_3:
[00001084] 2e2e fffc                 move.l     -4(a6),d7
[00001088] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000108c] 4e5e                      unlk       a6
[0000108e] 4e75                      rts

_symevset:
[00001090] 4e56 fffa                 link       a6,#-6
[00001094] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001098] 2a6e 0008                 movea.l    8(a6),a5
[0000109c] 2e95                      move.l     (a5),(a7)
[0000109e] 4eb9 0000 0000            jsr        _mapmsd
[000010a4] 2d47 fffc                 move.l     d7,-4(a6)
[000010a8] 6754                      beq.s      _symevset_1
[000010aa] 2ead 0004                 move.l     4(a5),(a7)
[000010ae] 2f2e fffc                 move.l     -4(a6),-(a7)
[000010b2] 4eb9 0000 06e2            jsr        _chkev
[000010b8] 588f                      addq.l     #4,a7
[000010ba] 2847                      movea.l    d7,a4
[000010bc] 2e0c                      move.l     a4,d7
[000010be] 660e                      bne.s      _symevset_2
[000010c0] 4878 03e8                 pea.l      ($000003E8).w
[000010c4] 4eb9 0000 0000            jsr        _uerror
[000010ca] 588f                      addq.l     #4,a7
[000010cc] 6030                      bra.s      _symevset_1
_symevset_2:
[000010ce] 3d6c 0004 fffa            move.w     4(a4),-6(a6)
[000010d4] 2e2d 0008                 move.l     8(a5),d7
[000010d8] 8f6c 0004                 or.w       d7,4(a4)
[000010dc] 3e2c 0004                 move.w     4(a4),d7
[000010e0] be6e fffa                 cmp.w      -6(a6),d7
[000010e4] 6704                      beq.s      _symevset_3
[000010e6] 7e01                      moveq.l    #1,d7
[000010e8] 6002                      bra.s      _symevset_4
_symevset_3:
[000010ea] 7e00                      moveq.l    #0,d7
_symevset_4:
[000010ec] 2e87                      move.l     d7,(a7)
[000010ee] 2f2d 0004                 move.l     4(a5),-(a7)
[000010f2] 2f2e fffc                 move.l     -4(a6),-(a7)
[000010f6] 4eb9 0000 0f14            jsr        _evpost
[000010fc] 508f                      addq.l     #8,a7
_symevset_1:
[000010fe] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001102] 4e5e                      unlk       a6
[00001104] 4e75                      rts

_symfree:
[00001106] 4e56 fff6                 link       a6,#-10
[0000110a] 226e 0008                 movea.l    8(a6),a1
[0000110e] 2e91                      move.l     (a1),(a7)
[00001110] 4eb9 0000 0000            jsr        _mapmsd
[00001116] 2d47 fffc                 move.l     d7,-4(a6)
[0000111a] 6730                      beq.s      _symfree_1
[0000111c] 226e 0008                 movea.l    8(a6),a1
[00001120] 2ea9 0008                 move.l     8(a1),(a7)
[00001124] 226e 0008                 movea.l    8(a6),a1
[00001128] 2f29 0004                 move.l     4(a1),-(a7)
[0000112c] 2f2e fffc                 move.l     -4(a6),-(a7)
[00001130] 4eb9 0000 0340            jsr        _mbfree
[00001136] 508f                      addq.l     #8,a7
[00001138] 3d47 fffa                 move.w     d7,-6(a6)
[0000113c] 670e                      beq.s      _symfree_1
[0000113e] 3e2e fffa                 move.w     -6(a6),d7
[00001142] 48c7                      ext.l      d7
[00001144] 2e87                      move.l     d7,(a7)
[00001146] 4eb9 0000 0000            jsr        _uerror
_symfree_1:
[0000114c] 4e5e                      unlk       a6
[0000114e] 4e75                      rts

_symgetbuf:
[00001150] 4e56 0000                 link       a6,#0
[00001154] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001158] 2a6e 0008                 movea.l    8(a6),a5
[0000115c] 2e95                      move.l     (a5),(a7)
[0000115e] 4eb9 0000 0000            jsr        _mapmsd
[00001164] 2847                      movea.l    d7,a4
[00001166] 2e0c                      move.l     a4,d7
[00001168] 6722                      beq.s      _symgetbuf_1
_symgetbuf_4:
[0000116a] 4eb9 0000 0000            jsr        _curpid
[00001170] 2e87                      move.l     d7,(a7)
[00001172] 2f2d 0004                 move.l     4(a5),-(a7)
[00001176] 2f0c                      move.l     a4,-(a7)
[00001178] 4eb9 0000 03c4            jsr        _mballoc
[0000117e] 508f                      addq.l     #8,a7
[00001180] 2a07                      move.l     d7,d5
[00001182] 6606                      bne.s      _symgetbuf_2
[00001184] 4aad 0008                 tst.l      8(a5)
[00001188] 660a                      bne.s      _symgetbuf_3
_symgetbuf_2:
[0000118a] 2a85                      move.l     d5,(a5)
_symgetbuf_1:
[0000118c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001190] 4e5e                      unlk       a6
[00001192] 4e75                      rts
_symgetbuf_3:
[00001194] 08ec 0004 00a7            bset       #4,167(a4)
[0000119a] 486c 0014                 pea.l      20(a4)
[0000119e] 4878 0001                 pea.l      ($00000001).w
[000011a2] 486c 000c                 pea.l      12(a4)
[000011a6] 4eb9 0000 0000            jsr        _sleepl
[000011ac] 4fef 000c                 lea.l      12(a7),a7
[000011b0] 60b8                      bra.s      _symgetbuf_4

_symgetprm:
[000011b2] 4e56 fff8                 link       a6,#-8
[000011b6] 226e 0008                 movea.l    8(a6),a1
[000011ba] 2e91                      move.l     (a1),(a7)
[000011bc] 4eb9 0000 0000            jsr        _mapmsd
[000011c2] 2d47 fffc                 move.l     d7,-4(a6)
[000011c6] 6604                      bne.s      _symgetprm_1
[000011c8] 4e5e                      unlk       a6
[000011ca] 4e75                      rts
_symgetprm_1:
[000011cc] 226e 0008                 movea.l    8(a6),a1
[000011d0] 2e29 0004                 move.l     4(a1),d7
[000011d4] 41f9 0000 1bdc            lea.l      $000036EE,a0
[000011da] 4ef9 0000 0000            jmp        a~jtab
[000011e0] 226e 0008                 movea.l    8(a6),a1
[000011e4] 246e fffc                 movea.l    -4(a6),a2
[000011e8] 7e00                      moveq.l    #0,d7
[000011ea] 3e2a 009a                 move.w     154(a2),d7
[000011ee] 2287                      move.l     d7,(a1)
[000011f0] 6054                      bra.s      _symgetprm_2
[000011f2] 226e 0008                 movea.l    8(a6),a1
[000011f6] 246e fffc                 movea.l    -4(a6),a2
[000011fa] 7e00                      moveq.l    #0,d7
[000011fc] 3e2a 00a0                 move.w     160(a2),d7
[00001200] 2287                      move.l     d7,(a1)
[00001202] 6042                      bra.s      _symgetprm_2
[00001204] 226e 0008                 movea.l    8(a6),a1
[00001208] 246e fffc                 movea.l    -4(a6),a2
[0000120c] 7e00                      moveq.l    #0,d7
[0000120e] 3e2a 0096                 move.w     150(a2),d7
[00001212] 2287                      move.l     d7,(a1)
[00001214] 6030                      bra.s      _symgetprm_2
[00001216] 226e 0008                 movea.l    8(a6),a1
[0000121a] 246e fffc                 movea.l    -4(a6),a2
[0000121e] 7e00                      moveq.l    #0,d7
[00001220] 3e2a 00a4                 move.w     164(a2),d7
[00001224] 2287                      move.l     d7,(a1)
[00001226] 601e                      bra.s      _symgetprm_2
[00001228] 226e 0008                 movea.l    8(a6),a1
[0000122c] 246e fffc                 movea.l    -4(a6),a2
[00001230] 7e00                      moveq.l    #0,d7
[00001232] 3e2a 009c                 move.w     156(a2),d7
[00001236] 2287                      move.l     d7,(a1)
[00001238] 600c                      bra.s      _symgetprm_2
[0000123a] 4878 03ee                 pea.l      ($000003EE).w
[0000123e] 4eb9 0000 0000            jsr        _uerror
[00001244] 588f                      addq.l     #4,a7
_symgetprm_2:
[00001246] 4e5e                      unlk       a6
[00001248] 4e75                      rts

_symreceive:
[0000124a] 4e56 fff4                 link       a6,#-12
[0000124e] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001252] 2a6e 0008                 movea.l    8(a6),a5
[00001256] 43ee fff4                 lea.l      -12(a6),a1
[0000125a] 2a09                      move.l     a1,d5
[0000125c] 2e95                      move.l     (a5),(a7)
[0000125e] 4eb9 0000 0000            jsr        _mapmsd
[00001264] 2647                      movea.l    d7,a3
[00001266] 2e0b                      move.l     a3,d7
[00001268] 671a                      beq.s      _symreceive_1
[0000126a] 2e8b                      move.l     a3,(a7)
[0000126c] 4eb9 0000 0836            jsr        _findmp
[00001272] 2847                      movea.l    d7,a4
[00001274] 2e0c                      move.l     a4,d7
[00001276] 6614                      bne.s      _symreceive_2
[00001278] 4878 03ef                 pea.l      ($000003EF).w
[0000127c] 4eb9 0000 0000            jsr        _uerror
[00001282] 588f                      addq.l     #4,a7
_symreceive_1:
[00001284] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001288] 4e5e                      unlk       a6
[0000128a] 4e75                      rts
_symreceive_2:
[0000128c] 082d 0004 000b            btst       #4,11(a5)
[00001292] 6716                      beq.s      _symreceive_3
[00001294] 4878 000c                 pea.l      ($0000000C).w
[00001298] 2f05                      move.l     d5,-(a7)
[0000129a] 2f2d 0004                 move.l     4(a5),-(a7)
[0000129e] 4eb9 0000 0000            jsr        _inbuf
[000012a4] 4fef 000c                 lea.l      12(a7),a7
[000012a8] 6004                      bra.s      _symreceive_4
_symreceive_3:
[000012aa] 2245                      movea.l    d5,a1
[000012ac] 4291                      clr.l      (a1)
_symreceive_4:
[000012ae] 2245                      movea.l    d5,a1
[000012b0] 5889                      addq.l     #4,a1
[000012b2] 4291                      clr.l      (a1)
[000012b4] 2245                      movea.l    d5,a1
[000012b6] 5089                      addq.l     #8,a1
[000012b8] 4291                      clr.l      (a1)
_symreceive_8:
[000012ba] 2245                      movea.l    d5,a1
[000012bc] 5889                      addq.l     #4,a1
[000012be] 1e2c 0014                 move.b     20(a4),d7
[000012c2] 4887                      ext.w      d7
[000012c4] 48c7                      ext.l      d7
[000012c6] 2287                      move.l     d7,(a1)
[000012c8] 6712                      beq.s      _symreceive_5
[000012ca] 082d 0001 000b            btst       #1,11(a5)
[000012d0] 6604                      bne.s      _symreceive_6
[000012d2] 422c 0014                 clr.b      20(a4)
_symreceive_6:
[000012d6] 2245                      movea.l    d5,a1
[000012d8] 4291                      clr.l      (a1)
[000012da] 6042                      bra.s      _symreceive_7
_symreceive_5:
[000012dc] 7e02                      moveq.l    #2,d7
[000012de] cead 0008                 and.l      8(a5),d7
[000012e2] 2e87                      move.l     d7,(a7)
[000012e4] 2f05                      move.l     d5,-(a7)
[000012e6] 2245                      movea.l    d5,a1
[000012e8] 2f11                      move.l     (a1),-(a7)
[000012ea] 2f0c                      move.l     a4,-(a7)
[000012ec] 2f0b                      move.l     a3,-(a7)
[000012ee] 4eb9 0000 072e            jsr        _findm
[000012f4] 4fef 0010                 lea.l      16(a7),a7
[000012f8] 4a87                      tst.l      d7
[000012fa] 6622                      bne.s      _symreceive_7
[000012fc] 082d 0000 000b            btst       #0,11(a5)
[00001302] 671a                      beq.s      _symreceive_7
[00001304] 522c 0015                 addq.b     #1,21(a4)
[00001308] 486c 000c                 pea.l      12(a4)
[0000130c] 4878 0001                 pea.l      ($00000001).w
[00001310] 2f0c                      move.l     a4,-(a7)
[00001312] 4eb9 0000 0000            jsr        _sleepl
[00001318] 4fef 000c                 lea.l      12(a7),a7
[0000131c] 609c                      bra.s      _symreceive_8
_symreceive_7:
[0000131e] 4878 000c                 pea.l      ($0000000C).w
[00001322] 2f2d 0004                 move.l     4(a5),-(a7)
[00001326] 2f05                      move.l     d5,-(a7)
[00001328] 4eb9 0000 0000            jsr        _outbuf
[0000132e] 4fef 000c                 lea.l      12(a7),a7
[00001332] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00001336] 4e5e                      unlk       a6
[00001338] 4e75                      rts

_symrelbuf:
[0000133a] 4e56 fff8                 link       a6,#-8
[0000133e] 226e 0008                 movea.l    8(a6),a1
[00001342] 2e91                      move.l     (a1),(a7)
[00001344] 4eb9 0000 0000            jsr        _mapmsd
[0000134a] 2d47 fffc                 move.l     d7,-4(a6)
[0000134e] 6716                      beq.s      _symrelbuf_1
[00001350] 4297                      clr.l      (a7)
[00001352] 226e 0008                 movea.l    8(a6),a1
[00001356] 2f29 0004                 move.l     4(a1),-(a7)
[0000135a] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000135e] 4eb9 0000 04c4            jsr        _mbchown
[00001364] 508f                      addq.l     #8,a7
_symrelbuf_1:
[00001366] 4e5e                      unlk       a6
[00001368] 4e75                      rts

_symremove:
[0000136a] 4e56 fff8                 link       a6,#-8
[0000136e] 226e 0008                 movea.l    8(a6),a1
[00001372] 2e91                      move.l     (a1),(a7)
[00001374] 4eb9 0000 0000            jsr        _mapmsd
[0000137a] 2d47 fffc                 move.l     d7,-4(a6)
[0000137e] 670a                      beq.s      _symremove_1
[00001380] 226e fffc                 movea.l    -4(a6),a1
[00001384] 08e9 0000 009d            bset       #0,157(a1)
_symremove_1:
[0000138a] 4e5e                      unlk       a6
[0000138c] 4e75                      rts

_symsend:
[0000138e] 4e56 ffe4                 link       a6,#-28
[00001392] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001396] 4aae 0008                 tst.l      8(a6)
[0000139a] 6610                      bne.s      _symsend_1
[0000139c] 2d6e 000c 0008            move.l     12(a6),8(a6)
[000013a2] 226e 0008                 movea.l    8(a6),a1
[000013a6] 2d51 fff0                 move.l     (a1),-16(a6)
[000013aa] 6010                      bra.s      _symsend_2
_symsend_1:
[000013ac] 226e 0008                 movea.l    8(a6),a1
[000013b0] 2e91                      move.l     (a1),(a7)
[000013b2] 4eb9 0000 0000            jsr        _mapmsd
[000013b8] 2d47 fff0                 move.l     d7,-16(a6)
_symsend_2:
[000013bc] 226e 0008                 movea.l    8(a6),a1
[000013c0] 2a29 0010                 move.l     16(a1),d5
[000013c4] 4aae fff0                 tst.l      -16(a6)
[000013c8] 6740                      beq.s      _symsend_3
[000013ca] 226e 0008                 movea.l    8(a6),a1
[000013ce] 2ea9 0004                 move.l     4(a1),(a7)
[000013d2] 2f2e fff0                 move.l     -16(a6),-(a7)
[000013d6] 4eb9 0000 06b8            jsr        _chkchan
[000013dc] 588f                      addq.l     #4,a7
[000013de] 4a87                      tst.l      d7
[000013e0] 6630                      bne.s      _symsend_4
[000013e2] 7e0e                      moveq.l    #14,d7
[000013e4] ce85                      and.l      d5,d7
[000013e6] 6616                      bne.s      _symsend_5
[000013e8] 4297                      clr.l      (a7)
[000013ea] 226e 0008                 movea.l    8(a6),a1
[000013ee] 2f29 0008                 move.l     8(a1),-(a7)
[000013f2] 2f2e fff0                 move.l     -16(a6),-(a7)
[000013f6] 4eb9 0000 04c4            jsr        _mbchown
[000013fc] 508f                      addq.l     #8,a7
_symsend_5:
[000013fe] 4878 03e9                 pea.l      ($000003E9).w
[00001402] 4eb9 0000 0000            jsr        _uerror
[00001408] 588f                      addq.l     #4,a7
_symsend_3:
[0000140a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000140e] 4e5e                      unlk       a6
[00001410] 4e75                      rts
_symsend_4:
[00001412] 226e fff0                 movea.l    -16(a6),a1
[00001416] 2e29 001c                 move.l     28(a1),d7
[0000141a] 226e 0008                 movea.l    8(a6),a1
[0000141e] 2c29 0004                 move.l     4(a1),d6
[00001422] e786                      asl.l      #3,d6
[00001424] de86                      add.l      d6,d7
[00001426] 2d47 fffc                 move.l     d7,-4(a6)
[0000142a] 0805 0001                 btst       #1,d5
[0000142e] 6716                      beq.s      _symsend_6
[00001430] 226e fffc                 movea.l    -4(a6),a1
[00001434] 4a91                      tst.l      (a1)
[00001436] 660c                      bne.s      _symsend_7
[00001438] 4878 03ef                 pea.l      ($000003EF).w
[0000143c] 4eb9 0000 0000            jsr        _uerror
[00001442] 588f                      addq.l     #4,a7
_symsend_7:
[00001444] 60c4                      bra.s      _symsend_3
_symsend_6:
[00001446] 0805 0000                 btst       #0,d5
[0000144a] 6606                      bne.s      _symsend_8
[0000144c] 42ae ffe8                 clr.l      -24(a6)
[00001450] 6054                      bra.s      _symsend_9
_symsend_8:
[00001452] 7e24                      moveq.l    #36,d7
[00001454] deae fff0                 add.l      -16(a6),d7
[00001458] 2e87                      move.l     d7,(a7)
[0000145a] 42a7                      clr.l      -(a7)
[0000145c] 4878 0006                 pea.l      ($00000006).w
[00001460] 4eb9 0000 0000            jsr        _halloc
[00001466] 508f                      addq.l     #8,a7
[00001468] 2d47 ffe8                 move.l     d7,-24(a6)
[0000146c] 6630                      bne.s      _symsend_10
[0000146e] 7e0e                      moveq.l    #14,d7
[00001470] ce85                      and.l      d5,d7
[00001472] 6616                      bne.s      _symsend_11
[00001474] 4297                      clr.l      (a7)
[00001476] 226e 0008                 movea.l    8(a6),a1
[0000147a] 2f29 0008                 move.l     8(a1),-(a7)
[0000147e] 2f2e fff0                 move.l     -16(a6),-(a7)
[00001482] 4eb9 0000 04c4            jsr        _mbchown
[00001488] 508f                      addq.l     #8,a7
_symsend_11:
[0000148a] 4878 03ec                 pea.l      ($000003EC).w
[0000148e] 4eb9 0000 0000            jsr        _uerror
[00001494] 588f                      addq.l     #4,a7
[00001496] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000149a] 4e5e                      unlk       a6
[0000149c] 4e75                      rts
_symsend_10:
[0000149e] 226e ffe8                 movea.l    -24(a6),a1
[000014a2] 4269 0004                 clr.w      4(a1)
_symsend_9:
[000014a6] 2d7c 0000 03ef ffe4       move.l     #$000003EF,-28(a6)
[000014ae] 426e fff8                 clr.w      -8(a6)
[000014b2] 226e fffc                 movea.l    -4(a6),a1
[000014b6] 2851                      movea.l    (a1),a4
_symsend_15:
[000014b8] 2e0c                      move.l     a4,d7
[000014ba] 6700 0100                 beq        _symsend_12
[000014be] 226e 0008                 movea.l    8(a6),a1
[000014c2] 4aa9 0008                 tst.l      8(a1)
[000014c6] 6710                      beq.s      _symsend_13
[000014c8] 0805 0002                 btst       #2,d5
[000014cc] 6642                      bne.s      _symsend_14
[000014ce] 4a94                      tst.l      (a4)
[000014d0] 663e                      bne.s      _symsend_14
[000014d2] 6004                      bra.s      _symsend_13
_symsend_17:
[000014d4] 2854                      movea.l    (a4),a4
[000014d6] 60e0                      bra.s      _symsend_15
_symsend_13:
[000014d8] 226e 0008                 movea.l    8(a6),a1
[000014dc] 2d69 0008 ffec            move.l     8(a1),-20(a6)
_symsend_19:
[000014e2] 2e85                      move.l     d5,(a7)
[000014e4] 2f2e ffe8                 move.l     -24(a6),-(a7)
[000014e8] 226e 0008                 movea.l    8(a6),a1
[000014ec] 2f29 000c                 move.l     12(a1),-(a7)
[000014f0] 2f2e ffec                 move.l     -20(a6),-(a7)
[000014f4] 2f0c                      move.l     a4,-(a7)
[000014f6] 2f2e fff0                 move.l     -16(a6),-(a7)
[000014fa] 4eb9 0000 16d4            jsr        _minject
[00001500] 4fef 0014                 lea.l      20(a7),a7
[00001504] 2d47 ffe4                 move.l     d7,-28(a6)
[00001508] 6678                      bne.s      _symsend_16
[0000150a] 526e fff8                 addq.w     #1,-8(a6)
[0000150e] 60c4                      bra.s      _symsend_17
_symsend_14:
[00001510] 4eb9 0000 0000            jsr        _curpid
[00001516] 2e87                      move.l     d7,(a7)
[00001518] 226e 0008                 movea.l    8(a6),a1
[0000151c] 2f29 000c                 move.l     12(a1),-(a7)
[00001520] 2f2e fff0                 move.l     -16(a6),-(a7)
[00001524] 4eb9 0000 03c4            jsr        _mballoc
[0000152a] 508f                      addq.l     #8,a7
[0000152c] 2d47 ffec                 move.l     d7,-20(a6)
[00001530] 6734                      beq.s      _symsend_18
[00001532] 226e 0008                 movea.l    8(a6),a1
[00001536] 2ea9 000c                 move.l     12(a1),(a7)
[0000153a] 2f2e ffec                 move.l     -20(a6),-(a7)
[0000153e] 4eb9 0000 0000            jsr        _mapbuf
[00001544] 588f                      addq.l     #4,a7
[00001546] 2f07                      move.l     d7,-(a7)
[00001548] 226e 0008                 movea.l    8(a6),a1
[0000154c] 2f29 0008                 move.l     8(a1),-(a7)
[00001550] 4eb9 0000 0000            jsr        _mapbuf
[00001556] 588f                      addq.l     #4,a7
[00001558] 2f07                      move.l     d7,-(a7)
[0000155a] 4eb9 0000 0000            jsr        __movmem
[00001560] 508f                      addq.l     #8,a7
[00001562] 6000 ff7e                 bra        _symsend_19
_symsend_18:
[00001566] 70ff                      moveq.l    #-1,d0
[00001568] 2d40 ffec                 move.l     d0,-20(a6)
[0000156c] 0805 0005                 btst       #5,d5
[00001570] 6600 ff70                 bne        _symsend_19
[00001574] 226c 0004                 movea.l    4(a4),a1
[00001578] 08e9 0000 0014            bset       #0,20(a1)
[0000157e] 6000 ff62                 bra        _symsend_19
_symsend_16:
[00001582] 4aae ffec                 tst.l      -20(a6)
[00001586] 6700 ff4c                 beq        _symsend_17
[0000158a] 226e 0008                 movea.l    8(a6),a1
[0000158e] 2e29 0008                 move.l     8(a1),d7
[00001592] beae ffec                 cmp.l      -20(a6),d7
[00001596] 6700 ff3c                 beq        _symsend_17
[0000159a] 0cae ffff ffff ffec       cmpi.l     #$FFFFFFFF,-20(a6)
[000015a2] 6700 ff30                 beq        _symsend_17
[000015a6] 4297                      clr.l      (a7)
[000015a8] 2f2e ffec                 move.l     -20(a6),-(a7)
[000015ac] 2f2e fff0                 move.l     -16(a6),-(a7)
[000015b0] 4eb9 0000 04c4            jsr        _mbchown
[000015b6] 508f                      addq.l     #8,a7
[000015b8] 6000 ff1a                 bra        _symsend_17
_symsend_12:
[000015bc] 4a6e fff8                 tst.w      -8(a6)
[000015c0] 673a                      beq.s      _symsend_20
[000015c2] 4aae ffe8                 tst.l      -24(a6)
[000015c6] 672c                      beq.s      _symsend_21
[000015c8] 2eae ffe8                 move.l     -24(a6),(a7)
[000015cc] 4878 0001                 pea.l      ($00000001).w
[000015d0] 2f2e ffe8                 move.l     -24(a6),-(a7)
[000015d4] 4eb9 0000 0000            jsr        _sleepl
[000015da] 508f                      addq.l     #8,a7
[000015dc] 4297                      clr.l      (a7)
[000015de] 2f2e ffe8                 move.l     -24(a6),-(a7)
[000015e2] 4878 0006                 pea.l      ($00000006).w
[000015e6] 2f2e fff0                 move.l     -16(a6),-(a7)
[000015ea] 4eb9 0000 086a            jsr        _msfree
[000015f0] 4fef 000c                 lea.l      12(a7),a7
_symsend_21:
[000015f4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000015f8] 4e5e                      unlk       a6
[000015fa] 4e75                      rts
_symsend_20:
[000015fc] 0805 0005                 btst       #5,d5
[00001600] 6700 009a                 beq        _symsend_22
[00001604] 2e2e ffe4                 move.l     -28(a6),d7
[00001608] 41f9 0000 1c04            lea.l      $00003716,a0
[0000160e] 4ef9 0000 0000            jmp        a~jtab
[00001614] 2e2e fffc                 move.l     -4(a6),d7
[00001618] 2f07                      move.l     d7,-(a7)
[0000161a] 5897                      addq.l     #4,(a7)
[0000161c] 4878 0001                 pea.l      ($00000001).w
[00001620] 226e 0008                 movea.l    8(a6),a1
[00001624] 2f29 0004                 move.l     4(a1),-(a7)
[00001628] 4eb9 0000 0000            jsr        _sleepl
[0000162e] 4fef 000c                 lea.l      12(a7),a7
[00001632] 604e                      bra.s      _symsend_23
[00001634] 226e fff0                 movea.l    -16(a6),a1
[00001638] 08e9 0003 00a7            bset       #3,167(a1)
[0000163e] 7e14                      moveq.l    #20,d7
[00001640] deae fff0                 add.l      -16(a6),d7
[00001644] 2e87                      move.l     d7,(a7)
[00001646] 4878 0001                 pea.l      ($00000001).w
[0000164a] 7e24                      moveq.l    #36,d7
[0000164c] deae fff0                 add.l      -16(a6),d7
[00001650] 2f07                      move.l     d7,-(a7)
[00001652] 4eb9 0000 0000            jsr        _sleepl
[00001658] 508f                      addq.l     #8,a7
[0000165a] 6026                      bra.s      _symsend_23
[0000165c] 226e fff0                 movea.l    -16(a6),a1
[00001660] 08e9 0004 00a7            bset       #4,167(a1)
[00001666] 7e14                      moveq.l    #20,d7
[00001668] deae fff0                 add.l      -16(a6),d7
[0000166c] 2e87                      move.l     d7,(a7)
[0000166e] 4878 0001                 pea.l      ($00000001).w
[00001672] 7e0c                      moveq.l    #12,d7
[00001674] deae fff0                 add.l      -16(a6),d7
[00001678] 2f07                      move.l     d7,-(a7)
[0000167a] 4eb9 0000 0000            jsr        _sleepl
[00001680] 508f                      addq.l     #8,a7
_symsend_23:
[00001682] 226e fff0                 movea.l    -16(a6),a1
[00001686] 2251                      movea.l    (a1),a1
[00001688] 4a91                      tst.l      (a1)
[0000168a] 6600 fe1a                 bne        _symsend_9
[0000168e] 4878 03f0                 pea.l      ($000003F0).w
[00001692] 4eb9 0000 0000            jsr        _uerror
[00001698] 588f                      addq.l     #4,a7
[0000169a] 6030                      bra.s      _symsend_24
_symsend_22:
[0000169c] 7e0c                      moveq.l    #12,d7
[0000169e] ce85                      and.l      d5,d7
[000016a0] 6620                      bne.s      _symsend_25
[000016a2] 226e 0008                 movea.l    8(a6),a1
[000016a6] 4aa9 0008                 tst.l      8(a1)
[000016aa] 6716                      beq.s      _symsend_25
[000016ac] 4297                      clr.l      (a7)
[000016ae] 226e 0008                 movea.l    8(a6),a1
[000016b2] 2f29 0008                 move.l     8(a1),-(a7)
[000016b6] 2f2e fff0                 move.l     -16(a6),-(a7)
[000016ba] 4eb9 0000 04c4            jsr        _mbchown
[000016c0] 508f                      addq.l     #8,a7
_symsend_25:
[000016c2] 2eae ffe4                 move.l     -28(a6),(a7)
[000016c6] 4eb9 0000 0000            jsr        _uerror
_symsend_24:
[000016cc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000016d0] 4e5e                      unlk       a6
[000016d2] 4e75                      rts

_minject:
[000016d4] 4e56 fffc                 link       a6,#-4
[000016d8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000016dc] 2a6e 000c                 movea.l    12(a6),a5
[000016e0] 2d6d 0004 fffc            move.l     4(a5),-4(a6)
[000016e6] 3e2d 0008                 move.w     8(a5),d7
[000016ea] be6d 000a                 cmp.w      10(a5),d7
[000016ee] 6624                      bne.s      _minject_1
[000016f0] 082e 0005 001f            btst       #5,31(a6)
[000016f6] 6708                      beq.s      _minject_2
[000016f8] 3e3c 03f3                 move.w     #$03F3,d7
[000016fc] 48c7                      ext.l      d7
[000016fe] 6052                      bra.s      _minject_3
_minject_2:
[00001700] 3a3c 03f3                 move.w     #$03F3,d5
[00001704] 48c5                      ext.l      d5
[00001706] 226e fffc                 movea.l    -4(a6),a1
[0000170a] 08e9 0004 0014            bset       #4,20(a1)
[00001710] 6000 00c4                 bra        _minject_4
_minject_1:
[00001714] 0cae ffff ffff 0010       cmpi.l     #$FFFFFFFF,16(a6)
[0000171c] 660a                      bne.s      _minject_5
[0000171e] 3a3c 03f2                 move.w     #$03F2,d5
[00001722] 48c5                      ext.l      d5
[00001724] 6000 00b0                 bra        _minject_4
_minject_5:
[00001728] 7e24                      moveq.l    #36,d7
[0000172a] deae 0008                 add.l      8(a6),d7
[0000172e] 2e87                      move.l     d7,(a7)
[00001730] 42a7                      clr.l      -(a7)
[00001732] 4878 0014                 pea.l      ($00000014).w
[00001736] 4eb9 0000 0000            jsr        _halloc
[0000173c] 508f                      addq.l     #8,a7
[0000173e] 2847                      movea.l    d7,a4
[00001740] 2e0c                      move.l     a4,d7
[00001742] 6628                      bne.s      _minject_6
[00001744] 082e 0005 001f            btst       #5,31(a6)
[0000174a] 670e                      beq.s      _minject_7
[0000174c] 3e3c 03ec                 move.w     #$03EC,d7
[00001750] 48c7                      ext.l      d7
_minject_3:
[00001752] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001756] 4e5e                      unlk       a6
[00001758] 4e75                      rts
_minject_7:
[0000175a] 3a3c 03ec                 move.w     #$03EC,d5
[0000175e] 48c5                      ext.l      d5
[00001760] 226e fffc                 movea.l    -4(a6),a1
[00001764] 08e9 0003 0014            bset       #3,20(a1)
[0000176a] 606a                      bra.s      _minject_4
_minject_6:
[0000176c] 296e 0010 0008            move.l     16(a6),8(a4)
[00001772] 671c                      beq.s      _minject_8
[00001774] 226e fffc                 movea.l    -4(a6),a1
[00001778] 3e29 0010                 move.w     16(a1),d7
[0000177c] 48c7                      ext.l      d7
[0000177e] 2e87                      move.l     d7,(a7)
[00001780] 2f2e 0010                 move.l     16(a6),-(a7)
[00001784] 2f2e 0008                 move.l     8(a6),-(a7)
[00001788] 4eb9 0000 04c4            jsr        _mbchown
[0000178e] 508f                      addq.l     #8,a7
_minject_8:
[00001790] 296e 0014 000c            move.l     20(a6),12(a4)
[00001796] 294d 0010                 move.l     a5,16(a4)
[0000179a] 296e 0018 0004            move.l     24(a6),4(a4)
[000017a0] 6708                      beq.s      _minject_9
[000017a2] 226e 0018                 movea.l    24(a6),a1
[000017a6] 5269 0004                 addq.w     #1,4(a1)
_minject_9:
[000017aa] 226e fffc                 movea.l    -4(a6),a1
[000017ae] 4aa9 0004                 tst.l      4(a1)
[000017b2] 660a                      bne.s      _minject_10
[000017b4] 226e fffc                 movea.l    -4(a6),a1
[000017b8] 234c 0004                 move.l     a4,4(a1)
[000017bc] 600a                      bra.s      _minject_11
_minject_10:
[000017be] 226e fffc                 movea.l    -4(a6),a1
[000017c2] 2269 0008                 movea.l    8(a1),a1
[000017c6] 228c                      move.l     a4,(a1)
_minject_11:
[000017c8] 226e fffc                 movea.l    -4(a6),a1
[000017cc] 234c 0008                 move.l     a4,8(a1)
[000017d0] 526d 0008                 addq.w     #1,8(a5)
[000017d4] 7a00                      moveq.l    #0,d5
_minject_4:
[000017d6] 226e fffc                 movea.l    -4(a6),a1
[000017da] 4a29 0015                 tst.b      21(a1)
[000017de] 671c                      beq.s      _minject_12
[000017e0] 226e fffc                 movea.l    -4(a6),a1
[000017e4] 4229 0015                 clr.b      21(a1)
[000017e8] 7e0c                      moveq.l    #12,d7
[000017ea] deae fffc                 add.l      -4(a6),d7
[000017ee] 2e87                      move.l     d7,(a7)
[000017f0] 2f2e fffc                 move.l     -4(a6),-(a7)
[000017f4] 4eb9 0000 0000            jsr        _wakeupl
[000017fa] 588f                      addq.l     #4,a7
_minject_12:
[000017fc] 2e05                      move.l     d5,d7
[000017fe] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001802] 4e5e                      unlk       a6
[00001804] 4e75                      rts

_msend:
[00001806] 4e56 0000                 link       a6,#0
[0000180a] 486e 0008                 pea.l      8(a6)
[0000180e] 42a7                      clr.l      -(a7)
[00001810] 4eba fb7c                 jsr        _symsend(pc)
[00001814] 508f                      addq.l     #8,a7
[00001816] 7e00                      moveq.l    #0,d7
[00001818] 4e5e                      unlk       a6
[0000181a] 4e75                      rts

_symsetprm:
[0000181c] 4e56 fff6                 link       a6,#-10
[00001820] 226e 0008                 movea.l    8(a6),a1
[00001824] 3d69 000a fffa            move.w     10(a1),-6(a6)
[0000182a] 226e 0008                 movea.l    8(a6),a1
[0000182e] 2e91                      move.l     (a1),(a7)
[00001830] 4eb9 0000 0000            jsr        _mapmsd
[00001836] 2d47 fffc                 move.l     d7,-4(a6)
[0000183a] 6604                      bne.s      _symsetprm_1
[0000183c] 4e5e                      unlk       a6
[0000183e] 4e75                      rts
_symsetprm_1:
[00001840] 226e 0008                 movea.l    8(a6),a1
[00001844] 2e29 0004                 move.l     4(a1),d7
[00001848] 41f9 0000 1c30            lea.l      $00003742,a0
[0000184e] 4ef9 0000 0000            jmp        a~jtab
[00001854] 226e fffc                 movea.l    -4(a6),a1
[00001858] 336e fffa 009a            move.w     -6(a6),154(a1)
[0000185e] 603c                      bra.s      _symsetprm_2
[00001860] 226e fffc                 movea.l    -4(a6),a1
[00001864] 336e fffa 00a0            move.w     -6(a6),160(a1)
[0000186a] 6030                      bra.s      _symsetprm_2
[0000186c] 226e fffc                 movea.l    -4(a6),a1
[00001870] 336e fffa 0096            move.w     -6(a6),150(a1)
[00001876] 6024                      bra.s      _symsetprm_2
[00001878] 226e fffc                 movea.l    -4(a6),a1
[0000187c] 336e fffa 00a4            move.w     -6(a6),164(a1)
[00001882] 6018                      bra.s      _symsetprm_2
[00001884] 226e fffc                 movea.l    -4(a6),a1
[00001888] 336e fffa 009c            move.w     -6(a6),156(a1)
[0000188e] 600c                      bra.s      _symsetprm_2
[00001890] 4878 03ee                 pea.l      ($000003EE).w
[00001894] 4eb9 0000 0000            jsr        _uerror
[0000189a] 588f                      addq.l     #4,a7
_symsetprm_2:
[0000189c] 4e5e                      unlk       a6
[0000189e] 4e75                      rts

_symtimer:
[000018a0] 4e56 fff0                 link       a6,#-16
[000018a4] 0cb9 0000 2800 0000 0000  cmpi.l     #$00002800,_tinc
[000018ae] 6408                      bcc.s      _symtimer_1
[000018b0] 2e3c 0000 2800            move.l     #$00002800,d7
[000018b6] 6006                      bra.s      _symtimer_2
_symtimer_1:
[000018b8] 2e39 0000 0000            move.l     _tinc,d7
_symtimer_2:
[000018be] 23c7 0000 1c58            move.l     d7,$0000376A
[000018c4] 226e 0008                 movea.l    8(a6),a1
[000018c8] 2e91                      move.l     (a1),(a7)
[000018ca] 4eb9 0000 0000            jsr        _mapmsd
[000018d0] 2d47 fffc                 move.l     d7,-4(a6)
[000018d4] 6604                      bne.s      _symtimer_3
[000018d6] 4e5e                      unlk       a6
[000018d8] 4e75                      rts
_symtimer_3:
[000018da] 2e2e fffc                 move.l     -4(a6),d7
[000018de] 2247                      movea.l    d7,a1
[000018e0] 43e9 0084                 lea.l      132(a1),a1
[000018e4] 2d69 000c fff8            move.l     12(a1),-8(a6)
_symtimer_5:
[000018ea] 4aae fff8                 tst.l      -8(a6)
[000018ee] 671e                      beq.s      _symtimer_4
[000018f0] 226e fff8                 movea.l    -8(a6),a1
[000018f4] 3e29 000c                 move.w     12(a1),d7
[000018f8] 48c7                      ext.l      d7
[000018fa] 226e 0008                 movea.l    8(a6),a1
[000018fe] bea9 0004                 cmp.l      4(a1),d7
[00001902] 670a                      beq.s      _symtimer_4
[00001904] 226e fff8                 movea.l    -8(a6),a1
[00001908] 2d51 fff8                 move.l     (a1),-8(a6)
[0000190c] 60dc                      bra.s      _symtimer_5
_symtimer_4:
[0000190e] 4aae fff8                 tst.l      -8(a6)
[00001912] 6706                      beq.s      _symtimer_6
[00001914] 42ae fff4                 clr.l      -12(a6)
[00001918] 6060                      bra.s      _symtimer_7
_symtimer_6:
[0000191a] 7e24                      moveq.l    #36,d7
[0000191c] deae fffc                 add.l      -4(a6),d7
[00001920] 2e87                      move.l     d7,(a7)
[00001922] 42a7                      clr.l      -(a7)
[00001924] 4878 000e                 pea.l      ($0000000E).w
[00001928] 4eb9 0000 0000            jsr        _halloc
[0000192e] 508f                      addq.l     #8,a7
[00001930] 2d47 fff8                 move.l     d7,-8(a6)
[00001934] 6610                      bne.s      _symtimer_8
[00001936] 4878 03ec                 pea.l      ($000003EC).w
[0000193a] 4eb9 0000 0000            jsr        _uerror
[00001940] 588f                      addq.l     #4,a7
[00001942] 4e5e                      unlk       a6
[00001944] 4e75                      rts
_symtimer_8:
[00001946] 226e fff8                 movea.l    -8(a6),a1
[0000194a] 2e2e fffc                 move.l     -4(a6),d7
[0000194e] 2447                      movea.l    d7,a2
[00001950] 45ea 0084                 lea.l      132(a2),a2
[00001954] 22aa 000c                 move.l     12(a2),(a1)
[00001958] 2e2e fffc                 move.l     -4(a6),d7
[0000195c] 2247                      movea.l    d7,a1
[0000195e] 43e9 0084                 lea.l      132(a1),a1
[00001962] 236e fff8 000c            move.l     -8(a6),12(a1)
[00001968] 226e fff8                 movea.l    -8(a6),a1
[0000196c] 4a91                      tst.l      (a1)
[0000196e] 6604                      bne.s      _symtimer_9
[00001970] 7e01                      moveq.l    #1,d7
[00001972] 6002                      bra.s      _symtimer_10
_symtimer_9:
[00001974] 7e00                      moveq.l    #0,d7
_symtimer_10:
[00001976] 2d47 fff4                 move.l     d7,-12(a6)
_symtimer_7:
[0000197a] 226e fff8                 movea.l    -8(a6),a1
[0000197e] 246e 0008                 movea.l    8(a6),a2
[00001982] 336a 0006 000c            move.w     6(a2),12(a1)
[00001988] 226e fff8                 movea.l    -8(a6),a1
[0000198c] 246e 0008                 movea.l    8(a6),a2
[00001990] 2eaa 0008                 move.l     8(a2),(a7)
[00001994] 4878 0266                 pea.l      ($00000266).w
[00001998] 4eb9 0000 0000            jsr        a~lmul
[0000199e] 2e17                      move.l     (a7),d7
[000019a0] 2347 0004                 move.l     d7,4(a1)
[000019a4] 226e fff8                 movea.l    -8(a6),a1
[000019a8] 246e 0008                 movea.l    8(a6),a2
[000019ac] 2eaa 000c                 move.l     12(a2),(a7)
[000019b0] 4878 0266                 pea.l      ($00000266).w
[000019b4] 4eb9 0000 0000            jsr        a~lmul
[000019ba] 2e17                      move.l     (a7),d7
[000019bc] 2347 0008                 move.l     d7,8(a1)
[000019c0] 2e2e fffc                 move.l     -4(a6),d7
[000019c4] 2247                      movea.l    d7,a1
[000019c6] 43e9 0084                 lea.l      132(a1),a1
[000019ca] 237c 0000 1a0e 0004       move.l     #_timer,4(a1)
[000019d2] 2e2e fffc                 move.l     -4(a6),d7
[000019d6] 2247                      movea.l    d7,a1
[000019d8] 43e9 0084                 lea.l      132(a1),a1
[000019dc] 236e fffc 0008            move.l     -4(a6),8(a1)
[000019e2] 4aae fff4                 tst.l      -12(a6)
[000019e6] 6722                      beq.s      _symtimer_11
[000019e8] 226e fffc                 movea.l    -4(a6),a1
[000019ec] 08e9 0002 00a7            bset       #2,167(a1)
[000019f2] 4878 0001                 pea.l      ($00000001).w
[000019f6] 2e2e fffc                 move.l     -4(a6),d7
[000019fa] 2f07                      move.l     d7,-(a7)
[000019fc] 0697 0000 0084            addi.l     #$00000084,(a7)
[00001a02] 4eb9 0000 0000            jsr        _clkout
[00001a08] 508f                      addq.l     #8,a7
_symtimer_11:
[00001a0a] 4e5e                      unlk       a6
[00001a0c] 4e75                      rts

_timer:
[00001a0e] 4e56 0000                 link       a6,#0
[00001a12] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00001a16] 2a6e 0008                 movea.l    8(a6),a5
[00001a1a] 2e39 0000 1c58            move.l     $0000376A,d7
[00001a20] dfb9 0000 1c60            add.l      d7,$00003772
[00001a26] 2e39 0000 1c60            move.l     $00003772,d7
[00001a2c] 7c0b                      moveq.l    #11,d6
[00001a2e] ecaf                      lsr.l      d6,d7
[00001a30] 2807                      move.l     d7,d4
[00001a32] d9b9 0000 1c5c            add.l      d4,$0000376E
[00001a38] 02b9 0000 07ff 0000 1c60  andi.l     #$000007FF,$00003772
[00001a42] 286d 0090                 movea.l    144(a5),a4
_timer_3:
[00001a46] 2e0c                      move.l     a4,d7
[00001a48] 6700 0092                 beq        _timer_1
[00001a4c] 4aac 0008                 tst.l      8(a4)
[00001a50] 6622                      bne.s      _timer_2
[00001a52] 4aac 0004                 tst.l      4(a4)
[00001a56] 661c                      bne.s      _timer_2
[00001a58] 486d 0024                 pea.l      36(a5)
[00001a5c] 486d 0090                 pea.l      144(a5)
[00001a60] 2f0c                      move.l     a4,-(a7)
[00001a62] 4878 000e                 pea.l      ($0000000E).w
[00001a66] 4eb9 0000 0000            jsr        _hfrelst
[00001a6c] 4fef 0010                 lea.l      16(a7),a7
_timer_4:
[00001a70] 2854                      movea.l    (a4),a4
[00001a72] 60d2                      bra.s      _timer_3
_timer_2:
[00001a74] 2e04                      move.l     d4,d7
[00001a76] 7c0b                      moveq.l    #11,d6
[00001a78] eda7                      asl.l      d6,d7
[00001a7a] 9fac 0004                 sub.l      d7,4(a4)
[00001a7e] 6ef0                      bgt.s      _timer_4
[00001a80] 2e2c 0008                 move.l     8(a4),d7
[00001a84] dfac 0004                 add.l      d7,4(a4)
[00001a88] 6c04                      bge.s      _timer_5
[00001a8a] 42ac 0004                 clr.l      4(a4)
_timer_5:
[00001a8e] 4297                      clr.l      (a7)
[00001a90] 2e39 0000 1c5c            move.l     $0000376E,d7
[00001a96] 7c0b                      moveq.l    #11,d6
[00001a98] eda7                      asl.l      d6,d7
[00001a9a] 2f07                      move.l     d7,-(a7)
[00001a9c] 4878 0266                 pea.l      ($00000266).w
[00001aa0] 4eb9 0000 0000            jsr        a~uldiv
[00001aa6] 42a7                      clr.l      -(a7)
[00001aa8] 3e2c 000c                 move.w     12(a4),d7
[00001aac] 48c7                      ext.l      d7
[00001aae] 2f07                      move.l     d7,-(a7)
[00001ab0] 2f0d                      move.l     a5,-(a7)
[00001ab2] 4eb9 0000 1806            jsr        _msend
[00001ab8] 4fef 0010                 lea.l      16(a7),a7
[00001abc] 4aac 0008                 tst.l      8(a4)
[00001ac0] 66ae                      bne.s      _timer_4
[00001ac2] 486d 0024                 pea.l      36(a5)
[00001ac6] 486d 0090                 pea.l      144(a5)
[00001aca] 2f0c                      move.l     a4,-(a7)
[00001acc] 4878 000e                 pea.l      ($0000000E).w
[00001ad0] 4eb9 0000 0000            jsr        _hfrelst
[00001ad6] 4fef 0010                 lea.l      16(a7),a7
[00001ada] 6094                      bra.s      _timer_4
_timer_1:
[00001adc] 082d 0001 00a7            btst       #1,167(a5)
[00001ae2] 6710                      beq.s      _timer_6
[00001ae4] 08ad 0002 00a7            bclr       #2,167(a5)
[00001aea] 2e8d                      move.l     a5,(a7)
[00001aec] 4eb9 0000 0000            jsr        _wakeup
[00001af2] 6016                      bra.s      _timer_7
_timer_6:
[00001af4] 4aad 0090                 tst.l      144(a5)
[00001af8] 6710                      beq.s      _timer_7
[00001afa] 4878 0001                 pea.l      ($00000001).w
[00001afe] 486d 0084                 pea.l      132(a5)
[00001b02] 4eb9 0000 0000            jsr        _clkout
[00001b08] 508f                      addq.l     #8,a7
_timer_7:
[00001b0a] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00001b0e] 4e5e                      unlk       a6
[00001b10] 4e75                      rts

	.data
[00001b12]                           dc.b $00
[00001b13]                           dc.b $86
[00001b14]                           dc.w $1029
[00001b16]                           dc.b $00
[00001b17]                           dc.b $00
[00001b18] 00000194                  dc.l _msgopen
[00001b1c] 000000a8                  dc.l _msgclose
[00001b20] 00000000                  dc.l _nodev
[00001b24] 00001b44                  dc.l $00001b44 ; no symbol found
[00001b28] 00001b56                  dc.l $00001b56 ; no symbol found
[00001b2c] 00000194                  dc.l _msgopen
[00001b30] 000000a8                  dc.l _msgclose
[00001b34] 00000226                  dc.l _msgread
[00001b38] 00000000                  dc.l _nodev
[00001b3c] 00000000                  dc.l _nodev
[00001b40] 00001b69                  dc.l $00001b69 ; no symbol found
[00001b44]                           dc.b $00
[00001b45]                           dc.b $00
[00001b46]                           dc.b $00
[00001b47]                           dc.b $00
[00001b48]                           dc.b $00
[00001b49]                           dc.b $00
[00001b4a]                           dc.b $00
[00001b4b]                           dc.b $00
[00001b4c]                           dc.b $00
[00001b4d]                           dc.b $00
[00001b4e]                           dc.b $00
[00001b4f]                           dc.b $00
[00001b50]                           dc.b $00
[00001b51]                           dc.b $00
[00001b52]                           dc.b $00
[00001b53]                           dc.b $00
[00001b54]                           dc.b $00
[00001b55]                           dc.b $00
[00001b56]                           dc.b 'msg msg2 msg3 msg4',0
[00001b69]                           dc.b 'rmsg rmsg2 rmsg3 rmsg4',0
[00001b80]                           dc.b $00
[00001b81]                           dc.b $00
[00001b82]                           dc.b $00
[00001b83]                           dc.b $00
[00001b84]                           dc.b $00
[00001b85]                           dc.b $00
[00001b86]                           dc.b $00
[00001b87]                           dc.b $00
[00001b88]                           dc.b $00
[00001b89]                           dc.b $00
[00001b8a]                           dc.b $00
[00001b8b]                           dc.b $00
[00001b8c]                           dc.b $00
[00001b8d]                           dc.b $00
[00001b8e]                           dc.b $00
[00001b8f]                           dc.b $00
[00001b90]                           dc.b $00
[00001b91]                           dc.b $00
[00001b92]                           dc.b $00
[00001b93]                           dc.b $00
[00001b94]                           dc.b $00
[00001b95]                           dc.b $00
[00001b96]                           dc.b $00
[00001b97]                           dc.b $00
[00001b98]                           dc.b 'MBFREE!',$0a,0
[00001ba1]                           dc.b 'MBALLOC!',$0a,0
[00001bab]                           dc.b $00
[00001bac]                           dc.b $00
[00001bad]                           dc.b $00
[00001bae]                           dc.b $00
[00001baf]                           dc.b $07
[00001bb0]                           dc.b $00
[00001bb1]                           dc.b $00
[00001bb2]                           dc.b $00
[00001bb3]                           dc.b $01
[00001bb4] 00000ff8                  dc.l $00000ff8 ; no symbol found
[00001bb8] 0000100c                  dc.l $0000100c ; no symbol found
[00001bbc] 0000101c                  dc.l $0000101c ; no symbol found
[00001bc0] 00001052                  dc.l $00001052 ; no symbol found
[00001bc4] 0000105a                  dc.l $0000105a ; no symbol found
[00001bc8] 0000106e                  dc.l $0000106e ; no symbol found
[00001bcc] 00001016                  dc.l $00001016 ; no symbol found
[00001bd0]                           dc.b $00
[00001bd1]                           dc.b $00
[00001bd2]                           dc.b $00
[00001bd3]                           dc.b $00
[00001bd4]                           dc.b $00
[00001bd5]                           dc.b $00
[00001bd6]                           dc.b $00
[00001bd7]                           dc.b $00
[00001bd8] 00001080                  dc.l $00001080 ; no symbol found
[00001bdc]                           dc.b $00
[00001bdd]                           dc.b $00
[00001bde]                           dc.b $00
[00001bdf]                           dc.b $05
[00001be0]                           dc.b $00
[00001be1]                           dc.b $00
[00001be2]                           dc.b $00
[00001be3]                           dc.b $01
[00001be4] 000011e0                  dc.l $000011e0 ; no symbol found
[00001be8] 000011f2                  dc.l $000011f2 ; no symbol found
[00001bec] 00001204                  dc.l $00001204 ; no symbol found
[00001bf0] 00001216                  dc.l $00001216 ; no symbol found
[00001bf4] 00001228                  dc.l $00001228 ; no symbol found
[00001bf8]                           dc.b $00
[00001bf9]                           dc.b $00
[00001bfa]                           dc.b $00
[00001bfb]                           dc.b $00
[00001bfc]                           dc.b $00
[00001bfd]                           dc.b $00
[00001bfe]                           dc.b $00
[00001bff]                           dc.b $00
[00001c00] 0000123a                  dc.l $0000123a ; no symbol found
[00001c04]                           dc.b $00
[00001c05]                           dc.b $00
[00001c06]                           dc.b $00
[00001c07]                           dc.b $00
[00001c08]                           dc.b $00
[00001c09]                           dc.b $00
[00001c0a]                           dc.b $00
[00001c0b]                           dc.b $04
[00001c0c] 00001634                  dc.l $00001634 ; no symbol found
[00001c10]                           dc.b $00
[00001c11]                           dc.b $00
[00001c12]                           dc.w $03ec
[00001c14] 00001614                  dc.l $00001614 ; no symbol found
[00001c18]                           dc.b $00
[00001c19]                           dc.b $00
[00001c1a]                           dc.w $03ef
[00001c1c] 0000165c                  dc.l $0000165c ; no symbol found
[00001c20]                           dc.b $00
[00001c21]                           dc.b $00
[00001c22]                           dc.w $03f2
[00001c24] 00001614                  dc.l $00001614 ; no symbol found
[00001c28]                           dc.b $00
[00001c29]                           dc.b $00
[00001c2a]                           dc.w $03f3
[00001c2c] 00001682                  dc.l $00001682 ; no symbol found
[00001c30]                           dc.b $00
[00001c31]                           dc.b $00
[00001c32]                           dc.b $00
[00001c33]                           dc.b $05
[00001c34]                           dc.b $00
[00001c35]                           dc.b $00
[00001c36]                           dc.b $00
[00001c37]                           dc.b $01
[00001c38] 00001854                  dc.l $00001854 ; no symbol found
[00001c3c] 00001860                  dc.l $00001860 ; no symbol found
[00001c40] 0000186c                  dc.l $0000186c ; no symbol found
[00001c44] 00001878                  dc.l $00001878 ; no symbol found
[00001c48] 00001884                  dc.l $00001884 ; no symbol found
[00001c4c]                           dc.b $00
[00001c4d]                           dc.b $00
[00001c4e]                           dc.b $00
[00001c4f]                           dc.b $00
[00001c50]                           dc.b $00
[00001c51]                           dc.b $00
[00001c52]                           dc.b $00
[00001c53]                           dc.b $00
[00001c54] 00001890                  dc.l $00001890 ; no symbol found
[00001c58]                           dc.b $00
[00001c59]                           dc.b $00
[00001c5a]                           dc.b $00
[00001c5b]                           dc.b $00
[00001c5c]                           dc.b $00
[00001c5d]                           dc.b $00
[00001c5e]                           dc.b $00
[00001c5f]                           dc.b $00
[00001c60]                           dc.b $00
[00001c61]                           dc.b $00
[00001c62]                           dc.b $00
[00001c63]                           dc.b $00
[00001c64]                           dc.b $00
[00001c65]                           dc.b $00
[00001c66]                           dc.b $00
[00001c67]                           dc.b $00
;
         U _uerror
         U _nodev
         U _sleep
         U _outbuf
         U _alloc
         U _mapfd
         U _iocount
         U _ioseek
         U a~lmul
         U _iobase
         U _movio
         U _free
         U _putfmt
         U _hfree
         U _curpid
         U _wakeupl
         U _halloc
         U a~uldiv
         U _hfrelst
         U _hinit
         U a~pushstr
         U _inbuf
         U a~jtab
         U _sleepl
         U _mapbuf
         U __movmem
         U _clkout
         U _wakeup
         U _tinc
00000000 T _mapmsd
000000a8 T _msgclose
00000194 T _msgopen
00000226 T _msgread
00000340 T _mbfree
000003c4 T _mballoc
00000492 T _mbgran
000004c4 T _mbchown
000005ae T _bufree
000005f8 T _cdiscon
000006b8 T _chkchan
000006e2 T _chkev
0000072e T _findm
00000800 T _findmcon
00000836 T _findmp
0000086a T _msfree
000008b6 T _msfrelst
00000902 T _symnone
00000910 T _symconnect
00000ada T _symcreat
00000c5c T _symdiscon
00000cc2 T _symevclr
00000d3a T _symevget
00000d88 T _symevmon
00000ed0 T _findemon
00000f14 T _evpost
00000fd8 T _eeval
00001090 T _symevset
00001106 T _symfree
00001150 T _symgetbuf
000011b2 T _symgetprm
0000124a T _symreceive
0000133a T _symrelbuf
0000136a T _symremove
0000138e T _symsend
000016d4 T _minject
00001806 T _msend
0000181c T _symsetprm
000018a0 T _symtimer
00001a0e T _timer
00003624 D __mdate
00003628 D __mversion
0000362a D _msgbdev
0000363e D _msgcdev
00003656 D _msgtab
00003668 D _nmmsg
0000367b D _nmrmsg
;
; a.out Relocations:
0000000e: 00000000 _mapfd
00000042: 00000000 _uerror
00000070: 00000000 a~lmul
00000078: 00001b12
00000086: 00000000 _uerror
00000098: 00000000 a~lmul
000000a0: 00001b12
000000c2: 00000000 a~lmul
000000ca: 00001b12
000000dc: 00000000
00000108: 00000000
00000116: 00000000
0000014a: 00000000 _sleep
00000170: 00000000 _free
00000182: 00000000 _free
000001b0: 00000000 a~lmul
000001b8: 00001b12
000001cc: 00000000 _uerror
000001e6: 00000000 _alloc
000001f8: 00000000 _uerror
00000240: 00000000 a~lmul
00000248: 00001b12
0000025c: 00000000 _uerror
0000028e: 00000000 _iocount
000002a0: 00000000 _uerror
000002b0: 00000000 _ioseek
000002ba: 00000000 _outbuf
000002c4: 00000000 _iobase
000002d0: 00000000 _movio
000002da: 00000000 _ioseek
000002e8: 00000000 _iocount
000002fc: 00000000 _outbuf
00000306: 00000000 _iobase
00000310: 00000000 _movio
0000031a: 00000000 _outbuf
00000324: 00000000 _iobase
00000330: 00000000 _movio
00000376: 00000000 _halloc
00000392: 00000000 _curpid
000003a8: 00000000
000003b2: 00001b12
000003b8: 00000000 _putfmt
000003da: 00000000
00000434: 00000000 _halloc
00000442: 00001b12
00000448: 00000000 _putfmt
000004a8: 00000000 a~uldiv
000004b2: 00000000 a~lmul
000004fe: 00000000 _curpid
00000542: 00000000 _hfree
0000057e: 00000000 _hfree
000005a0: 00000000 _wakeupl
000005b8: 00000000 _curpid
000005e2: 00000000
00000610: 00000000
0000062c: 00000000
00000652: 00000000
00000668: 00000000
0000068c: 00000000
000006ac: 00000000
0000070c: 00000000 a~lmul
0000071e: 00000000 _uerror
0000079c: 00000000 _wakeupl
000007ce: 00000000
000007ec: 00000000 _wakeupl
00000840: 00000000 _curpid
0000088e: 00000000 _wakeupl
000008a6: 00000000 _hfree
000008da: 00000000 _wakeupl
000008f2: 00000000 _hfrelst
00000908: 00000000 _uerror
0000092a: 00000000
00000940: 00000000
00000950: 00000000 _uerror
00000962: 00000000
0000097a: 00000000
00000996: 00000000 _uerror
000009be: 00000000 _halloc
000009d2: 00000000 _uerror
00000a00: 00000000 _hfree
00000a0e: 00000000 _uerror
00000a2a: 00000000 _halloc
00000a48: 00000000 _hfree
00000a56: 00000000 _uerror
00000a74: 00000000 _curpid
00000acc: 00000000 _wakeupl
00000aea: 00000000
00000b02: 00000000 _uerror
00000b28: 00000000 _alloc
00000b3a: 00000000 _uerror
00000b54: 00000000 _hinit
00000b6c: 00000000 _hfree
00000b8a: 00000000 _halloc
00000bac: 00000000 a~lmul
00000bb8: 00000000 _halloc
00000bd2: 00000000 _free
00000be2: 00000000 _uerror
00000c68: 00000000
00000c7e: 00000000 a~pushstr
00000c88: 00000000
00000c96: 00000000
00000cba: 00000000 _uerror
00000cd2: 00000000
00000ce6: 00000000
00000cf8: 00000000 _uerror
00000d32: 00000000
00000d4a: 00000000
00000d5e: 00000000
00000d70: 00000000 _uerror
00000d98: 00000000
00000db4: 00000000 _inbuf
00000dc6: 00000000 _uerror
00000de0: 00000000
00000df2: 00000000 _uerror
00000e0e: 00000000
00000e38: 00000000 _hfrelst
00000e4e: 00000000 _halloc
00000e62: 00000000 _uerror
00000ec8: 00000000
00000eee: 00000000 a~lmul
00000f2a: 00000000 a~lmul
00000f70: 00000000
00000f92: 00000000
00000fb8: 00000000 _hfrelst
00000fee: 00001b12
00000ff4: 00000000 a~jtab
000010a0: 00000000
000010b4: 00000000
000010c6: 00000000 _uerror
000010f8: 00000000
00001112: 00000000
00001132: 00000000
00001148: 00000000 _uerror
00001160: 00000000
0000116c: 00000000 _curpid
0000117a: 00000000
000011a8: 00000000 _sleepl
000011be: 00000000
000011d6: 00001b12
000011dc: 00000000 a~jtab
00001240: 00000000 _uerror
00001260: 00000000
0000126e: 00000000
0000127e: 00000000 _uerror
000012a0: 00000000 _inbuf
000012f0: 00000000
00001314: 00000000 _sleepl
0000132a: 00000000 _outbuf
00001346: 00000000
00001360: 00000000
00001376: 00000000
000013b4: 00000000
000013d8: 00000000
000013f8: 00000000
00001404: 00000000 _uerror
0000143e: 00000000 _uerror
00001462: 00000000 _halloc
00001484: 00000000
00001490: 00000000 _uerror
000014fc: 00000000
00001512: 00000000 _curpid
00001526: 00000000
00001540: 00000000 _mapbuf
00001552: 00000000 _mapbuf
0000155c: 00000000 __movmem
000015b2: 00000000
000015d6: 00000000 _sleepl
000015ec: 00000000
0000160a: 00001b12
00001610: 00000000 a~jtab
0000162a: 00000000 _sleepl
00001654: 00000000 _sleepl
0000167c: 00000000 _sleepl
00001694: 00000000 _uerror
000016bc: 00000000
000016c8: 00000000 _uerror
00001738: 00000000 _halloc
0000178a: 00000000
000017f6: 00000000 _wakeupl
00001832: 00000000
0000184a: 00001b12
00001850: 00000000 a~jtab
00001896: 00000000 _uerror
000018aa: 00000000 _tinc
000018ba: 00000000 _tinc
000018c0: 00001b12
000018cc: 00000000
0000192a: 00000000 _halloc
0000193c: 00000000 _uerror
0000199a: 00000000 a~lmul
000019b6: 00000000 a~lmul
000019cc: 00000000
00001a04: 00000000 _clkout
00001a1c: 00001b12
00001a22: 00001b12
00001a28: 00001b12
00001a34: 00001b12
00001a3e: 00001b12
00001a68: 00000000 _hfrelst
00001a92: 00001b12
00001aa2: 00000000 a~uldiv
00001ab4: 00000000
00001ad2: 00000000 _hfrelst
00001aee: 00000000 _wakeup
00001b04: 00000000 _clkout
00001b18: 00000000
00001b1c: 00000000
00001b20: 00000000 _nodev
00001b24: 00001b12
00001b28: 00001b12
00001b2c: 00000000
00001b30: 00000000
00001b34: 00000000
00001b38: 00000000 _nodev
00001b3c: 00000000 _nodev
00001b40: 00001b12
00001bb4: 00000000
00001bb8: 00000000
00001bbc: 00000000
00001bc0: 00000000
00001bc4: 00000000
00001bc8: 00000000
00001bcc: 00000000
00001bd8: 00000000
00001be4: 00000000
00001be8: 00000000
00001bec: 00000000
00001bf0: 00000000
00001bf4: 00000000
00001c00: 00000000
00001c0c: 00000000
00001c14: 00000000
00001c1c: 00000000
00001c24: 00000000
00001c2c: 00000000
00001c38: 00000000
00001c3c: 00000000
00001c40: 00000000
00001c44: 00000000
00001c48: 00000000
00001c54: 00000000
