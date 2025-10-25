; a_magic   = 0x9928
; a_text    = 0x0000029c
; a_data    = 0x00000288
; a_bss     = 0x00000000
; a_syms    = 0x00000544
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x000000ac@0x00000a84


_csw:
[00000000] 2e39 0000 0012            move.l     __cpu,d7
[00000006] 4e75                      rts

_exit:
[00000008] 4e56 fffc                 link       a6,#-4
[0000000c] 2ebc 0000 024b            move.l     #$000004E7,(a7)
[00000012] 4eb9 0000 001c            jsr        _panic
[00000018] 4e5e                      unlk       a6
[0000001a] 4e75                      rts

_panic:
[0000001c] 4e56 fffc                 link       a6,#-4
[00000020] 2eae 0008                 move.l     8(a6),(a7)
[00000024] 2f3c 0000 0250            move.l     #$000004EC,-(a7)
[0000002a] 4eb9 0000 0000            jsr        _putfmt
[00000030] 588f                      addq.l     #4,a7
[00000032] 4eb9 0000 0000            jsr        _sync
_panic_1:
[00000038] 4eb9 0000 0000            jsr        _idloop
[0000003e] 60f8                      bra.s      _panic_1

_syuser:
[00000040] 4e56 0000                 link       a6,#0
[00000044] 226e 0008                 movea.l    8(a6),a1
[00000048] 4291                      clr.l      (a1)
[0000004a] 4e5e                      unlk       a6
[0000004c] 4e75                      rts

x4e:
[0000004e] 4e75                      rts

x50:
[00000050] 4e56 0000                 link       a6,#0
[00000054] 48e7 001c                 movem.l    a3-a5,-(a7)
[00000058] 9bcd                      suba.l     a5,a5
[0000005a] 286e 0008                 movea.l    8(a6),a4
[0000005e] 267c 0000 01e8            movea.l    #_where,a3
x50_5:
[00000064] 4a13                      tst.b      (a3)
[00000066] 671e                      beq.s      x50_1
[00000068] 1e13                      move.b     (a3),d7
[0000006a] be14                      cmp.b      (a4),d7
[0000006c] 660a                      bne.s      x50_2
[0000006e] 2e0d                      move.l     a5,d7
[00000070] 6602                      bne.s      x50_3
[00000072] 2a4b                      movea.l    a3,a5
x50_3:
[00000074] 528c                      addq.l     #1,a4
[00000076] 600a                      bra.s      x50_4
x50_2:
[00000078] 4a14                      tst.b      (a4)
[0000007a] 670a                      beq.s      x50_1
[0000007c] 9bcd                      suba.l     a5,a5
[0000007e] 286e 0008                 movea.l    8(a6),a4
x50_4:
[00000082] 528b                      addq.l     #1,a3
[00000084] 60de                      bra.s      x50_5
x50_1:
[00000086] 2e0d                      move.l     a5,d7
[00000088] 670e                      beq.s      x50_6
[0000008a] 4aae 000c                 tst.l      12(a6)
[0000008e] 6704                      beq.s      x50_7
[00000090] 7e2b                      moveq.l    #43,d7
[00000092] 6002                      bra.s      x50_8
x50_7:
[00000094] 7e2d                      moveq.l    #45,d7
x50_8:
[00000096] 1a87                      move.b     d7,(a5)
x50_6:
[00000098] 4cdf 3800                 movem.l    (a7)+,a3-a5
[0000009c] 4e5e                      unlk       a6
[0000009e] 4e75                      rts

_main:
[000000a0] 4e56 fffc                 link       a6,#-4
[000000a4] 4ab9 0000 0000            tst.l      _bootflg
[000000aa] 661e                      bne.s      _main_1
[000000ac] 33fc 0400 0000 006e       move.w     #$0400,_rootdev
[000000b4] 4279 0000 0070            clr.w      _pipedev
[000000ba] 4279 0000 0072            clr.w      _swapdev
[000000c0] 7001                      moveq.l    #1,d0
[000000c2] 23c0 0000 0078            move.l     d0,_rootro
[000000c8] 6022                      bra.s      _main_2
_main_1:
[000000ca] 0cb9 0000 0046 0000 0000  cmpi.l     #$00000046,_bootflg
[000000d4] 6408                      bcc.s      _main_3
[000000d6] 4279 0000 0072            clr.w      _swapdev
[000000dc] 600e                      bra.s      _main_2
_main_3:
[000000de] 7eba                      moveq.l    #-70,d7
[000000e0] deb9 0000 0000            add.l      _bootflg,d7
[000000e6] 33c7 0000 0076            move.w     d7,_swapsiz
_main_2:
[000000ec] 33fc 001e 0000 0000       move.w     #$001E,_schrate
[000000f4] 33fc 0002 0000 0000       move.w     #$0002,_minquan
[000000fc] 4ab9 0000 0000            tst.l      _romsys
[00000102] 670a                      beq.s      _main_4
[00000104] 06b9 0000 07d0 0000 0100  addi.l     #$000007D0,_nheap
_main_4:
[0000010e] 2ebc 0000 0114            move.l     #_svdnib,(a7)
[00000114] 2f3c 0000 0000            move.l     #__memory,-(a7)
[0000011a] 4eb9 0000 0226            jsr        $00000226
[00000120] 588f                      addq.l     #4,a7
[00000122] 0cb9 0000 0002 0000 00f8  cmpi.l     #$00000002,_nbufs
[0000012c] 640a                      bcc.s      _main_5
[0000012e] 2ebc 0000 0261            move.l     #$000004FD,(a7)
[00000134] 4eba fee6                 jsr        _panic(pc)
_main_5:
[00000138] 2e39 0000 001e            move.l     _exuser,d7
[0000013e] 7c09                      moveq.l    #9,d6
[00000140] ecaf                      lsr.l      d6,d7
[00000142] 33c7 0000 0000            move.w     d7,_exbase
[00000148] 2e39 0000 0000            move.l     _systop,d7
[0000014e] 7c09                      moveq.l    #9,d6
[00000150] ecaf                      lsr.l      d6,d7
[00000152] 33c7 0000 0000            move.w     d7,_lopage
[00000158] 2e39 0000 0000            move.l     _memtop,d7
[0000015e] 7c09                      moveq.l    #9,d6
[00000160] ecaf                      lsr.l      d6,d7
[00000162] 33c7 0000 0000            move.w     d7,_hipage
[00000168] 7e00                      moveq.l    #0,d7
[0000016a] 3e39 0000 0000            move.w     _hipage,d7
[00000170] 7c00                      moveq.l    #0,d6
[00000172] 3c39 0000 0000            move.w     _lopage,d6
[00000178] 9e86                      sub.l      d6,d7
[0000017a] 33c7 0000 0000            move.w     d7,_memsiz
[00000180] 33f9 0000 0000 0000 0000  move.w     _memsiz,_contig
[0000018a] 2e39 0000 0026            move.l     __mdbase,d7
[00000190] 7c09                      moveq.l    #9,d6
[00000192] ecaf                      lsr.l      d6,d7
[00000194] 33c7 0000 002c            move.w     d7,_mdbase
[0000019a] 33f9 0000 0024 0000 002a  move.w     $000002C0,_mdpages
[000001a4] 4ab9 0000 01dc            tst.l      _rahead
[000001aa] 6710                      beq.s      _main_6
[000001ac] 0cb9 0000 0006 0000 00f8  cmpi.l     #$00000006,_nbufs
[000001b6] 6504                      bcs.s      _main_6
[000001b8] 7e01                      moveq.l    #1,d7
[000001ba] 6002                      bra.s      _main_7
_main_6:
[000001bc] 7e00                      moveq.l    #0,d7
_main_7:
[000001be] 23c7 0000 01dc            move.l     d7,_rahead
[000001c4] 2e39 0000 0000            move.l     _buffers,d7
[000001ca] 9eb9 0000 0000            sub.l      _pheap,d7
[000001d0] 23c7 0000 0100            move.l     d7,_nheap
[000001d6] 2eb9 0000 01bc            move.l     _fppres,(a7)
[000001dc] 2f3c 0000 027c            move.l     #$00000518,-(a7)
[000001e2] 4eba fe6c                 jsr        $00000050(pc)
[000001e6] 588f                      addq.l     #4,a7
[000001e8] 2eb9 0000 01e0            move.l     _sepid,(a7)
[000001ee] 2f3c 0000 0281            move.l     #$0000051D,-(a7)
[000001f4] 4eba fe5a                 jsr        $00000050(pc)
[000001f8] 588f                      addq.l     #4,a7
[000001fa] 4ab9 0000 0000            tst.l      _romsys
[00000200] 6620                      bne.s      _main_8
[00000202] 4297                      clr.l      (a7)
[00000204] 2f3c 0000 004e            move.l     #$0000004E,-(a7)
[0000020a] 2e3c 0000 029a            move.l     #$0000029A,d7
[00000210] 2c3c 0000 004e            move.l     #$0000004E,d6
[00000216] 9e86                      sub.l      d6,d7
[00000218] 2f07                      move.l     d7,-(a7)
[0000021a] 4eb9 0000 0000            jsr        _free
[00000220] 508f                      addq.l     #8,a7
_main_8:
[00000222] 4e5e                      unlk       a6
[00000224] 4e75                      rts

x226:
[00000226] 4e56 0000                 link       a6,#0
[0000022a] 48e7 0404                 movem.l    d5/a5,-(a7)
[0000022e] 2a2e 0008                 move.l     8(a6),d5
[00000232] 2a6e 000c                 movea.l    12(a6),a5
x226_3:
[00000236] 0c95 ffff ffff            cmpi.l     #$FFFFFFFF,(a5)
[0000023c] 6754                      beq.s      x226_1
[0000023e] 2e05                      move.l     d5,d7
[00000240] de95                      add.l      (a5),d7
[00000242] 2c15                      move.l     (a5),d6
[00000244] 4686                      not.l      d6
[00000246] ce86                      and.l      d6,d7
[00000248] 2a07                      move.l     d7,d5
[0000024a] 4aad 0004                 tst.l      4(a5)
[0000024e] 670e                      beq.s      x226_2
[00000250] 226d 0004                 movea.l    4(a5),a1
[00000254] 2285                      move.l     d5,(a1)
[00000256] 6006                      bra.s      x226_2
x226_4:
[00000258] 4bed 0010                 lea.l      16(a5),a5
[0000025c] 60d8                      bra.s      x226_3
x226_2:
[0000025e] 4aad 0008                 tst.l      8(a5)
[00000262] 67f4                      beq.s      x226_4
[00000264] 226d 0008                 movea.l    8(a5),a1
[00000268] 2e11                      move.l     (a1),d7
[0000026a] 226d 000c                 movea.l    12(a5),a1
[0000026e] 2c11                      move.l     (a1),d6
[00000270] 4847                      swap       d7
[00000272] 3007                      move.w     d7,d0
[00000274] c0c6                      mulu.w     d6,d0
[00000276] 3e00                      move.w     d0,d7
[00000278] 4847                      swap       d7
[0000027a] 2006                      move.l     d6,d0
[0000027c] 4840                      swap       d0
[0000027e] c0c7                      mulu.w     d7,d0
[00000280] 4847                      swap       d7
[00000282] de40                      add.w      d0,d7
[00000284] 4847                      swap       d7
[00000286] 3007                      move.w     d7,d0
[00000288] c0c6                      mulu.w     d6,d0
[0000028a] 4247                      clr.w      d7
[0000028c] de80                      add.l      d0,d7
[0000028e] da87                      add.l      d7,d5
[00000290] 60c6                      bra.s      x226_4
x226_1:
[00000292] 4cdf 2020                 movem.l    (a7)+,d5/a5
[00000296] 4e5e                      unlk       a6
[00000298] 4e75                      rts

x29a:
[0000029a] 4e75                      rts

	.data
_mmupres:
[0000029c]                           dc.b $00
[0000029d]                           dc.b $00
[0000029e]                           dc.b $00
[0000029f]                           dc.b $00
_silent:
[000002a0]                           dc.b $00
[000002a1]                           dc.b $00
[000002a2]                           dc.b $00
[000002a3]                           dc.b $00
_smax:
[000002a4]                           dc.b $00
[000002a5]                           dc.b $20
_biops:
[000002a6]                           dc.w $2700
_ttyps:
[000002a8]                           dc.w $2700
_hips:
[000002aa]                           dc.w $2700
_lops:
[000002ac]                           dc.w $2000
__cpu:
[000002ae]                           dc.b $00
[000002af]                           dc.b $00
[000002b0]                           dc.b $00
[000002b1]                           dc.b $00
__vbr:
[000002b2]                           dc.b $00
[000002b3]                           dc.b $00
[000002b4]                           dc.b $00
[000002b5]                           dc.b $00
_u0stack:
[000002b6]                           dc.b $00
[000002b7]                           dc.b $00
[000002b8]                           dc.b $00
[000002b9]                           dc.b $00
_exuser:
[000002ba]                           dc.b $00
[000002bb]                           dc.b $00
[000002bc]                           dc.b $00
[000002bd]                           dc.b $00
__mdpages:
[000002be]                           dc.b $00
[000002bf]                           dc.b $00
[000002c0]                           dc.b $00
[000002c1]                           dc.b $0a
__mdbase:
[000002c2]                           dc.b $00
[000002c3]                           dc.b $00
[000002c4]                           dc.b $00
[000002c5]                           dc.b $00
_mdpages:
[000002c6]                           dc.b $00
[000002c7]                           dc.b $00
_mdbase:
[000002c8]                           dc.b $00
[000002c9]                           dc.b $00
_ex20sz:
[000002ca]                           dc.b $00
[000002cb]                           dc.b $00
[000002cc]                           dc.b $00
[000002cd]                           dc.b $08
[000002ce]                           dc.b $00
[000002cf]                           dc.b $00
[000002d0]                           dc.b $00
[000002d1]                           dc.b $08
[000002d2]                           dc.b $00
[000002d3]                           dc.b $00
[000002d4]                           dc.b $00
[000002d5]                           dc.b $0c
[000002d6]                           dc.b $00
[000002d7]                           dc.b $00
[000002d8]                           dc.b $00
[000002d9]                           dc.b $08
[000002da]                           dc.b $00
[000002db]                           dc.b $00
[000002dc]                           dc.b $00
[000002dd]                           dc.b $08
[000002de]                           dc.b $00
[000002df]                           dc.b $00
[000002e0]                           dc.b $00
[000002e1]                           dc.b $08
[000002e2]                           dc.b $00
[000002e3]                           dc.b $00
[000002e4]                           dc.b $00
[000002e5]                           dc.b $08
[000002e6]                           dc.b $00
[000002e7]                           dc.b $00
[000002e8]                           dc.b $00
[000002e9]                           dc.b $08
[000002ea]                           dc.b $00
[000002eb]                           dc.b $00
[000002ec]                           dc.b $00
[000002ed]                           dc.b $3a
[000002ee]                           dc.b $00
[000002ef]                           dc.b $00
[000002f0]                           dc.b $00
[000002f1]                           dc.b $14
[000002f2]                           dc.b $00
[000002f3]                           dc.b $00
[000002f4]                           dc.b $00
[000002f5]                           dc.b $20
[000002f6]                           dc.b $00
[000002f7]                           dc.b $00
[000002f8]                           dc.b $00
[000002f9]                           dc.b $5c
[000002fa]                           dc.b $00
[000002fb]                           dc.b $00
[000002fc]                           dc.b $00
[000002fd]                           dc.b $08
[000002fe]                           dc.b $00
[000002ff]                           dc.b $00
[00000300]                           dc.b $00
[00000301]                           dc.b $08
[00000302]                           dc.b $00
[00000303]                           dc.b $00
[00000304]                           dc.b $00
[00000305]                           dc.b $08
[00000306]                           dc.b $00
[00000307]                           dc.b $00
[00000308]                           dc.b $00
[00000309]                           dc.b $08
_rootdev:
[0000030a]                           dc.w $0502
_pipedev:
[0000030c]                           dc.w $0502
_swapdev:
[0000030e]                           dc.w $0501
_swapadr:
[00000310]                           dc.b $00
[00000311]                           dc.b $01
_swapsiz:
[00000312]                           dc.w $0800
_rootro:
[00000314]                           dc.b $00
[00000315]                           dc.b $00
[00000316]                           dc.b $00
[00000317]                           dc.b $00
_blkdevs:
[00000318] 00000000                  dc.l _nobdev
[0000031c] 00000000                  dc.l _nobdev
[00000320] 00000000                  dc.l _nobdev
[00000324] 00000000                  dc.l _nobdev
[00000328] 00000000                  dc.l _fdbdev
[0000032c] 00000000                  dc.l _hdbdev
[00000330] 00000000                  dc.l _mdbdev
[00000334] 00000000                  dc.l _msgbdev
[00000338] 00000000                  dc.l _nobdev
_nblkdev:
[0000033c]                           dc.b $00
[0000033d]                           dc.b $00
[0000033e]                           dc.b $00
[0000033f]                           dc.b $09
_chrdevs:
[00000340] 00000000                  dc.l _memcdev
[00000344] 00000000                  dc.l _concdev
[00000348] 00000000                  dc.l _sercdev
[0000034c] 00000000                  dc.l _lpcdev
[00000350] 00000000                  dc.l _fdcdev
[00000354] 00000000                  dc.l _hdcdev
[00000358] 00000000                  dc.l _mdcdev
[0000035c] 00000000                  dc.l _msgcdev
[00000360] 00000000                  dc.l _fppcdev
[00000364] 00000000                  dc.l _nocdev
[00000368] 00000000                  dc.l _nocdev
[0000036c] 00000000                  dc.l _nocdev
[00000370] 00000000                  dc.l _nocdev
[00000374] 00000000                  dc.l _nocdev
_nchrdev:
[00000378]                           dc.b $00
[00000379]                           dc.b $00
[0000037a]                           dc.b $00
[0000037b]                           dc.b $0e
_in_max:
[0000037c]                           dc.w $04b0
_in_xoff:
[0000037e]                           dc.w $012c
_in_xon:
[00000380]                           dc.b $00
[00000381]                           dc.b $c8
_in_lim:
[00000382]                           dc.w $0258
_out_hi:
[00000384]                           dc.w $0320
_out_lo:
[00000386]                           dc.w $012c
_syslock:
[00000388]                           dc.b $00
[00000389]                           dc.b $00
[0000038a]                           dc.b $00
[0000038b]                           dc.b $00
[0000038c]                           dc.b $00
[0000038d]                           dc.b $00
[0000038e]                           dc.b $00
[0000038f]                           dc.b $00
_nsyslock:
[00000390]                           dc.b $00
[00000391]                           dc.b $00
[00000392]                           dc.b $00
[00000393]                           dc.b $08
_nbufs:
[00000394]                           dc.b $00
[00000395]                           dc.b $00
[00000396]                           dc.b $00
[00000397]                           dc.b $32
_nclist:
[00000398]                           dc.b $00
[00000399]                           dc.b $00
[0000039a]                           dc.b $00
[0000039b]                           dc.b $78
_nheap:
[0000039c]                           dc.b $00
[0000039d]                           dc.b $00
[0000039e]                           dc.w $2710
_u0stksz:
[000003a0]                           dc.b $00
[000003a1]                           dc.b $00
[000003a2]                           dc.w $0800
_lit1:
[000003a4]                           dc.b $00
[000003a5]                           dc.b $00
[000003a6]                           dc.b $00
[000003a7]                           dc.b $01
_lit16:
[000003a8]                           dc.b $00
[000003a9]                           dc.b $00
[000003aa]                           dc.b $00
[000003ab]                           dc.b $10
_lit512:
[000003ac]                           dc.b $00
[000003ad]                           dc.b $00
[000003ae]                           dc.w $0200
_svdnib:
[000003b0]                           dc.b $00
[000003b1]                           dc.b $00
[000003b2]                           dc.b $00
[000003b3]                           dc.b $01
[000003b4]                           dc.b $00
[000003b5]                           dc.b $00
[000003b6]                           dc.b $00
[000003b7]                           dc.b $00
[000003b8] 00000104                  dc.l $00000104 ; no symbol found
[000003bc] 00000108                  dc.l $00000108 ; no symbol found
[000003c0]                           dc.b $00
[000003c1]                           dc.b $00
[000003c2]                           dc.b $00
[000003c3]                           dc.b $01
[000003c4] 0000001a                  dc.l $0000001a ; no symbol found
[000003c8]                           dc.b $00
[000003c9]                           dc.b $00
[000003ca]                           dc.b $00
[000003cb]                           dc.b $00
[000003cc]                           dc.b $00
[000003cd]                           dc.b $00
[000003ce]                           dc.b $00
[000003cf]                           dc.b $00
[000003d0]                           dc.b $00
[000003d1]                           dc.b $00
[000003d2]                           dc.b $00
[000003d3]                           dc.b $01
[000003d4] 00000000                  dc.l _pbufs
[000003d8] 000000f8                  dc.l $000000f8 ; no symbol found
[000003dc] 00000000                  dc.l _bufsiz
[000003e0]                           dc.b $00
[000003e1]                           dc.b $00
[000003e2]                           dc.b $00
[000003e3]                           dc.b $0f
[000003e4] 00000000                  dc.l _pclist
[000003e8] 000000fc                  dc.l $000000fc ; no symbol found
[000003ec] 0000010c                  dc.l $0000010c ; no symbol found
[000003f0]                           dc.b $00
[000003f1]                           dc.b $00
[000003f2]                           dc.b $00
[000003f3]                           dc.b $01
[000003f4] 00000000                  dc.l _pheap
[000003f8] 00000100                  dc.l $00000100 ; no symbol found
[000003fc] 00000108                  dc.l $00000108 ; no symbol found
[00000400]                           dc.b $00
[00000401]                           dc.b $00
[00000402]                           dc.w $01ff
[00000404] 00000000                  dc.l _buffers
[00000408] 000000f8                  dc.l $000000f8 ; no symbol found
[0000040c] 00000110                  dc.l $00000110 ; no symbol found
[00000410]                           dc.b $00
[00000411]                           dc.b $00
[00000412]                           dc.w $01ff
[00000414] 0000001e                  dc.l $0000001e ; no symbol found
[00000418] 00000000                  dc.l _usize
[0000041c] 00000110                  dc.l $00000110 ; no symbol found
[00000420]                           dc.b $00
[00000421]                           dc.b $00
[00000422]                           dc.w $01ff
[00000424] 00000026                  dc.l $00000026 ; no symbol found
[00000428] 00000022                  dc.l $00000022 ; no symbol found
[0000042c] 00000110                  dc.l $00000110 ; no symbol found
[00000430]                           dc.b $00
[00000431]                           dc.b $00
[00000432]                           dc.w $01ff
[00000434] 00000000                  dc.l _systop
[00000438]                           dc.b $00
[00000439]                           dc.b $00
[0000043a]                           dc.b $00
[0000043b]                           dc.b $00
[0000043c]                           dc.b $00
[0000043d]                           dc.b $00
[0000043e]                           dc.b $00
[0000043f]                           dc.b $00
[00000440]                           dc.w $ffff
[00000442]                           dc.w $ffff
[00000444]                           dc.b $00
[00000445]                           dc.b $00
[00000446]                           dc.b $00
[00000447]                           dc.b $00
[00000448]                           dc.b $00
[00000449]                           dc.b $00
[0000044a]                           dc.b $00
[0000044b]                           dc.b $00
[0000044c]                           dc.b $00
[0000044d]                           dc.b $00
[0000044e]                           dc.b $00
[0000044f]                           dc.b $00
_tinc:
[00000450]                           dc.b $00
[00000451]                           dc.b $00
[00000452]                           dc.w $3000
_coremode:
[00000454]                           dc.b $00
[00000455]                           dc.b $00
[00000456]                           dc.b $00
[00000457]                           dc.b $02
_fppres:
[00000458]                           dc.b $00
[00000459]                           dc.b $00
[0000045a]                           dc.b $00
[0000045b]                           dc.b $00
_hi_chk:
[0000045c]                           dc.b $00
[0000045d]                           dc.b $00
[0000045e]                           dc.w $0200
_sig_chk:
[00000460]                           dc.b $00
[00000461]                           dc.b $00
[00000462]                           dc.w $0100
_lo_chk:
[00000464]                           dc.b $00
[00000465]                           dc.b $00
[00000466]                           dc.b $00
[00000467]                           dc.b $80
_maxargs:
[00000468]                           dc.b $00
[00000469]                           dc.b $00
[0000046a]                           dc.w $2710
_maxpipe:
[0000046c]                           dc.b $00
[0000046d]                           dc.b $00
[0000046e]                           dc.w $1000
_absok:
[00000470]                           dc.b $00
[00000471]                           dc.b $00
[00000472]                           dc.b $00
[00000473]                           dc.b $01
_sharetext:
[00000474]                           dc.b $00
[00000475]                           dc.b $00
[00000476]                           dc.b $00
[00000477]                           dc.b $00
_rahead:
[00000478]                           dc.b $00
[00000479]                           dc.b $00
[0000047a]                           dc.b $00
[0000047b]                           dc.b $01
_sepid:
[0000047c]                           dc.b $00
[0000047d]                           dc.b $00
[0000047e]                           dc.b $00
[0000047f]                           dc.b $00
_stdheap:
[00000480]                           dc.b $00
[00000481]                           dc.b $00
[00000482]                           dc.w $1000
_where:
[00000484]                           dc.b 'Idris/68k V3.12 12/08/87 15:37 (Atari ST V2.0) -fpp -sepid',0
_sysname:
[000004bf]                           dc.b 'idris',0
[000004c5]                           dc.b $00
[000004c6]                           dc.b $00
_nodename:
[000004c7]                           dc.b 'atari',0
[000004cd]                           dc.b $00
[000004ce]                           dc.b $00
_release:
[000004cf]                           dc.b '3.12',0
[000004d4]                           dc.b $00
[000004d5]                           dc.b $00
[000004d6]                           dc.b $00
_version:
[000004d7]                           dc.b $00
[000004d8]                           dc.b $00
[000004d9]                           dc.b $00
[000004da]                           dc.b $00
[000004db]                           dc.b $00
[000004dc]                           dc.b $00
[000004dd]                           dc.b $00
[000004de]                           dc.b $00
_machine:
[000004df]                           dc.b '68k',0
[000004e3]                           dc.b $00
[000004e4]                           dc.b $00
[000004e5]                           dc.b $00
[000004e6]                           dc.b $00
[000004e7]                           dc.b 'exit',0
[000004ec]                           dc.b 'Idris crash: %s',$0a,0
[000004fd]                           dc.b 'not enough system buffers',$0a,0
[00000518]                           dc.b '+fpp',0
[0000051d]                           dc.b '+sepid',0
;
         U _putfmt
         U _pbufs
         U _memsiz
         U _bufsiz
         U _memtop
         U _pclist
         U _pheap
         U _idloop
         U _contig
         U _nocdev
         U _lpcdev
         U _nobdev
         U _sync
         U _minquan
         U _lopage
         U _exbase
         U __memory
         U _mdcdev
         U _systop
         U _mdbdev
         U _usize
         U _hipage
         U _hdcdev
         U _romsys
         U _bootflg
         U _buffers
         U _hdbdev
         U _fdcdev
         U _sercdev
         U _fdbdev
         U _schrate
         U _msgcdev
         U _fppcdev
         U _msgbdev
         U _free
         U _concdev
         U _memcdev
00000000 T _csw
00000008 T _exit
0000001c T _panic
00000040 T _syuser
000000a0 T _main
0000029c D _mmupres
000002a0 D _silent
000002a4 D _smax
000002a6 D _biops
000002a8 D _ttyps
000002aa D _hips
000002ac D _lops
000002ae D __cpu
000002b2 D __vbr
000002b6 D _u0stack
000002ba D _exuser
000002be D __mdpages
000002c2 D __mdbase
000002c6 D _mdpages
000002c8 D _mdbase
000002ca D _ex20sz
0000030a D _rootdev
0000030c D _pipedev
0000030e D _swapdev
00000310 D _swapadr
00000312 D _swapsiz
00000314 D _rootro
00000318 D _blkdevs
0000033c D _nblkdev
00000340 D _chrdevs
00000378 D _nchrdev
0000037c D _in_max
0000037e D _in_xoff
00000380 D _in_xon
00000382 D _in_lim
00000384 D _out_hi
00000386 D _out_lo
00000388 D _syslock
00000390 D _nsyslock
00000394 D _nbufs
00000398 D _nclist
0000039c D _nheap
000003a0 D _u0stksz
000003a4 D _lit1
000003a8 D _lit16
000003ac D _lit512
000003b0 D _svdnib
00000450 D _tinc
00000454 D _coremode
00000458 D _fppres
0000045c D _hi_chk
00000460 D _sig_chk
00000464 D _lo_chk
00000468 D _maxargs
0000046c D _maxpipe
00000470 D _absok
00000474 D _sharetext
00000478 D _rahead
0000047c D _sepid
00000480 D _stdheap
00000484 D _where
000004bf D _sysname
000004c7 D _nodename
000004cf D _release
000004d7 D _version
000004df D _machine
;
; a.out Relocations:
00000002: 0000029c
0000000e: 0000029c
00000014: 00000000
00000026: 0000029c
0000002c: 00000000 _putfmt
00000034: 00000000 _sync
0000003a: 00000000 _idloop
00000060: 0000029c
000000a6: 00000000 _bootflg
000000b0: 0000029c
000000b6: 0000029c
000000bc: 0000029c
000000c4: 0000029c
000000d0: 00000000 _bootflg
000000d8: 0000029c
000000e2: 00000000 _bootflg
000000e8: 0000029c
000000f0: 00000000 _schrate
000000f8: 00000000 _minquan
000000fe: 00000000 _romsys
0000010a: 0000029c
00000110: 0000029c
00000116: 00000000 __memory
0000011c: 00000000
00000128: 0000029c
00000130: 0000029c
0000013a: 0000029c
00000144: 00000000 _exbase
0000014a: 00000000 _systop
00000154: 00000000 _lopage
0000015a: 00000000 _memtop
00000164: 00000000 _hipage
0000016c: 00000000 _hipage
00000174: 00000000 _lopage
0000017c: 00000000 _memsiz
00000182: 00000000 _memsiz
00000186: 00000000 _contig
0000018c: 0000029c
00000196: 0000029c
0000019c: 0000029c
000001a0: 0000029c
000001a6: 0000029c
000001b2: 0000029c
000001c0: 0000029c
000001c6: 00000000 _buffers
000001cc: 00000000 _pheap
000001d2: 0000029c
000001d8: 0000029c
000001de: 0000029c
000001ea: 0000029c
000001f0: 0000029c
000001fc: 00000000 _romsys
00000206: 00000000
0000020c: 00000000
00000212: 00000000
0000021c: 00000000 _free
00000318: 00000000 _nobdev
0000031c: 00000000 _nobdev
00000320: 00000000 _nobdev
00000324: 00000000 _nobdev
00000328: 00000000 _fdbdev
0000032c: 00000000 _hdbdev
00000330: 00000000 _mdbdev
00000334: 00000000 _msgbdev
00000338: 00000000 _nobdev
00000340: 00000000 _memcdev
00000344: 00000000 _concdev
00000348: 00000000 _sercdev
0000034c: 00000000 _lpcdev
00000350: 00000000 _fdcdev
00000354: 00000000 _hdcdev
00000358: 00000000 _mdcdev
0000035c: 00000000 _msgcdev
00000360: 00000000 _fppcdev
00000364: 00000000 _nocdev
00000368: 00000000 _nocdev
0000036c: 00000000 _nocdev
00000370: 00000000 _nocdev
00000374: 00000000 _nocdev
000003b8: 0000029c
000003bc: 0000029c
000003c4: 0000029c
000003d4: 00000000 _pbufs
000003d8: 0000029c
000003dc: 00000000 _bufsiz
000003e4: 00000000 _pclist
000003e8: 0000029c
000003ec: 0000029c
000003f4: 00000000 _pheap
000003f8: 0000029c
000003fc: 0000029c
00000404: 00000000 _buffers
00000408: 0000029c
0000040c: 0000029c
00000414: 0000029c
00000418: 00000000 _usize
0000041c: 0000029c
00000424: 0000029c
00000428: 0000029c
0000042c: 0000029c
00000434: 00000000 _systop
