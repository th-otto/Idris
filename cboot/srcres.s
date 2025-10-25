; a_magic   = 0x9928
; a_text    = 0x0000ad6e
; a_data    = 0x000009b0
; a_bss     = 0x00000000
; a_syms    = 0x00001ca8
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x0000ad6e
; a_relocs  = 0x00001084@0x0000d3e2


x0:
[00000000] 4e56 0000                 link       a6,#0
[00000004] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000008] 2a2e 0008                 move.l     8(a6),d5
[0000000c] 2a6e 000c                 movea.l    12(a6),a5
x0_4:
[00000010] 2855                      movea.l    (a5),a4
[00000012] 2e0c                      move.l     a4,d7
[00000014] 6724                      beq.s      x0_1
[00000016] baac 0004                 cmp.l      4(a4),d5
[0000001a] 621a                      bhi.s      x0_2
[0000001c] 2e0c                      move.l     a4,d7
[0000001e] de85                      add.l      d5,d7
[00000020] 2a87                      move.l     d7,(a5)
[00000022] 2255                      movea.l    (a5),a1
[00000024] 2e2c 0004                 move.l     4(a4),d7
[00000028] 9e85                      sub.l      d5,d7
[0000002a] 2347 0004                 move.l     d7,4(a1)
[0000002e] 2255                      movea.l    (a5),a1
[00000030] 2294                      move.l     (a4),(a1)
[00000032] 2e0c                      move.l     a4,d7
[00000034] 6006                      bra.s      x0_3
x0_2:
[00000036] 2a4c                      movea.l    a4,a5
[00000038] 60d6                      bra.s      x0_4
x0_1:
[0000003a] 7e00                      moveq.l    #0,d7
x0_3:
[0000003c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000040] 4e5e                      unlk       a6
[00000042] 4e75                      rts

x44:
[00000044] 4e56 0000                 link       a6,#0
[00000048] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000004c] 2a6e 000c                 movea.l    12(a6),a5
[00000050] 2e2e 0008                 move.l     8(a6),d7
[00000054] 5987                      subq.l     #4,d7
[00000056] 5987                      subq.l     #4,d7
[00000058] 2b47 0004                 move.l     d7,4(a5)
[0000005c] 226e 0014                 movea.l    20(a6),a1
[00000060] 4a91                      tst.l      (a1)
[00000062] 6708                      beq.s      x44_1
[00000064] 226e 0014                 movea.l    20(a6),a1
[00000068] bbd1                      cmpa.l     (a1),a5
[0000006a] 6420                      bcc.s      x44_2
x44_1:
[0000006c] 226e 0014                 movea.l    20(a6),a1
[00000070] 2a91                      move.l     (a1),(a5)
[00000072] 226e 0014                 movea.l    20(a6),a1
[00000076] 228d                      move.l     a5,(a1)
[00000078] 2e8d                      move.l     a5,(a7)
[0000007a] 4eb9 0000 00c8            jsr        $000000C8
x44_6:
[00000080] 2e2e 0010                 move.l     16(a6),d7
[00000084] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000088] 4e5e                      unlk       a6
[0000008a] 4e75                      rts
x44_2:
[0000008c] 226e 0014                 movea.l    20(a6),a1
[00000090] 2851                      movea.l    (a1),a4
x44_4:
[00000092] 2654                      movea.l    (a4),a3
[00000094] 2e0b                      move.l     a3,d7
[00000096] 6708                      beq.s      x44_3
[00000098] b7cd                      cmpa.l     a5,a3
[0000009a] 6404                      bcc.s      x44_3
[0000009c] 284b                      movea.l    a3,a4
[0000009e] 60f2                      bra.s      x44_4
x44_3:
[000000a0] 2e0b                      move.l     a3,d7
[000000a2] 6716                      beq.s      x44_5
[000000a4] 2a8b                      move.l     a3,(a5)
[000000a6] 288d                      move.l     a5,(a4)
[000000a8] 2e8d                      move.l     a5,(a7)
[000000aa] 4eb9 0000 00c8            jsr        $000000C8
[000000b0] 2e8c                      move.l     a4,(a7)
[000000b2] 4eb9 0000 00c8            jsr        $000000C8
[000000b8] 60c6                      bra.s      x44_6
x44_5:
[000000ba] 4295                      clr.l      (a5)
[000000bc] 288d                      move.l     a5,(a4)
[000000be] 2e8c                      move.l     a4,(a7)
[000000c0] 4eb9 0000 00c8            jsr        $000000C8
[000000c6] 60b8                      bra.s      x44_6
[000000c8] 4e56 0000                 link       a6,#0
[000000cc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000000d0] 2a6e 0008                 movea.l    8(a6),a5
[000000d4] 2855                      movea.l    (a5),a4
[000000d6] 2e0d                      move.l     a5,d7
[000000d8] dead 0004                 add.l      4(a5),d7
[000000dc] 5087                      addq.l     #8,d7
[000000de] be8c                      cmp.l      a4,d7
[000000e0] 660c                      bne.s      x44_7
[000000e2] 2e2c 0004                 move.l     4(a4),d7
[000000e6] 5087                      addq.l     #8,d7
[000000e8] dfad 0004                 add.l      d7,4(a5)
[000000ec] 2a94                      move.l     (a4),(a5)
x44_7:
[000000ee] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000000f2] 4e5e                      unlk       a6
[000000f4] 4e75                      rts

_alloc:
[000000f6] 4e56 fffc                 link       a6,#-4
[000000fa] 2ebc 0000 ad6e            move.l     #$00015ADC,(a7)
[00000100] 2f2e 000c                 move.l     12(a6),-(a7)
[00000104] 2f2e 0008                 move.l     8(a6),-(a7)
[00000108] 4eb9 0000 015c            jsr        _halloc
[0000010e] 508f                      addq.l     #8,a7
[00000110] 4e5e                      unlk       a6
[00000112] 4e75                      rts

_free:
[00000114] 4e56 fffc                 link       a6,#-4
[00000118] 2ebc 0000 ad6e            move.l     #$00015ADC,(a7)
[0000011e] 2f2e 0010                 move.l     16(a6),-(a7)
[00000122] 2f2e 000c                 move.l     12(a6),-(a7)
[00000126] 2f2e 0008                 move.l     8(a6),-(a7)
[0000012a] 4eb9 0000 022a            jsr        _hfree
[00000130] 4fef 000c                 lea.l      12(a7),a7
[00000134] 4e5e                      unlk       a6
[00000136] 4e75                      rts

_frelst:
[00000138] 4e56 fffc                 link       a6,#-4
[0000013c] 2ebc 0000 ad6e            move.l     #$00015ADC,(a7)
[00000142] 2f2e 0010                 move.l     16(a6),-(a7)
[00000146] 2f2e 000c                 move.l     12(a6),-(a7)
[0000014a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000014e] 4eb9 0000 02c6            jsr        _hfrelst
[00000154] 4fef 000c                 lea.l      12(a7),a7
[00000158] 4e5e                      unlk       a6
[0000015a] 4e75                      rts

_halloc:
[0000015c] 4e56 0000                 link       a6,#0
[00000160] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000164] 2a6e 0010                 movea.l    16(a6),a5
[00000168] 0cae 0000 0008 0008       cmpi.l     #$00000008,8(a6)
[00000170] 6404                      bcc.s      _halloc_1
[00000172] 7e08                      moveq.l    #8,d7
[00000174] 6004                      bra.s      _halloc_2
_halloc_1:
[00000176] 2e2e 0008                 move.l     8(a6),d7
_halloc_2:
[0000017a] 7c00                      moveq.l    #0,d6
[0000017c] 5486                      addq.l     #2,d6
[0000017e] 5386                      subq.l     #1,d6
[00000180] de86                      add.l      d6,d7
[00000182] 7c00                      moveq.l    #0,d6
[00000184] 5486                      addq.l     #2,d6
[00000186] 5386                      subq.l     #1,d6
[00000188] 4686                      not.l      d6
[0000018a] ce86                      and.l      d6,d7
[0000018c] 2d47 0008                 move.l     d7,8(a6)
[00000190] 43ed 0010                 lea.l      16(a5),a1
[00000194] 2849                      movea.l    a1,a4
[00000196] 97cb                      suba.l     a3,a3
_halloc_5:
[00000198] 4aac 0004                 tst.l      4(a4)
[0000019c] 6718                      beq.s      _halloc_3
[0000019e] 2e2c 0004                 move.l     4(a4),d7
[000001a2] beae 0008                 cmp.l      8(a6),d7
[000001a6] 660a                      bne.s      _halloc_4
[000001a8] 2654                      movea.l    (a4),a3
[000001aa] 2e0b                      move.l     a3,d7
[000001ac] 6708                      beq.s      _halloc_3
[000001ae] 2893                      move.l     (a3),(a4)
[000001b0] 6004                      bra.s      _halloc_3
_halloc_4:
[000001b2] 508c                      addq.l     #8,a4
[000001b4] 60e2                      bra.s      _halloc_5
_halloc_3:
[000001b6] 2e0b                      move.l     a3,d7
[000001b8] 6650                      bne.s      _halloc_6
[000001ba] 2e8d                      move.l     a5,(a7)
[000001bc] 2f2e 0008                 move.l     8(a6),-(a7)
[000001c0] 4eba fe3e                 jsr        $00000000(pc)
[000001c4] 588f                      addq.l     #4,a7
[000001c6] 2647                      movea.l    d7,a3
[000001c8] 2e0b                      move.l     a3,d7
[000001ca] 663e                      bne.s      _halloc_6
[000001cc] 43ed 0010                 lea.l      16(a5),a1
[000001d0] 2849                      movea.l    a1,a4
_halloc_10:
[000001d2] 4aac 0004                 tst.l      4(a4)
[000001d6] 6724                      beq.s      _halloc_7
[000001d8] 2654                      movea.l    (a4),a3
_halloc_9:
[000001da] 2e0b                      move.l     a3,d7
[000001dc] 6716                      beq.s      _halloc_8
[000001de] 2e8d                      move.l     a5,(a7)
[000001e0] 2f13                      move.l     (a3),-(a7)
[000001e2] 2f0b                      move.l     a3,-(a7)
[000001e4] 2f2c 0004                 move.l     4(a4),-(a7)
[000001e8] 4eba fe5a                 jsr        $00000044(pc)
[000001ec] 4fef 000c                 lea.l      12(a7),a7
[000001f0] 2647                      movea.l    d7,a3
[000001f2] 60e6                      bra.s      _halloc_9
_halloc_8:
[000001f4] 42ac 0004                 clr.l      4(a4)
[000001f8] 508c                      addq.l     #8,a4
[000001fa] 60d6                      bra.s      _halloc_10
_halloc_7:
[000001fc] 2e8d                      move.l     a5,(a7)
[000001fe] 2f2e 0008                 move.l     8(a6),-(a7)
[00000202] 4eba fdfc                 jsr        $00000000(pc)
[00000206] 588f                      addq.l     #4,a7
[00000208] 2647                      movea.l    d7,a3
_halloc_6:
[0000020a] 2e0b                      move.l     a3,d7
[0000020c] 6706                      beq.s      _halloc_11
[0000020e] 26ae 000c                 move.l     12(a6),(a3)
[00000212] 600c                      bra.s      _halloc_12
_halloc_11:
[00000214] 2ebc 0000 adce            move.l     #$00015B3C,(a7)
[0000021a] 4eb9 0000 20d6            jsr        _putfmt
_halloc_12:
[00000220] 2e0b                      move.l     a3,d7
[00000222] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000226] 4e5e                      unlk       a6
[00000228] 4e75                      rts

_hfree:
[0000022a] 4e56 0000                 link       a6,#0
[0000022e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000232] 2a2e 0008                 move.l     8(a6),d5
[00000236] 2a6e 0014                 movea.l    20(a6),a5
[0000023a] 0c85 0000 0008            cmpi.l     #$00000008,d5
[00000240] 6404                      bcc.s      _hfree_1
[00000242] 7e08                      moveq.l    #8,d7
[00000244] 6002                      bra.s      _hfree_2
_hfree_1:
[00000246] 2e05                      move.l     d5,d7
_hfree_2:
[00000248] 7c00                      moveq.l    #0,d6
[0000024a] 5486                      addq.l     #2,d6
[0000024c] 5386                      subq.l     #1,d6
[0000024e] de86                      add.l      d6,d7
[00000250] 7c00                      moveq.l    #0,d6
[00000252] 5486                      addq.l     #2,d6
[00000254] 5386                      subq.l     #1,d6
[00000256] 4686                      not.l      d6
[00000258] ce86                      and.l      d6,d7
[0000025a] 2a07                      move.l     d7,d5
[0000025c] 43ed 0010                 lea.l      16(a5),a1
[00000260] 2849                      movea.l    a1,a4
_hfree_4:
[00000262] 4aac 0004                 tst.l      4(a4)
[00000266] 670c                      beq.s      _hfree_3
[00000268] 2e2c 0004                 move.l     4(a4),d7
[0000026c] be85                      cmp.l      d5,d7
[0000026e] 6704                      beq.s      _hfree_3
[00000270] 508c                      addq.l     #8,a4
[00000272] 60ee                      bra.s      _hfree_4
_hfree_3:
[00000274] 4aac 0004                 tst.l      4(a4)
[00000278] 670c                      beq.s      _hfree_5
[0000027a] 226e 000c                 movea.l    12(a6),a1
[0000027e] 2294                      move.l     (a4),(a1)
[00000280] 28ae 000c                 move.l     12(a6),(a4)
[00000284] 6034                      bra.s      _hfree_6
_hfree_5:
[00000286] 2e2d 000c                 move.l     12(a5),d7
[0000028a] e787                      asl.l      #3,d7
[0000028c] 43ed 0008                 lea.l      8(a5),a1
[00000290] 43f1 7800                 lea.l      0(a1,d7.l),a1
[00000294] b9c9                      cmpa.l     a1,a4
[00000296] 6410                      bcc.s      _hfree_7
[00000298] 226e 000c                 movea.l    12(a6),a1
[0000029c] 4291                      clr.l      (a1)
[0000029e] 2945 0004                 move.l     d5,4(a4)
[000002a2] 28ae 000c                 move.l     12(a6),(a4)
[000002a6] 6012                      bra.s      _hfree_6
_hfree_7:
[000002a8] 2e8d                      move.l     a5,(a7)
[000002aa] 42a7                      clr.l      -(a7)
[000002ac] 2f2e 000c                 move.l     12(a6),-(a7)
[000002b0] 2f05                      move.l     d5,-(a7)
[000002b2] 4eba fd90                 jsr        $00000044(pc)
[000002b6] 4fef 000c                 lea.l      12(a7),a7
_hfree_6:
[000002ba] 2e2e 0010                 move.l     16(a6),d7
[000002be] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000002c2] 4e5e                      unlk       a6
[000002c4] 4e75                      rts

_hfrelst:
[000002c6] 4e56 fffe                 link       a6,#-2
[000002ca] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000002ce] 286e 0010                 movea.l    16(a6),a4
_hfrelst_3:
[000002d2] 2a54                      movea.l    (a4),a5
[000002d4] 2e0d                      move.l     a5,d7
[000002d6] 673a                      beq.s      _hfrelst_1
[000002d8] bbee 000c                 cmpa.l     12(a6),a5
[000002dc] 6630                      bne.s      _hfrelst_2
[000002de] 4eb9 0000 0000            jsr        _spl7
[000002e4] 3d47 fffe                 move.w     d7,-2(a6)
[000002e8] 2895                      move.l     (a5),(a4)
[000002ea] 7e00                      moveq.l    #0,d7
[000002ec] 3e2e fffe                 move.w     -2(a6),d7
[000002f0] 2e87                      move.l     d7,(a7)
[000002f2] 4eb9 0000 0000            jsr        _spl
[000002f8] 2eae 0014                 move.l     20(a6),(a7)
[000002fc] 2f15                      move.l     (a5),-(a7)
[000002fe] 2f0d                      move.l     a5,-(a7)
[00000300] 2f2e 0008                 move.l     8(a6),-(a7)
[00000304] 4eba ff24                 jsr        _hfree(pc)
[00000308] 4fef 000c                 lea.l      12(a7),a7
[0000030c] 6004                      bra.s      _hfrelst_1
_hfrelst_2:
[0000030e] 284d                      movea.l    a5,a4
[00000310] 60c0                      bra.s      _hfrelst_3
_hfrelst_1:
[00000312] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000316] 4e5e                      unlk       a6
[00000318] 4e75                      rts

_hinit:
[0000031a] 4e56 0000                 link       a6,#0
[0000031e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000322] 2a6e 0008                 movea.l    8(a6),a5
[00000326] 2b6e 000c 0004            move.l     12(a6),4(a5)
[0000032c] 2b6e 0010 0008            move.l     16(a6),8(a5)
[00000332] 2a2e 0014                 move.l     20(a6),d5
[00000336] 2b45 000c                 move.l     d5,12(a5)
[0000033a] 4295                      clr.l      (a5)
[0000033c] 43ed 0010                 lea.l      16(a5),a1
[00000340] 2849                      movea.l    a1,a4
_hinit_2:
[00000342] 5385                      subq.l     #1,d5
[00000344] 6d0a                      blt.s      _hinit_1
[00000346] 4294                      clr.l      (a4)
[00000348] 42ac 0004                 clr.l      4(a4)
[0000034c] 508c                      addq.l     #8,a4
[0000034e] 60f2                      bra.s      _hinit_2
_hinit_1:
[00000350] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000354] 4e5e                      unlk       a6
[00000356] 4e75                      rts

_bbuy:
[00000358] 4e56 0000                 link       a6,#0
_bbuy_3:
[0000035c] 4ab9 0000 b15a            tst.l      _nbufres
[00000362] 6620                      bne.s      _bbuy_1
[00000364] 4aae 0008                 tst.l      8(a6)
[00000368] 6706                      beq.s      _bbuy_2
[0000036a] 7e00                      moveq.l    #0,d7
[0000036c] 4e5e                      unlk       a6
[0000036e] 4e75                      rts
_bbuy_2:
[00000370] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00000374] 2f3c 0000 b15a            move.l     #_nbufres,-(a7)
[0000037a] 4eb9 0000 8844            jsr        _sleep
[00000380] 508f                      addq.l     #8,a7
[00000382] 60d8                      bra.s      _bbuy_3
_bbuy_1:
[00000384] 53b9 0000 b15a            subq.l     #1,_nbufres
[0000038a] 7e01                      moveq.l    #1,d7
[0000038c] 4e5e                      unlk       a6
[0000038e] 4e75                      rts

_brelse:
[00000390] 4e56 0000                 link       a6,#0
[00000394] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000398] 2a6e 0008                 movea.l    8(a6),a5
[0000039c] 2e8d                      move.l     a5,(a7)
[0000039e] 4eb9 0000 0a0c            jsr        _wakeb
[000003a4] 2ebc 0000 b124            move.l     #_blist,(a7)
[000003aa] 4eb9 0000 0a0c            jsr        _wakeb
[000003b0] 082d 0003 0011            btst       #3,17(a5)
[000003b6] 6704                      beq.s      _brelse_1
[000003b8] 426d 0012                 clr.w      18(a5)
_brelse_1:
[000003bc] 7e00                      moveq.l    #0,d7
[000003be] 3e39 0000 0000            move.w     _biops,d7
[000003c4] 2e87                      move.l     d7,(a7)
[000003c6] 4eb9 0000 0000            jsr        _spl
[000003cc] 2a07                      move.l     d7,d5
[000003ce] 026d fffc 0010            andi.w     #$FFFC,16(a5)
[000003d4] 2e8d                      move.l     a5,(a7)
[000003d6] 2f3c 0000 b124            move.l     #_blist,-(a7)
[000003dc] 4eb9 0000 0b76            jsr        _enq
[000003e2] 588f                      addq.l     #4,a7
[000003e4] 2e85                      move.l     d5,(a7)
[000003e6] 4eb9 0000 0000            jsr        _spl
[000003ec] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000003f0] 4e5e                      unlk       a6
[000003f2] 4e75                      rts

_bsell:
[000003f4] 4e56 fffc                 link       a6,#-4
[000003f8] 4ab9 0000 b15a            tst.l      _nbufres
[000003fe] 660c                      bne.s      _bsell_1
[00000400] 2ebc 0000 b15a            move.l     #_nbufres,(a7)
[00000406] 4eb9 0000 8b4c            jsr        _wakeup
_bsell_1:
[0000040c] 52b9 0000 b15a            addq.l     #1,_nbufres
[00000412] 4e5e                      unlk       a6
[00000414] 4e75                      rts

_buflush:
[00000416] 4e56 fffc                 link       a6,#-4
[0000041a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000041e] 7001                      moveq.l    #1,d0
[00000420] 2d40 fffc                 move.l     d0,-4(a6)
_buflush_8:
[00000424] 7e00                      moveq.l    #0,d7
[00000426] 3e39 0000 0000            move.w     _biops,d7
[0000042c] 2e87                      move.l     d7,(a7)
[0000042e] 4eb9 0000 0000            jsr        _spl
[00000434] 2a79 0000 b124            movea.l    _blist,a5
_buflush_3:
[0000043a] bbfc 0000 b124            cmpa.l     #_blist,a5
[00000440] 6754                      beq.s      _buflush_1
[00000442] 4aae 0008                 tst.l      8(a6)
[00000446] 6712                      beq.s      _buflush_2
[00000448] 2e2e 0008                 move.l     8(a6),d7
[0000044c] 7c00                      moveq.l    #0,d6
[0000044e] 3c2d 0012                 move.w     18(a5),d6
[00000452] be86                      cmp.l      d6,d7
[00000454] 6704                      beq.s      _buflush_2
_buflush_6:
[00000456] 2a55                      movea.l    (a5),a5
[00000458] 60e0                      bra.s      _buflush_3
_buflush_2:
[0000045a] 082d 0002 0011            btst       #2,17(a5)
[00000460] 6706                      beq.s      _buflush_4
[00000462] 42ae fffc                 clr.l      -4(a6)
[00000466] 602e                      bra.s      _buflush_1
_buflush_4:
[00000468] 4aae 000c                 tst.l      12(a6)
[0000046c] 6714                      beq.s      _buflush_5
[0000046e] 2e2e 0008                 move.l     8(a6),d7
[00000472] 7c00                      moveq.l    #0,d6
[00000474] 3c2d 0012                 move.w     18(a5),d6
[00000478] be86                      cmp.l      d6,d7
[0000047a] 6606                      bne.s      _buflush_5
[0000047c] 426d 0012                 clr.w      18(a5)
[00000480] 60d4                      bra.s      _buflush_6
_buflush_5:
[00000482] 4a6d 0012                 tst.w      18(a5)
[00000486] 67ce                      beq.s      _buflush_6
[00000488] 082d 0006 0011            btst       #6,17(a5)
[0000048e] 66c6                      bne.s      _buflush_6
[00000490] 42ae fffc                 clr.l      -4(a6)
[00000494] 60c0                      bra.s      _buflush_6
_buflush_1:
[00000496] bbfc 0000 b124            cmpa.l     #_blist,a5
[0000049c] 6612                      bne.s      _buflush_7
[0000049e] 4eb9 0000 0000            jsr        _spl0
[000004a4] 2e2e fffc                 move.l     -4(a6),d7
[000004a8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000004ac] 4e5e                      unlk       a6
[000004ae] 4e75                      rts
_buflush_7:
[000004b0] 2e8d                      move.l     a5,(a7)
[000004b2] 4eb9 0000 09a4            jsr        _unfree
[000004b8] 2e87                      move.l     d7,(a7)
[000004ba] 4eb9 0000 0a3e            jsr        _writb
[000004c0] 4eb9 0000 0000            jsr        _spl0
[000004c6] 6000 ff5c                 bra        _buflush_8

_clrbuf:
[000004ca] 4e56 0000                 link       a6,#0
[000004ce] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000004d2] 2a3c 0000 0080            move.l     #$00000080,d5
[000004d8] 2eae 0008                 move.l     8(a6),(a7)
[000004dc] 4eb9 0000 0c18            jsr        _getaddr
[000004e2] 2a47                      movea.l    d7,a5
_clrbuf_2:
[000004e4] 5385                      subq.l     #1,d5
[000004e6] 6d04                      blt.s      _clrbuf_1
[000004e8] 429d                      clr.l      (a5)+
[000004ea] 60f8                      bra.s      _clrbuf_2
_clrbuf_1:
[000004ec] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000004f0] 4e5e                      unlk       a6
[000004f2] 4e75                      rts

_getblk:
[000004f4] 4e56 0000                 link       a6,#0
[000004f8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000004fc] 3e2e 000a                 move.w     10(a6),d7
[00000500] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000506] e087                      asr.l      #8,d7
[00000508] 2a07                      move.l     d7,d5
[0000050a] 4aae 0008                 tst.l      8(a6)
[0000050e] 6608                      bne.s      _getblk_1
[00000510] 287c 0000 b124            movea.l    #_blist,a4
[00000516] 6028                      bra.s      _getblk_2
_getblk_1:
[00000518] bab9 0000 0000            cmp.l      _nblkdev,d5
[0000051e] 6414                      bcc.s      _getblk_3
[00000520] 2e05                      move.l     d5,d7
[00000522] e587                      asl.l      #2,d7
[00000524] 2247                      movea.l    d7,a1
[00000526] d3fc 0000 0000            adda.l     #_blkdevs,a1
[0000052c] 2251                      movea.l    (a1),a1
[0000052e] 2869 000c                 movea.l    12(a1),a4
[00000532] 600c                      bra.s      _getblk_2
_getblk_3:
[00000534] 2ebc 0000 ade0            move.l     #$00015B4E,(a7)
[0000053a] 4eb9 0000 0000            jsr        _panic
_getblk_2:
[00000540] 4eb9 0000 0000            jsr        _spl0
[00000546] 4a39 0000 b34a            tst.b      _onflag
[0000054c] 6706                      beq.s      _getblk_4
[0000054e] 4eb9 0000 4f2c            jsr        _dounits
_getblk_4:
[00000554] 4ab9 0000 b4fc            tst.l      _hiproc
[0000055a] 6706                      beq.s      _getblk_5
[0000055c] 4eb9 0000 8974            jsr        _switchp
_getblk_5:
[00000562] 4aae 0008                 tst.l      8(a6)
[00000566] 6604                      bne.s      _getblk_6
[00000568] 7e00                      moveq.l    #0,d7
[0000056a] 6010                      bra.s      _getblk_7
_getblk_6:
[0000056c] 2eae 000c                 move.l     12(a6),(a7)
[00000570] 2f2e 0008                 move.l     8(a6),-(a7)
[00000574] 4eb9 0000 06e0            jsr        _locb
[0000057a] 588f                      addq.l     #4,a7
_getblk_7:
[0000057c] 2a47                      movea.l    d7,a5
[0000057e] 7e00                      moveq.l    #0,d7
[00000580] 3e39 0000 0000            move.w     _biops,d7
[00000586] 2e87                      move.l     d7,(a7)
[00000588] 4eb9 0000 0000            jsr        _spl
[0000058e] 2e0d                      move.l     a5,d7
[00000590] 6724                      beq.s      _getblk_8
[00000592] 082d 0001 0011            btst       #1,17(a5)
[00000598] 671c                      beq.s      _getblk_8
[0000059a] 08ed 0007 0011            bset       #7,17(a5)
[000005a0] 2ebc 0000 addc            move.l     #$00015B4A,(a7)
[000005a6] 4878 ffff                 pea.l      ($FFFFFFFF).w
[000005aa] 2f0d                      move.l     a5,-(a7)
[000005ac] 4eb9 0000 8862            jsr        _sleepl
[000005b2] 508f                      addq.l     #8,a7
[000005b4] 608a                      bra.s      _getblk_2
_getblk_8:
[000005b6] 2e0d                      move.l     a5,d7
[000005b8] 6718                      beq.s      _getblk_9
[000005ba] 2e8d                      move.l     a5,(a7)
[000005bc] 4eb9 0000 09a4            jsr        _unfree
[000005c2] 4eb9 0000 0000            jsr        _spl0
[000005c8] 2e0d                      move.l     a5,d7
[000005ca] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000005ce] 4e5e                      unlk       a6
[000005d0] 4e75                      rts
_getblk_9:
[000005d2] 2e39 0000 b124            move.l     _blist,d7
[000005d8] 0c87 0000 b124            cmpi.l     #_blist,d7
[000005de] 6610                      bne.s      _getblk_10
[000005e0] 2ebc 0000 b124            move.l     #_blist,(a7)
[000005e6] 4eb9 0000 097c            jsr        _sleepb
[000005ec] 6000 ff52                 bra        _getblk_2
_getblk_10:
[000005f0] 2eb9 0000 b124            move.l     _blist,(a7)
[000005f6] 4eb9 0000 09a4            jsr        _unfree
[000005fc] 2a47                      movea.l    d7,a5
[000005fe] 082d 0002 0011            btst       #2,17(a5)
[00000604] 6712                      beq.s      _getblk_11
[00000606] 4eb9 0000 0000            jsr        _spl0
[0000060c] 2e8d                      move.l     a5,(a7)
[0000060e] 4eb9 0000 0a3e            jsr        _writb
[00000614] 6000 ff2a                 bra        _getblk_2
_getblk_11:
[00000618] 7e00                      moveq.l    #0,d7
[0000061a] 3e2d 0010                 move.w     16(a5),d7
[0000061e] 0287 0000 0400            andi.l     #$00000400,d7
[00000624] 08c7 0001                 bset       #1,d7
[00000628] 3b47 0010                 move.w     d7,16(a5)
[0000062c] 226d 0008                 movea.l    8(a5),a1
[00000630] 236d 000c 000c            move.l     12(a5),12(a1)
[00000636] 226d 000c                 movea.l    12(a5),a1
[0000063a] 236d 0008 0008            move.l     8(a5),8(a1)
[00000640] 2b6c 0008 0008            move.l     8(a4),8(a5)
[00000646] 2b4c 000c                 move.l     a4,12(a5)
[0000064a] 226c 0008                 movea.l    8(a4),a1
[0000064e] 234d 000c                 move.l     a5,12(a1)
[00000652] 294d 0008                 move.l     a5,8(a4)
[00000656] 3b6e 000a 0012            move.w     10(a6),18(a5)
[0000065c] 3b6e 000e 002c            move.w     14(a6),44(a5)
[00000662] 42ad 0028                 clr.l      40(a5)
[00000666] 2e2e 000c                 move.l     12(a6),d7
[0000066a] 7c09                      moveq.l    #9,d6
[0000066c] eda7                      asl.l      d6,d7
[0000066e] 2b47 001c                 move.l     d7,28(a5)
[00000672] 4eb9 0000 0000            jsr        _spl0
[00000678] 2e0d                      move.l     a5,d7
[0000067a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000067e] 4e5e                      unlk       a6
[00000680] 4e75                      rts

_errget:
[00000682] 4e56 0000                 link       a6,#0
[00000686] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000068a] 2a6e 0008                 movea.l    8(a6),a5
[0000068e] 082d 0003 0011            btst       #3,17(a5)
[00000694] 670c                      beq.s      _errget_1
[00000696] 4878 0005                 pea.l      ($00000005).w
[0000069a] 4eb9 0000 2868            jsr        _uerror
[000006a0] 588f                      addq.l     #4,a7
_errget_1:
[000006a2] 2e0d                      move.l     a5,d7
[000006a4] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000006a8] 4e5e                      unlk       a6
[000006aa] 4e75                      rts

_iodone:
[000006ac] 4e56 0000                 link       a6,#0
[000006b0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000006b4] 2a6e 0008                 movea.l    8(a6),a5
[000006b8] 08ed 0006 0011            bset       #6,17(a5)
[000006be] 082d 0000 0011            btst       #0,17(a5)
[000006c4] 6708                      beq.s      _iodone_1
[000006c6] 2e8d                      move.l     a5,(a7)
[000006c8] 4eba fcc6                 jsr        _brelse(pc)
[000006cc] 6008                      bra.s      _iodone_2
_iodone_1:
[000006ce] 2e8d                      move.l     a5,(a7)
[000006d0] 4eb9 0000 0a0c            jsr        _wakeb
_iodone_2:
[000006d6] 2e0d                      move.l     a5,d7
[000006d8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000006dc] 4e5e                      unlk       a6
[000006de] 4e75                      rts

_locb:
[000006e0] 4e56 0000                 link       a6,#0
[000006e4] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000006e8] 3e2e 000a                 move.w     10(a6),d7
[000006ec] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000006f2] e087                      asr.l      #8,d7
[000006f4] e587                      asl.l      #2,d7
[000006f6] 2247                      movea.l    d7,a1
[000006f8] d3fc 0000 0000            adda.l     #_blkdevs,a1
[000006fe] 2251                      movea.l    (a1),a1
[00000700] 2869 000c                 movea.l    12(a1),a4
[00000704] 52b9 0000 b6bc            addq.l     #1,_nlocb
[0000070a] 2a79 0000 ade8            movea.l    $00015B56,a5
[00000710] 2e0d                      move.l     a5,d7
[00000712] 6722                      beq.s      _locb_1
[00000714] 7e00                      moveq.l    #0,d7
[00000716] 3e2d 002c                 move.w     44(a5),d7
[0000071a] beae 000c                 cmp.l      12(a6),d7
[0000071e] 6616                      bne.s      _locb_1
[00000720] 7e00                      moveq.l    #0,d7
[00000722] 3e2d 0012                 move.w     18(a5),d7
[00000726] beae 0008                 cmp.l      8(a6),d7
[0000072a] 660a                      bne.s      _locb_1
[0000072c] 52b9 0000 b6c0            addq.l     #1,_nlocbh
[00000732] 2e0d                      move.l     a5,d7
[00000734] 6032                      bra.s      _locb_2
_locb_1:
[00000736] 2a6c 0008                 movea.l    8(a4),a5
_locb_5:
[0000073a] bbcc                      cmpa.l     a4,a5
[0000073c] 6738                      beq.s      _locb_3
[0000073e] 7e00                      moveq.l    #0,d7
[00000740] 3e2d 002c                 move.w     44(a5),d7
[00000744] beae 000c                 cmp.l      12(a6),d7
[00000748] 6626                      bne.s      _locb_4
[0000074a] 7e00                      moveq.l    #0,d7
[0000074c] 3e2d 0012                 move.w     18(a5),d7
[00000750] beae 0008                 cmp.l      8(a6),d7
[00000754] 661a                      bne.s      _locb_4
[00000756] 52b9 0000 b6c4            addq.l     #1,_nlocbs
[0000075c] 23cd 0000 ade8            move.l     a5,$00015B56
[00000762] 2e39 0000 ade8            move.l     $00015B56,d7
_locb_2:
[00000768] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000076c] 4e5e                      unlk       a6
[0000076e] 4e75                      rts
_locb_4:
[00000770] 2a6d 0008                 movea.l    8(a5),a5
[00000774] 60c4                      bra.s      _locb_5
_locb_3:
[00000776] 52b9 0000 b6c8            addq.l     #1,_nlocbm
[0000077c] 7e00                      moveq.l    #0,d7
[0000077e] 60e8                      bra.s      _locb_2

_locctig:
[00000780] 4e56 fffe                 link       a6,#-2
[00000784] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000788] 2a2e 0010                 move.l     16(a6),d5
[0000078c] 3e2e 000a                 move.w     10(a6),d7
[00000790] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000796] e087                      asr.l      #8,d7
[00000798] e587                      asl.l      #2,d7
[0000079a] 2247                      movea.l    d7,a1
[0000079c] d3fc 0000 0000            adda.l     #_blkdevs,a1
[000007a2] 2251                      movea.l    (a1),a1
[000007a4] 2869 000c                 movea.l    12(a1),a4
[000007a8] 2e05                      move.l     d5,d7
[000007aa] 5387                      subq.l     #1,d7
[000007ac] deae 000c                 add.l      12(a6),d7
[000007b0] 3d47 fffe                 move.w     d7,-2(a6)
[000007b4] 2a6c 0008                 movea.l    8(a4),a5
_locctig_4:
[000007b8] bbcc                      cmpa.l     a4,a5
[000007ba] 6748                      beq.s      _locctig_1
[000007bc] 7e00                      moveq.l    #0,d7
[000007be] 3e2d 0012                 move.w     18(a5),d7
[000007c2] beae 0008                 cmp.l      8(a6),d7
[000007c6] 6636                      bne.s      _locctig_2
[000007c8] 2e2e 000c                 move.l     12(a6),d7
[000007cc] 7c00                      moveq.l    #0,d6
[000007ce] 3c2d 002c                 move.w     44(a5),d6
[000007d2] be86                      cmp.l      d6,d7
[000007d4] 6e28                      bgt.s      _locctig_2
[000007d6] 3e2d 002c                 move.w     44(a5),d7
[000007da] be6e fffe                 cmp.w      -2(a6),d7
[000007de] 621e                      bhi.s      _locctig_2
[000007e0] 7e00                      moveq.l    #0,d7
[000007e2] 3e2d 002c                 move.w     44(a5),d7
[000007e6] 9eae 000c                 sub.l      12(a6),d7
[000007ea] 2e87                      move.l     d7,(a7)
[000007ec] 2f05                      move.l     d5,-(a7)
[000007ee] 4eb9 0000 26f4            jsr        _minu
[000007f4] 588f                      addq.l     #4,a7
[000007f6] 2a07                      move.l     d7,d5
[000007f8] 6604                      bne.s      _locctig_2
[000007fa] 7e00                      moveq.l    #0,d7
[000007fc] 6008                      bra.s      _locctig_3
_locctig_2:
[000007fe] 2a6d 0008                 movea.l    8(a5),a5
[00000802] 60b4                      bra.s      _locctig_4
_locctig_1:
[00000804] 2e05                      move.l     d5,d7
_locctig_3:
[00000806] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000080a] 4e5e                      unlk       a6
[0000080c] 4e75                      rts

_printb:
[0000080e] 4e56 0000                 link       a6,#0
[00000812] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000816] 2a6e 0008                 movea.l    8(a6),a5
[0000081a] 7a00                      moveq.l    #0,d5
_printb_4:
[0000081c] 0c85 0000 000c            cmpi.l     #$0000000C,d5
[00000822] 6c2a                      bge.s      _printb_1
[00000824] 7e01                      moveq.l    #1,d7
[00000826] eba7                      asl.l      d5,d7
[00000828] 7c00                      moveq.l    #0,d6
[0000082a] 3c2d 0010                 move.w     16(a5),d6
[0000082e] ce86                      and.l      d6,d7
[00000830] 670e                      beq.s      _printb_2
[00000832] 227c 0000 adec            movea.l    #$00015B5A,a1
[00000838] 7e00                      moveq.l    #0,d7
[0000083a] 1e31 5800                 move.b     0(a1,d5.l),d7
[0000083e] 6002                      bra.s      _printb_3
_printb_2:
[00000840] 7e20                      moveq.l    #32,d7
_printb_3:
[00000842] 2e87                      move.l     d7,(a7)
[00000844] 4eb9 0000 0000            jsr        _putch
[0000084a] 5285                      addq.l     #1,d5
[0000084c] 60ce                      bra.s      _printb_4
_printb_1:
[0000084e] 2eae 000c                 move.l     12(a6),(a7)
[00000852] 2f3c 0000 adf9            move.l     #$00015B67,-(a7)
[00000858] 4eb9 0000 20d6            jsr        _putfmt
[0000085e] 588f                      addq.l     #4,a7
[00000860] 4297                      clr.l      (a7)
[00000862] 7e00                      moveq.l    #0,d7
[00000864] 3e2d 0012                 move.w     18(a5),d7
[00000868] 2f07                      move.l     d7,-(a7)
[0000086a] 4eb9 0000 204c            jsr        _putdnm
[00000870] 588f                      addq.l     #4,a7
[00000872] 7e00                      moveq.l    #0,d7
[00000874] 3e2d 002c                 move.w     44(a5),d7
[00000878] 2e87                      move.l     d7,(a7)
[0000087a] 2f3c 0000 adfe            move.l     #$00015B6C,-(a7)
[00000880] 4eb9 0000 20d6            jsr        _putfmt
[00000886] 588f                      addq.l     #4,a7
[00000888] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000088c] 4e5e                      unlk       a6
[0000088e] 4e75                      rts

_rdstrat:
[00000890] 4e56 0000                 link       a6,#0
[00000894] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000898] 2eae 000c                 move.l     12(a6),(a7)
[0000089c] 2f2e 0008                 move.l     8(a6),-(a7)
[000008a0] 4eba fc52                 jsr        _getblk(pc)
[000008a4] 588f                      addq.l     #4,a7
[000008a6] 2a47                      movea.l    d7,a5
[000008a8] 082d 0006 0011            btst       #6,17(a5)
[000008ae] 6636                      bne.s      _rdstrat_1
[000008b0] 2e2e 0010                 move.l     16(a6),d7
[000008b4] 08c7 0004                 bset       #4,d7
[000008b8] 8f6d 0010                 or.w       d7,16(a5)
[000008bc] 2b7c 0000 0200 0024       move.l     #$00000200,36(a5)
[000008c4] 2e8d                      move.l     a5,(a7)
[000008c6] 3e2e 000a                 move.w     10(a6),d7
[000008ca] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000008d0] e087                      asr.l      #8,d7
[000008d2] e587                      asl.l      #2,d7
[000008d4] 2247                      movea.l    d7,a1
[000008d6] d3fc 0000 0000            adda.l     #_blkdevs,a1
[000008dc] 2251                      movea.l    (a1),a1
[000008de] 2269 0008                 movea.l    8(a1),a1
[000008e2] 4e91                      jsr        (a1)
[000008e4] 600e                      bra.s      _rdstrat_2
_rdstrat_1:
[000008e6] 082e 0000 0013            btst       #0,19(a6)
[000008ec] 6706                      beq.s      _rdstrat_2
[000008ee] 2e8d                      move.l     a5,(a7)
[000008f0] 4eba fa9e                 jsr        _brelse(pc)
_rdstrat_2:
[000008f4] 2e0d                      move.l     a5,d7
[000008f6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000008fa] 4e5e                      unlk       a6
[000008fc] 4e75                      rts

_readab:
[000008fe] 4e56 0000                 link       a6,#0
[00000902] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000906] 2a2e 0008                 move.l     8(a6),d5
[0000090a] 282e 0010                 move.l     16(a6),d4
[0000090e] 4297                      clr.l      (a7)
[00000910] 2f2e 000c                 move.l     12(a6),-(a7)
[00000914] 2f05                      move.l     d5,-(a7)
[00000916] 4eba ff78                 jsr        _rdstrat(pc)
[0000091a] 508f                      addq.l     #8,a7
[0000091c] 2a47                      movea.l    d7,a5
[0000091e] 4a84                      tst.l      d4
[00000920] 672a                      beq.s      _readab_1
[00000922] 4ab9 0000 0000            tst.l      _rahead
[00000928] 6722                      beq.s      _readab_1
[0000092a] 4878 0001                 pea.l      ($00000001).w
[0000092e] 4eba fa28                 jsr        _bbuy(pc)
[00000932] 588f                      addq.l     #4,a7
[00000934] 4a87                      tst.l      d7
[00000936] 6714                      beq.s      _readab_1
[00000938] 4878 0001                 pea.l      ($00000001).w
[0000093c] 2f04                      move.l     d4,-(a7)
[0000093e] 2f05                      move.l     d5,-(a7)
[00000940] 4eba ff4e                 jsr        _rdstrat(pc)
[00000944] 4fef 000c                 lea.l      12(a7),a7
[00000948] 4eba faaa                 jsr        _bsell(pc)
_readab_1:
[0000094c] 2e8d                      move.l     a5,(a7)
[0000094e] 4eb9 0000 09ca            jsr        _waitio
[00000954] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000958] 4e5e                      unlk       a6
[0000095a] 4e75                      rts

_readb:
[0000095c] 4e56 fffc                 link       a6,#-4
[00000960] 4297                      clr.l      (a7)
[00000962] 2f2e 000c                 move.l     12(a6),-(a7)
[00000966] 2f2e 0008                 move.l     8(a6),-(a7)
[0000096a] 4eba ff24                 jsr        _rdstrat(pc)
[0000096e] 508f                      addq.l     #8,a7
[00000970] 2e87                      move.l     d7,(a7)
[00000972] 4eb9 0000 09ca            jsr        _waitio
[00000978] 4e5e                      unlk       a6
[0000097a] 4e75                      rts

_sleepb:
[0000097c] 4e56 fffc                 link       a6,#-4
[00000980] 226e 0008                 movea.l    8(a6),a1
[00000984] 08e9 0007 0011            bset       #7,17(a1)
[0000098a] 2ebc 0000 addc            move.l     #$00015B4A,(a7)
[00000990] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00000994] 2f2e 0008                 move.l     8(a6),-(a7)
[00000998] 4eb9 0000 8862            jsr        _sleepl
[0000099e] 508f                      addq.l     #8,a7
[000009a0] 4e5e                      unlk       a6
[000009a2] 4e75                      rts

_unfree:
[000009a4] 4e56 0000                 link       a6,#0
[000009a8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000009ac] 2a6e 0008                 movea.l    8(a6),a5
[000009b0] 2ead 0004                 move.l     4(a5),(a7)
[000009b4] 4eb9 0000 0b3e            jsr        _deq
[000009ba] 08ed 0001 0011            bset       #1,17(a5)
[000009c0] 2e0d                      move.l     a5,d7
[000009c2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000009c6] 4e5e                      unlk       a6
[000009c8] 4e75                      rts

_waitio:
[000009ca] 4e56 0000                 link       a6,#0
[000009ce] 48e7 8004                 movem.l    d0/a5,-(a7)
[000009d2] 2a6e 0008                 movea.l    8(a6),a5
[000009d6] 7e00                      moveq.l    #0,d7
[000009d8] 3e39 0000 0000            move.w     _biops,d7
[000009de] 2e87                      move.l     d7,(a7)
[000009e0] 4eb9 0000 0000            jsr        _spl
_waitio_2:
[000009e6] 082d 0006 0011            btst       #6,17(a5)
[000009ec] 6608                      bne.s      _waitio_1
[000009ee] 2e8d                      move.l     a5,(a7)
[000009f0] 4eba ff8a                 jsr        _sleepb(pc)
[000009f4] 60f0                      bra.s      _waitio_2
_waitio_1:
[000009f6] 4eb9 0000 0000            jsr        _spl0
[000009fc] 2e8d                      move.l     a5,(a7)
[000009fe] 4eba fc82                 jsr        _errget(pc)
[00000a02] 2e0d                      move.l     a5,d7
[00000a04] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000a08] 4e5e                      unlk       a6
[00000a0a] 4e75                      rts

_wakeb:
[00000a0c] 4e56 0000                 link       a6,#0
[00000a10] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000a14] 2a6e 0008                 movea.l    8(a6),a5
[00000a18] 082d 0007 0011            btst       #7,17(a5)
[00000a1e] 6716                      beq.s      _wakeb_1
[00000a20] 08ad 0007 0011            bclr       #7,17(a5)
[00000a26] 2ebc 0000 addc            move.l     #$00015B4A,(a7)
[00000a2c] 2f0d                      move.l     a5,-(a7)
[00000a2e] 4eb9 0000 8b66            jsr        _wakeupl
[00000a34] 588f                      addq.l     #4,a7
_wakeb_1:
[00000a36] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000a3a] 4e5e                      unlk       a6
[00000a3c] 4e75                      rts

_writb:
[00000a3e] 4e56 0000                 link       a6,#0
[00000a42] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000a46] 2a6e 0008                 movea.l    8(a6),a5
[00000a4a] 026d ffa3 0010            andi.w     #$FFA3,16(a5)
[00000a50] 08ed 0000 0011            bset       #0,17(a5)
[00000a56] 2b7c 0000 0200 0024       move.l     #$00000200,36(a5)
[00000a5e] 2e8d                      move.l     a5,(a7)
[00000a60] 7e00                      moveq.l    #0,d7
[00000a62] 3e2d 0012                 move.w     18(a5),d7
[00000a66] e087                      asr.l      #8,d7
[00000a68] e587                      asl.l      #2,d7
[00000a6a] 2247                      movea.l    d7,a1
[00000a6c] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00000a72] 2251                      movea.l    (a1),a1
[00000a74] 2269 0008                 movea.l    8(a1),a1
[00000a78] 4e91                      jsr        (a1)
[00000a7a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000a7e] 4e5e                      unlk       a6
[00000a80] 4e75                      rts

_writdb:
[00000a82] 4e56 0000                 link       a6,#0
[00000a86] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000a8a] 2a6e 0008                 movea.l    8(a6),a5
[00000a8e] 082d 0005 0011            btst       #5,17(a5)
[00000a94] 6708                      beq.s      _writdb_1
[00000a96] 2e8d                      move.l     a5,(a7)
[00000a98] 4eba ffa4                 jsr        _writb(pc)
[00000a9c] 600c                      bra.s      _writdb_2
_writdb_1:
[00000a9e] 006d 0044 0010            ori.w      #$0044,16(a5)
[00000aa4] 2e8d                      move.l     a5,(a7)
[00000aa6] 4eba f8e8                 jsr        _brelse(pc)
_writdb_2:
[00000aaa] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000aae] 4e5e                      unlk       a6
[00000ab0] 4e75                      rts

_closed:
[00000ab2] 4e56 0000                 link       a6,#0
[00000ab6] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000aba] 3e2e 000a                 move.w     10(a6),d7
[00000abe] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000ac4] e087                      asr.l      #8,d7
[00000ac6] 2a07                      move.l     d7,d5
[00000ac8] 2e2e 0010                 move.l     16(a6),d7
[00000acc] 0287 0000 6000            andi.l     #$00006000,d7
[00000ad2] 41f9 0000 ae04            lea.l      $00015B72,a0
[00000ad8] 4ef9 0000 0000            jmp        a~jtab
[00000ade] 4878 0001                 pea.l      ($00000001).w
[00000ae2] 2f2e 0008                 move.l     8(a6),-(a7)
[00000ae6] 4eb9 0000 0416            jsr        _buflush
[00000aec] 508f                      addq.l     #8,a7
[00000aee] 2eae 000c                 move.l     12(a6),(a7)
[00000af2] 2f2e 0008                 move.l     8(a6),-(a7)
[00000af6] 2e05                      move.l     d5,d7
[00000af8] e587                      asl.l      #2,d7
[00000afa] 2247                      movea.l    d7,a1
[00000afc] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00000b02] 2251                      movea.l    (a1),a1
[00000b04] 2269 0004                 movea.l    4(a1),a1
[00000b08] 4e91                      jsr        (a1)
[00000b0a] 588f                      addq.l     #4,a7
[00000b0c] 6028                      bra.s      _closed_1
[00000b0e] 2eae 0008                 move.l     8(a6),(a7)
[00000b12] 4eb9 0000 124c            jsr        _rdoff
[00000b18] 2eae 000c                 move.l     12(a6),(a7)
[00000b1c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000b20] 2e05                      move.l     d5,d7
[00000b22] e587                      asl.l      #2,d7
[00000b24] 2247                      movea.l    d7,a1
[00000b26] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00000b2c] 2251                      movea.l    (a1),a1
[00000b2e] 2269 0004                 movea.l    4(a1),a1
[00000b32] 4e91                      jsr        (a1)
[00000b34] 588f                      addq.l     #4,a7
_closed_1:
[00000b36] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000b3a] 4e5e                      unlk       a6
[00000b3c] 4e75                      rts

_deq:
[00000b3e] 4e56 0000                 link       a6,#0
[00000b42] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000b46] 2a6e 0008                 movea.l    8(a6),a5
[00000b4a] 2855                      movea.l    (a5),a4
[00000b4c] 2e0c                      move.l     a4,d7
[00000b4e] 671c                      beq.s      _deq_1
[00000b50] 2a94                      move.l     (a4),(a5)
[00000b52] 670a                      beq.s      _deq_2
[00000b54] 2254                      movea.l    (a4),a1
[00000b56] 236c 0004 0004            move.l     4(a4),4(a1)
[00000b5c] 600c                      bra.s      _deq_3
_deq_2:
[00000b5e] 2e2d 0004                 move.l     4(a5),d7
[00000b62] be8c                      cmp.l      a4,d7
[00000b64] 6604                      bne.s      _deq_3
[00000b66] 2b4d 0004                 move.l     a5,4(a5)
_deq_3:
[00000b6a] 4294                      clr.l      (a4)
_deq_1:
[00000b6c] 2e0c                      move.l     a4,d7
[00000b6e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000b72] 4e5e                      unlk       a6
[00000b74] 4e75                      rts

_enq:
[00000b76] 4e56 0000                 link       a6,#0
[00000b7a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000b7e] 2a6e 0008                 movea.l    8(a6),a5
[00000b82] 286e 000c                 movea.l    12(a6),a4
[00000b86] 296d 0004 0004            move.l     4(a5),4(a4)
[00000b8c] 226d 0004                 movea.l    4(a5),a1
[00000b90] 2891                      move.l     (a1),(a4)
[00000b92] 226d 0004                 movea.l    4(a5),a1
[00000b96] 228c                      move.l     a4,(a1)
[00000b98] 2b4c 0004                 move.l     a4,4(a5)
[00000b9c] 2e0c                      move.l     a4,d7
[00000b9e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000ba2] 4e5e                      unlk       a6
[00000ba4] 4e75                      rts

_enqelev:
[00000ba6] 4e56 0000                 link       a6,#0
[00000baa] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000bae] 2a6e 000c                 movea.l    12(a6),a5
[00000bb2] 2b6e 0010 0018            move.l     16(a6),24(a5)
[00000bb8] 226e 0008                 movea.l    8(a6),a1
[00000bbc] 2851                      movea.l    (a1),a4
[00000bbe] 2e0c                      move.l     a4,d7
[00000bc0] 6734                      beq.s      _enqelev_1
_enqelev_3:
[00000bc2] 2654                      movea.l    (a4),a3
[00000bc4] 2e0b                      move.l     a3,d7
[00000bc6] 672e                      beq.s      _enqelev_1
[00000bc8] 2e2c 0018                 move.l     24(a4),d7
[00000bcc] bead 0018                 cmp.l      24(a5),d7
[00000bd0] 6210                      bhi.s      _enqelev_2
[00000bd2] 2e2d 0018                 move.l     24(a5),d7
[00000bd6] beab 0018                 cmp.l      24(a3),d7
[00000bda] 651a                      bcs.s      _enqelev_1
[00000bdc] 6004                      bra.s      _enqelev_2
_enqelev_4:
[00000bde] 284b                      movea.l    a3,a4
[00000be0] 60e0                      bra.s      _enqelev_3
_enqelev_2:
[00000be2] 2e2b 0018                 move.l     24(a3),d7
[00000be6] bead 0018                 cmp.l      24(a5),d7
[00000bea] 64f2                      bcc.s      _enqelev_4
[00000bec] 2e2d 0018                 move.l     24(a5),d7
[00000bf0] beac 0018                 cmp.l      24(a4),d7
[00000bf4] 62e8                      bhi.s      _enqelev_4
_enqelev_1:
[00000bf6] 2e8d                      move.l     a5,(a7)
[00000bf8] 2e0c                      move.l     a4,d7
[00000bfa] 6708                      beq.s      _enqelev_5
[00000bfc] 2e0b                      move.l     a3,d7
[00000bfe] 6704                      beq.s      _enqelev_5
[00000c00] 2e0b                      move.l     a3,d7
[00000c02] 6004                      bra.s      _enqelev_6
_enqelev_5:
[00000c04] 2e2e 0008                 move.l     8(a6),d7
_enqelev_6:
[00000c08] 2f07                      move.l     d7,-(a7)
[00000c0a] 4eba ff6a                 jsr        _enq(pc)
[00000c0e] 588f                      addq.l     #4,a7
[00000c10] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000c14] 4e5e                      unlk       a6
[00000c16] 4e75                      rts

_getaddr:
[00000c18] 4e56 0000                 link       a6,#0
[00000c1c] 226e 0008                 movea.l    8(a6),a1
[00000c20] 2e29 0020                 move.l     32(a1),d7
[00000c24] 4e5e                      unlk       a6
[00000c26] 4e75                      rts

_getdev:
[00000c28] 4e56 0000                 link       a6,#0
[00000c2c] 226e 0008                 movea.l    8(a6),a1
[00000c30] 7e00                      moveq.l    #0,d7
[00000c32] 3e29 0012                 move.w     18(a1),d7
[00000c36] 4e5e                      unlk       a6
[00000c38] 4e75                      rts

_mountdev:
[00000c3a] 4e56 fffe                 link       a6,#-2
[00000c3e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00000c42] 4297                      clr.l      (a7)
[00000c44] 2f2e 0008                 move.l     8(a6),-(a7)
[00000c48] 4eb9 0000 3ebe            jsr        _findi
[00000c4e] 588f                      addq.l     #4,a7
[00000c50] 2a47                      movea.l    d7,a5
[00000c52] 2e0d                      move.l     a5,d7
[00000c54] 6604                      bne.s      _mountdev_1
[00000c56] 7e00                      moveq.l    #0,d7
[00000c58] 604e                      bra.s      _mountdev_2
_mountdev_1:
[00000c5a] 3d6d 0022 fffe            move.w     34(a5),-2(a6)
[00000c60] 7e00                      moveq.l    #0,d7
[00000c62] 3e2d 001a                 move.w     26(a5),d7
[00000c66] 0287 0000 6000            andi.l     #$00006000,d7
[00000c6c] 0c87 0000 6000            cmpi.l     #$00006000,d7
[00000c72] 6612                      bne.s      _mountdev_3
[00000c74] 7e00                      moveq.l    #0,d7
[00000c76] 3e2e fffe                 move.w     -2(a6),d7
[00000c7a] e087                      asr.l      #8,d7
[00000c7c] 2c39 0000 0000            move.l     _nblkdev,d6
[00000c82] bc87                      cmp.l      d7,d6
[00000c84] 6210                      bhi.s      _mountdev_4
_mountdev_3:
[00000c86] 4878 000f                 pea.l      ($0000000F).w
[00000c8a] 4eb9 0000 2868            jsr        _uerror
[00000c90] 588f                      addq.l     #4,a7
[00000c92] 426e fffe                 clr.w      -2(a6)
_mountdev_4:
[00000c96] 4297                      clr.l      (a7)
[00000c98] 2f0d                      move.l     a5,-(a7)
[00000c9a] 4eb9 0000 3540            jsr        _puti
[00000ca0] 588f                      addq.l     #4,a7
[00000ca2] 7e00                      moveq.l    #0,d7
[00000ca4] 3e2e fffe                 move.w     -2(a6),d7
_mountdev_2:
[00000ca8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000cac] 4e5e                      unlk       a6
[00000cae] 4e75                      rts

_nodev:
[00000cb0] 4878 0013                 pea.l      ($00000013).w
[00000cb4] 4eb9 0000 2868            jsr        _uerror
[00000cba] 588f                      addq.l     #4,a7
[00000cbc] 4e75                      rts

_nulldev:
[00000cbe] 4e75                      rts

_opendev:
[00000cc0] 4e56 0000                 link       a6,#0
[00000cc4] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000cc8] 3e2e 000a                 move.w     10(a6),d7
[00000ccc] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000cd2] e087                      asr.l      #8,d7
[00000cd4] 2a07                      move.l     d7,d5
[00000cd6] 2e2e 0010                 move.l     16(a6),d7
[00000cda] 0287 0000 6000            andi.l     #$00006000,d7
[00000ce0] 41f9 0000 ae20            lea.l      $00015B8E,a0
[00000ce6] 4ef9 0000 0000            jmp        a~jtab
[00000cec] 2e39 0000 0000            move.l     _nblkdev,d7
[00000cf2] be85                      cmp.l      d5,d7
[00000cf4] 620e                      bhi.s      _opendev_1
[00000cf6] 4878 0006                 pea.l      ($00000006).w
[00000cfa] 4eb9 0000 2868            jsr        _uerror
[00000d00] 588f                      addq.l     #4,a7
[00000d02] 6052                      bra.s      _opendev_2
_opendev_1:
[00000d04] 2eae 000c                 move.l     12(a6),(a7)
[00000d08] 2f2e 0008                 move.l     8(a6),-(a7)
[00000d0c] 2e05                      move.l     d5,d7
[00000d0e] e587                      asl.l      #2,d7
[00000d10] 2247                      movea.l    d7,a1
[00000d12] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00000d18] 2251                      movea.l    (a1),a1
[00000d1a] 2251                      movea.l    (a1),a1
[00000d1c] 4e91                      jsr        (a1)
[00000d1e] 588f                      addq.l     #4,a7
[00000d20] 6034                      bra.s      _opendev_2
[00000d22] 2e39 0000 0000            move.l     _nchrdev,d7
[00000d28] be85                      cmp.l      d5,d7
[00000d2a] 620e                      bhi.s      _opendev_3
[00000d2c] 4878 0006                 pea.l      ($00000006).w
[00000d30] 4eb9 0000 2868            jsr        _uerror
[00000d36] 588f                      addq.l     #4,a7
[00000d38] 601c                      bra.s      _opendev_2
_opendev_3:
[00000d3a] 2eae 000c                 move.l     12(a6),(a7)
[00000d3e] 2f2e 0008                 move.l     8(a6),-(a7)
[00000d42] 2e05                      move.l     d5,d7
[00000d44] e587                      asl.l      #2,d7
[00000d46] 2247                      movea.l    d7,a1
[00000d48] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00000d4e] 2251                      movea.l    (a1),a1
[00000d50] 2251                      movea.l    (a1),a1
[00000d52] 4e91                      jsr        (a1)
[00000d54] 588f                      addq.l     #4,a7
_opendev_2:
[00000d56] 4297                      clr.l      (a7)
[00000d58] 4eb9 0000 2868            jsr        _uerror
[00000d5e] 4a87                      tst.l      d7
[00000d60] 6604                      bne.s      _opendev_4
[00000d62] 7e01                      moveq.l    #1,d7
[00000d64] 6002                      bra.s      _opendev_5
_opendev_4:
[00000d66] 7e00                      moveq.l    #0,d7
_opendev_5:
[00000d68] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000d6c] 4e5e                      unlk       a6
[00000d6e] 4e75                      rts

_readev:
[00000d70] 4e56 fffc                 link       a6,#-4
[00000d74] 2eae 0008                 move.l     8(a6),(a7)
[00000d78] 3e2e 000a                 move.w     10(a6),d7
[00000d7c] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000d82] e087                      asr.l      #8,d7
[00000d84] e587                      asl.l      #2,d7
[00000d86] 2247                      movea.l    d7,a1
[00000d88] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00000d8e] 2251                      movea.l    (a1),a1
[00000d90] 2269 0008                 movea.l    8(a1),a1
[00000d94] 4e91                      jsr        (a1)
[00000d96] 4e5e                      unlk       a6
[00000d98] 4e75                      rts

_wridev:
[00000d9a] 4e56 fffc                 link       a6,#-4
[00000d9e] 2eae 0008                 move.l     8(a6),(a7)
[00000da2] 3e2e 000a                 move.w     10(a6),d7
[00000da6] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00000dac] e087                      asr.l      #8,d7
[00000dae] e587                      asl.l      #2,d7
[00000db0] 2247                      movea.l    d7,a1
[00000db2] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00000db8] 2251                      movea.l    (a1),a1
[00000dba] 2269 000c                 movea.l    12(a1),a1
[00000dbe] 4e91                      jsr        (a1)
[00000dc0] 4e5e                      unlk       a6
[00000dc2] 4e75                      rts

_deqc:
[00000dc4] 4e56 fffc                 link       a6,#-4
[00000dc8] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000dcc] 7e00                      moveq.l    #0,d7
[00000dce] 3e39 0000 0000            move.w     _ttyps,d7
[00000dd4] 2e87                      move.l     d7,(a7)
[00000dd6] 4eb9 0000 0000            jsr        _spl
[00000ddc] 3d47 fffe                 move.w     d7,-2(a6)
[00000de0] 2a6e 0008                 movea.l    8(a6),a5
[00000de4] 4a55                      tst.w      (a5)
[00000de6] 6618                      bne.s      _deqc_1
[00000de8] 7e00                      moveq.l    #0,d7
[00000dea] 3e2e fffe                 move.w     -2(a6),d7
[00000dee] 2e87                      move.l     d7,(a7)
[00000df0] 4eb9 0000 0000            jsr        _spl
[00000df6] 7eff                      moveq.l    #-1,d7
[00000df8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000dfc] 4e5e                      unlk       a6
[00000dfe] 4e75                      rts
_deqc_1:
[00000e00] 226d 0002                 movea.l    2(a5),a1
[00000e04] 1d51 fffd                 move.b     (a1),-3(a6)
[00000e08] 5355                      subq.w     #1,(a5)
[00000e0a] 6634                      bne.s      _deqc_2
[00000e0c] 7ef0                      moveq.l    #-16,d7
[00000e0e] cead 0002                 and.l      2(a5),d7
[00000e12] 2847                      movea.l    d7,a4
[00000e14] 4255                      clr.w      (a5)
[00000e16] 42ad 0002                 clr.l      2(a5)
[00000e1a] 42ad 0006                 clr.l      6(a5)
[00000e1e] 4ab9 0000 ae3c            tst.l      _clist
[00000e24] 660c                      bne.s      _deqc_3
[00000e26] 2ebc 0000 ae3c            move.l     #_clist,(a7)
[00000e2c] 4eb9 0000 8b4c            jsr        _wakeup
_deqc_3:
[00000e32] 28b9 0000 ae3c            move.l     _clist,(a4)
[00000e38] 23cc 0000 ae3c            move.l     a4,_clist
[00000e3e] 6042                      bra.s      _deqc_4
_deqc_2:
[00000e40] 52ad 0002                 addq.l     #1,2(a5)
[00000e44] 2e2d 0002                 move.l     2(a5),d7
[00000e48] 7c0f                      moveq.l    #15,d6
[00000e4a] cc07                      and.b      d7,d6
[00000e4c] 7e00                      moveq.l    #0,d7
[00000e4e] 1e06                      move.b     d6,d7
[00000e50] 6630                      bne.s      _deqc_4
[00000e52] 7ef0                      moveq.l    #-16,d7
[00000e54] dead 0002                 add.l      2(a5),d7
[00000e58] 2847                      movea.l    d7,a4
[00000e5a] 2e14                      move.l     (a4),d7
[00000e5c] 5887                      addq.l     #4,d7
[00000e5e] 2b47 0002                 move.l     d7,2(a5)
[00000e62] 4ab9 0000 ae3c            tst.l      _clist
[00000e68] 660c                      bne.s      _deqc_5
[00000e6a] 2ebc 0000 ae3c            move.l     #_clist,(a7)
[00000e70] 4eb9 0000 8b4c            jsr        _wakeup
_deqc_5:
[00000e76] 28b9 0000 ae3c            move.l     _clist,(a4)
[00000e7c] 23cc 0000 ae3c            move.l     a4,_clist
_deqc_4:
[00000e82] 7e00                      moveq.l    #0,d7
[00000e84] 3e2e fffe                 move.w     -2(a6),d7
[00000e88] 2e87                      move.l     d7,(a7)
[00000e8a] 4eb9 0000 0000            jsr        _spl
[00000e90] 7e00                      moveq.l    #0,d7
[00000e92] 1e2e fffd                 move.b     -3(a6),d7
[00000e96] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000e9a] 4e5e                      unlk       a6
[00000e9c] 4e75                      rts

_enqc:
[00000e9e] 4e56 fffc                 link       a6,#-4
[00000ea2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000ea6] 7e00                      moveq.l    #0,d7
[00000ea8] 3e39 0000 0000            move.w     _ttyps,d7
[00000eae] 2e87                      move.l     d7,(a7)
[00000eb0] 4eb9 0000 0000            jsr        _spl
[00000eb6] 2d47 fffc                 move.l     d7,-4(a6)
[00000eba] 2a6e 000c                 movea.l    12(a6),a5
[00000ebe] 7e0f                      moveq.l    #15,d7
[00000ec0] 2c2d 0006                 move.l     6(a5),d6
[00000ec4] ce06                      and.b      d6,d7
[00000ec6] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000ecc] 664a                      bne.s      _enqc_1
[00000ece] 2879 0000 ae3c            movea.l    _clist,a4
[00000ed4] 2e0c                      move.l     a4,d7
[00000ed6] 6614                      bne.s      _enqc_2
[00000ed8] 2eae fffc                 move.l     -4(a6),(a7)
[00000edc] 4eb9 0000 0000            jsr        _spl
[00000ee2] 5279 0000 ae44            addq.w     #1,_nclost
[00000ee8] 7e01                      moveq.l    #1,d7
[00000eea] 6046                      bra.s      _enqc_3
_enqc_2:
[00000eec] 2279 0000 ae3c            movea.l    _clist,a1
[00000ef2] 23d1 0000 ae3c            move.l     (a1),_clist
[00000ef8] 4294                      clr.l      (a4)
[00000efa] 4a55                      tst.w      (a5)
[00000efc] 670a                      beq.s      _enqc_4
[00000efe] 226d 0006                 movea.l    6(a5),a1
[00000f02] 234c fff0                 move.l     a4,-16(a1)
[00000f06] 6008                      bra.s      _enqc_5
_enqc_4:
[00000f08] 2e0c                      move.l     a4,d7
[00000f0a] 5887                      addq.l     #4,d7
[00000f0c] 2b47 0002                 move.l     d7,2(a5)
_enqc_5:
[00000f10] 2e0c                      move.l     a4,d7
[00000f12] 5887                      addq.l     #4,d7
[00000f14] 2b47 0006                 move.l     d7,6(a5)
_enqc_1:
[00000f18] 226d 0006                 movea.l    6(a5),a1
[00000f1c] 12ae 000b                 move.b     11(a6),(a1)
[00000f20] 52ad 0006                 addq.l     #1,6(a5)
[00000f24] 5255                      addq.w     #1,(a5)
[00000f26] 2eae fffc                 move.l     -4(a6),(a7)
[00000f2a] 4eb9 0000 0000            jsr        _spl
[00000f30] 7e00                      moveq.l    #0,d7
_enqc_3:
[00000f32] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000f36] 4e5e                      unlk       a6
[00000f38] 4e75                      rts

_popc:
[00000f3a] 4e56 fffa                 link       a6,#-6
[00000f3e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000f42] 7e00                      moveq.l    #0,d7
[00000f44] 3e39 0000 0000            move.w     _ttyps,d7
[00000f4a] 2e87                      move.l     d7,(a7)
[00000f4c] 4eb9 0000 0000            jsr        _spl
[00000f52] 2d47 fffc                 move.l     d7,-4(a6)
[00000f56] 2a6e 0008                 movea.l    8(a6),a5
[00000f5a] 4a55                      tst.w      (a5)
[00000f5c] 670a                      beq.s      _popc_1
[00000f5e] 226d 0006                 movea.l    6(a5),a1
[00000f62] 1d69 ffff fffb            move.b     -1(a1),-5(a6)
_popc_1:
[00000f68] 2e2e 000c                 move.l     12(a6),d7
[00000f6c] 9f55                      sub.w      d7,(a5)
[00000f6e] 7ef0                      moveq.l    #-16,d7
[00000f70] cead 0002                 and.l      2(a5),d7
[00000f74] 2847                      movea.l    d7,a4
[00000f76] 2e2d 0006                 move.l     6(a5),d7
[00000f7a] 5387                      subq.l     #1,d7
[00000f7c] 7cf0                      moveq.l    #-16,d6
[00000f7e] cc87                      and.l      d7,d6
[00000f80] 2646                      movea.l    d6,a3
[00000f82] 4a55                      tst.w      (a5)
[00000f84] 6630                      bne.s      _popc_2
[00000f86] 2e0c                      move.l     a4,d7
[00000f88] 6728                      beq.s      _popc_3
[00000f8a] 42ad 0002                 clr.l      2(a5)
[00000f8e] 42ad 0006                 clr.l      6(a5)
[00000f92] 4ab9 0000 ae3c            tst.l      _clist
[00000f98] 660c                      bne.s      _popc_4
[00000f9a] 2ebc 0000 ae3c            move.l     #_clist,(a7)
[00000fa0] 4eb9 0000 8b4c            jsr        _wakeup
_popc_4:
[00000fa6] 26b9 0000 ae3c            move.l     _clist,(a3)
[00000fac] 23cc 0000 ae3c            move.l     a4,_clist
_popc_3:
[00000fb2] 4255                      clr.w      (a5)
[00000fb4] 607c                      bra.s      _popc_5
_popc_2:
[00000fb6] 7e00                      moveq.l    #0,d7
[00000fb8] 3e15                      move.w     (a5),d7
[00000fba] 23c7 0000 ae4a            move.l     d7,$00015BB8
[00000fc0] 7e0f                      moveq.l    #15,d7
[00000fc2] cead 0002                 and.l      2(a5),d7
[00000fc6] 7c10                      moveq.l    #16,d6
[00000fc8] 9c87                      sub.l      d7,d6
[00000fca] 23c6 0000 ae46            move.l     d6,$00015BB4
_popc_7:
[00000fd0] 2e39 0000 ae46            move.l     $00015BB4,d7
[00000fd6] beb9 0000 ae4a            cmp.l      $00015BB8,d7
[00000fdc] 6418                      bcc.s      _popc_6
[00000fde] 2854                      movea.l    (a4),a4
[00000fe0] 2e39 0000 ae46            move.l     $00015BB4,d7
[00000fe6] 9fb9 0000 ae4a            sub.l      d7,$00015BB8
[00000fec] 700c                      moveq.l    #12,d0
[00000fee] 23c0 0000 ae46            move.l     d0,$00015BB4
[00000ff4] 60da                      bra.s      _popc_7
_popc_6:
[00000ff6] b9cb                      cmpa.l     a3,a4
[00000ff8] 6722                      beq.s      _popc_8
[00000ffa] 4ab9 0000 ae3c            tst.l      _clist
[00001000] 660c                      bne.s      _popc_9
[00001002] 2ebc 0000 ae3c            move.l     #_clist,(a7)
[00001008] 4eb9 0000 8b4c            jsr        _wakeup
_popc_9:
[0000100e] 26b9 0000 ae3c            move.l     _clist,(a3)
[00001014] 23d4 0000 ae3c            move.l     (a4),_clist
[0000101a] 4294                      clr.l      (a4)
_popc_8:
[0000101c] 7e10                      moveq.l    #16,d7
[0000101e] 43f4 7800                 lea.l      0(a4,d7.l),a1
[00001022] d3f9 0000 ae4a            adda.l     $00015BB8,a1
[00001028] 93f9 0000 ae46            suba.l     $00015BB4,a1
[0000102e] 2b49 0006                 move.l     a1,6(a5)
_popc_5:
[00001032] 2eae fffc                 move.l     -4(a6),(a7)
[00001036] 4eb9 0000 0000            jsr        _spl
[0000103c] 7e00                      moveq.l    #0,d7
[0000103e] 1e2e fffb                 move.b     -5(a6),d7
[00001042] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001046] 4e5e                      unlk       a6
[00001048] 4e75                      rts

x104a:
[0000104a] 4e56 0000                 link       a6,#0
[0000104e] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001052] 2a6e 0008                 movea.l    8(a6),a5
[00001056] 2e8d                      move.l     a5,(a7)
[00001058] 4878 0008                 pea.l      ($00000008).w
[0000105c] 4eb9 0000 175a            jsr        _ttout
[00001062] 588f                      addq.l     #4,a7
[00001064] 2e8d                      move.l     a5,(a7)
[00001066] 4878 0020                 pea.l      ($00000020).w
[0000106a] 4eb9 0000 175a            jsr        _ttout
[00001070] 588f                      addq.l     #4,a7
[00001072] 2e8d                      move.l     a5,(a7)
[00001074] 4878 0008                 pea.l      ($00000008).w
[00001078] 4eb9 0000 175a            jsr        _ttout
[0000107e] 588f                      addq.l     #4,a7
[00001080] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001084] 4e5e                      unlk       a6
[00001086] 4e75                      rts

x1088:
[00001088] 4e56 0000                 link       a6,#0
[0000108c] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00001090] 2a6e 0008                 movea.l    8(a6),a5
[00001094] 2a2e 000c                 move.l     12(a6),d5
[00001098] 4aae 0010                 tst.l      16(a6)
[0000109c] 670e                      beq.s      x1088_1
[0000109e] 2e3c 0000 0100            move.l     #$00000100,d7
[000010a4] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000010a8] 4e5e                      unlk       a6
[000010aa] 4e75                      rts
x1088_1:
[000010ac] 4a6d 0034                 tst.w      52(a5)
[000010b0] 6700 009e                 beq        x1088_2
[000010b4] 4878 0001                 pea.l      ($00000001).w
[000010b8] 486d 000e                 pea.l      14(a5)
[000010bc] 4eb9 0000 0f3a            jsr        _popc
[000010c2] 508f                      addq.l     #8,a7
[000010c4] 2807                      move.l     d7,d4
[000010c6] 0804 0007                 btst       #7,d4
[000010ca] 6726                      beq.s      x1088_3
[000010cc] 4878 0001                 pea.l      ($00000001).w
[000010d0] 486d 000e                 pea.l      14(a5)
[000010d4] 4eb9 0000 0f3a            jsr        _popc
[000010da] 508f                      addq.l     #8,a7
[000010dc] 0804 0006                 btst       #6,d4
[000010e0] 6708                      beq.s      x1088_4
[000010e2] 0084 ffff ffc0            ori.l      #$FFFFFFC0,d4
[000010e8] 600a                      bra.s      x1088_5
x1088_4:
[000010ea] 0284 0000 003f            andi.l     #$0000003F,d4
[000010f0] 6002                      bra.s      x1088_5
x1088_3:
[000010f2] 7801                      moveq.l    #1,d4
x1088_5:
[000010f4] 536d 0034                 subq.w     #1,52(a5)
[000010f8] 0805 0007                 btst       #7,d5
[000010fc] 6644                      bne.s      x1088_6
[000010fe] 082d 0003 0005            btst       #3,5(a5)
[00001104] 673c                      beq.s      x1088_6
[00001106] 3e2d 002e                 move.w     46(a5),d7
[0000110a] 48c7                      ext.l      d7
[0000110c] 3c2d 0030                 move.w     48(a5),d6
[00001110] 48c6                      ext.l      d6
[00001112] 9e86                      sub.l      d6,d7
[00001114] d887                      add.l      d7,d4
x1088_8:
[00001116] 4a84                      tst.l      d4
[00001118] 6c12                      bge.s      x1088_7
[0000111a] 2e8d                      move.l     a5,(a7)
[0000111c] 4878 0020                 pea.l      ($00000020).w
[00001120] 4eb9 0000 175a            jsr        _ttout
[00001126] 588f                      addq.l     #4,a7
[00001128] 5284                      addq.l     #1,d4
[0000112a] 60ea                      bra.s      x1088_8
x1088_7:
[0000112c] 4a84                      tst.l      d4
[0000112e] 6f0a                      ble.s      x1088_9
[00001130] 2e8d                      move.l     a5,(a7)
[00001132] 4eba ff16                 jsr        $0000104A(pc)
[00001136] 5384                      subq.l     #1,d4
[00001138] 60f2                      bra.s      x1088_7
x1088_9:
[0000113a] 2e8d                      move.l     a5,(a7)
[0000113c] 226d 0026                 movea.l    38(a5),a1
[00001140] 4e91                      jsr        (a1)
x1088_6:
[00001142] 3b6d 002e 0030            move.w     46(a5),48(a5)
[00001148] 4aae 0014                 tst.l      20(a6)
[0000114c] 6600 ff5e                 bne        x1088_1
x1088_2:
[00001150] 0805 0007                 btst       #7,d5
[00001154] 6708                      beq.s      x1088_10
[00001156] 2e3c 0000 0800            move.l     #$00000800,d7
[0000115c] 6006                      bra.s      x1088_11
x1088_10:
[0000115e] 2e3c 0000 1800            move.l     #$00001800,d7
x1088_11:
[00001164] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001168] 4e5e                      unlk       a6
[0000116a] 4e75                      rts

_flush:
[0000116c] 4e56 fffc                 link       a6,#-4
[00001170] 2eae 0008                 move.l     8(a6),(a7)
[00001174] 4eb9 0000 1188            jsr        _flushi
[0000117a] 2eae 0008                 move.l     8(a6),(a7)
[0000117e] 4eb9 0000 11f2            jsr        _flusho
[00001184] 4e5e                      unlk       a6
[00001186] 4e75                      rts

_flushi:
[00001188] 4e56 0000                 link       a6,#0
[0000118c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001190] 2a6e 0008                 movea.l    8(a6),a5
[00001194] 7e00                      moveq.l    #0,d7
[00001196] 3e39 0000 0000            move.w     _ttyps,d7
[0000119c] 2e87                      move.l     d7,(a7)
[0000119e] 4eb9 0000 0000            jsr        _spl
[000011a4] 2a07                      move.l     d7,d5
[000011a6] 7e00                      moveq.l    #0,d7
[000011a8] 3e2d 000e                 move.w     14(a5),d7
[000011ac] 2e87                      move.l     d7,(a7)
[000011ae] 486d 000e                 pea.l      14(a5)
[000011b2] 4eb9 0000 0f3a            jsr        _popc
[000011b8] 588f                      addq.l     #4,a7
[000011ba] 426d 002c                 clr.w      44(a5)
[000011be] 426d 0034                 clr.w      52(a5)
[000011c2] 08ad 0002 000d            bclr       #2,13(a5)
[000011c8] 2e8d                      move.l     a5,(a7)
[000011ca] 4eb9 0000 1e9e            jsr        $00001E9E
[000011d0] 2e85                      move.l     d5,(a7)
[000011d2] 4eb9 0000 0000            jsr        _spl
[000011d8] 2ebc 0000 af16            move.l     #$00015C84,(a7)
[000011de] 486d 000e                 pea.l      14(a5)
[000011e2] 4eb9 0000 8b66            jsr        _wakeupl
[000011e8] 588f                      addq.l     #4,a7
[000011ea] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000011ee] 4e5e                      unlk       a6
[000011f0] 4e75                      rts

_flusho:
[000011f2] 4e56 0000                 link       a6,#0
[000011f6] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000011fa] 2a6e 0008                 movea.l    8(a6),a5
[000011fe] 7e00                      moveq.l    #0,d7
[00001200] 3e39 0000 0000            move.w     _ttyps,d7
[00001206] 2e87                      move.l     d7,(a7)
[00001208] 4eb9 0000 0000            jsr        _spl
[0000120e] 2a07                      move.l     d7,d5
[00001210] 7e00                      moveq.l    #0,d7
[00001212] 3e2d 0018                 move.w     24(a5),d7
[00001216] 2e87                      move.l     d7,(a7)
[00001218] 486d 0018                 pea.l      24(a5)
[0000121c] 4eb9 0000 0f3a            jsr        _popc
[00001222] 588f                      addq.l     #4,a7
[00001224] 08ad 0004 000d            bclr       #4,13(a5)
[0000122a] 2e85                      move.l     d5,(a7)
[0000122c] 4eb9 0000 0000            jsr        _spl
[00001232] 2ebc 0000 af1a            move.l     #$00015C88,(a7)
[00001238] 486d 0018                 pea.l      24(a5)
[0000123c] 4eb9 0000 8b66            jsr        _wakeupl
[00001242] 588f                      addq.l     #4,a7
[00001244] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001248] 4e5e                      unlk       a6
[0000124a] 4e75                      rts

_rdoff:
[0000124c] 4e56 0000                 link       a6,#0
[00001250] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001254] 7e00                      moveq.l    #0,d7
[00001256] 3e39 0000 0000            move.w     _ttyps,d7
[0000125c] 2e87                      move.l     d7,(a7)
[0000125e] 4eb9 0000 0000            jsr        _spl
[00001264] 2a07                      move.l     d7,d5
[00001266] 287c 0000 ae92            movea.l    #$00015C00,a4
_rdoff_3:
[0000126c] 2a54                      movea.l    (a4),a5
[0000126e] 2e0d                      move.l     a5,d7
[00001270] 673e                      beq.s      _rdoff_1
[00001272] bbfc 0000 ae92            cmpa.l     #$00015C00,a5
[00001278] 6736                      beq.s      _rdoff_1
[0000127a] 7e00                      moveq.l    #0,d7
[0000127c] 3e2d 002a                 move.w     42(a5),d7
[00001280] beae 0008                 cmp.l      8(a6),d7
[00001284] 6622                      bne.s      _rdoff_2
[00001286] 0c6d 0001 0032            cmpi.w     #$0001,50(a5)
[0000128c] 6e22                      bgt.s      _rdoff_1
[0000128e] 28ad 0022                 move.l     34(a5),(a4)
[00001292] 42ad 0022                 clr.l      34(a5)
[00001296] 1b79 0000 ae54 0006       move.b     $00015BC2,6(a5)
[0000129e] 1b79 0000 ae55 0007       move.b     $00015BC3,7(a5)
[000012a6] 6008                      bra.s      _rdoff_1
_rdoff_2:
[000012a8] 43ed 0022                 lea.l      34(a5),a1
[000012ac] 2849                      movea.l    a1,a4
[000012ae] 60bc                      bra.s      _rdoff_3
_rdoff_1:
[000012b0] 2e85                      move.l     d5,(a7)
[000012b2] 4eb9 0000 0000            jsr        _spl
[000012b8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000012bc] 4e5e                      unlk       a6
[000012be] 4e75                      rts

x12c0:
[000012c0] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000012c4] 287c 0000 ae92            movea.l    #$00015C00,a4
x12c0_5:
[000012ca] 2a54                      movea.l    (a4),a5
[000012cc] bbfc 0000 ae92            cmpa.l     #$00015C00,a5
[000012d2] 6756                      beq.s      x12c0_1
[000012d4] 1e2d 000b                 move.b     11(a5),d7
[000012d8] 0c07 00ff                 cmpi.b     #$FF,d7
[000012dc] 6722                      beq.s      x12c0_2
[000012de] 4a2d 0006                 tst.b      6(a5)
[000012e2] 6706                      beq.s      x12c0_3
[000012e4] 4a6d 002c                 tst.w      44(a5)
[000012e8] 670e                      beq.s      x12c0_4
x12c0_3:
[000012ea] 522d 000b                 addq.b     #1,11(a5)
[000012ee] 1e2d 000b                 move.b     11(a5),d7
[000012f2] be2d 0007                 cmp.b      7(a5),d7
[000012f6] 6408                      bcc.s      x12c0_2
x12c0_4:
[000012f8] 43ed 0022                 lea.l      34(a5),a1
[000012fc] 2849                      movea.l    a1,a4
[000012fe] 60ca                      bra.s      x12c0_5
x12c0_2:
[00001300] 28ad 0022                 move.l     34(a5),(a4)
[00001304] 42ad 0022                 clr.l      34(a5)
[00001308] 082d 0000 000c            btst       #0,12(a5)
[0000130e] 67ba                      beq.s      x12c0_5
[00001310] 08ad 0000 000c            bclr       #0,12(a5)
[00001316] 2ebc 0000 af16            move.l     #$00015C84,(a7)
[0000131c] 486d 000e                 pea.l      14(a5)
[00001320] 4eb9 0000 8b66            jsr        _wakeupl
[00001326] 588f                      addq.l     #4,a7
[00001328] 60a0                      bra.s      x12c0_5
x12c0_1:
[0000132a] 2e39 0000 ae92            move.l     $00015C00,d7
[00001330] 0c87 0000 ae92            cmpi.l     #$00015C00,d7
[00001336] 6714                      beq.s      x12c0_6
[00001338] 4878 0006                 pea.l      ($00000006).w
[0000133c] 2f3c 0000 ae86            move.l     #$00015BF4,-(a7)
[00001342] 4eb9 0000 4f0e            jsr        _clkout
[00001348] 508f                      addq.l     #8,a7
[0000134a] 6006                      bra.s      x12c0_7
x12c0_6:
[0000134c] 42b9 0000 ae92            clr.l      $00015C00
x12c0_7:
[00001352] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001356] 4e75                      rts

_ttin:
[00001358] 4e56 fff8                 link       a6,#-8
[0000135c] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00001360] 2a2e 0008                 move.l     8(a6),d5
[00001364] 2a6e 000c                 movea.l    12(a6),a5
[00001368] 7800                      moveq.l    #0,d4
[0000136a] 382d 0004                 move.w     4(a5),d4
[0000136e] 7e04                      moveq.l    #4,d7
[00001370] 7c00                      moveq.l    #0,d6
[00001372] 3c2d 000c                 move.w     12(a5),d6
[00001376] ce86                      and.l      d6,d7
[00001378] 2d47 fff8                 move.l     d7,-8(a6)
[0000137c] 026d ffeb 000c            andi.w     #$FFEB,12(a5)
[00001382] 0285 0000 00ff            andi.l     #$000000FF,d5
[00001388] 0804 0005                 btst       #5,d4
[0000138c] 6708                      beq.s      _ttin_1
[0000138e] 08c5 0009                 bset       #9,d5
[00001392] 6000 00a2                 bra        _ttin_2
_ttin_1:
[00001396] 0804 0000                 btst       #0,d4
[0000139a] 6740                      beq.s      _ttin_3
[0000139c] 7e7f                      moveq.l    #127,d7
[0000139e] ce85                      and.l      d5,d7
[000013a0] 41f9 0000 af2a            lea.l      $00015C98,a0
[000013a6] 4ef9 0000 0000            jmp        a~jtab
[000013ac] 2e8d                      move.l     a5,(a7)
[000013ae] 226d 0026                 movea.l    38(a5),a1
[000013b2] 4e91                      jsr        (a1)
[000013b4] 6006                      bra.s      _ttin_4
[000013b6] 08ed 0004 000d            bset       #4,13(a5)
_ttin_4:
[000013bc] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000013c0] 4e5e                      unlk       a6
[000013c2] 4e75                      rts
[000013c4] 2a3c 0000 0403            move.l     #$00000403,d5
[000013ca] 606a                      bra.s      _ttin_2
[000013cc] 2a3c 0000 0402            move.l     #$00000402,d5
[000013d2] 6062                      bra.s      _ttin_2
[000013d4] 08c5 0009                 bset       #9,d5
[000013d8] 605c                      bra.s      _ttin_2
[000013da] 605a                      bra.s      _ttin_2
_ttin_3:
[000013dc] 0285 0000 007f            andi.l     #$0000007F,d5
[000013e2] 7e7f                      moveq.l    #127,d7
[000013e4] 7c00                      moveq.l    #0,d6
[000013e6] 1c2d 0002                 move.b     2(a5),d6
[000013ea] ce86                      and.l      d6,d7
[000013ec] ba87                      cmp.l      d7,d5
[000013ee] 661c                      bne.s      _ttin_5
[000013f0] 4297                      clr.l      (a7)
[000013f2] 2f2e fff8                 move.l     -8(a6),-(a7)
[000013f6] 7e00                      moveq.l    #0,d7
[000013f8] 1e2d 0002                 move.b     2(a5),d7
[000013fc] 2f07                      move.l     d7,-(a7)
[000013fe] 2f0d                      move.l     a5,-(a7)
[00001400] 4eba fc86                 jsr        $00001088(pc)
[00001404] 4fef 000c                 lea.l      12(a7),a7
[00001408] 8a87                      or.l       d7,d5
[0000140a] 602a                      bra.s      _ttin_2
_ttin_5:
[0000140c] 7e7f                      moveq.l    #127,d7
[0000140e] 7c00                      moveq.l    #0,d6
[00001410] 1c2d 0003                 move.b     3(a5),d6
[00001414] ce86                      and.l      d6,d7
[00001416] be85                      cmp.l      d5,d7
[00001418] 6636                      bne.s      _ttin_6
[0000141a] 4878 0001                 pea.l      ($00000001).w
[0000141e] 2f2e fff8                 move.l     -8(a6),-(a7)
[00001422] 7e00                      moveq.l    #0,d7
[00001424] 1e2d 0003                 move.b     3(a5),d7
[00001428] 2f07                      move.l     d7,-(a7)
[0000142a] 2f0d                      move.l     a5,-(a7)
[0000142c] 4eba fc5a                 jsr        $00001088(pc)
[00001430] 4fef 0010                 lea.l      16(a7),a7
[00001434] 8a87                      or.l       d7,d5
_ttin_2:
[00001436] 0805 000a                 btst       #10,d5
[0000143a] 6600 00e4                 bne        _ttin_7
[0000143e] 3e39 0000 0000            move.w     _in_max,d7
[00001444] be6d 000e                 cmp.w      14(a5),d7
[00001448] 6200 0104                 bhi        _ttin_8
[0000144c] 6000 00d2                 bra        _ttin_7
_ttin_6:
[00001450] 2e05                      move.l     d5,d7
[00001452] 41f9 0000 af56            lea.l      $00015CC4,a0
[00001458] 4ef9 0000 0000            jmp        a~jtab
[0000145e] 08c5 0009                 bset       #9,d5
[00001462] 60d2                      bra.s      _ttin_2
[00001464] 0804 0004                 btst       #4,d4
[00001468] 67cc                      beq.s      _ttin_2
[0000146a] 2a3c 0000 020a            move.l     #$0000020A,d5
[00001470] 60c4                      bra.s      _ttin_2
[00001472] 08ed 0002 000d            bset       #2,13(a5)
[00001478] 08c5 000b                 bset       #11,d5
[0000147c] 60b8                      bra.s      _ttin_2
[0000147e] 2e8d                      move.l     a5,(a7)
[00001480] 226d 0026                 movea.l    38(a5),a1
[00001484] 4e91                      jsr        (a1)
[00001486] 6006                      bra.s      _ttin_9
[00001488] 08ed 0004 000d            bset       #4,13(a5)
_ttin_9:
[0000148e] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001492] 4e5e                      unlk       a6
[00001494] 4e75                      rts
[00001496] 2a3c 0000 0403            move.l     #$00000403,d5
[0000149c] 6098                      bra.s      _ttin_2
[0000149e] 2a3c 0000 0402            move.l     #$00000402,d5
[000014a4] 6090                      bra.s      _ttin_2
[000014a6] 0804 0002                 btst       #2,d4
[000014aa] 678a                      beq.s      _ttin_2
[000014ac] 0c85 0000 0041            cmpi.l     #$00000041,d5
[000014b2] 6d20                      blt.s      _ttin_10
[000014b4] 0c85 0000 005a            cmpi.l     #$0000005A,d5
[000014ba] 6e18                      bgt.s      _ttin_10
[000014bc] 4aae fff8                 tst.l      -8(a6)
[000014c0] 6708                      beq.s      _ttin_11
[000014c2] 08c5 0008                 bset       #8,d5
[000014c6] 6000 ff6e                 bra        _ttin_2
_ttin_11:
[000014ca] 0685 0000 0020            addi.l     #$00000020,d5
[000014d0] 6000 ff64                 bra        _ttin_2
_ttin_10:
[000014d4] 4aae fff8                 tst.l      -8(a6)
[000014d8] 6700 ff5c                 beq        _ttin_2
[000014dc] 2d7c 0000 af1e fffc       move.l     #$00015C8C,-4(a6)
_ttin_13:
[000014e4] 226e fffc                 movea.l    -4(a6),a1
[000014e8] 4a11                      tst.b      (a1)
[000014ea] 6714                      beq.s      _ttin_12
[000014ec] 226e fffc                 movea.l    -4(a6),a1
[000014f0] 7e00                      moveq.l    #0,d7
[000014f2] 1e29 0001                 move.b     1(a1),d7
[000014f6] be85                      cmp.l      d5,d7
[000014f8] 6706                      beq.s      _ttin_12
[000014fa] 54ae fffc                 addq.l     #2,-4(a6)
[000014fe] 60e4                      bra.s      _ttin_13
_ttin_12:
[00001500] 226e fffc                 movea.l    -4(a6),a1
[00001504] 4a11                      tst.b      (a1)
[00001506] 6700 ff2e                 beq        _ttin_2
[0000150a] 226e fffc                 movea.l    -4(a6),a1
[0000150e] 7e00                      moveq.l    #0,d7
[00001510] 1e11                      move.b     (a1),d7
[00001512] 08c7 0008                 bset       #8,d7
[00001516] 2a07                      move.l     d7,d5
[00001518] 6000 ff1c                 bra        _ttin_2
[0000151c] 6000 ff18                 bra        _ttin_2
_ttin_7:
[00001520] 2e8d                      move.l     a5,(a7)
[00001522] 4eba fc48                 jsr        _flush(pc)
[00001526] 0805 000a                 btst       #10,d5
[0000152a] 671a                      beq.s      _ttin_14
[0000152c] 2e05                      move.l     d5,d7
[0000152e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00001534] 2e87                      move.l     d7,(a7)
[00001536] 7e00                      moveq.l    #0,d7
[00001538] 3e2d 002a                 move.w     42(a5),d7
[0000153c] 2f07                      move.l     d7,-(a7)
[0000153e] 4eb9 0000 8808            jsr        _signal
[00001544] 588f                      addq.l     #4,a7
_ttin_14:
[00001546] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000154a] 4e5e                      unlk       a6
[0000154c] 4e75                      rts
_ttin_8:
[0000154e] 4aae fff8                 tst.l      -8(a6)
[00001552] 673e                      beq.s      _ttin_15
[00001554] 0805 0008                 btst       #8,d5
[00001558] 6708                      beq.s      _ttin_16
[0000155a] 2e8d                      move.l     a5,(a7)
[0000155c] 4eba faec                 jsr        $0000104A(pc)
[00001560] 6030                      bra.s      _ttin_15
_ttin_16:
[00001562] 486d 000e                 pea.l      14(a5)
[00001566] 4878 005c                 pea.l      ($0000005C).w
[0000156a] 4eb9 0000 0e9e            jsr        _enqc
[00001570] 508f                      addq.l     #8,a7
[00001572] 4a87                      tst.l      d7
[00001574] 6704                      beq.s      _ttin_17
[00001576] 7a07                      moveq.l    #7,d5
[00001578] 6018                      bra.s      _ttin_15
_ttin_17:
[0000157a] 526d 0034                 addq.w     #1,52(a5)
[0000157e] 0c6d 0001 0034            cmpi.w     #$0001,52(a5)
[00001584] 6608                      bne.s      _ttin_18
[00001586] 3b6d 002e 0030            move.w     46(a5),48(a5)
[0000158c] 6004                      bra.s      _ttin_15
_ttin_18:
[0000158e] 526d 0030                 addq.w     #1,48(a5)
_ttin_15:
[00001592] 0805 000b                 btst       #11,d5
[00001596] 661a                      bne.s      _ttin_19
[00001598] 486d 000e                 pea.l      14(a5)
[0000159c] 2f05                      move.l     d5,-(a7)
[0000159e] 4eb9 0000 0e9e            jsr        _enqc
[000015a4] 508f                      addq.l     #8,a7
[000015a6] 4a87                      tst.l      d7
[000015a8] 6704                      beq.s      _ttin_20
[000015aa] 7a23                      moveq.l    #35,d5
[000015ac] 6004                      bra.s      _ttin_19
_ttin_20:
[000015ae] 526d 0034                 addq.w     #1,52(a5)
_ttin_19:
[000015b2] 0804 0005                 btst       #5,d4
[000015b6] 666e                      bne.s      _ttin_21
[000015b8] 082d 0000 000d            btst       #0,13(a5)
[000015be] 663c                      bne.s      _ttin_22
[000015c0] 0815 0005                 btst       #5,(a5)
[000015c4] 6636                      bne.s      _ttin_22
[000015c6] 3e39 0000 0000            move.w     _in_xoff,d7
[000015cc] be6d 000e                 cmp.w      14(a5),d7
[000015d0] 622a                      bhi.s      _ttin_22
[000015d2] 4a6d 002c                 tst.w      44(a5)
[000015d6] 6724                      beq.s      _ttin_22
[000015d8] 486d 0018                 pea.l      24(a5)
[000015dc] 4878 0013                 pea.l      ($00000013).w
[000015e0] 4eb9 0000 0e9e            jsr        _enqc
[000015e6] 508f                      addq.l     #8,a7
[000015e8] 4a87                      tst.l      d7
[000015ea] 663a                      bne.s      _ttin_21
[000015ec] 08ed 0000 000d            bset       #0,13(a5)
[000015f2] 2e8d                      move.l     a5,(a7)
[000015f4] 226d 0026                 movea.l    38(a5),a1
[000015f8] 4e91                      jsr        (a1)
[000015fa] 602a                      bra.s      _ttin_21
_ttin_22:
[000015fc] 0804 0000                 btst       #0,d4
[00001600] 6624                      bne.s      _ttin_21
[00001602] 3e39 0000 0000            move.w     _in_lim,d7
[00001608] be6d 000e                 cmp.w      14(a5),d7
[0000160c] 6418                      bcc.s      _ttin_21
[0000160e] 486d 000e                 pea.l      14(a5)
[00001612] 4878 0004                 pea.l      ($00000004).w
[00001616] 4eb9 0000 0e9e            jsr        _enqc
[0000161c] 508f                      addq.l     #8,a7
[0000161e] 4a87                      tst.l      d7
[00001620] 6604                      bne.s      _ttin_21
[00001622] 08c5 0009                 bset       #9,d5
_ttin_21:
[00001626] 0805 0009                 btst       #9,d5
[0000162a] 6744                      beq.s      _ttin_23
[0000162c] 526d 002c                 addq.w     #1,44(a5)
[00001630] 426d 0034                 clr.w      52(a5)
[00001634] 4a2d 0006                 tst.b      6(a5)
[00001638] 6704                      beq.s      _ttin_24
[0000163a] 422d 000b                 clr.b      11(a5)
_ttin_24:
[0000163e] 082d 0000 000c            btst       #0,12(a5)
[00001644] 672a                      beq.s      _ttin_23
[00001646] 7e21                      moveq.l    #33,d7
[00001648] ce84                      and.l      d4,d7
[0000164a] 670c                      beq.s      _ttin_25
[0000164c] 4247                      clr.w      d7
[0000164e] 1e2d 0006                 move.b     6(a5),d7
[00001652] be6d 002c                 cmp.w      44(a5),d7
[00001656] 6e18                      bgt.s      _ttin_23
_ttin_25:
[00001658] 08ad 0000 000c            bclr       #0,12(a5)
[0000165e] 2ebc 0000 af16            move.l     #$00015C84,(a7)
[00001664] 486d 000e                 pea.l      14(a5)
[00001668] 4eb9 0000 8b66            jsr        _wakeupl
[0000166e] 588f                      addq.l     #4,a7
_ttin_23:
[00001670] 0804 0003                 btst       #3,d4
[00001674] 6776                      beq.s      _ttin_26
[00001676] 0805 000c                 btst       #12,d5
[0000167a] 6670                      bne.s      _ttin_26
[0000167c] 0c6d 0001 0034            cmpi.w     #$0001,52(a5)
[00001682] 6606                      bne.s      _ttin_27
[00001684] 3b6d 002e 0030            move.w     46(a5),48(a5)
_ttin_27:
[0000168a] 2e8d                      move.l     a5,(a7)
[0000168c] 2f05                      move.l     d5,-(a7)
[0000168e] 4eb9 0000 175a            jsr        _ttout
[00001694] 588f                      addq.l     #4,a7
[00001696] 7e7f                      moveq.l    #127,d7
[00001698] ce85                      and.l      d5,d7
[0000169a] 0c87 0000 005c            cmpi.l     #$0000005C,d7
[000016a0] 6742                      beq.s      _ttin_28
[000016a2] 3e2d 002e                 move.w     46(a5),d7
[000016a6] 48c7                      ext.l      d7
[000016a8] 3c2d 0030                 move.w     48(a5),d6
[000016ac] 48c6                      ext.l      d6
[000016ae] 9e86                      sub.l      d6,d7
[000016b0] 0c87 0000 0001            cmpi.l     #$00000001,d7
[000016b6] 6726                      beq.s      _ttin_29
[000016b8] 0805 0009                 btst       #9,d5
[000016bc] 6620                      bne.s      _ttin_29
[000016be] 486d 000e                 pea.l      14(a5)
[000016c2] 3e2d 002e                 move.w     46(a5),d7
[000016c6] 48c7                      ext.l      d7
[000016c8] 3c2d 0030                 move.w     48(a5),d6
[000016cc] 48c6                      ext.l      d6
[000016ce] 9e86                      sub.l      d6,d7
[000016d0] 08c7 0007                 bset       #7,d7
[000016d4] 2f07                      move.l     d7,-(a7)
[000016d6] 4eb9 0000 0e9e            jsr        _enqc
[000016dc] 508f                      addq.l     #8,a7
_ttin_29:
[000016de] 3b6d 002e 0030            move.w     46(a5),48(a5)
_ttin_28:
[000016e4] 2e8d                      move.l     a5,(a7)
[000016e6] 226d 0026                 movea.l    38(a5),a1
[000016ea] 4e91                      jsr        (a1)
_ttin_26:
[000016ec] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000016f0] 4e5e                      unlk       a6
[000016f2] 4e75                      rts

_ttinit:
[000016f4] 4e56 0000                 link       a6,#0
[000016f8] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000016fc] 2a6e 0008                 movea.l    8(a6),a5
[00001700] 2a2e 000c                 move.l     12(a6),d5
[00001704] 2e0d                      move.l     a5,d7
[00001706] 6620                      bne.s      _ttinit_1
[00001708] 4878 0038                 pea.l      ($00000038).w
[0000170c] 4eb9 0000 00f6            jsr        _alloc
[00001712] 588f                      addq.l     #4,a7
[00001714] 2a47                      movea.l    d7,a5
[00001716] 2e0d                      move.l     a5,d7
[00001718] 660e                      bne.s      _ttinit_1
[0000171a] 4878 000b                 pea.l      ($0000000B).w
[0000171e] 4eb9 0000 2868            jsr        _uerror
[00001724] 588f                      addq.l     #4,a7
[00001726] 6028                      bra.s      _ttinit_2
_ttinit_1:
[00001728] 4878 0038                 pea.l      ($00000038).w
[0000172c] 2f0d                      move.l     a5,-(a7)
[0000172e] 2f3c 0000 ae4e            move.l     #__i_tty,-(a7)
[00001734] 4eb9 0000 2754            jsr        _movbuf
[0000173a] 4fef 000c                 lea.l      12(a7),a7
[0000173e] 3b45 0008                 move.w     d5,8(a5)
[00001742] 0285 0000 000f            andi.l     #$0000000F,d5
[00001748] 2e05                      move.l     d5,d7
[0000174a] e187                      asl.l      #8,d7
[0000174c] 8e85                      or.l       d5,d7
[0000174e] 3a87                      move.w     d7,(a5)
_ttinit_2:
[00001750] 2e0d                      move.l     a5,d7
[00001752] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001756] 4e5e                      unlk       a6
[00001758] 4e75                      rts

_ttout:
[0000175a] 4e56 0000                 link       a6,#0
[0000175e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001762] 2a2e 0008                 move.l     8(a6),d5
[00001766] 2a6e 000c                 movea.l    12(a6),a5
[0000176a] 3e2d 0004                 move.w     4(a5),d7
[0000176e] 0247 0021                 andi.w     #$0021,d7
[00001772] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001778] 6710                      beq.s      _ttout_1
[0000177a] 486d 0018                 pea.l      24(a5)
[0000177e] 2f05                      move.l     d5,-(a7)
[00001780] 4eb9 0000 0e9e            jsr        _enqc
[00001786] 508f                      addq.l     #8,a7
[00001788] 6042                      bra.s      _ttout_2
_ttout_1:
[0000178a] 0285 0000 007f            andi.l     #$0000007F,d5
[00001790] 2e05                      move.l     d5,d7
[00001792] 41f9 0000 afa2            lea.l      $00015D10,a0
[00001798] 4ef9 0000 0000            jmp        a~jtab
[0000179e] 082d 0001 0005            btst       #1,5(a5)
[000017a4] 6700 00a4                 beq        _ttout_3
_ttout_4:
[000017a8] 486d 0018                 pea.l      24(a5)
[000017ac] 4878 0020                 pea.l      ($00000020).w
[000017b0] 4eb9 0000 0e9e            jsr        _enqc
[000017b6] 508f                      addq.l     #8,a7
[000017b8] 526d 002e                 addq.w     #1,46(a5)
[000017bc] 3e2d 002e                 move.w     46(a5),d7
[000017c0] 0247 0003                 andi.w     #$0003,d7
[000017c4] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000017ca] 66dc                      bne.s      _ttout_4
_ttout_2:
[000017cc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000017d0] 4e5e                      unlk       a6
[000017d2] 4e75                      rts
[000017d4] 082d 0004 0005            btst       #4,5(a5)
[000017da] 676e                      beq.s      _ttout_3
[000017dc] 2e8d                      move.l     a5,(a7)
[000017de] 4878 000d                 pea.l      ($0000000D).w
[000017e2] 4eba ff76                 jsr        _ttout(pc)
[000017e6] 588f                      addq.l     #4,a7
[000017e8] 6060                      bra.s      _ttout_3
[000017ea] 082d 0002 0005            btst       #2,5(a5)
[000017f0] 6758                      beq.s      _ttout_3
[000017f2] 287c 0000 af1e            movea.l    #$00015C8C,a4
_ttout_6:
[000017f8] 4a14                      tst.b      (a4)
[000017fa] 670c                      beq.s      _ttout_5
[000017fc] 7e00                      moveq.l    #0,d7
[000017fe] 1e14                      move.b     (a4),d7
[00001800] be85                      cmp.l      d5,d7
[00001802] 6704                      beq.s      _ttout_5
[00001804] 548c                      addq.l     #2,a4
[00001806] 60f0                      bra.s      _ttout_6
_ttout_5:
[00001808] 4a14                      tst.b      (a4)
[0000180a] 6610                      bne.s      _ttout_7
[0000180c] 0c85 0000 0041            cmpi.l     #$00000041,d5
[00001812] 6d20                      blt.s      _ttout_8
[00001814] 0c85 0000 005a            cmpi.l     #$0000005A,d5
[0000181a] 6e18                      bgt.s      _ttout_8
_ttout_7:
[0000181c] 2e8d                      move.l     a5,(a7)
[0000181e] 4878 005c                 pea.l      ($0000005C).w
[00001822] 4eba ff36                 jsr        _ttout(pc)
[00001826] 588f                      addq.l     #4,a7
[00001828] 4a14                      tst.b      (a4)
[0000182a] 671e                      beq.s      _ttout_3
[0000182c] 7a00                      moveq.l    #0,d5
[0000182e] 1a2c 0001                 move.b     1(a4),d5
[00001832] 6016                      bra.s      _ttout_3
_ttout_8:
[00001834] 0c85 0000 0061            cmpi.l     #$00000061,d5
[0000183a] 6d0e                      blt.s      _ttout_3
[0000183c] 0c85 0000 007a            cmpi.l     #$0000007A,d5
[00001842] 6e06                      bgt.s      _ttout_3
[00001844] 0685 ffff ffe0            addi.l     #$FFFFFFE0,d5
_ttout_3:
[0000184a] 486d 0018                 pea.l      24(a5)
[0000184e] 2f05                      move.l     d5,-(a7)
[00001850] 4eb9 0000 0e9e            jsr        _enqc
[00001856] 508f                      addq.l     #8,a7
[00001858] 4a87                      tst.l      d7
[0000185a] 6620                      bne.s      _ttout_9
[0000185c] 227c 0000 ae96            movea.l    #_cmaptab,a1
[00001862] 7e00                      moveq.l    #0,d7
[00001864] 1e31 5800                 move.b     0(a1,d5.l),d7
[00001868] 7c47                      moveq.l    #71,d6
[0000186a] cc87                      and.l      d7,d6
[0000186c] 2a06                      move.l     d6,d5
[0000186e] 2e05                      move.l     d5,d7
[00001870] 41f9 0000 afbe            lea.l      $00015D2C,a0
[00001876] 4ef9 0000 0000            jmp        a~jtab
_ttout_9:
[0000187c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001880] 4e5e                      unlk       a6
[00001882] 4e75                      rts

x1884_2:
[00001884] 4a6d 002e                 tst.w      46(a5)
[00001888] 6726                      beq.s      x1884_1
[0000188a] 536d 002e                 subq.w     #1,46(a5)
[0000188e] 6020                      bra.s      x1884_1
[00001890] 7e03                      moveq.l    #3,d7
[00001892] 3c2d 002e                 move.w     46(a5),d6
[00001896] 48c6                      ext.l      d6
[00001898] 8e86                      or.l       d6,d7
[0000189a] 5287                      addq.l     #1,d7
[0000189c] 3b47 002e                 move.w     d7,46(a5)
[000018a0] 600e                      bra.s      x1884_1
[000018a2] 426d 002e                 clr.w      46(a5)
[000018a6] 6008                      bra.s      x1884_1
[000018a8] 6006                      bra.s      x1884_1
[000018aa] 526d 002e                 addq.w     #1,46(a5)
[000018ae] 60cc                      bra.s      x1884_2
x1884_1:
[000018b0] 0285 0000 0007            andi.l     #$00000007,d5
[000018b6] 227c 0000 aff1            movea.l    #$00015D5F,a1
[000018bc] 1e31 5800                 move.b     0(a1,d5.l),d7
[000018c0] 7c00                      moveq.l    #0,d6
[000018c2] 3c2d 0004                 move.w     4(a5),d6
[000018c6] eea6                      asr.l      d7,d6
[000018c8] 227c 0000 afea            movea.l    #$00015D58,a1
[000018ce] 7e00                      moveq.l    #0,d7
[000018d0] 1e31 5800                 move.b     0(a1,d5.l),d7
[000018d4] cc87                      and.l      d7,d6
[000018d6] 2a06                      move.l     d6,d5
[000018d8] 6714                      beq.s      x1884_3
[000018da] 486d 0018                 pea.l      24(a5)
[000018de] 2e05                      move.l     d5,d7
[000018e0] 08c7 0007                 bset       #7,d7
[000018e4] 2f07                      move.l     d7,-(a7)
[000018e6] 4eb9 0000 0e9e            jsr        _enqc
[000018ec] 508f                      addq.l     #8,a7
x1884_3:
[000018ee] 608c                      bra.s      x1884_2

_ttread:
[000018f0] 4e56 0000                 link       a6,#0
[000018f4] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000018f8] 2a6e 0008                 movea.l    8(a6),a5
[000018fc] 7e00                      moveq.l    #0,d7
[000018fe] 3e39 0000 0000            move.w     _ttyps,d7
[00001904] 2e87                      move.l     d7,(a7)
[00001906] 4eb9 0000 0000            jsr        _spl
_ttread_7:
[0000190c] 4a6d 002c                 tst.w      44(a5)
[00001910] 6600 00c6                 bne        _ttread_1
[00001914] 082d 0001 000d            btst       #1,13(a5)
[0000191a] 6700 00bc                 beq        _ttread_1
[0000191e] 2e8d                      move.l     a5,(a7)
[00001920] 4eb9 0000 1e9e            jsr        $00001E9E
[00001926] 4eb9 0000 0000            jsr        _spl0
[0000192c] 7a00                      moveq.l    #0,d5
[0000192e] 3e2d 0004                 move.w     4(a5),d7
[00001932] 0247 0021                 andi.w     #$0021,d7
[00001936] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[0000193c] 674c                      beq.s      _ttread_2
[0000193e] 4a2d 0007                 tst.b      7(a5)
[00001942] 6740                      beq.s      _ttread_3
[00001944] 7a01                      moveq.l    #1,d5
[00001946] 422d 000b                 clr.b      11(a5)
[0000194a] 4ab9 0000 ae92            tst.l      $00015C00
[00001950] 661c                      bne.s      _ttread_4
[00001952] 23fc 0000 ae92 0000 ae92  move.l     #$00015C00,$00015C00
[0000195c] 4878 0006                 pea.l      ($00000006).w
[00001960] 2f3c 0000 ae86            move.l     #$00015BF4,-(a7)
[00001966] 4eb9 0000 4f0e            jsr        _clkout
[0000196c] 508f                      addq.l     #8,a7
_ttread_4:
[0000196e] 4aad 0022                 tst.l      34(a5)
[00001972] 6616                      bne.s      _ttread_2
[00001974] 2b79 0000 ae92 0022       move.l     $00015C00,34(a5)
[0000197c] 23cd 0000 ae92            move.l     a5,$00015C00
[00001982] 6006                      bra.s      _ttread_2
_ttread_3:
[00001984] 4a2d 0006                 tst.b      6(a5)
[00001988] 670a                      beq.s      _ttread_5
_ttread_2:
[0000198a] 4eb9 0000 2778            jsr        _nodelay
[00001990] 4a87                      tst.l      d7
[00001992] 6708                      beq.s      _ttread_6
_ttread_5:
[00001994] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001998] 4e5e                      unlk       a6
[0000199a] 4e75                      rts
_ttread_6:
[0000199c] 7e00                      moveq.l    #0,d7
[0000199e] 3e39 0000 0000            move.w     _ttyps,d7
[000019a4] 2e87                      move.l     d7,(a7)
[000019a6] 4eb9 0000 0000            jsr        _spl
[000019ac] 08ed 0000 000c            bset       #0,12(a5)
[000019b2] 2ebc 0000 af16            move.l     #$00015C84,(a7)
[000019b8] 42a7                      clr.l      -(a7)
[000019ba] 486d 000e                 pea.l      14(a5)
[000019be] 4eb9 0000 8862            jsr        _sleepl
[000019c4] 508f                      addq.l     #8,a7
[000019c6] 4a85                      tst.l      d5
[000019c8] 6700 ff42                 beq        _ttread_7
[000019cc] 1e2d 0007                 move.b     7(a5),d7
[000019d0] be2d 000b                 cmp.b      11(a5),d7
[000019d4] 6200 ff36                 bhi        _ttread_7
_ttread_1:
[000019d8] 1b7c 00ff 000b            move.b     #$FF,11(a5)
_ttread_10:
[000019de] 4a6d 002c                 tst.w      44(a5)
[000019e2] 6774                      beq.s      _ttread_8
[000019e4] 486d 000e                 pea.l      14(a5)
[000019e8] 4eb9 0000 0dc4            jsr        _deqc
[000019ee] 588f                      addq.l     #4,a7
[000019f0] 2807                      move.l     d7,d4
[000019f2] 0804 0007                 btst       #7,d4
[000019f6] 6710                      beq.s      _ttread_9
[000019f8] 3e2d 0004                 move.w     4(a5),d7
[000019fc] 0247 0021                 andi.w     #$0021,d7
[00001a00] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001a06] 67d6                      beq.s      _ttread_10
_ttread_9:
[00001a08] 3e2d 0004                 move.w     4(a5),d7
[00001a0c] 0247 0021                 andi.w     #$0021,d7
[00001a10] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001a16] 6608                      bne.s      _ttread_11
[00001a18] 0c84 0000 000a            cmpi.l     #$0000000A,d4
[00001a1e] 6618                      bne.s      _ttread_12
_ttread_11:
[00001a20] 536d 002c                 subq.w     #1,44(a5)
_ttread_14:
[00001a24] 4eb9 0000 0000            jsr        _spl0
[00001a2a] 2e84                      move.l     d4,(a7)
[00001a2c] 4eb9 0000 0000            jsr        _xsetch
[00001a32] 4a87                      tst.l      d7
[00001a34] 6c10                      bge.s      _ttread_13
[00001a36] 6020                      bra.s      _ttread_8
_ttread_12:
[00001a38] 0c84 0000 0004            cmpi.l     #$00000004,d4
[00001a3e] 66e4                      bne.s      _ttread_14
[00001a40] 536d 002c                 subq.w     #1,44(a5)
[00001a44] 6012                      bra.s      _ttread_8
_ttread_13:
[00001a46] 7e00                      moveq.l    #0,d7
[00001a48] 3e39 0000 0000            move.w     _ttyps,d7
[00001a4e] 2e87                      move.l     d7,(a7)
[00001a50] 4eb9 0000 0000            jsr        _spl
[00001a56] 6086                      bra.s      _ttread_10
_ttread_8:
[00001a58] 2e8d                      move.l     a5,(a7)
[00001a5a] 4eb9 0000 1e9e            jsr        $00001E9E
[00001a60] 4eb9 0000 0000            jsr        _spl0
[00001a66] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001a6a] 4e5e                      unlk       a6
[00001a6c] 4e75                      rts

_ttrstart:
[00001a6e] 4e56 fffc                 link       a6,#-4
[00001a72] 226e 0008                 movea.l    8(a6),a1
[00001a76] 08a9 0005 000d            bclr       #5,13(a1)
[00001a7c] 2eae 0008                 move.l     8(a6),(a7)
[00001a80] 226e 0008                 movea.l    8(a6),a1
[00001a84] 2269 0026                 movea.l    38(a1),a1
[00001a88] 4e91                      jsr        (a1)
[00001a8a] 4e5e                      unlk       a6
[00001a8c] 4e75                      rts

_ttset:
[00001a8e] 4e56 ffe0                 link       a6,#-32
[00001a92] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00001a96] 2a6e 0008                 movea.l    8(a6),a5
[00001a9a] 4eb9 0000 2500            jsr        _iobase
[00001aa0] 2a07                      move.l     d7,d5
[00001aa2] 7e00                      moveq.l    #0,d7
[00001aa4] 3e2d 0008                 move.w     8(a5),d7
[00001aa8] 0287 0000 037f            andi.l     #$0000037F,d7
[00001aae] 3d47 fffe                 move.w     d7,-2(a6)
[00001ab2] 2e2e 000c                 move.l     12(a6),d7
[00001ab6] 41f9 0000 b00a            lea.l      $00015D78,a0
[00001abc] 4ef9 0000 0000            jmp        a~jtab
[00001ac2] 7e00                      moveq.l    #0,d7
[00001ac4] 3e39 0000 0000            move.w     _ttyps,d7
[00001aca] 2e87                      move.l     d7,(a7)
[00001acc] 4eb9 0000 0000            jsr        _spl
[00001ad2] 3d47 fffc                 move.w     d7,-4(a6)
[00001ad6] 0255 7f7f                 andi.w     #$7F7F,(a5)
[00001ada] 4a6d 002c                 tst.w      44(a5)
[00001ade] 6706                      beq.s      _ttset_1
[00001ae0] 08ed 0007 0001            bset       #7,1(a5)
_ttset_1:
[00001ae6] 4a6d 0018                 tst.w      24(a5)
[00001aea] 6604                      bne.s      _ttset_2
[00001aec] 08d5 0007                 bset       #7,(a5)
_ttset_2:
[00001af0] 4878 0006                 pea.l      ($00000006).w
[00001af4] 486e fff6                 pea.l      -10(a6)
[00001af8] 2f0d                      move.l     a5,-(a7)
[00001afa] 4eb9 0000 2754            jsr        _movbuf
[00001b00] 4fef 000c                 lea.l      12(a7),a7
[00001b04] 0255 ffcf                 andi.w     #$FFCF,(a5)
[00001b08] 7e00                      moveq.l    #0,d7
[00001b0a] 3e2e fffc                 move.w     -4(a6),d7
[00001b0e] 2e87                      move.l     d7,(a7)
[00001b10] 4eb9 0000 0000            jsr        _spl
[00001b16] 4878 0006                 pea.l      ($00000006).w
[00001b1a] 2f05                      move.l     d5,-(a7)
[00001b1c] 486e fff6                 pea.l      -10(a6)
[00001b20] 4eb9 0000 0000            jsr        _outbuf
[00001b26] 4fef 000c                 lea.l      12(a7),a7
[00001b2a] 6000 0248                 bra        _ttset_3
[00001b2e] 4878 0006                 pea.l      ($00000006).w
[00001b32] 486e fff6                 pea.l      -10(a6)
[00001b36] 2f05                      move.l     d5,-(a7)
[00001b38] 4eb9 0000 0000            jsr        _inbuf
[00001b3e] 4fef 000c                 lea.l      12(a7),a7
[00001b42] 7e00                      moveq.l    #0,d7
[00001b44] 3e39 0000 0000            move.w     _ttyps,d7
[00001b4a] 2e87                      move.l     d7,(a7)
[00001b4c] 4eb9 0000 0000            jsr        _spl
[00001b52] 3d47 fffc                 move.w     d7,-4(a6)
[00001b56] 7800                      moveq.l    #0,d4
[00001b58] 382d 0004                 move.w     4(a5),d4
[00001b5c] 4878 0006                 pea.l      ($00000006).w
[00001b60] 2f0d                      move.l     a5,-(a7)
[00001b62] 486e fff6                 pea.l      -10(a6)
[00001b66] 4eb9 0000 2754            jsr        _movbuf
[00001b6c] 4fef 000c                 lea.l      12(a7),a7
[00001b70] 7e21                      moveq.l    #33,d7
[00001b72] ce84                      and.l      d4,d7
[00001b74] 6710                      beq.s      _ttset_4
[00001b76] 3e2d 0004                 move.w     4(a5),d7
[00001b7a] 0247 0021                 andi.w     #$0021,d7
[00001b7e] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001b84] 6608                      bne.s      _ttset_5
_ttset_4:
[00001b86] 2e8d                      move.l     a5,(a7)
[00001b88] 4eb9 0000 1f38            jsr        _wflush
_ttset_5:
[00001b8e] 026d fff0 0008            andi.w     #$FFF0,8(a5)
[00001b94] 7e0f                      moveq.l    #15,d7
[00001b96] 7c00                      moveq.l    #0,d6
[00001b98] 3c15                      move.w     (a5),d6
[00001b9a] ce86                      and.l      d6,d7
[00001b9c] 8f6d 0008                 or.w       d7,8(a5)
[00001ba0] 0895 0004                 bclr       #4,(a5)
[00001ba4] 7e00                      moveq.l    #0,d7
[00001ba6] 3e2e fffc                 move.w     -4(a6),d7
[00001baa] 2e87                      move.l     d7,(a7)
[00001bac] 4eb9 0000 0000            jsr        _spl
[00001bb2] 6000 01c0                 bra        _ttset_3
[00001bb6] 2e8d                      move.l     a5,(a7)
[00001bb8] 4eb9 0000 1ee8            jsr        _wdrain
[00001bbe] 08d5 0004                 bset       #4,(a5)
[00001bc2] 4a85                      tst.l      d5
[00001bc4] 6704                      beq.s      _ttset_6
[00001bc6] 2e05                      move.l     d5,d7
[00001bc8] 6002                      bra.s      _ttset_7
_ttset_6:
[00001bca] 7e03                      moveq.l    #3,d7
_ttset_7:
[00001bcc] 1b47 0036                 move.b     d7,54(a5)
[00001bd0] 7e00                      moveq.l    #0,d7
[00001bd2] 3e39 0000 0000            move.w     _ttyps,d7
[00001bd8] 2e87                      move.l     d7,(a7)
[00001bda] 4eb9 0000 0000            jsr        _spl
[00001be0] 3d47 fffc                 move.w     d7,-4(a6)
[00001be4] 2e8d                      move.l     a5,(a7)
[00001be6] 226d 0026                 movea.l    38(a5),a1
[00001bea] 4e91                      jsr        (a1)
[00001bec] 7e00                      moveq.l    #0,d7
[00001bee] 3e2e fffc                 move.w     -4(a6),d7
[00001bf2] 2e87                      move.l     d7,(a7)
[00001bf4] 4eb9 0000 0000            jsr        _spl
[00001bfa] 6000 0178                 bra        _ttset_3
[00001bfe] 2e8d                      move.l     a5,(a7)
[00001c00] 4eb9 0000 1f38            jsr        _wflush
[00001c06] 2e8d                      move.l     a5,(a7)
[00001c08] 4eb9 0000 1ee8            jsr        _wdrain
[00001c0e] 4878 0012                 pea.l      ($00000012).w
[00001c12] 486e ffe4                 pea.l      -28(a6)
[00001c16] 2f05                      move.l     d5,-(a7)
[00001c18] 4eb9 0000 0000            jsr        _inbuf
[00001c1e] 4fef 000c                 lea.l      12(a7),a7
[00001c22] 7e00                      moveq.l    #0,d7
[00001c24] 3e39 0000 0000            move.w     _ttyps,d7
[00001c2a] 2e87                      move.l     d7,(a7)
[00001c2c] 4eb9 0000 0000            jsr        _spl
[00001c32] 3d47 fffc                 move.w     d7,-4(a6)
[00001c36] 026d ffde 0004            andi.w     #$FFDE,4(a5)
[00001c3c] 082e 0001 ffeb            btst       #1,-21(a6)
[00001c42] 661e                      bne.s      _ttset_8
[00001c44] 1b6e fff2 0007            move.b     -14(a6),7(a5)
[00001c4a] 1b6e fff1 0006            move.b     -15(a6),6(a5)
[00001c50] 082e 0000 ffe7            btst       #0,-25(a6)
[00001c56] 6704                      beq.s      _ttset_9
[00001c58] 7e01                      moveq.l    #1,d7
[00001c5a] 6002                      bra.s      _ttset_10
_ttset_9:
[00001c5c] 7e20                      moveq.l    #32,d7
_ttset_10:
[00001c5e] 8f6d 0004                 or.w       d7,4(a5)
_ttset_8:
[00001c62] 3e2e ffea                 move.w     -22(a6),d7
[00001c66] 0247 0018                 andi.w     #$0018,d7
[00001c6a] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00001c70] 6708                      beq.s      _ttset_11
[00001c72] 08ed 0003 0005            bset       #3,5(a5)
[00001c78] 6006                      bra.s      _ttset_12
_ttset_11:
[00001c7a] 08ad 0003 0005            bclr       #3,5(a5)
_ttset_12:
[00001c80] 1b6e ffed 000a            move.b     -19(a6),10(a5)
[00001c86] 1b6e ffef 0002            move.b     -17(a6),2(a5)
[00001c8c] 1b6e fff0 0003            move.b     -16(a6),3(a5)
[00001c92] 3b6e ffe8 0008            move.w     -24(a6),8(a5)
[00001c98] 0255 f0f0                 andi.w     #$F0F0,(a5)
[00001c9c] 7e0f                      moveq.l    #15,d7
[00001c9e] 7c00                      moveq.l    #0,d6
[00001ca0] 3c2e ffe8                 move.w     -24(a6),d6
[00001ca4] ce86                      and.l      d6,d7
[00001ca6] 2807                      move.l     d7,d4
[00001ca8] 2e04                      move.l     d4,d7
[00001caa] e187                      asl.l      #8,d7
[00001cac] 8e84                      or.l       d4,d7
[00001cae] 8f55                      or.w       d7,(a5)
[00001cb0] 7e00                      moveq.l    #0,d7
[00001cb2] 3e2e fffc                 move.w     -4(a6),d7
[00001cb6] 2e87                      move.l     d7,(a7)
[00001cb8] 4eb9 0000 0000            jsr        _spl
[00001cbe] 6000 00b4                 bra        _ttset_3
[00001cc2] 4878 0012                 pea.l      ($00000012).w
[00001cc6] 486e ffe4                 pea.l      -28(a6)
[00001cca] 2f3c 0000 aff8            move.l     #$00015D66,-(a7)
[00001cd0] 4eb9 0000 2754            jsr        _movbuf
[00001cd6] 4fef 000c                 lea.l      12(a7),a7
[00001cda] 3d6d 0008 ffe8            move.w     8(a5),-24(a6)
[00001ce0] 1d6d 000a ffed            move.b     10(a5),-19(a6)
[00001ce6] 1d6d 0002 ffef            move.b     2(a5),-17(a6)
[00001cec] 1d6d 0003 fff0            move.b     3(a5),-16(a6)
[00001cf2] 082d 0005 0005            btst       #5,5(a5)
[00001cf8] 661e                      bne.s      _ttset_13
[00001cfa] 08ee 0000 ffe7            bset       #0,-25(a6)
[00001d00] 082d 0000 0005            btst       #0,5(a5)
[00001d06] 6604                      bne.s      _ttset_14
[00001d08] 7e01                      moveq.l    #1,d7
[00001d0a] 6002                      bra.s      _ttset_15
_ttset_14:
[00001d0c] 7e00                      moveq.l    #0,d7
_ttset_15:
[00001d0e] 4a87                      tst.l      d7
[00001d10] 6706                      beq.s      _ttset_13
[00001d12] 08ee 0001 ffeb            bset       #1,-21(a6)
_ttset_13:
[00001d18] 082d 0003 0005            btst       #3,5(a5)
[00001d1e] 6706                      beq.s      _ttset_16
[00001d20] 006e 0018 ffea            ori.w      #$0018,-22(a6)
_ttset_16:
[00001d26] 082e 0001 ffeb            btst       #1,-21(a6)
[00001d2c] 660c                      bne.s      _ttset_17
[00001d2e] 1d6d 0006 fff1            move.b     6(a5),-15(a6)
[00001d34] 1d6d 0007 fff2            move.b     7(a5),-14(a6)
_ttset_17:
[00001d3a] 4878 0012                 pea.l      ($00000012).w
[00001d3e] 2f05                      move.l     d5,-(a7)
[00001d40] 486e ffe4                 pea.l      -28(a6)
[00001d44] 4eb9 0000 0000            jsr        _outbuf
[00001d4a] 4fef 000c                 lea.l      12(a7),a7
[00001d4e] 6024                      bra.s      _ttset_3
[00001d50] 5285                      addq.l     #1,d5
[00001d52] 0805 0000                 btst       #0,d5
[00001d56] 6706                      beq.s      _ttset_18
[00001d58] 2e8d                      move.l     a5,(a7)
[00001d5a] 4eba f42c                 jsr        _flushi(pc)
_ttset_18:
[00001d5e] 0805 0001                 btst       #1,d5
[00001d62] 6710                      beq.s      _ttset_3
[00001d64] 2e8d                      move.l     a5,(a7)
[00001d66] 4eba f48a                 jsr        _flusho(pc)
[00001d6a] 6008                      bra.s      _ttset_3
[00001d6c] 2e8d                      move.l     a5,(a7)
[00001d6e] 4eb9 0000 1ee8            jsr        _wdrain
_ttset_3:
[00001d74] 7e00                      moveq.l    #0,d7
[00001d76] 3e2d 0008                 move.w     8(a5),d7
[00001d7a] 0287 0000 037f            andi.l     #$0000037F,d7
[00001d80] 7c00                      moveq.l    #0,d6
[00001d82] 3c2e fffe                 move.w     -2(a6),d6
[00001d86] be86                      cmp.l      d6,d7
[00001d88] 6604                      bne.s      _ttset_19
[00001d8a] 7e01                      moveq.l    #1,d7
[00001d8c] 6002                      bra.s      _ttset_20
_ttset_19:
[00001d8e] 7e00                      moveq.l    #0,d7
_ttset_20:
[00001d90] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001d94] 4e5e                      unlk       a6
[00001d96] 4e75                      rts

_ttwake:
[00001d98] 4e56 0000                 link       a6,#0
[00001d9c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001da0] 2a6e 0008                 movea.l    8(a6),a5
[00001da4] 082d 0001 000c            btst       #1,12(a5)
[00001daa] 672a                      beq.s      _ttwake_1
[00001dac] 4a6d 0018                 tst.w      24(a5)
[00001db0] 670c                      beq.s      _ttwake_2
[00001db2] 3e2d 0018                 move.w     24(a5),d7
[00001db6] be79 0000 0000            cmp.w      _out_lo,d7
[00001dbc] 6218                      bhi.s      _ttwake_1
_ttwake_2:
[00001dbe] 08ad 0001 000c            bclr       #1,12(a5)
[00001dc4] 2ebc 0000 af1a            move.l     #$00015C88,(a7)
[00001dca] 486d 0018                 pea.l      24(a5)
[00001dce] 4eb9 0000 8b66            jsr        _wakeupl
[00001dd4] 588f                      addq.l     #4,a7
_ttwake_1:
[00001dd6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001dda] 4e5e                      unlk       a6
[00001ddc] 4e75                      rts

_ttwrite:
[00001dde] 4e56 0000                 link       a6,#0
[00001de2] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001de6] 2a6e 0008                 movea.l    8(a6),a5
[00001dea] 082d 0001 000d            btst       #1,13(a5)
[00001df0] 6700 0086                 beq        _ttwrite_1
_ttwrite_5:
[00001df4] 4eb9 0000 0000            jsr        _xfetch
[00001dfa] 2a07                      move.l     d7,d5
[00001dfc] 6d7a                      blt.s      _ttwrite_1
[00001dfe] 7e00                      moveq.l    #0,d7
[00001e00] 3e39 0000 0000            move.w     _ttyps,d7
[00001e06] 2e87                      move.l     d7,(a7)
[00001e08] 4eb9 0000 0000            jsr        _spl
_ttwrite_3:
[00001e0e] 4ab9 0000 ae3c            tst.l      _clist
[00001e14] 6612                      bne.s      _ttwrite_2
[00001e16] 4297                      clr.l      (a7)
[00001e18] 2f3c 0000 ae3c            move.l     #_clist,-(a7)
[00001e1e] 4eb9 0000 8844            jsr        _sleep
[00001e24] 588f                      addq.l     #4,a7
[00001e26] 60e6                      bra.s      _ttwrite_3
_ttwrite_2:
[00001e28] 3e39 0000 0000            move.w     _out_hi,d7
[00001e2e] be6d 0018                 cmp.w      24(a5),d7
[00001e32] 6230                      bhi.s      _ttwrite_4
[00001e34] 2e8d                      move.l     a5,(a7)
[00001e36] 226d 0026                 movea.l    38(a5),a1
[00001e3a] 4e91                      jsr        (a1)
[00001e3c] 3e39 0000 0000            move.w     _out_hi,d7
[00001e42] be6d 0018                 cmp.w      24(a5),d7
[00001e46] 62c6                      bhi.s      _ttwrite_3
[00001e48] 08ed 0001 000c            bset       #1,12(a5)
[00001e4e] 2ebc 0000 af1a            move.l     #$00015C88,(a7)
[00001e54] 42a7                      clr.l      -(a7)
[00001e56] 486d 0018                 pea.l      24(a5)
[00001e5a] 4eb9 0000 8862            jsr        _sleepl
[00001e60] 508f                      addq.l     #8,a7
[00001e62] 60aa                      bra.s      _ttwrite_3
_ttwrite_4:
[00001e64] 4eb9 0000 0000            jsr        _spl0
[00001e6a] 2e8d                      move.l     a5,(a7)
[00001e6c] 2f05                      move.l     d5,-(a7)
[00001e6e] 4eba f8ea                 jsr        _ttout(pc)
[00001e72] 588f                      addq.l     #4,a7
[00001e74] 6000 ff7e                 bra        _ttwrite_5
_ttwrite_1:
[00001e78] 7e00                      moveq.l    #0,d7
[00001e7a] 3e39 0000 0000            move.w     _ttyps,d7
[00001e80] 2e87                      move.l     d7,(a7)
[00001e82] 4eb9 0000 0000            jsr        _spl
[00001e88] 2e8d                      move.l     a5,(a7)
[00001e8a] 226d 0026                 movea.l    38(a5),a1
[00001e8e] 4e91                      jsr        (a1)
[00001e90] 4eb9 0000 0000            jsr        _spl0
[00001e96] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001e9a] 4e5e                      unlk       a6
[00001e9c] 4e75                      rts

x1e9e:
[00001e9e] 4e56 0000                 link       a6,#0
[00001ea2] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001ea6] 2a6e 0008                 movea.l    8(a6),a5
[00001eaa] 082d 0000 000d            btst       #0,13(a5)
[00001eb0] 672e                      beq.s      x1e9e_1
[00001eb2] 3e2d 000e                 move.w     14(a5),d7
[00001eb6] be79 0000 0000            cmp.w      _in_xon,d7
[00001ebc] 6222                      bhi.s      x1e9e_1
[00001ebe] 486d 0018                 pea.l      24(a5)
[00001ec2] 4878 0011                 pea.l      ($00000011).w
[00001ec6] 4eb9 0000 0e9e            jsr        _enqc
[00001ecc] 508f                      addq.l     #8,a7
[00001ece] 4a87                      tst.l      d7
[00001ed0] 660e                      bne.s      x1e9e_1
[00001ed2] 08ad 0000 000d            bclr       #0,13(a5)
[00001ed8] 2e8d                      move.l     a5,(a7)
[00001eda] 226d 0026                 movea.l    38(a5),a1
[00001ede] 4e91                      jsr        (a1)
x1e9e_1:
[00001ee0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001ee4] 4e5e                      unlk       a6
[00001ee6] 4e75                      rts

_wdrain:
[00001ee8] 4e56 0000                 link       a6,#0
[00001eec] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001ef0] 2a6e 0008                 movea.l    8(a6),a5
[00001ef4] 7e00                      moveq.l    #0,d7
[00001ef6] 3e39 0000 0000            move.w     _ttyps,d7
[00001efc] 2e87                      move.l     d7,(a7)
[00001efe] 4eb9 0000 0000            jsr        _spl
[00001f04] 2a07                      move.l     d7,d5
_wdrain_2:
[00001f06] 4a6d 0018                 tst.w      24(a5)
[00001f0a] 671c                      beq.s      _wdrain_1
[00001f0c] 08ed 0001 000c            bset       #1,12(a5)
[00001f12] 2ebc 0000 af1a            move.l     #$00015C88,(a7)
[00001f18] 42a7                      clr.l      -(a7)
[00001f1a] 486d 0018                 pea.l      24(a5)
[00001f1e] 4eb9 0000 8862            jsr        _sleepl
[00001f24] 508f                      addq.l     #8,a7
[00001f26] 60de                      bra.s      _wdrain_2
_wdrain_1:
[00001f28] 2e85                      move.l     d5,(a7)
[00001f2a] 4eb9 0000 0000            jsr        _spl
[00001f30] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001f34] 4e5e                      unlk       a6
[00001f36] 4e75                      rts

_wflush:
[00001f38] 4e56 0000                 link       a6,#0
[00001f3c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001f40] 2a6e 0008                 movea.l    8(a6),a5
[00001f44] 2e8d                      move.l     a5,(a7)
[00001f46] 4eba ffa0                 jsr        _wdrain(pc)
[00001f4a] 2e8d                      move.l     a5,(a7)
[00001f4c] 4eba f21e                 jsr        _flush(pc)
[00001f50] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001f54] 4e5e                      unlk       a6
[00001f56] 4e75                      rts

_deverr:
[00001f58] 4e56 0000                 link       a6,#0
[00001f5c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001f60] 2a6e 0008                 movea.l    8(a6),a5
[00001f64] 7a00                      moveq.l    #0,d5
[00001f66] 3a2d 0010                 move.w     16(a5),d5
[00001f6a] 7e00                      moveq.l    #0,d7
[00001f6c] 3e2d 002c                 move.w     44(a5),d7
[00001f70] 2e87                      move.l     d7,(a7)
[00001f72] 0805 0004                 btst       #4,d5
[00001f76] 6708                      beq.s      _deverr_1
[00001f78] 2e3c 0000 b06a            move.l     #$00015DD8,d7
[00001f7e] 6006                      bra.s      _deverr_2
_deverr_1:
[00001f80] 2e3c 0000 b062            move.l     #$00015DD0,d7
_deverr_2:
[00001f86] 2f07                      move.l     d7,-(a7)
[00001f88] 2f3c 0000 b072            move.l     #$00015DE0,-(a7)
[00001f8e] 4eb9 0000 20d6            jsr        _putfmt
[00001f94] 508f                      addq.l     #8,a7
[00001f96] 2e05                      move.l     d5,d7
[00001f98] 0287 0000 0100            andi.l     #$00000100,d7
[00001f9e] 2e87                      move.l     d7,(a7)
[00001fa0] 7e00                      moveq.l    #0,d7
[00001fa2] 3e2d 0012                 move.w     18(a5),d7
[00001fa6] 2f07                      move.l     d7,-(a7)
[00001fa8] 4eb9 0000 204c            jsr        _putdnm
[00001fae] 588f                      addq.l     #4,a7
[00001fb0] 2ebc 0000 b08f            move.l     #$00015DFD,(a7)
[00001fb6] 4eb9 0000 20d6            jsr        _putfmt
[00001fbc] 4aae 000c                 tst.l      12(a6)
[00001fc0] 671e                      beq.s      _deverr_3
[00001fc2] 2eae 001c                 move.l     28(a6),(a7)
[00001fc6] 2f2e 0018                 move.l     24(a6),-(a7)
[00001fca] 2f2e 0014                 move.l     20(a6),-(a7)
[00001fce] 2f2e 0010                 move.l     16(a6),-(a7)
[00001fd2] 2f2e 000c                 move.l     12(a6),-(a7)
[00001fd6] 4eb9 0000 20d6            jsr        _putfmt
[00001fdc] 4fef 0010                 lea.l      16(a7),a7
_deverr_3:
[00001fe0] 4878 000a                 pea.l      ($0000000A).w
[00001fe4] 4eb9 0000 0000            jsr        _putch
[00001fea] 588f                      addq.l     #4,a7
[00001fec] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00001ff0] 4e5e                      unlk       a6
[00001ff2] 4e75                      rts

_ioerror:
[00001ff4] 4e56 fffc                 link       a6,#-4
[00001ff8] 2eae 0010                 move.l     16(a6),(a7)
[00001ffc] 2f2e 000c                 move.l     12(a6),-(a7)
[00002000] 2f3c 0000 b092            move.l     #$00015E00,-(a7)
[00002006] 2f2e 0008                 move.l     8(a6),-(a7)
[0000200a] 4eba ff4c                 jsr        _deverr(pc)
[0000200e] 4fef 000c                 lea.l      12(a7),a7
[00002012] 4e5e                      unlk       a6
[00002014] 4e75                      rts

_putderr:
[00002016] 4e56 fffc                 link       a6,#-4
[0000201a] 2eae 0008                 move.l     8(a6),(a7)
[0000201e] 2f3c 0000 b098            move.l     #$00015E06,-(a7)
[00002024] 4eb9 0000 20d6            jsr        _putfmt
[0000202a] 588f                      addq.l     #4,a7
[0000202c] 2eae 0010                 move.l     16(a6),(a7)
[00002030] 2f2e 000c                 move.l     12(a6),-(a7)
[00002034] 4eb9 0000 204c            jsr        _putdnm
[0000203a] 588f                      addq.l     #4,a7
[0000203c] 4878 000a                 pea.l      ($0000000A).w
[00002040] 4eb9 0000 0000            jsr        _putch
[00002046] 588f                      addq.l     #4,a7
[00002048] 4e5e                      unlk       a6
[0000204a] 4e75                      rts

_putdnm:
[0000204c] 4e56 0000                 link       a6,#0
[00002050] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00002054] 2e2e 0008                 move.l     8(a6),d7
[00002058] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000205e] 2807                      move.l     d7,d4
[00002060] 4aae 000c                 tst.l      12(a6)
[00002064] 671e                      beq.s      _putdnm_1
[00002066] 3e2e 000a                 move.w     10(a6),d7
[0000206a] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00002070] e087                      asr.l      #8,d7
[00002072] e587                      asl.l      #2,d7
[00002074] 2247                      movea.l    d7,a1
[00002076] d3fc 0000 0000            adda.l     #_chrdevs,a1
[0000207c] 2251                      movea.l    (a1),a1
[0000207e] 2e29 0014                 move.l     20(a1),d7
[00002082] 601c                      bra.s      _putdnm_2
_putdnm_1:
[00002084] 3e2e 000a                 move.w     10(a6),d7
[00002088] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[0000208e] e087                      asr.l      #8,d7
[00002090] e587                      asl.l      #2,d7
[00002092] 2247                      movea.l    d7,a1
[00002094] d3fc 0000 0000            adda.l     #_blkdevs,a1
[0000209a] 2251                      movea.l    (a1),a1
[0000209c] 2e29 0010                 move.l     16(a1),d7
_putdnm_2:
[000020a0] 2a47                      movea.l    d7,a5
[000020a2] 7a00                      moveq.l    #0,d5
_putdnm_5:
[000020a4] ba84                      cmp.l      d4,d5
[000020a6] 6e26                      bgt.s      _putdnm_3
[000020a8] 4a15                      tst.b      (a5)
[000020aa] 6606                      bne.s      _putdnm_4
[000020ac] 6020                      bra.s      _putdnm_3
_putdnm_7:
[000020ae] 528d                      addq.l     #1,a5
[000020b0] 60f2                      bra.s      _putdnm_5
_putdnm_4:
[000020b2] 0c15 0020                 cmpi.b     #$20,(a5)
[000020b6] 6604                      bne.s      _putdnm_6
[000020b8] 5285                      addq.l     #1,d5
[000020ba] 60f2                      bra.s      _putdnm_7
_putdnm_6:
[000020bc] ba84                      cmp.l      d4,d5
[000020be] 66ee                      bne.s      _putdnm_7
[000020c0] 7e00                      moveq.l    #0,d7
[000020c2] 1e15                      move.b     (a5),d7
[000020c4] 2e87                      move.l     d7,(a7)
[000020c6] 4eb9 0000 0000            jsr        _putch
[000020cc] 60e0                      bra.s      _putdnm_7
_putdnm_3:
[000020ce] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000020d2] 4e5e                      unlk       a6
[000020d4] 4e75                      rts

_putfmt:
[000020d6] 4e56 0000                 link       a6,#0
[000020da] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000020de] 2a6e 0008                 movea.l    8(a6),a5
[000020e2] 7a01                      moveq.l    #1,d5
_putfmt_3:
[000020e4] 0c15 0025                 cmpi.b     #$25,(a5)
[000020e8] 6720                      beq.s      _putfmt_1
[000020ea] 4a15                      tst.b      (a5)
[000020ec] 660e                      bne.s      _putfmt_2
[000020ee] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000020f2] 4e5e                      unlk       a6
[000020f4] 4e75                      rts
_putfmt_10:
[000020f6] 5285                      addq.l     #1,d5
[000020f8] 528d                      addq.l     #1,a5
[000020fa] 60e8                      bra.s      _putfmt_3
_putfmt_2:
[000020fc] 7e00                      moveq.l    #0,d7
[000020fe] 1e1d                      move.b     (a5)+,d7
[00002100] 2e87                      move.l     d7,(a7)
[00002102] 4eb9 0000 0000            jsr        _putch
[00002108] 60da                      bra.s      _putfmt_3
_putfmt_1:
[0000210a] 0c85 0000 0001            cmpi.l     #$00000001,d5
[00002110] 6606                      bne.s      _putfmt_4
[00002112] 2e2e 000c                 move.l     12(a6),d7
[00002116] 6020                      bra.s      _putfmt_5
_putfmt_4:
[00002118] 0c85 0000 0002            cmpi.l     #$00000002,d5
[0000211e] 6606                      bne.s      _putfmt_6
[00002120] 2e2e 0010                 move.l     16(a6),d7
[00002124] 6012                      bra.s      _putfmt_5
_putfmt_6:
[00002126] 0c85 0000 0003            cmpi.l     #$00000003,d5
[0000212c] 6606                      bne.s      _putfmt_7
[0000212e] 2e2e 0014                 move.l     20(a6),d7
[00002132] 6004                      bra.s      _putfmt_5
_putfmt_7:
[00002134] 2e2e 0018                 move.l     24(a6),d7
_putfmt_5:
[00002138] 2847                      movea.l    d7,a4
[0000213a] 528d                      addq.l     #1,a5
[0000213c] 0c15 0073                 cmpi.b     #$73,(a5)
[00002140] 6706                      beq.s      _putfmt_8
[00002142] 0c15 0070                 cmpi.b     #$70,(a5)
[00002146] 6612                      bne.s      _putfmt_9
_putfmt_8:
[00002148] 4a14                      tst.b      (a4)
[0000214a] 67aa                      beq.s      _putfmt_10
[0000214c] 7e00                      moveq.l    #0,d7
[0000214e] 1e1c                      move.b     (a4)+,d7
[00002150] 2e87                      move.l     d7,(a7)
[00002152] 4eb9 0000 0000            jsr        _putch
[00002158] 60ee                      bra.s      _putfmt_8
_putfmt_9:
[0000215a] 7e00                      moveq.l    #0,d7
[0000215c] 1e15                      move.b     (a5),d7
[0000215e] 2e87                      move.l     d7,(a7)
[00002160] 2f0c                      move.l     a4,-(a7)
[00002162] 4eb9 0000 216c            jsr        _putnum
[00002168] 588f                      addq.l     #4,a7
[0000216a] 608a                      bra.s      _putfmt_10

_putnum:
[0000216c] 4e56 0000                 link       a6,#0
[00002170] 48e7 9c00                 movem.l    d0/d3-d5,-(a7)
[00002174] 2a2e 0008                 move.l     8(a6),d5
[00002178] 282e 000c                 move.l     12(a6),d4
[0000217c] 2e04                      move.l     d4,d7
[0000217e] 41f9 0000 b0aa            lea.l      $00015E18,a0
[00002184] 4ef9 0000 0000            jmp        a~jtab
[0000218a] 4a85                      tst.l      d5
[0000218c] 6c12                      bge.s      _putnum_1
[0000218e] 4878 002d                 pea.l      ($0000002D).w
[00002192] 4eb9 0000 0000            jsr        _putch
[00002198] 588f                      addq.l     #4,a7
[0000219a] 2e05                      move.l     d5,d7
[0000219c] 4487                      neg.l      d7
[0000219e] 2a07                      move.l     d7,d5
_putnum_1:
[000021a0] 780a                      moveq.l    #10,d4
[000021a2] 601c                      bra.s      _putnum_2
[000021a4] 4878 0030                 pea.l      ($00000030).w
[000021a8] 4eb9 0000 0000            jsr        _putch
[000021ae] 588f                      addq.l     #4,a7
[000021b0] 7808                      moveq.l    #8,d4
[000021b2] 600c                      bra.s      _putnum_2
[000021b4] 2ebc 0000 b0a6            move.l     #$00015E14,(a7)
[000021ba] 4eba ff1a                 jsr        _putfmt(pc)
[000021be] 7810                      moveq.l    #16,d4
_putnum_2:
[000021c0] 2e85                      move.l     d5,(a7)
[000021c2] 2f04                      move.l     d4,-(a7)
[000021c4] 4eb9 0000 0000            jsr        a~uldiv
[000021ca] 2e17                      move.l     (a7),d7
[000021cc] 2607                      move.l     d7,d3
[000021ce] 670a                      beq.s      _putnum_3
[000021d0] 2e84                      move.l     d4,(a7)
[000021d2] 2f03                      move.l     d3,-(a7)
[000021d4] 4eba ff96                 jsr        _putnum(pc)
[000021d8] 588f                      addq.l     #4,a7
_putnum_3:
[000021da] 2e85                      move.l     d5,(a7)
[000021dc] 2f04                      move.l     d4,-(a7)
[000021de] 4eb9 0000 0000            jsr        a~ulmod
[000021e4] 2257                      movea.l    (a7),a1
[000021e6] d3fc 0000 b0d6            adda.l     #$00015E44,a1
[000021ec] 7e00                      moveq.l    #0,d7
[000021ee] 1e11                      move.b     (a1),d7
[000021f0] 2e87                      move.l     d7,(a7)
[000021f2] 4eb9 0000 0000            jsr        _putch
[000021f8] 4cdf 0039                 movem.l    (a7)+,d0/d3-d5
[000021fc] 4e5e                      unlk       a6
[000021fe] 4e75                      rts

_closef:
[00002200] 4e56 fffa                 link       a6,#-6
[00002204] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002208] 2a6e 0008                 movea.l    8(a6),a5
[0000220c] 2855                      movea.l    (a5),a4
[0000220e] 532d 0009                 subq.b     #1,9(a5)
[00002212] 6600 00f2                 bne        _closef_1
[00002216] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000221a] 2f0c                      move.l     a4,-(a7)
[0000221c] 4eb9 0000 2646            jsr        _locki
[00002222] 508f                      addq.l     #8,a7
[00002224] 3d6c 0022 fffa            move.w     34(a4),-6(a6)
[0000222a] 4247                      clr.w      d7
[0000222c] 1e2d 0008                 move.b     8(a5),d7
[00002230] 3d47 fffe                 move.w     d7,-2(a6)
[00002234] 3d6c 001a fffc            move.w     26(a4),-4(a6)
[0000223a] 2ebc 0100 0000            move.l     #$01000000,(a7)
[00002240] 42a7                      clr.l      -(a7)
[00002242] 2f0c                      move.l     a4,-(a7)
[00002244] 4eb9 0000 494e            jsr        _unlock
[0000224a] 508f                      addq.l     #8,a7
[0000224c] 7e00                      moveq.l    #0,d7
[0000224e] 3e2e fffc                 move.w     -4(a6),d7
[00002252] 0287 0000 6249            andi.l     #$00006249,d7
[00002258] 0c87 0000 0200            cmpi.l     #$00000200,d7
[0000225e] 6614                      bne.s      _closef_2
[00002260] 082e 0000 ffff            btst       #0,-1(a6)
[00002266] 670c                      beq.s      _closef_2
[00002268] 082e 0001 ffff            btst       #1,-1(a6)
[0000226e] 6704                      beq.s      _closef_2
[00002270] 536c 000e                 subq.w     #1,14(a4)
_closef_2:
[00002274] 082d 0000 0008            btst       #0,8(a5)
[0000227a] 6704                      beq.s      _closef_3
[0000227c] 536c 0012                 subq.w     #1,18(a4)
_closef_3:
[00002280] 082d 0007 0008            btst       #7,8(a5)
[00002286] 6738                      beq.s      _closef_4
[00002288] 4a6c 0012                 tst.w      18(a4)
[0000228c] 660e                      bne.s      _closef_5
[0000228e] 4878 0004                 pea.l      ($00000004).w
[00002292] 2f0c                      move.l     a4,-(a7)
[00002294] 4eb9 0000 5d72            jsr        _wakep
[0000229a] 508f                      addq.l     #8,a7
_closef_5:
[0000229c] 7e00                      moveq.l    #0,d7
[0000229e] 3e2c 000e                 move.w     14(a4),d7
[000022a2] 7c00                      moveq.l    #0,d6
[000022a4] 3c2c 0012                 move.w     18(a4),d6
[000022a8] 9e86                      sub.l      d6,d7
[000022aa] 0c87 0000 0001            cmpi.l     #$00000001,d7
[000022b0] 660e                      bne.s      _closef_4
[000022b2] 4878 0003                 pea.l      ($00000003).w
[000022b6] 2f0c                      move.l     a4,-(a7)
[000022b8] 4eb9 0000 5d72            jsr        _wakep
[000022be] 508f                      addq.l     #8,a7
_closef_4:
[000022c0] 4878 0001                 pea.l      ($00000001).w
[000022c4] 2f0c                      move.l     a4,-(a7)
[000022c6] 4eb9 0000 3540            jsr        _puti
[000022cc] 508f                      addq.l     #8,a7
[000022ce] 4297                      clr.l      (a7)
[000022d0] 2f0d                      move.l     a5,-(a7)
[000022d2] 4878 000a                 pea.l      ($0000000A).w
[000022d6] 4eb9 0000 0114            jsr        _free
[000022dc] 508f                      addq.l     #8,a7
[000022de] 082e 0005 fffc            btst       #5,-4(a6)
[000022e4] 6720                      beq.s      _closef_1
[000022e6] 7e00                      moveq.l    #0,d7
[000022e8] 3e2e fffc                 move.w     -4(a6),d7
[000022ec] 2e87                      move.l     d7,(a7)
[000022ee] 7e00                      moveq.l    #0,d7
[000022f0] 3e2e fffe                 move.w     -2(a6),d7
[000022f4] 2f07                      move.l     d7,-(a7)
[000022f6] 7e00                      moveq.l    #0,d7
[000022f8] 3e2e fffa                 move.w     -6(a6),d7
[000022fc] 2f07                      move.l     d7,-(a7)
[000022fe] 4eb9 0000 0ab2            jsr        _closed
[00002304] 508f                      addq.l     #8,a7
_closef_1:
[00002306] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000230a] 4e5e                      unlk       a6
[0000230c] 4e75                      rts

_curpid:
[0000230e] 2279 0000 0000            movea.l    _pu,a1
[00002314] 2269 0010                 movea.l    16(a1),a1
[00002318] 3e29 001c                 move.w     28(a1),d7
[0000231c] 48c7                      ext.l      d7
[0000231e] 4e75                      rts

_curproc:
[00002320] 2279 0000 0000            movea.l    _pu,a1
[00002326] 2e29 0010                 move.l     16(a1),d7
[0000232a] 4e75                      rts

_dup:
[0000232c] 4e56 0000                 link       a6,#0
[00002330] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002334] 2a6e 0008                 movea.l    8(a6),a5
[00002338] 2e95                      move.l     (a5),(a7)
[0000233a] 4eb9 0000 2710            jsr        _mapfd
[00002340] 2847                      movea.l    d7,a4
[00002342] 2e0c                      move.l     a4,d7
[00002344] 6726                      beq.s      _dup_1
[00002346] 2eae 000c                 move.l     12(a6),(a7)
[0000234a] 4eb9 0000 24be            jsr        _getuf
[00002350] 2a07                      move.l     d7,d5
[00002352] 6d18                      blt.s      _dup_1
[00002354] 43f8 0044                 lea.l      ($00000044).w,a1
[00002358] d3f9 0000 0000            adda.l     _pu,a1
[0000235e] 2e05                      move.l     d5,d7
[00002360] e587                      asl.l      #2,d7
[00002362] 238c 7800                 move.l     a4,0(a1,d7.l)
[00002366] 522c 0009                 addq.b     #1,9(a4)
[0000236a] 2a85                      move.l     d5,(a5)
_dup_1:
[0000236c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002370] 4e5e                      unlk       a6
[00002372] 4e75                      rts

_dupfiles:
[00002374] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002378] 2879 0000 0000            movea.l    _pu,a4
[0000237e] 43ec 0044                 lea.l      68(a4),a1
[00002382] 2a49                      movea.l    a1,a5
[00002384] 7a20                      moveq.l    #32,d5
_dupfiles_3:
[00002386] 5385                      subq.l     #1,d5
[00002388] 6d0e                      blt.s      _dupfiles_1
[0000238a] 4a95                      tst.l      (a5)
[0000238c] 6706                      beq.s      _dupfiles_2
[0000238e] 2255                      movea.l    (a5),a1
[00002390] 5229 0009                 addq.b     #1,9(a1)
_dupfiles_2:
[00002394] 588d                      addq.l     #4,a5
[00002396] 60ee                      bra.s      _dupfiles_3
_dupfiles_1:
[00002398] 226c 0034                 movea.l    52(a4),a1
[0000239c] 5269 000e                 addq.w     #1,14(a1)
[000023a0] 226c 0038                 movea.l    56(a4),a1
[000023a4] 5269 000e                 addq.w     #1,14(a1)
[000023a8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000023ac] 4e75                      rts

_error:
[000023ae] 4e56 fffc                 link       a6,#-4
[000023b2] 2eae 0008                 move.l     8(a6),(a7)
[000023b6] 4eb9 0000 0000            jsr        _panic
[000023bc] 4e5e                      unlk       a6
[000023be] 4e75                      rts

_fetch:
[000023c0] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000023c4] 2a79 0000 0000            movea.l    _pu,a5
[000023ca] 4aad 002c                 tst.l      44(a5)
[000023ce] 6604                      bne.s      _fetch_1
[000023d0] 7eff                      moveq.l    #-1,d7
[000023d2] 6028                      bra.s      _fetch_2
_fetch_1:
[000023d4] 4a2d 0143                 tst.b      323(a5)
[000023d8] 670c                      beq.s      _fetch_3
[000023da] 226d 0028                 movea.l    40(a5),a1
[000023de] 1a11                      move.b     (a1),d5
[000023e0] 4885                      ext.w      d5
[000023e2] 48c5                      ext.l      d5
[000023e4] 601c                      bra.s      _fetch_4
_fetch_3:
[000023e6] 2ead 0028                 move.l     40(a5),(a7)
[000023ea] 4eb9 0000 0000            jsr        _inbyte
[000023f0] 2a07                      move.l     d7,d5
[000023f2] 6c0e                      bge.s      _fetch_4
[000023f4] 1b7c 000e 0142            move.b     #$0E,322(a5)
[000023fa] 7eff                      moveq.l    #-1,d7
_fetch_2:
[000023fc] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00002400] 4e75                      rts
_fetch_4:
[00002402] 52ad 0028                 addq.l     #1,40(a5)
[00002406] 53ad 002c                 subq.l     #1,44(a5)
[0000240a] 52ad 0030                 addq.l     #1,48(a5)
[0000240e] 2e05                      move.l     d5,d7
[00002410] 0287 0000 00ff            andi.l     #$000000FF,d7
[00002416] 60e4                      bra.s      _fetch_2

_getfd:
[00002418] 4e56 0000                 link       a6,#0
[0000241c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00002420] 9bcd                      suba.l     a5,a5
[00002422] 4297                      clr.l      (a7)
[00002424] 4eb9 0000 24be            jsr        _getuf
[0000242a] 2a07                      move.l     d7,d5
[0000242c] 6d54                      blt.s      _getfd_1
[0000242e] 4297                      clr.l      (a7)
[00002430] 4878 000a                 pea.l      ($0000000A).w
[00002434] 4eb9 0000 00f6            jsr        _alloc
[0000243a] 588f                      addq.l     #4,a7
[0000243c] 2a47                      movea.l    d7,a5
[0000243e] 2e0d                      move.l     a5,d7
[00002440] 660e                      bne.s      _getfd_2
[00002442] 4878 000b                 pea.l      ($0000000B).w
[00002446] 4eb9 0000 2868            jsr        _uerror
[0000244c] 588f                      addq.l     #4,a7
[0000244e] 6032                      bra.s      _getfd_1
_getfd_2:
[00002450] 43f8 0044                 lea.l      ($00000044).w,a1
[00002454] d3f9 0000 0000            adda.l     _pu,a1
[0000245a] 2e05                      move.l     d5,d7
[0000245c] e587                      asl.l      #2,d7
[0000245e] 238d 7800                 move.l     a5,0(a1,d7.l)
[00002462] 2279 0000 0000            movea.l    _pu,a1
[00002468] 7e01                      moveq.l    #1,d7
[0000246a] eba7                      asl.l      d5,d7
[0000246c] 4687                      not.l      d7
[0000246e] cfa9 0040                 and.l      d7,64(a1)
[00002472] 1b7c 0001 0009            move.b     #$01,9(a5)
[00002478] 42ad 0004                 clr.l      4(a5)
[0000247c] 226e 0008                 movea.l    8(a6),a1
[00002480] 3285                      move.w     d5,(a1)
_getfd_1:
[00002482] 2e0d                      move.l     a5,d7
[00002484] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00002488] 4e5e                      unlk       a6
[0000248a] 4e75                      rts

_getmount:
[0000248c] 4e56 0000                 link       a6,#0
[00002490] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00002494] 2a2e 0008                 move.l     8(a6),d5
[00002498] 2a79 0000 b0ec            movea.l    _mlist,a5
_getmount_4:
[0000249e] 2e0d                      move.l     a5,d7
[000024a0] 6712                      beq.s      _getmount_1
[000024a2] 7e00                      moveq.l    #0,d7
[000024a4] 3e2d 0008                 move.w     8(a5),d7
[000024a8] be85                      cmp.l      d5,d7
[000024aa] 6604                      bne.s      _getmount_2
[000024ac] 2e0d                      move.l     a5,d7
[000024ae] 6006                      bra.s      _getmount_3
_getmount_2:
[000024b0] 2a55                      movea.l    (a5),a5
[000024b2] 60ea                      bra.s      _getmount_4
_getmount_1:
[000024b4] 7e00                      moveq.l    #0,d7
_getmount_3:
[000024b6] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000024ba] 4e5e                      unlk       a6
[000024bc] 4e75                      rts

_getuf:
[000024be] 4e56 0000                 link       a6,#0
[000024c2] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000024c6] 2a2e 0008                 move.l     8(a6),d5
[000024ca] 2a79 0000 0000            movea.l    _pu,a5
_getuf_4:
[000024d0] 0c85 0000 0020            cmpi.l     #$00000020,d5
[000024d6] 6c18                      bge.s      _getuf_1
[000024d8] 2e05                      move.l     d5,d7
[000024da] e587                      asl.l      #2,d7
[000024dc] 2247                      movea.l    d7,a1
[000024de] 45ed 0044                 lea.l      68(a5),a2
[000024e2] 4ab1 a800                 tst.l      0(a1,a2.l)
[000024e6] 6604                      bne.s      _getuf_2
[000024e8] 2e05                      move.l     d5,d7
[000024ea] 600c                      bra.s      _getuf_3
_getuf_2:
[000024ec] 5285                      addq.l     #1,d5
[000024ee] 60e0                      bra.s      _getuf_4
_getuf_1:
[000024f0] 1b7c 0018 0142            move.b     #$18,322(a5)
[000024f6] 7eff                      moveq.l    #-1,d7
_getuf_3:
[000024f8] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000024fc] 4e5e                      unlk       a6
[000024fe] 4e75                      rts

_iobase:
[00002500] 2279 0000 0000            movea.l    _pu,a1
[00002506] 2e29 0028                 move.l     40(a1),d7
[0000250a] 4e75                      rts

_iocount:
[0000250c] 2279 0000 0000            movea.l    _pu,a1
[00002512] 2e29 002c                 move.l     44(a1),d7
[00002516] 4e75                      rts

_ioflag:
[00002518] 2279 0000 0000            movea.l    _pu,a1
[0000251e] 7e00                      moveq.l    #0,d7
[00002520] 3e29 013a                 move.w     314(a1),d7
[00002524] 4e75                      rts

_ioseek:
[00002526] 2279 0000 0000            movea.l    _pu,a1
[0000252c] 2e29 0030                 move.l     48(a1),d7
[00002530] 4e75                      rts

_isacc:
[00002532] 4e56 0000                 link       a6,#0
[00002536] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000253a] 2a6e 0008                 movea.l    8(a6),a5
[0000253e] 2a2e 000c                 move.l     12(a6),d5
[00002542] 2879 0000 0000            movea.l    _pu,a4
[00002548] 0c85 0000 0080            cmpi.l     #$00000080,d5
[0000254e] 6626                      bne.s      _isacc_1
[00002550] 7e00                      moveq.l    #0,d7
[00002552] 3e2d 0016                 move.w     22(a5),d7
[00002556] 2e87                      move.l     d7,(a7)
[00002558] 4eba ff32                 jsr        _getmount(pc)
[0000255c] 2247                      movea.l    d7,a1
[0000255e] 4a29 000e                 tst.b      14(a1)
[00002562] 6712                      beq.s      _isacc_1
[00002564] 082d 0005 001a            btst       #5,26(a5)
[0000256a] 660a                      bne.s      _isacc_1
[0000256c] 197c 001e 0142            move.b     #$1E,322(a4)
[00002572] 7e00                      moveq.l    #0,d7
[00002574] 6010                      bra.s      _isacc_2
_isacc_1:
[00002576] 0c85 0000 0100            cmpi.l     #$00000100,d5
[0000257c] 6610                      bne.s      _isacc_3
[0000257e] 4a2c 0130                 tst.b      304(a4)
[00002582] 660a                      bne.s      _isacc_3
[00002584] 7e01                      moveq.l    #1,d7
_isacc_2:
[00002586] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000258a] 4e5e                      unlk       a6
[0000258c] 4e75                      rts
_isacc_3:
[0000258e] 4a2c 0130                 tst.b      304(a4)
[00002592] 6610                      bne.s      _isacc_4
[00002594] 2e05                      move.l     d5,d7
[00002596] e687                      asr.l      #3,d7
[00002598] 8e85                      or.l       d5,d7
[0000259a] 2c05                      move.l     d5,d6
[0000259c] ec86                      asr.l      #6,d6
[0000259e] 8e86                      or.l       d6,d7
[000025a0] 2a07                      move.l     d7,d5
[000025a2] 601a                      bra.s      _isacc_5
_isacc_4:
[000025a4] 1e2c 0130                 move.b     304(a4),d7
[000025a8] be2d 001d                 cmp.b      29(a5),d7
[000025ac] 6710                      beq.s      _isacc_5
[000025ae] 1e2c 0131                 move.b     305(a4),d7
[000025b2] be2d 001e                 cmp.b      30(a5),d7
[000025b6] 6604                      bne.s      _isacc_6
[000025b8] e685                      asr.l      #3,d5
[000025ba] 6002                      bra.s      _isacc_5
_isacc_6:
[000025bc] ec85                      asr.l      #6,d5
_isacc_5:
[000025be] 3e2d 001a                 move.w     26(a5),d7
[000025c2] ce45                      and.w      d5,d7
[000025c4] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000025ca] 6704                      beq.s      _isacc_7
[000025cc] 7e01                      moveq.l    #1,d7
[000025ce] 60b6                      bra.s      _isacc_2
_isacc_7:
[000025d0] 197c 000d 0142            move.b     #$0D,322(a4)
[000025d6] 7e00                      moveq.l    #0,d7
[000025d8] 60ac                      bra.s      _isacc_2

_isdir:
[000025da] 4e56 0000                 link       a6,#0
[000025de] 226e 0008                 movea.l    8(a6),a1
[000025e2] 7e00                      moveq.l    #0,d7
[000025e4] 3e29 001a                 move.w     26(a1),d7
[000025e8] 0287 0000 6000            andi.l     #$00006000,d7
[000025ee] 0c87 0000 4000            cmpi.l     #$00004000,d7
[000025f4] 6604                      bne.s      _isdir_1
[000025f6] 7e01                      moveq.l    #1,d7
[000025f8] 6002                      bra.s      _isdir_2
_isdir_1:
[000025fa] 7e00                      moveq.l    #0,d7
_isdir_2:
[000025fc] 4e5e                      unlk       a6
[000025fe] 4e75                      rts

_isuper:
[00002600] 48e7 8004                 movem.l    d0/a5,-(a7)
[00002604] 2a79 0000 0000            movea.l    _pu,a5
[0000260a] 4a2d 0130                 tst.b      304(a5)
[0000260e] 670a                      beq.s      _isuper_1
[00002610] 1b7c 0001 0142            move.b     #$01,322(a5)
[00002616] 7e00                      moveq.l    #0,d7
[00002618] 6002                      bra.s      _isuper_2
_isuper_1:
[0000261a] 7e01                      moveq.l    #1,d7
_isuper_2:
[0000261c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00002620] 4e75                      rts

_itols:
[00002622] 4e56 0000                 link       a6,#0
[00002626] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000262a] 2a6e 0008                 movea.l    8(a6),a5
[0000262e] 1aae 000f                 move.b     15(a6),(a5)
[00002632] 2e2e 000c                 move.l     12(a6),d7
[00002636] e087                      asr.l      #8,d7
[00002638] 1b47 0001                 move.b     d7,1(a5)
[0000263c] 2e0d                      move.l     a5,d7
[0000263e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00002642] 4e5e                      unlk       a6
[00002644] 4e75                      rts

_locki:
[00002646] 4e56 0000                 link       a6,#0
[0000264a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000264e] 2a6e 0008                 movea.l    8(a6),a5
_locki_2:
[00002652] 082d 0001 000d            btst       #1,13(a5)
[00002658] 671c                      beq.s      _locki_1
[0000265a] 08ed 0004 000d            bset       #4,13(a5)
[00002660] 486d 0008                 pea.l      8(a5)
[00002664] 2f2e 000c                 move.l     12(a6),-(a7)
[00002668] 2f0d                      move.l     a5,-(a7)
[0000266a] 4eb9 0000 8862            jsr        _sleepl
[00002670] 4fef 000c                 lea.l      12(a7),a7
[00002674] 60dc                      bra.s      _locki_2
_locki_1:
[00002676] 08ed 0001 000d            bset       #1,13(a5)
[0000267c] 2e0d                      move.l     a5,d7
[0000267e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00002682] 4e5e                      unlk       a6
[00002684] 4e75                      rts

_lsize:
[00002686] 4e56 0000                 link       a6,#0
[0000268a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000268e] 2a6e 0008                 movea.l    8(a6),a5
[00002692] 7e00                      moveq.l    #0,d7
[00002694] 1e2d 001f                 move.b     31(a5),d7
[00002698] 7c10                      moveq.l    #16,d6
[0000269a] eda7                      asl.l      d6,d7
[0000269c] 7c00                      moveq.l    #0,d6
[0000269e] 3c2d 0020                 move.w     32(a5),d6
[000026a2] 8e86                      or.l       d6,d7
[000026a4] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000026a8] 4e5e                      unlk       a6
[000026aa] 4e75                      rts

_lstou:
[000026ac] 4e56 fffe                 link       a6,#-2
[000026b0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000026b4] 2a6e 0008                 movea.l    8(a6),a5
[000026b8] 7e00                      moveq.l    #0,d7
[000026ba] 1e2d 0001                 move.b     1(a5),d7
[000026be] e187                      asl.l      #8,d7
[000026c0] 7c00                      moveq.l    #0,d6
[000026c2] 1c15                      move.b     (a5),d6
[000026c4] de86                      add.l      d6,d7
[000026c6] 3d47 fffe                 move.w     d7,-2(a6)
[000026ca] 7e00                      moveq.l    #0,d7
[000026cc] 3e2e fffe                 move.w     -2(a6),d7
[000026d0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000026d4] 4e5e                      unlk       a6
[000026d6] 4e75                      rts

_maxu:
[000026d8] 4e56 0000                 link       a6,#0
[000026dc] 2e2e 000c                 move.l     12(a6),d7
[000026e0] beae 0008                 cmp.l      8(a6),d7
[000026e4] 6406                      bcc.s      _maxu_1
[000026e6] 2e2e 0008                 move.l     8(a6),d7
[000026ea] 6004                      bra.s      _maxu_2
_maxu_1:
[000026ec] 2e2e 000c                 move.l     12(a6),d7
_maxu_2:
[000026f0] 4e5e                      unlk       a6
[000026f2] 4e75                      rts

_minu:
[000026f4] 4e56 0000                 link       a6,#0
[000026f8] 2e2e 0008                 move.l     8(a6),d7
[000026fc] beae 000c                 cmp.l      12(a6),d7
[00002700] 6406                      bcc.s      _minu_1
[00002702] 2e2e 0008                 move.l     8(a6),d7
[00002706] 6004                      bra.s      _minu_2
_minu_1:
[00002708] 2e2e 000c                 move.l     12(a6),d7
_minu_2:
[0000270c] 4e5e                      unlk       a6
[0000270e] 4e75                      rts

_mapfd:
[00002710] 4e56 0000                 link       a6,#0
[00002714] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002718] 2a2e 0008                 move.l     8(a6),d5
[0000271c] 2879 0000 0000            movea.l    _pu,a4
[00002722] 4a85                      tst.l      d5
[00002724] 6d1e                      blt.s      _mapfd_1
[00002726] 0c85 0000 0020            cmpi.l     #$00000020,d5
[0000272c] 6c16                      bge.s      _mapfd_1
[0000272e] 2e05                      move.l     d5,d7
[00002730] e587                      asl.l      #2,d7
[00002732] 2247                      movea.l    d7,a1
[00002734] 45ec 0044                 lea.l      68(a4),a2
[00002738] 2a71 a800                 movea.l    0(a1,a2.l),a5
[0000273c] 2e0d                      move.l     a5,d7
[0000273e] 6704                      beq.s      _mapfd_1
[00002740] 2e0d                      move.l     a5,d7
[00002742] 6008                      bra.s      _mapfd_2
_mapfd_1:
[00002744] 197c 0009 0142            move.b     #$09,322(a4)
[0000274a] 7e00                      moveq.l    #0,d7
_mapfd_2:
[0000274c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002750] 4e5e                      unlk       a6
[00002752] 4e75                      rts

_movbuf:
[00002754] 4e56 0000                 link       a6,#0
[00002758] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000275c] 2a6e 0008                 movea.l    8(a6),a5
[00002760] 286e 000c                 movea.l    12(a6),a4
[00002764] 2a2e 0010                 move.l     16(a6),d5
_movbuf_2:
[00002768] 5385                      subq.l     #1,d5
[0000276a] 6d04                      blt.s      _movbuf_1
[0000276c] 18dd                      move.b     (a5)+,(a4)+
[0000276e] 60f8                      bra.s      _movbuf_2
_movbuf_1:
[00002770] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002774] 4e5e                      unlk       a6
[00002776] 4e75                      rts

_nodelay:
[00002778] 2279 0000 0000            movea.l    _pu,a1
[0000277e] 7e00                      moveq.l    #0,d7
[00002780] 3e29 013a                 move.w     314(a1),d7
[00002784] 7c04                      moveq.l    #4,d6
[00002786] cc87                      and.l      d7,d6
[00002788] 2e06                      move.l     d6,d7
[0000278a] 4e75                      rts

_reli:
[0000278c] 4e56 0000                 link       a6,#0
[00002790] 48e7 8004                 movem.l    d0/a5,-(a7)
[00002794] 2a6e 0008                 movea.l    8(a6),a5
[00002798] 082d 0004 000d            btst       #4,13(a5)
[0000279e] 670e                      beq.s      _reli_1
[000027a0] 486d 0008                 pea.l      8(a5)
[000027a4] 2f0d                      move.l     a5,-(a7)
[000027a6] 4eb9 0000 8b66            jsr        _wakeupl
[000027ac] 508f                      addq.l     #8,a7
_reli_1:
[000027ae] 026d ffed 000c            andi.w     #$FFED,12(a5)
[000027b4] 2e0d                      move.l     a5,d7
[000027b6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000027ba] 4e5e                      unlk       a6
[000027bc] 4e75                      rts

_setbase:
[000027be] 4e56 0000                 link       a6,#0
[000027c2] 2279 0000 0000            movea.l    _pu,a1
[000027c8] 236e 0008 0028            move.l     8(a6),40(a1)
[000027ce] 2e29 0028                 move.l     40(a1),d7
[000027d2] 4e5e                      unlk       a6
[000027d4] 4e75                      rts

_setch:
[000027d6] 4e56 0000                 link       a6,#0
[000027da] 48e7 8004                 movem.l    d0/a5,-(a7)
[000027de] 2a79 0000 0000            movea.l    _pu,a5
[000027e4] 4aad 002c                 tst.l      44(a5)
[000027e8] 6604                      bne.s      _setch_1
[000027ea] 7eff                      moveq.l    #-1,d7
[000027ec] 602c                      bra.s      _setch_2
_setch_1:
[000027ee] 4a2d 0143                 tst.b      323(a5)
[000027f2] 670a                      beq.s      _setch_3
[000027f4] 226d 0028                 movea.l    40(a5),a1
[000027f8] 12ae 000b                 move.b     11(a6),(a1)
[000027fc] 6024                      bra.s      _setch_4
_setch_3:
[000027fe] 2eae 0008                 move.l     8(a6),(a7)
[00002802] 2f2d 0028                 move.l     40(a5),-(a7)
[00002806] 4eb9 0000 0000            jsr        _outbyte
[0000280c] 588f                      addq.l     #4,a7
[0000280e] 4a87                      tst.l      d7
[00002810] 6c10                      bge.s      _setch_4
[00002812] 1b7c 000e 0142            move.b     #$0E,322(a5)
[00002818] 7eff                      moveq.l    #-1,d7
_setch_2:
[0000281a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000281e] 4e5e                      unlk       a6
[00002820] 4e75                      rts
_setch_4:
[00002822] 52ad 0028                 addq.l     #1,40(a5)
[00002826] 52ad 0030                 addq.l     #1,48(a5)
[0000282a] 53ad 002c                 subq.l     #1,44(a5)
[0000282e] 6704                      beq.s      _setch_5
[00002830] 7e00                      moveq.l    #0,d7
[00002832] 6002                      bra.s      _setch_6
_setch_5:
[00002834] 7eff                      moveq.l    #-1,d7
_setch_6:
[00002836] 60e2                      bra.s      _setch_2

_setcount:
[00002838] 4e56 0000                 link       a6,#0
[0000283c] 2279 0000 0000            movea.l    _pu,a1
[00002842] 236e 0008 002c            move.l     8(a6),44(a1)
[00002848] 2e29 002c                 move.l     44(a1),d7
[0000284c] 4e5e                      unlk       a6
[0000284e] 4e75                      rts

_setseek:
[00002850] 4e56 0000                 link       a6,#0
[00002854] 2279 0000 0000            movea.l    _pu,a1
[0000285a] 236e 0008 0030            move.l     8(a6),48(a1)
[00002860] 2e29 0030                 move.l     48(a1),d7
[00002864] 4e5e                      unlk       a6
[00002866] 4e75                      rts

_uerror:
[00002868] 4e56 0000                 link       a6,#0
[0000286c] 4aae 0008                 tst.l      8(a6)
[00002870] 670c                      beq.s      _uerror_1
[00002872] 2279 0000 0000            movea.l    _pu,a1
[00002878] 136e 000b 0142            move.b     11(a6),322(a1)
_uerror_1:
[0000287e] 2279 0000 0000            movea.l    _pu,a1
[00002884] 1e29 0142                 move.b     322(a1),d7
[00002888] 4887                      ext.w      d7
[0000288a] 48c7                      ext.l      d7
[0000288c] 4e5e                      unlk       a6
[0000288e] 4e75                      rts

_lo_init:
[00002890] 4e75                      rts

_blk_init:
[00002892] 4e56 fffc                 link       a6,#-4
[00002896] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000289a] 2e39 0000 0000            move.l     _nbufs,d7
[000028a0] 5387                      subq.l     #1,d7
[000028a2] 23c7 0000 b15a            move.l     d7,_nbufres
[000028a8] 2a39 0000 0000            move.l     _nbufs,d5
[000028ae] 2a79 0000 b152            movea.l    _pbufs,a5
[000028b4] 2d79 0000 b15e fffc       move.l     _buffers,-4(a6)
_blk_init_2:
[000028bc] 5385                      subq.l     #1,d5
[000028be] 6d6c                      blt.s      _blk_init_1
[000028c0] 2b4d 0008                 move.l     a5,8(a5)
[000028c4] 2b4d 000c                 move.l     a5,12(a5)
[000028c8] 3b7c 0400 0010            move.w     #$0400,16(a5)
[000028ce] 426d 0012                 clr.w      18(a5)
[000028d2] 42ad 0024                 clr.l      36(a5)
[000028d6] 2b6e fffc 0020            move.l     -4(a6),32(a5)
[000028dc] 2e2e fffc                 move.l     -4(a6),d7
[000028e0] deb9 0000 0000            add.l      _physbias,d7
[000028e6] 2b47 0014                 move.l     d7,20(a5)
[000028ea] 42ad 0028                 clr.l      40(a5)
[000028ee] 426d 002c                 clr.w      44(a5)
[000028f2] 42ad 001c                 clr.l      28(a5)
[000028f6] 42ad 0018                 clr.l      24(a5)
[000028fa] 2e8d                      move.l     a5,(a7)
[000028fc] 2f39 0000 b128            move.l     $00015E96,-(a7)
[00002902] 4eb9 0000 0b76            jsr        _enq
[00002908] 588f                      addq.l     #4,a7
[0000290a] 4297                      clr.l      (a7)
[0000290c] 42a7                      clr.l      -(a7)
[0000290e] 4eb9 0000 04f4            jsr        _getblk
[00002914] 588f                      addq.l     #4,a7
[00002916] 2e87                      move.l     d7,(a7)
[00002918] 4eb9 0000 0390            jsr        _brelse
[0000291e] 4bed 002e                 lea.l      46(a5),a5
[00002922] 06ae 0000 0200 fffc       addi.l     #$00000200,-4(a6)
[0000292a] 6090                      bra.s      _blk_init_2
_blk_init_1:
[0000292c] 2a39 0000 0000            move.l     _nblkdev,d5
_blk_init_4:
[00002932] 5385                      subq.l     #1,d5
[00002934] 6d24                      blt.s      _blk_init_3
[00002936] 2e05                      move.l     d5,d7
[00002938] e587                      asl.l      #2,d7
[0000293a] 2247                      movea.l    d7,a1
[0000293c] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00002942] 2251                      movea.l    (a1),a1
[00002944] 2869 000c                 movea.l    12(a1),a4
[00002948] 2e0c                      move.l     a4,d7
[0000294a] 67e6                      beq.s      _blk_init_4
[0000294c] 294c 0004                 move.l     a4,4(a4)
[00002950] 294c 0008                 move.l     a4,8(a4)
[00002954] 294c 000c                 move.l     a4,12(a4)
[00002958] 60d8                      bra.s      _blk_init_4
_blk_init_3:
[0000295a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000295e] 4e5e                      unlk       a6
[00002960] 4e75                      rts

_chq_init:
[00002962] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00002966] 7e0f                      moveq.l    #15,d7
[00002968] deb9 0000 ae40            add.l      _pclist,d7
[0000296e] 7cf0                      moveq.l    #-16,d6
[00002970] cc87                      and.l      d7,d6
[00002972] 2a46                      movea.l    d6,a5
[00002974] 2e39 0000 0000            move.l     _nclist,d7
[0000297a] 5387                      subq.l     #1,d7
[0000297c] 2a07                      move.l     d7,d5
[0000297e] 23cd 0000 ae3c            move.l     a5,_clist
_chq_init_2:
[00002984] 5385                      subq.l     #1,d5
[00002986] 6f0c                      ble.s      _chq_init_1
[00002988] 43ed 0010                 lea.l      16(a5),a1
[0000298c] 2a89                      move.l     a1,(a5)
[0000298e] 4bed 0010                 lea.l      16(a5),a5
[00002992] 60f0                      bra.s      _chq_init_2
_chq_init_1:
[00002994] 4295                      clr.l      (a5)
[00002996] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000299a] 4e75                      rts

_ino_init:
[0000299c] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000029a0] 4878 6000                 pea.l      ($00006000).w
[000029a4] 4878 0002                 pea.l      ($00000002).w
[000029a8] 7e00                      moveq.l    #0,d7
[000029aa] 3e39 0000 0000            move.w     _rootdev,d7
[000029b0] 2f07                      move.l     d7,-(a7)
[000029b2] 4eb9 0000 0cc0            jsr        _opendev
[000029b8] 4fef 000c                 lea.l      12(a7),a7
[000029bc] 4a79 0000 0000            tst.w      _swapdev
[000029c2] 671c                      beq.s      _ino_init_1
[000029c4] 4878 6000                 pea.l      ($00006000).w
[000029c8] 4878 0002                 pea.l      ($00000002).w
[000029cc] 7e00                      moveq.l    #0,d7
[000029ce] 3e39 0000 0000            move.w     _swapdev,d7
[000029d4] 2f07                      move.l     d7,-(a7)
[000029d6] 4eb9 0000 0cc0            jsr        _opendev
[000029dc] 4fef 000c                 lea.l      12(a7),a7
_ino_init_1:
[000029e0] 4a79 0000 0000            tst.w      _pipedev
[000029e6] 671c                      beq.s      _ino_init_2
[000029e8] 4878 6000                 pea.l      ($00006000).w
[000029ec] 4878 0002                 pea.l      ($00000002).w
[000029f0] 7e00                      moveq.l    #0,d7
[000029f2] 3e39 0000 0000            move.w     _pipedev,d7
[000029f8] 2f07                      move.l     d7,-(a7)
[000029fa] 4eb9 0000 0cc0            jsr        _opendev
[00002a00] 4fef 000c                 lea.l      12(a7),a7
_ino_init_2:
[00002a04] 4878 0001                 pea.l      ($00000001).w
[00002a08] 7e00                      moveq.l    #0,d7
[00002a0a] 3e39 0000 0000            move.w     _rootdev,d7
[00002a10] 2f07                      move.l     d7,-(a7)
[00002a12] 4eb9 0000 095c            jsr        _readb
[00002a18] 508f                      addq.l     #8,a7
[00002a1a] 2a47                      movea.l    d7,a5
[00002a1c] 4297                      clr.l      (a7)
[00002a1e] 4eb9 0000 2868            jsr        _uerror
[00002a24] 4a87                      tst.l      d7
[00002a26] 670c                      beq.s      _ino_init_3
[00002a28] 2ebc 0000 b162            move.l     #$00015ED0,(a7)
[00002a2e] 4eb9 0000 0000            jsr        _panic
_ino_init_3:
[00002a34] 2eb9 0000 b0ec            move.l     _mlist,(a7)
[00002a3a] 4878 0010                 pea.l      ($00000010).w
[00002a3e] 4eb9 0000 00f6            jsr        _alloc
[00002a44] 588f                      addq.l     #4,a7
[00002a46] 2847                      movea.l    d7,a4
[00002a48] 2e0c                      move.l     a4,d7
[00002a4a] 660c                      bne.s      _ino_init_4
[00002a4c] 2ebc 0000 b16b            move.l     #$00015ED9,(a7)
[00002a52] 4eb9 0000 0000            jsr        _panic
_ino_init_4:
[00002a58] 23cc 0000 b0ec            move.l     a4,_mlist
[00002a5e] 70ff                      moveq.l    #-1,d0
[00002a60] 2940 0004                 move.l     d0,4(a4)
[00002a64] 3979 0000 0000 0008       move.w     _rootdev,8(a4)
[00002a6c] 3979 0000 0000 000a       move.w     _rootdev,10(a4)
[00002a74] 397c 0001 000c            move.w     #$0001,12(a4)
[00002a7a] 1979 0000 0003 000e       move.b     _rootro+$00000003,14(a4)
[00002a82] 2e8d                      move.l     a5,(a7)
[00002a84] 4eb9 0000 0c18            jsr        _getaddr
[00002a8a] 2247                      movea.l    d7,a1
[00002a8c] 2ea9 019c                 move.l     412(a1),(a7)
[00002a90] 4eb9 0000 0000            jsr        _tflip
[00002a96] 23c7 0000 b59c            move.l     d7,_time
[00002a9c] 2e8d                      move.l     a5,(a7)
[00002a9e] 4eb9 0000 0390            jsr        _brelse
[00002aa4] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002aa8] 4e75                      rts

_hi_init:
[00002aaa] 4e75                      rts

_core:
[00002aac] 4e56 0000                 link       a6,#0
[00002ab0] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002ab4] 2879 0000 0000            movea.l    _pu,a4
[00002aba] 422c 0142                 clr.b      322(a4)
[00002abe] 397c 0010 013a            move.w     #$0010,314(a4)
[00002ac4] 9bcd                      suba.l     a5,a5
[00002ac6] 4ab9 0000 0000            tst.l      _coremode
[00002acc] 6752                      beq.s      _core_1
[00002ace] 1e2c 0130                 move.b     304(a4),d7
[00002ad2] be2c 0132                 cmp.b      306(a4),d7
[00002ad6] 6648                      bne.s      _core_1
[00002ad8] 4878 0005                 pea.l      ($00000005).w
[00002adc] 2f3c 0000 b172            move.l     #$00015EE0,-(a7)
[00002ae2] 4eb9 0000 3ebe            jsr        _findi
[00002ae8] 508f                      addq.l     #8,a7
[00002aea] 2a47                      movea.l    d7,a5
[00002aec] 2e0d                      move.l     a5,d7
[00002aee] 6630                      bne.s      _core_1
[00002af0] 4a2c 0142                 tst.b      322(a4)
[00002af4] 662a                      bne.s      _core_1
[00002af6] 0cb9 0000 0002 0000 0000  cmpi.l     #$00000002,_coremode
[00002b00] 6610                      bne.s      _core_2
[00002b02] 4878 01b6                 pea.l      ($000001B6).w
[00002b06] 4eb9 0000 4202            jsr        _makei
[00002b0c] 588f                      addq.l     #4,a7
[00002b0e] 2a47                      movea.l    d7,a5
[00002b10] 600e                      bra.s      _core_1
_core_2:
[00002b12] 4297                      clr.l      (a7)
[00002b14] 2f2c 003c                 move.l     60(a4),-(a7)
[00002b18] 4eb9 0000 3540            jsr        _puti
[00002b1e] 588f                      addq.l     #4,a7
_core_1:
[00002b20] 2e0d                      move.l     a5,d7
[00002b22] 672a                      beq.s      _core_3
[00002b24] 4878 0080                 pea.l      ($00000080).w
[00002b28] 2f0d                      move.l     a5,-(a7)
[00002b2a] 4eb9 0000 2532            jsr        _isacc
[00002b30] 508f                      addq.l     #8,a7
[00002b32] 4a87                      tst.l      d7
[00002b34] 670c                      beq.s      _core_4
[00002b36] 2e8d                      move.l     a5,(a7)
[00002b38] 4eb9 0000 25da            jsr        _isdir
[00002b3e] 4a87                      tst.l      d7
[00002b40] 6724                      beq.s      _core_5
_core_4:
[00002b42] 4297                      clr.l      (a7)
[00002b44] 2f0d                      move.l     a5,-(a7)
[00002b46] 4eb9 0000 3540            jsr        _puti
[00002b4c] 588f                      addq.l     #4,a7
_core_3:
[00002b4e] 2e0d                      move.l     a5,d7
[00002b50] 670a                      beq.s      _core_6
[00002b52] 4a2c 0142                 tst.b      322(a4)
[00002b56] 6604                      bne.s      _core_6
[00002b58] 7e01                      moveq.l    #1,d7
[00002b5a] 6002                      bra.s      _core_7
_core_6:
[00002b5c] 7e00                      moveq.l    #0,d7
_core_7:
[00002b5e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002b62] 4e5e                      unlk       a6
[00002b64] 4e75                      rts
_core_5:
[00002b66] 2e8d                      move.l     a5,(a7)
[00002b68] 4eb9 0000 3746            jsr        _trunci
[00002b6e] 2eae 000c                 move.l     12(a6),(a7)
[00002b72] 2f2e 0008                 move.l     8(a6),-(a7)
[00002b76] 2f0d                      move.l     a5,-(a7)
[00002b78] 4eb9 0000 0000            jsr        _coreout
[00002b7e] 508f                      addq.l     #8,a7
[00002b80] 4297                      clr.l      (a7)
[00002b82] 2f0d                      move.l     a5,-(a7)
[00002b84] 4eb9 0000 3540            jsr        _puti
[00002b8a] 588f                      addq.l     #4,a7
[00002b8c] 60c0                      bra.s      _core_3

_freebl:
[00002b8e] 4e56 fff6                 link       a6,#-10
[00002b92] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00002b96] 2a2e 000c                 move.l     12(a6),d5
[00002b9a] 2a6e 0010                 movea.l    16(a6),a5
[00002b9e] 2eae 0008                 move.l     8(a6),(a7)
[00002ba2] 4eb9 0000 0c18            jsr        _getaddr
[00002ba8] 2847                      movea.l    d7,a4
[00002baa] 2eae 0008                 move.l     8(a6),(a7)
[00002bae] 4eb9 0000 0c28            jsr        _getdev
[00002bb4] 3d47 fff6                 move.w     d7,-10(a6)
[00002bb8] 4a85                      tst.l      d5
[00002bba] 6604                      bne.s      _freebl_1
[00002bbc] 2e0d                      move.l     a5,d7
[00002bbe] 6756                      beq.s      _freebl_2
_freebl_1:
[00002bc0] 4a85                      tst.l      d5
[00002bc2] 6708                      beq.s      _freebl_3
[00002bc4] 2e3c 0000 0100            move.l     #$00000100,d7
[00002bca] 6002                      bra.s      _freebl_4
_freebl_3:
[00002bcc] 7e08                      moveq.l    #8,d7
_freebl_4:
[00002bce] 3d47 fff8                 move.w     d7,-8(a6)
[00002bd2] 42ae fffa                 clr.l      -6(a6)
_freebl_10:
[00002bd6] 536e fff8                 subq.w     #1,-8(a6)
[00002bda] 6d00 014a                 blt        _freebl_5
[00002bde] 2e0d                      move.l     a5,d7
[00002be0] 6622                      bne.s      _freebl_6
[00002be2] 2e85                      move.l     d5,(a7)
[00002be4] 7e00                      moveq.l    #0,d7
[00002be6] 3e2e fff6                 move.w     -10(a6),d7
[00002bea] 2f07                      move.l     d7,-(a7)
[00002bec] 4eb9 0000 095c            jsr        _readb
[00002bf2] 588f                      addq.l     #4,a7
[00002bf4] 2d47 fffa                 move.l     d7,-6(a6)
[00002bf8] 2eae fffa                 move.l     -6(a6),(a7)
[00002bfc] 4eb9 0000 0c18            jsr        _getaddr
[00002c02] 2a47                      movea.l    d7,a5
_freebl_6:
[00002c04] 4aae fffa                 tst.l      -6(a6)
[00002c08] 6714                      beq.s      _freebl_7
[00002c0a] 226e fffa                 movea.l    -6(a6),a1
[00002c0e] 0829 0003 0011            btst       #3,17(a1)
[00002c14] 6708                      beq.s      _freebl_7
_freebl_2:
[00002c16] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002c1a] 4e5e                      unlk       a6
[00002c1c] 4e75                      rts
_freebl_7:
[00002c1e] 7e00                      moveq.l    #0,d7
[00002c20] 3e2e fff6                 move.w     -10(a6),d7
[00002c24] 2e87                      move.l     d7,(a7)
[00002c26] 4a85                      tst.l      d5
[00002c28] 6716                      beq.s      _freebl_8
[00002c2a] 3e2e fff8                 move.w     -8(a6),d7
[00002c2e] 48c7                      ext.l      d7
[00002c30] e387                      asl.l      #1,d7
[00002c32] 4875 7800                 pea.l      0(a5,d7.l)
[00002c36] 4eb9 0000 26ac            jsr        _lstou
[00002c3c] 588f                      addq.l     #4,a7
[00002c3e] 6010                      bra.s      _freebl_9
_freebl_8:
[00002c40] 3e2e fff8                 move.w     -8(a6),d7
[00002c44] 48c7                      ext.l      d7
[00002c46] e387                      asl.l      #1,d7
[00002c48] 2247                      movea.l    d7,a1
[00002c4a] 7e00                      moveq.l    #0,d7
[00002c4c] 3e31 d800                 move.w     0(a1,a5.l),d7
_freebl_9:
[00002c50] 2f07                      move.l     d7,-(a7)
[00002c52] 2f0c                      move.l     a4,-(a7)
[00002c54] 4eb9 0000 3036            jsr        _goodbl
[00002c5a] 508f                      addq.l     #8,a7
[00002c5c] 3d47 fffe                 move.w     d7,-2(a6)
[00002c60] 6700 ff74                 beq        _freebl_10
[00002c64] 4a6c 0004                 tst.w      4(a4)
[00002c68] 660e                      bne.s      _freebl_11
[00002c6a] 397c 0001 0004            move.w     #$0001,4(a4)
[00002c70] 426c 0006                 clr.w      6(a4)
[00002c74] 6000 008c                 bra        _freebl_12
_freebl_11:
[00002c78] 3e2c 0004                 move.w     4(a4),d7
[00002c7c] 0c47 0064                 cmpi.w     #$0064,d7
[00002c80] 6500 0080                 bcs        _freebl_12 ; possibly optimized to short
[00002c84] 4aae fffa                 tst.l      -6(a6)
[00002c88] 670a                      beq.s      _freebl_13
[00002c8a] 2eae fffa                 move.l     -6(a6),(a7)
[00002c8e] 4eb9 0000 0390            jsr        _brelse
_freebl_13:
[00002c94] 7e00                      moveq.l    #0,d7
[00002c96] 3e2e fffe                 move.w     -2(a6),d7
[00002c9a] 2e87                      move.l     d7,(a7)
[00002c9c] 7e00                      moveq.l    #0,d7
[00002c9e] 3e2e fff6                 move.w     -10(a6),d7
[00002ca2] 2f07                      move.l     d7,-(a7)
[00002ca4] 4eb9 0000 04f4            jsr        _getblk
[00002caa] 588f                      addq.l     #4,a7
[00002cac] 2d47 fffa                 move.l     d7,-6(a6)
[00002cb0] 4878 00ca                 pea.l      ($000000CA).w
[00002cb4] 2f2e fffa                 move.l     -6(a6),-(a7)
[00002cb8] 4eb9 0000 0c18            jsr        _getaddr
[00002cbe] 588f                      addq.l     #4,a7
[00002cc0] 2f07                      move.l     d7,-(a7)
[00002cc2] 486c 0004                 pea.l      4(a4)
[00002cc6] 4eb9 0000 2754            jsr        _movbuf
[00002ccc] 4fef 000c                 lea.l      12(a7),a7
[00002cd0] 4878 0065                 pea.l      ($00000065).w
[00002cd4] 2f2e fffa                 move.l     -6(a6),-(a7)
[00002cd8] 4eb9 0000 0c18            jsr        _getaddr
[00002cde] 588f                      addq.l     #4,a7
[00002ce0] 2f07                      move.l     d7,-(a7)
[00002ce2] 4eb9 0000 0000            jsr        _bflip
[00002ce8] 508f                      addq.l     #8,a7
[00002cea] 426c 0004                 clr.w      4(a4)
[00002cee] 2eae fffa                 move.l     -6(a6),(a7)
[00002cf2] 4eb9 0000 0a3e            jsr        _writb
[00002cf8] 42ae fffa                 clr.l      -6(a6)
[00002cfc] 4a85                      tst.l      d5
[00002cfe] 6702                      beq.s      _freebl_12
[00002d00] 9bcd                      suba.l     a5,a5
_freebl_12:
[00002d02] 3e2c 0004                 move.w     4(a4),d7
[00002d06] 526c 0004                 addq.w     #1,4(a4)
[00002d0a] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00002d10] e387                      asl.l      #1,d7
[00002d12] 2247                      movea.l    d7,a1
[00002d14] 45ec 0006                 lea.l      6(a4),a2
[00002d18] 33ae fffe a800            move.w     -2(a6),0(a1,a2.l)
[00002d1e] 52ac 01a8                 addq.l     #1,424(a4)
[00002d22] 6000 feb2                 bra        _freebl_10
_freebl_5:
[00002d26] 4aae fffa                 tst.l      -6(a6)
[00002d2a] 670a                      beq.s      _freebl_14
[00002d2c] 2eae fffa                 move.l     -6(a6),(a7)
[00002d30] 4eb9 0000 0390            jsr        _brelse
_freebl_14:
[00002d36] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00002d3a] 4e5e                      unlk       a6
[00002d3c] 4e75                      rts

_getsb:
[00002d3e] 4e56 0000                 link       a6,#0
[00002d42] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00002d46] 4297                      clr.l      (a7)
[00002d48] 4eb9 0000 0358            jsr        _bbuy
[00002d4e] 4878 0001                 pea.l      ($00000001).w
[00002d52] 2f2e 0008                 move.l     8(a6),-(a7)
[00002d56] 4eb9 0000 095c            jsr        _readb
[00002d5c] 508f                      addq.l     #8,a7
[00002d5e] 2a47                      movea.l    d7,a5
[00002d60] 082d 0003 0011            btst       #3,17(a5)
[00002d66] 6712                      beq.s      _getsb_1
[00002d68] 2e8d                      move.l     a5,(a7)
[00002d6a] 4eb9 0000 0390            jsr        _brelse
[00002d70] 4eb9 0000 03f4            jsr        _bsell
[00002d76] 7e00                      moveq.l    #0,d7
[00002d78] 6052                      bra.s      _getsb_2
_getsb_1:
[00002d7a] 2e8d                      move.l     a5,(a7)
[00002d7c] 4eb9 0000 0c18            jsr        _getaddr
[00002d82] 2847                      movea.l    d7,a4
[00002d84] 2e8c                      move.l     a4,(a7)
[00002d86] 4eb9 0000 36f2            jsr        _sflip
[00002d8c] 3e2c 0004                 move.w     4(a4),d7
[00002d90] 0c47 0064                 cmpi.w     #$0064,d7
[00002d94] 620a                      bhi.s      _getsb_3
[00002d96] 3e2c 00ce                 move.w     206(a4),d7
[00002d9a] 0c47 0064                 cmpi.w     #$0064,d7
[00002d9e] 6334                      bls.s      _getsb_4
_getsb_3:
[00002da0] 4297                      clr.l      (a7)
[00002da2] 2f2e 0008                 move.l     8(a6),-(a7)
[00002da6] 2f3c 0000 b177            move.l     #$00015EE5,-(a7)
[00002dac] 4eb9 0000 2016            jsr        _putderr
[00002db2] 508f                      addq.l     #8,a7
[00002db4] 2e8c                      move.l     a4,(a7)
[00002db6] 4eb9 0000 36f2            jsr        _sflip
[00002dbc] 2e8d                      move.l     a5,(a7)
[00002dbe] 4eb9 0000 0390            jsr        _brelse
[00002dc4] 4eb9 0000 03f4            jsr        _bsell
[00002dca] 7e00                      moveq.l    #0,d7
_getsb_2:
[00002dcc] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00002dd0] 4e5e                      unlk       a6
[00002dd2] 4e75                      rts
_getsb_4:
[00002dd4] 2e0d                      move.l     a5,d7
[00002dd6] 60f4                      bra.s      _getsb_2

_geti:
[00002dd8] 4e56 0000                 link       a6,#0
[00002ddc] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
_geti_8:
[00002de0] 2eae 000c                 move.l     12(a6),(a7)
[00002de4] 2f2e 0008                 move.l     8(a6),-(a7)
[00002de8] 4eb9 0000 31fc            jsr        _loci
[00002dee] 588f                      addq.l     #4,a7
[00002df0] 2847                      movea.l    d7,a4
[00002df2] 2e0c                      move.l     a4,d7
[00002df4] 6700 0090                 beq        _geti_1
[00002df8] 526c 000e                 addq.w     #1,14(a4)
[00002dfc] 4878 fffe                 pea.l      ($FFFFFFFE).w
[00002e00] 2f0c                      move.l     a4,-(a7)
[00002e02] 4eb9 0000 2646            jsr        _locki
[00002e08] 508f                      addq.l     #8,a7
[00002e0a] 082c 0005 000d            btst       #5,13(a4)
[00002e10] 671c                      beq.s      _geti_2
[00002e12] 4878 0005                 pea.l      ($00000005).w
[00002e16] 4eb9 0000 2868            jsr        _uerror
[00002e1c] 588f                      addq.l     #4,a7
[00002e1e] 4297                      clr.l      (a7)
[00002e20] 2f0c                      move.l     a4,-(a7)
[00002e22] 4eb9 0000 3540            jsr        _puti
[00002e28] 588f                      addq.l     #4,a7
[00002e2a] 7e00                      moveq.l    #0,d7
[00002e2c] 600a                      bra.s      _geti_3
_geti_2:
[00002e2e] 082c 0002 000d            btst       #2,13(a4)
[00002e34] 660a                      bne.s      _geti_4
[00002e36] 2e0c                      move.l     a4,d7
_geti_3:
[00002e38] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002e3c] 4e5e                      unlk       a6
[00002e3e] 4e75                      rts
_geti_4:
[00002e40] 2679 0000 b0ec            movea.l    _mlist,a3
_geti_6:
[00002e46] 2e0b                      move.l     a3,d7
[00002e48] 670c                      beq.s      _geti_5
[00002e4a] 2e2b 0004                 move.l     4(a3),d7
[00002e4e] be8c                      cmp.l      a4,d7
[00002e50] 6704                      beq.s      _geti_5
[00002e52] 2653                      movea.l    (a3),a3
[00002e54] 60f0                      bra.s      _geti_6
_geti_5:
[00002e56] 2e0b                      move.l     a3,d7
[00002e58] 660c                      bne.s      _geti_7
[00002e5a] 2ebc 0000 b181            move.l     #$00015EEF,(a7)
[00002e60] 4eb9 0000 0000            jsr        _panic
_geti_7:
[00002e66] 7e00                      moveq.l    #0,d7
[00002e68] 3e2b 0008                 move.w     8(a3),d7
[00002e6c] 2d47 0008                 move.l     d7,8(a6)
[00002e70] 7001                      moveq.l    #1,d0
[00002e72] 2d40 000c                 move.l     d0,12(a6)
[00002e76] 536c 000e                 subq.w     #1,14(a4)
[00002e7a] 2e8c                      move.l     a4,(a7)
[00002e7c] 4eb9 0000 278c            jsr        _reli
[00002e82] 6000 ff5c                 bra        _geti_8
_geti_1:
[00002e86] 2eb9 0000 b0e8            move.l     _ilist,(a7)
[00002e8c] 4878 0032                 pea.l      ($00000032).w
[00002e90] 4eb9 0000 00f6            jsr        _alloc
[00002e96] 588f                      addq.l     #4,a7
[00002e98] 2847                      movea.l    d7,a4
[00002e9a] 2e0c                      move.l     a4,d7
[00002e9c] 6610                      bne.s      _geti_9
[00002e9e] 4878 0017                 pea.l      ($00000017).w
[00002ea2] 4eb9 0000 2868            jsr        _uerror
[00002ea8] 588f                      addq.l     #4,a7
[00002eaa] 7e00                      moveq.l    #0,d7
[00002eac] 608a                      bra.s      _geti_3
_geti_9:
[00002eae] 23cc 0000 b0e8            move.l     a4,_ilist
[00002eb4] 42ac 0008                 clr.l      8(a4)
[00002eb8] 42ac 0004                 clr.l      4(a4)
[00002ebc] 397c 0002 000c            move.w     #$0002,12(a4)
[00002ec2] 397c 0001 000e            move.w     #$0001,14(a4)
[00002ec8] 426c 0012                 clr.w      18(a4)
[00002ecc] 426c 0010                 clr.w      16(a4)
[00002ed0] 396e 000a 0016            move.w     10(a6),22(a4)
[00002ed6] 396e 000e 0018            move.w     14(a6),24(a4)
[00002edc] 2eae 000c                 move.l     12(a6),(a7)
[00002ee0] 2f2e 0008                 move.l     8(a6),-(a7)
[00002ee4] 4eb9 0000 31dc            jsr        _ireadb
[00002eea] 588f                      addq.l     #4,a7
[00002eec] 2a47                      movea.l    d7,a5
[00002eee] 486c 001a                 pea.l      26(a4)
[00002ef2] 2f2e 000c                 move.l     12(a6),-(a7)
[00002ef6] 2f0d                      move.l     a5,-(a7)
[00002ef8] 4eb9 0000 31b4            jsr        _iboff
[00002efe] 508f                      addq.l     #8,a7
[00002f00] 2f07                      move.l     d7,-(a7)
[00002f02] 4eb9 0000 0000            jsr        _iflip
[00002f08] 508f                      addq.l     #8,a7
[00002f0a] 2e8d                      move.l     a5,(a7)
[00002f0c] 4eb9 0000 0390            jsr        _brelse
[00002f12] 082d 0003 0011            btst       #3,17(a5)
[00002f18] 672e                      beq.s      _geti_10
[00002f1a] 7e00                      moveq.l    #0,d7
[00002f1c] 3e2c 0018                 move.w     24(a4),d7
[00002f20] 2e87                      move.l     d7,(a7)
[00002f22] 2f3c 0000 b18a            move.l     #$00015EF8,-(a7)
[00002f28] 2f0d                      move.l     a5,-(a7)
[00002f2a] 4eb9 0000 1f58            jsr        _deverr
[00002f30] 508f                      addq.l     #8,a7
[00002f32] 08ec 0005 000d            bset       #5,13(a4)
[00002f38] 4297                      clr.l      (a7)
[00002f3a] 2f0c                      move.l     a4,-(a7)
[00002f3c] 4eb9 0000 3540            jsr        _puti
[00002f42] 588f                      addq.l     #4,a7
[00002f44] 7e00                      moveq.l    #0,d7
[00002f46] 6008                      bra.s      _geti_11
_geti_10:
[00002f48] 397c ffff 0014            move.w     #$FFFF,20(a4)
[00002f4e] 2e0c                      move.l     a4,d7
_geti_11:
[00002f50] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00002f54] 4e5e                      unlk       a6
[00002f56] 4e75                      rts

_getstat:
[00002f58] 4e56 ffdc                 link       a6,#-36
[00002f5c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00002f60] 2a6e 0008                 movea.l    8(a6),a5
[00002f64] 7e00                      moveq.l    #0,d7
[00002f66] 3e2d 0018                 move.w     24(a5),d7
[00002f6a] 2e87                      move.l     d7,(a7)
[00002f6c] 7e00                      moveq.l    #0,d7
[00002f6e] 3e2d 0016                 move.w     22(a5),d7
[00002f72] 2f07                      move.l     d7,-(a7)
[00002f74] 4eb9 0000 31dc            jsr        _ireadb
[00002f7a] 588f                      addq.l     #4,a7
[00002f7c] 2847                      movea.l    d7,a4
[00002f7e] 7e00                      moveq.l    #0,d7
[00002f80] 3e2d 0018                 move.w     24(a5),d7
[00002f84] 2e87                      move.l     d7,(a7)
[00002f86] 2f0c                      move.l     a4,-(a7)
[00002f88] 4eb9 0000 31b4            jsr        _iboff
[00002f8e] 588f                      addq.l     #4,a7
[00002f90] 7c18                      moveq.l    #24,d6
[00002f92] dc87                      add.l      d7,d6
[00002f94] 2646                      movea.l    d6,a3
[00002f96] 2e93                      move.l     (a3),(a7)
[00002f98] 4eb9 0000 0000            jsr        _tflip
[00002f9e] 2d47 fff8                 move.l     d7,-8(a6)
[00002fa2] 2eab 0004                 move.l     4(a3),(a7)
[00002fa6] 4eb9 0000 0000            jsr        _tflip
[00002fac] 2d47 fffc                 move.l     d7,-4(a6)
[00002fb0] 082d 0005 001a            btst       #5,26(a5)
[00002fb6] 6708                      beq.s      _getstat_1
[00002fb8] 7e00                      moveq.l    #0,d7
[00002fba] 3e2d 0022                 move.w     34(a5),d7
[00002fbe] 6002                      bra.s      _getstat_2
_getstat_1:
[00002fc0] 7e00                      moveq.l    #0,d7
_getstat_2:
[00002fc2] 3d47 ffe8                 move.w     d7,-24(a6)
[00002fc6] 426e ffea                 clr.w      -22(a6)
[00002fca] 2e8d                      move.l     a5,(a7)
[00002fcc] 4eb9 0000 2686            jsr        _lsize
[00002fd2] 2d47 ffec                 move.l     d7,-20(a6)
[00002fd6] 42ae fff0                 clr.l      -16(a6)
[00002fda] 42ae fff4                 clr.l      -12(a6)
[00002fde] 4878 000c                 pea.l      ($0000000C).w
[00002fe2] 486e ffdc                 pea.l      -36(a6)
[00002fe6] 486d 0016                 pea.l      22(a5)
[00002fea] 4eb9 0000 2754            jsr        _movbuf
[00002ff0] 4fef 000c                 lea.l      12(a7),a7
[00002ff4] 4878 0024                 pea.l      ($00000024).w
[00002ff8] 2f2e 000c                 move.l     12(a6),-(a7)
[00002ffc] 486e ffdc                 pea.l      -36(a6)
[00003000] 4eb9 0000 0000            jsr        _outbuf
[00003006] 4fef 000c                 lea.l      12(a7),a7
[0000300a] 4a87                      tst.l      d7
[0000300c] 670c                      beq.s      _getstat_3
[0000300e] 4878 000e                 pea.l      ($0000000E).w
[00003012] 4eb9 0000 2868            jsr        _uerror
[00003018] 588f                      addq.l     #4,a7
_getstat_3:
[0000301a] 2e8c                      move.l     a4,(a7)
[0000301c] 4eb9 0000 0390            jsr        _brelse
[00003022] 4297                      clr.l      (a7)
[00003024] 2f0d                      move.l     a5,-(a7)
[00003026] 4eb9 0000 3540            jsr        _puti
[0000302c] 588f                      addq.l     #4,a7
[0000302e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003032] 4e5e                      unlk       a6
[00003034] 4e75                      rts

_goodbl:
[00003036] 4e56 fffc                 link       a6,#-4
[0000303a] 4aae 000c                 tst.l      12(a6)
[0000303e] 673c                      beq.s      _goodbl_1
[00003040] 226e 0008                 movea.l    8(a6),a1
[00003044] 7e00                      moveq.l    #0,d7
[00003046] 3e11                      move.w     (a1),d7
[00003048] 5487                      addq.l     #2,d7
[0000304a] 2c2e 000c                 move.l     12(a6),d6
[0000304e] bc87                      cmp.l      d7,d6
[00003050] 6d10                      blt.s      _goodbl_2
[00003052] 226e 0008                 movea.l    8(a6),a1
[00003056] 7e00                      moveq.l    #0,d7
[00003058] 3e29 0002                 move.w     2(a1),d7
[0000305c] beae 000c                 cmp.l      12(a6),d7
[00003060] 6e1a                      bgt.s      _goodbl_1
_goodbl_2:
[00003062] 4297                      clr.l      (a7)
[00003064] 2f2e 0010                 move.l     16(a6),-(a7)
[00003068] 2f3c 0000 b1a4            move.l     #$00015F12,-(a7)
[0000306e] 4eb9 0000 2016            jsr        _putderr
[00003074] 508f                      addq.l     #8,a7
[00003076] 7e00                      moveq.l    #0,d7
[00003078] 4e5e                      unlk       a6
[0000307a] 4e75                      rts
_goodbl_1:
[0000307c] 2e2e 000c                 move.l     12(a6),d7
[00003080] 4e5e                      unlk       a6
[00003082] 4e75                      rts

_grow:
[00003084] 4e56 fffc                 link       a6,#-4
[00003088] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000308c] 226e 000c                 movea.l    12(a6),a1
[00003090] 4a51                      tst.w      (a1)
[00003092] 660e                      bne.s      _grow_1
[00003094] 2eae 0008                 move.l     8(a6),(a7)
[00003098] 4eba fca4                 jsr        _getsb(pc)
[0000309c] 2d47 fffc                 move.l     d7,-4(a6)
[000030a0] 660a                      bne.s      _grow_2
_grow_1:
[000030a2] 7e00                      moveq.l    #0,d7
[000030a4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000030a8] 4e5e                      unlk       a6
[000030aa] 4e75                      rts
_grow_2:
[000030ac] 2eae fffc                 move.l     -4(a6),(a7)
[000030b0] 4eb9 0000 0c18            jsr        _getaddr
[000030b6] 2847                      movea.l    d7,a4
[000030b8] 9bcd                      suba.l     a5,a5
_grow_6:
[000030ba] 4a6c 0004                 tst.w      4(a4)
[000030be] 6700 00a2                 beq        _grow_3
[000030c2] 53ac 01a8                 subq.l     #1,424(a4)
[000030c6] 2eae 0008                 move.l     8(a6),(a7)
[000030ca] 536c 0004                 subq.w     #1,4(a4)
[000030ce] 7e00                      moveq.l    #0,d7
[000030d0] 3e2c 0004                 move.w     4(a4),d7
[000030d4] e387                      asl.l      #1,d7
[000030d6] 2247                      movea.l    d7,a1
[000030d8] 45ec 0006                 lea.l      6(a4),a2
[000030dc] 7e00                      moveq.l    #0,d7
[000030de] 3e31 a800                 move.w     0(a1,a2.l),d7
[000030e2] 2f07                      move.l     d7,-(a7)
[000030e4] 2f0c                      move.l     a4,-(a7)
[000030e6] 4eba ff4e                 jsr        _goodbl(pc)
[000030ea] 508f                      addq.l     #8,a7
[000030ec] 2a07                      move.l     d7,d5
[000030ee] 6604                      bne.s      _grow_4
[000030f0] 7e01                      moveq.l    #1,d7
[000030f2] 6002                      bra.s      _grow_5
_grow_4:
[000030f4] 7e00                      moveq.l    #0,d7
_grow_5:
[000030f6] 4a87                      tst.l      d7
[000030f8] 66c0                      bne.s      _grow_6
[000030fa] 4a6c 0004                 tst.w      4(a4)
[000030fe] 6652                      bne.s      _grow_7
[00003100] 2e85                      move.l     d5,(a7)
[00003102] 2f2e 0008                 move.l     8(a6),-(a7)
[00003106] 4eb9 0000 095c            jsr        _readb
[0000310c] 588f                      addq.l     #4,a7
[0000310e] 2a47                      movea.l    d7,a5
[00003110] 4878 00ca                 pea.l      ($000000CA).w
[00003114] 486c 0004                 pea.l      4(a4)
[00003118] 2f0d                      move.l     a5,-(a7)
[0000311a] 4eb9 0000 0c18            jsr        _getaddr
[00003120] 588f                      addq.l     #4,a7
[00003122] 2f07                      move.l     d7,-(a7)
[00003124] 4eb9 0000 2754            jsr        _movbuf
[0000312a] 4fef 000c                 lea.l      12(a7),a7
[0000312e] 4878 0065                 pea.l      ($00000065).w
[00003132] 486c 0004                 pea.l      4(a4)
[00003136] 4eb9 0000 0000            jsr        _bflip
[0000313c] 508f                      addq.l     #8,a7
[0000313e] 082d 0003 0011            btst       #3,17(a5)
[00003144] 671c                      beq.s      _grow_3
[00003146] 2e8d                      move.l     a5,(a7)
[00003148] 4eb9 0000 0390            jsr        _brelse
[0000314e] 9bcd                      suba.l     a5,a5
[00003150] 6010                      bra.s      _grow_3
_grow_7:
[00003152] 2e85                      move.l     d5,(a7)
[00003154] 2f2e 0008                 move.l     8(a6),-(a7)
[00003158] 4eb9 0000 04f4            jsr        _getblk
[0000315e] 588f                      addq.l     #4,a7
[00003160] 2a47                      movea.l    d7,a5
_grow_3:
[00003162] 2e0d                      move.l     a5,d7
[00003164] 6718                      beq.s      _grow_8
[00003166] 2e8d                      move.l     a5,(a7)
[00003168] 4eb9 0000 04ca            jsr        _clrbuf
[0000316e] 2e8d                      move.l     a5,(a7)
[00003170] 4eb9 0000 0a82            jsr        _writdb
[00003176] 226e 000c                 movea.l    12(a6),a1
[0000317a] 3285                      move.w     d5,(a1)
[0000317c] 6022                      bra.s      _grow_9
_grow_8:
[0000317e] 4297                      clr.l      (a7)
[00003180] 2f2e 0008                 move.l     8(a6),-(a7)
[00003184] 2f3c 0000 b1ae            move.l     #$00015F1C,-(a7)
[0000318a] 4eb9 0000 2016            jsr        _putderr
[00003190] 508f                      addq.l     #8,a7
[00003192] 4878 001c                 pea.l      ($0000001C).w
[00003196] 4eb9 0000 2868            jsr        _uerror
[0000319c] 588f                      addq.l     #4,a7
[0000319e] 7a00                      moveq.l    #0,d5
_grow_9:
[000031a0] 2eae fffc                 move.l     -4(a6),(a7)
[000031a4] 4eb9 0000 3686            jsr        _putsb
[000031aa] 2e05                      move.l     d5,d7
[000031ac] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000031b0] 4e5e                      unlk       a6
[000031b2] 4e75                      rts

_iboff:
[000031b4] 4e56 0000                 link       a6,#0
[000031b8] 48e7 8400                 movem.l    d0/d5,-(a7)
[000031bc] 2eae 0008                 move.l     8(a6),(a7)
[000031c0] 4eb9 0000 0c18            jsr        _getaddr
[000031c6] 2c2e 000c                 move.l     12(a6),d6
[000031ca] 5386                      subq.l     #1,d6
[000031cc] 7a0f                      moveq.l    #15,d5
[000031ce] ca86                      and.l      d6,d5
[000031d0] eb85                      asl.l      #5,d5
[000031d2] de85                      add.l      d5,d7
[000031d4] 4cdf 0021                 movem.l    (a7)+,d0/d5
[000031d8] 4e5e                      unlk       a6
[000031da] 4e75                      rts

_ireadb:
[000031dc] 4e56 0000                 link       a6,#0
[000031e0] 2e2e 000c                 move.l     12(a6),d7
[000031e4] 5387                      subq.l     #1,d7
[000031e6] e887                      asr.l      #4,d7
[000031e8] 2f07                      move.l     d7,-(a7)
[000031ea] 5497                      addq.l     #2,(a7)
[000031ec] 2f2e 0008                 move.l     8(a6),-(a7)
[000031f0] 4eb9 0000 095c            jsr        _readb
[000031f6] 508f                      addq.l     #8,a7
[000031f8] 4e5e                      unlk       a6
[000031fa] 4e75                      rts

_loci:
[000031fc] 4e56 0000                 link       a6,#0
[00003200] 48e7 8004                 movem.l    d0/a5,-(a7)
[00003204] 2a79 0000 b0e8            movea.l    _ilist,a5
_loci_4:
[0000320a] 2e0d                      move.l     a5,d7
[0000320c] 6720                      beq.s      _loci_1
[0000320e] 7e00                      moveq.l    #0,d7
[00003210] 3e2d 0018                 move.w     24(a5),d7
[00003214] beae 000c                 cmp.l      12(a6),d7
[00003218] 6610                      bne.s      _loci_2
[0000321a] 7e00                      moveq.l    #0,d7
[0000321c] 3e2d 0016                 move.w     22(a5),d7
[00003220] beae 0008                 cmp.l      8(a6),d7
[00003224] 6604                      bne.s      _loci_2
[00003226] 2e0d                      move.l     a5,d7
[00003228] 6006                      bra.s      _loci_3
_loci_2:
[0000322a] 2a55                      movea.l    (a5),a5
[0000322c] 60dc                      bra.s      _loci_4
_loci_1:
[0000322e] 7e00                      moveq.l    #0,d7
_loci_3:
[00003230] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00003234] 4e5e                      unlk       a6
[00003236] 4e75                      rts

_newi:
[00003238] 4e56 fff2                 link       a6,#-14
[0000323c] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003240] 2eae 0008                 move.l     8(a6),(a7)
[00003244] 4eb9 0000 248c            jsr        _getmount
[0000324a] 2247                      movea.l    d7,a1
[0000324c] 4a29 000e                 tst.b      14(a1)
[00003250] 660e                      bne.s      _newi_1
[00003252] 2eae 0008                 move.l     8(a6),(a7)
[00003256] 4eba fae6                 jsr        _getsb(pc)
[0000325a] 2d47 fffc                 move.l     d7,-4(a6)
[0000325e] 6616                      bne.s      _newi_2
_newi_1:
[00003260] 4878 000d                 pea.l      ($0000000D).w
[00003264] 4eb9 0000 2868            jsr        _uerror
[0000326a] 588f                      addq.l     #4,a7
[0000326c] 7e00                      moveq.l    #0,d7
[0000326e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003272] 4e5e                      unlk       a6
[00003274] 4e75                      rts
_newi_2:
[00003276] 2eae fffc                 move.l     -4(a6),(a7)
[0000327a] 4eb9 0000 0c18            jsr        _getaddr
[00003280] 2a47                      movea.l    d7,a5
[00003282] 97cb                      suba.l     a3,a3
_newi_13:
[00003284] 2e0b                      move.l     a3,d7
[00003286] 6600 01d4                 bne        _newi_3
[0000328a] 2279 0000 0000            movea.l    _pu,a1
[00003290] 4a29 0142                 tst.b      322(a1)
[00003294] 6600 01c6                 bne        _newi_3
[00003298] 4a6d 00ce                 tst.w      206(a5)
[0000329c] 6600 00dc                 bne        _newi_4
[000032a0] 3e15                      move.w     (a5),d7
[000032a2] 0c47 0fff                 cmpi.w     #$0FFF,d7
[000032a6] 6406                      bcc.s      _newi_5
[000032a8] 7e00                      moveq.l    #0,d7
[000032aa] 3e15                      move.w     (a5),d7
[000032ac] 6006                      bra.s      _newi_6
_newi_5:
[000032ae] 2e3c 0000 0fff            move.l     #$00000FFF,d7
_newi_6:
[000032b4] 3d47 fff6                 move.w     d7,-10(a6)
[000032b8] 426d 00ce                 clr.w      206(a5)
[000032bc] 3d7c 0001 fff2            move.w     #$0001,-14(a6)
_newi_11:
[000032c2] 3e2d 00ce                 move.w     206(a5),d7
[000032c6] 0c47 0064                 cmpi.w     #$0064,d7
[000032ca] 6400 00ae                 bcc        _newi_4
[000032ce] 536e fff6                 subq.w     #1,-10(a6)
[000032d2] 6d00 00a6                 blt        _newi_4
[000032d6] 7e00                      moveq.l    #0,d7
[000032d8] 3e2e fff2                 move.w     -14(a6),d7
[000032dc] 2e87                      move.l     d7,(a7)
[000032de] 2f2e 0008                 move.l     8(a6),-(a7)
[000032e2] 4eba fef8                 jsr        _ireadb(pc)
[000032e6] 588f                      addq.l     #4,a7
[000032e8] 2d47 fff8                 move.l     d7,-8(a6)
[000032ec] 226e fff8                 movea.l    -8(a6),a1
[000032f0] 0829 0003 0011            btst       #3,17(a1)
[000032f6] 6708                      beq.s      _newi_7
[000032f8] 066e 0010 fff2            addi.w     #$0010,-14(a6)
[000032fe] 606c                      bra.s      _newi_8
_newi_7:
[00003300] 3d7c 0010 fff4            move.w     #$0010,-12(a6)
[00003306] 2eae fff8                 move.l     -8(a6),(a7)
[0000330a] 4eb9 0000 0c18            jsr        _getaddr
[00003310] 2847                      movea.l    d7,a4
_newi_10:
[00003312] 3e2d 00ce                 move.w     206(a5),d7
[00003316] 0c47 0064                 cmpi.w     #$0064,d7
[0000331a] 6450                      bcc.s      _newi_8
[0000331c] 536e fff4                 subq.w     #1,-12(a6)
[00003320] 6d4a                      blt.s      _newi_8
[00003322] 2e8c                      move.l     a4,(a7)
[00003324] 4eb9 0000 26ac            jsr        _lstou
[0000332a] 0807 000f                 btst       #15,d7
[0000332e] 6632                      bne.s      _newi_9
[00003330] 7e00                      moveq.l    #0,d7
[00003332] 3e2e fff2                 move.w     -14(a6),d7
[00003336] 2e87                      move.l     d7,(a7)
[00003338] 2f2e 0008                 move.l     8(a6),-(a7)
[0000333c] 4eba febe                 jsr        _loci(pc)
[00003340] 588f                      addq.l     #4,a7
[00003342] 4a87                      tst.l      d7
[00003344] 661c                      bne.s      _newi_9
[00003346] 3e2d 00ce                 move.w     206(a5),d7
[0000334a] 526d 00ce                 addq.w     #1,206(a5)
[0000334e] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003354] e387                      asl.l      #1,d7
[00003356] 2247                      movea.l    d7,a1
[00003358] 45ed 00d0                 lea.l      208(a5),a2
[0000335c] 33ae fff2 a800            move.w     -14(a6),0(a1,a2.l)
_newi_9:
[00003362] 49ec 0020                 lea.l      32(a4),a4
[00003366] 526e fff2                 addq.w     #1,-14(a6)
[0000336a] 60a6                      bra.s      _newi_10
_newi_8:
[0000336c] 2eae fff8                 move.l     -8(a6),(a7)
[00003370] 4eb9 0000 0390            jsr        _brelse
[00003376] 6000 ff4a                 bra        _newi_11
_newi_4:
[0000337a] 4a6d 00ce                 tst.w      206(a5)
[0000337e] 6624                      bne.s      _newi_12
[00003380] 4297                      clr.l      (a7)
[00003382] 2f2e 0008                 move.l     8(a6),-(a7)
[00003386] 2f3c 0000 b1b7            move.l     #$00015F25,-(a7)
[0000338c] 4eb9 0000 2016            jsr        _putderr
[00003392] 508f                      addq.l     #8,a7
[00003394] 4878 001c                 pea.l      ($0000001C).w
[00003398] 4eb9 0000 2868            jsr        _uerror
[0000339e] 588f                      addq.l     #4,a7
[000033a0] 6000 00ba                 bra        _newi_3
_newi_12:
[000033a4] 4a6d 00ce                 tst.w      206(a5)
[000033a8] 6700 feda                 beq        _newi_13
[000033ac] 2279 0000 0000            movea.l    _pu,a1
[000033b2] 4a29 0142                 tst.b      322(a1)
[000033b6] 6600 fecc                 bne        _newi_13
[000033ba] 536d 00ce                 subq.w     #1,206(a5)
[000033be] 7e00                      moveq.l    #0,d7
[000033c0] 3e2d 00ce                 move.w     206(a5),d7
[000033c4] e387                      asl.l      #1,d7
[000033c6] 2247                      movea.l    d7,a1
[000033c8] 45ed 00d0                 lea.l      208(a5),a2
[000033cc] 3d71 a800 fff2            move.w     0(a1,a2.l),-14(a6)
[000033d2] 4a6e fff2                 tst.w      -14(a6)
[000033d6] 6714                      beq.s      _newi_14
[000033d8] 7e00                      moveq.l    #0,d7
[000033da] 3e2e fff2                 move.w     -14(a6),d7
[000033de] 5387                      subq.l     #1,d7
[000033e0] e887                      asr.l      #4,d7
[000033e2] 5287                      addq.l     #1,d7
[000033e4] 7c00                      moveq.l    #0,d6
[000033e6] 3c15                      move.w     (a5),d6
[000033e8] bc87                      cmp.l      d7,d6
[000033ea] 6c16                      bge.s      _newi_15
_newi_14:
[000033ec] 4297                      clr.l      (a7)
[000033ee] 2f2e 0008                 move.l     8(a6),-(a7)
[000033f2] 2f3c 0000 b1c1            move.l     #$00015F2F,-(a7)
[000033f8] 4eb9 0000 2016            jsr        _putderr
[000033fe] 508f                      addq.l     #8,a7
[00003400] 60a2                      bra.s      _newi_12
_newi_15:
[00003402] 7e00                      moveq.l    #0,d7
[00003404] 3e2e fff2                 move.w     -14(a6),d7
[00003408] 2e87                      move.l     d7,(a7)
[0000340a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000340e] 4eba fdec                 jsr        _loci(pc)
[00003412] 588f                      addq.l     #4,a7
[00003414] 4a87                      tst.l      d7
[00003416] 668c                      bne.s      _newi_12
[00003418] 7e00                      moveq.l    #0,d7
[0000341a] 3e2e fff2                 move.w     -14(a6),d7
[0000341e] 2e87                      move.l     d7,(a7)
[00003420] 2f2e 0008                 move.l     8(a6),-(a7)
[00003424] 4eba f9b2                 jsr        _geti(pc)
[00003428] 588f                      addq.l     #4,a7
[0000342a] 2647                      movea.l    d7,a3
[0000342c] 2e0b                      move.l     a3,d7
[0000342e] 6700 ff74                 beq        _newi_12
[00003432] 082b 0007 001a            btst       #7,26(a3)
[00003438] 6712                      beq.s      _newi_16
[0000343a] 4297                      clr.l      (a7)
[0000343c] 2f0b                      move.l     a3,-(a7)
[0000343e] 4eb9 0000 3540            jsr        _puti
[00003444] 588f                      addq.l     #4,a7
[00003446] 97cb                      suba.l     a3,a3
[00003448] 6000 ff5a                 bra        _newi_12
_newi_16:
[0000344c] 536d 01ac                 subq.w     #1,428(a5)
[00003450] 2e8b                      move.l     a3,(a7)
[00003452] 4eb9 0000 3b64            jsr        _zeroi
[00003458] 6000 fe2a                 bra        _newi_13
_newi_3:
[0000345c] 2eae fffc                 move.l     -4(a6),(a7)
[00003460] 4eb9 0000 3686            jsr        _putsb
[00003466] 2e0b                      move.l     a3,d7
[00003468] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000346c] 4e5e                      unlk       a6
[0000346e] 4e75                      rts

_printi:
[00003470] 4e56 0000                 link       a6,#0
[00003474] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00003478] 2a6e 0008                 movea.l    8(a6),a5
[0000347c] 1e39 0000 b1cb            move.b     _callno,d7
[00003482] 4887                      ext.w      d7
[00003484] 48c7                      ext.l      d7
[00003486] 2e87                      move.l     d7,(a7)
[00003488] 4eb9 0000 2320            jsr        _curproc
[0000348e] 7c14                      moveq.l    #20,d6
[00003490] dc87                      add.l      d7,d6
[00003492] 2f06                      move.l     d6,-(a7)
[00003494] 2f3c 0000 b1cc            move.l     #$00015F3A,-(a7)
[0000349a] 4eb9 0000 20d6            jsr        _putfmt
[000034a0] 508f                      addq.l     #8,a7
[000034a2] 4297                      clr.l      (a7)
[000034a4] 7e00                      moveq.l    #0,d7
[000034a6] 3e2d 0016                 move.w     22(a5),d7
[000034aa] 2f07                      move.l     d7,-(a7)
[000034ac] 4eb9 0000 204c            jsr        _putdnm
[000034b2] 588f                      addq.l     #4,a7
[000034b4] 7e00                      moveq.l    #0,d7
[000034b6] 3e2d 0018                 move.w     24(a5),d7
[000034ba] 2e87                      move.l     d7,(a7)
[000034bc] 2f3c 0000 b1d3            move.l     #$00015F41,-(a7)
[000034c2] 4eb9 0000 20d6            jsr        _putfmt
[000034c8] 588f                      addq.l     #4,a7
[000034ca] 7a00                      moveq.l    #0,d5
_printi_4:
[000034cc] 0c85 0000 0009            cmpi.l     #$00000009,d5
[000034d2] 6e2a                      bgt.s      _printi_1
[000034d4] 7e01                      moveq.l    #1,d7
[000034d6] eba7                      asl.l      d5,d7
[000034d8] 7c00                      moveq.l    #0,d6
[000034da] 3c2d 000c                 move.w     12(a5),d6
[000034de] ce86                      and.l      d6,d7
[000034e0] 670e                      beq.s      _printi_2
[000034e2] 227c 0000 b1d8            movea.l    #$00015F46,a1
[000034e8] 7e00                      moveq.l    #0,d7
[000034ea] 1e31 5800                 move.b     0(a1,d5.l),d7
[000034ee] 6002                      bra.s      _printi_3
_printi_2:
[000034f0] 7e20                      moveq.l    #32,d7
_printi_3:
[000034f2] 2e87                      move.l     d7,(a7)
[000034f4] 4eb9 0000 0000            jsr        _putch
[000034fa] 5285                      addq.l     #1,d5
[000034fc] 60ce                      bra.s      _printi_4
_printi_1:
[000034fe] 7e00                      moveq.l    #0,d7
[00003500] 1e2d 001c                 move.b     28(a5),d7
[00003504] 2e87                      move.l     d7,(a7)
[00003506] 7e00                      moveq.l    #0,d7
[00003508] 3e2d 0012                 move.w     18(a5),d7
[0000350c] 2f07                      move.l     d7,-(a7)
[0000350e] 7e00                      moveq.l    #0,d7
[00003510] 3e2d 000e                 move.w     14(a5),d7
[00003514] 2f07                      move.l     d7,-(a7)
[00003516] 2f3c 0000 b1e3            move.l     #$00015F51,-(a7)
[0000351c] 4eb9 0000 20d6            jsr        _putfmt
[00003522] 4fef 000c                 lea.l      12(a7),a7
[00003526] 2eae 000c                 move.l     12(a6),(a7)
[0000352a] 2f3c 0000 b1fd            move.l     #$00015F6B,-(a7)
[00003530] 4eb9 0000 20d6            jsr        _putfmt
[00003536] 588f                      addq.l     #4,a7
[00003538] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000353c] 4e5e                      unlk       a6
[0000353e] 4e75                      rts

_puti:
[00003540] 4e56 fffe                 link       a6,#-2
[00003544] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003548] 2a6e 0008                 movea.l    8(a6),a5
[0000354c] 3d6d 0016 fffe            move.w     22(a5),-2(a6)
[00003552] 3e2d 000e                 move.w     14(a5),d7
[00003556] 0c47 0001                 cmpi.w     #$0001,d7
[0000355a] 6600 00e0                 bne        _puti_1
[0000355e] 082d 0005 000d            btst       #5,13(a5)
[00003564] 6678                      bne.s      _puti_2
[00003566] 4a2d 001c                 tst.b      28(a5)
[0000356a] 6672                      bne.s      _puti_2
[0000356c] 2e8d                      move.l     a5,(a7)
[0000356e] 4eb9 0000 3746            jsr        _trunci
[00003574] 426d 001a                 clr.w      26(a5)
[00003578] 006d 0009 000c            ori.w      #$0009,12(a5)
[0000357e] 7e00                      moveq.l    #0,d7
[00003580] 3e2d 0016                 move.w     22(a5),d7
[00003584] 2e87                      move.l     d7,(a7)
[00003586] 4eba f7b6                 jsr        _getsb(pc)
[0000358a] 2847                      movea.l    d7,a4
[0000358c] 2e0c                      move.l     a4,d7
[0000358e] 673e                      beq.s      _puti_3
[00003590] 2e8c                      move.l     a4,(a7)
[00003592] 4eb9 0000 0c18            jsr        _getaddr
[00003598] 2647                      movea.l    d7,a3
[0000359a] 3e2b 00ce                 move.w     206(a3),d7
[0000359e] 0c47 0064                 cmpi.w     #$0064,d7
[000035a2] 641c                      bcc.s      _puti_4
[000035a4] 3e2b 00ce                 move.w     206(a3),d7
[000035a8] 526b 00ce                 addq.w     #1,206(a3)
[000035ac] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000035b2] e387                      asl.l      #1,d7
[000035b4] 2247                      movea.l    d7,a1
[000035b6] 45eb 00d0                 lea.l      208(a3),a2
[000035ba] 33ad 0018 a800            move.w     24(a5),0(a1,a2.l)
_puti_4:
[000035c0] 526b 01ac                 addq.w     #1,428(a3)
[000035c4] 2e8c                      move.l     a4,(a7)
[000035c6] 4eb9 0000 3686            jsr        _putsb
[000035cc] 6010                      bra.s      _puti_2
_puti_3:
[000035ce] 082d 0007 000d            btst       #7,13(a5)
[000035d4] 6708                      beq.s      _puti_2
[000035d6] 2e8d                      move.l     a5,(a7)
[000035d8] 4eb9 0000 3746            jsr        _trunci
_puti_2:
[000035de] 2e8d                      move.l     a5,(a7)
[000035e0] 4eb9 0000 388e            jsr        _updi
[000035e6] 082d 0004 000d            btst       #4,13(a5)
[000035ec] 663a                      bne.s      _puti_5
[000035ee] 4aad 0008                 tst.l      8(a5)
[000035f2] 6634                      bne.s      _puti_5
[000035f4] 4aad 0004                 tst.l      4(a5)
[000035f8] 662e                      bne.s      _puti_5
[000035fa] 2ebc 0000 b0e8            move.l     #_ilist,(a7)
[00003600] 2f0d                      move.l     a5,-(a7)
[00003602] 4878 0032                 pea.l      ($00000032).w
[00003606] 4eb9 0000 0138            jsr        _frelst
[0000360c] 508f                      addq.l     #8,a7
[0000360e] 4aae 000c                 tst.l      12(a6)
[00003612] 6712                      beq.s      _puti_6
[00003614] 4297                      clr.l      (a7)
[00003616] 7e00                      moveq.l    #0,d7
[00003618] 3e2e fffe                 move.w     -2(a6),d7
[0000361c] 2f07                      move.l     d7,-(a7)
[0000361e] 4eb9 0000 0416            jsr        _buflush
[00003624] 588f                      addq.l     #4,a7
_puti_6:
[00003626] 6056                      bra.s      _puti_7
_puti_5:
[00003628] 2ebc 0000 b202            move.l     #$00015F70,(a7)
[0000362e] 2f0d                      move.l     a5,-(a7)
[00003630] 4eba fe3e                 jsr        _printi(pc)
[00003634] 588f                      addq.l     #4,a7
[00003636] 526d 000e                 addq.w     #1,14(a5)
[0000363a] 601e                      bra.s      _puti_8
_puti_1:
[0000363c] 4aae 000c                 tst.l      12(a6)
[00003640] 6718                      beq.s      _puti_8
[00003642] 3e2d 000c                 move.w     12(a5),d7
[00003646] 0247 0009                 andi.w     #$0009,d7
[0000364a] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003650] 6708                      beq.s      _puti_8
[00003652] 2e8d                      move.l     a5,(a7)
[00003654] 4eb9 0000 388e            jsr        _updi
_puti_8:
[0000365a] 536d 000e                 subq.w     #1,14(a5)
[0000365e] 2e8d                      move.l     a5,(a7)
[00003660] 4eb9 0000 278c            jsr        _reli
[00003666] 4aae 000c                 tst.l      12(a6)
[0000366a] 6712                      beq.s      _puti_7
[0000366c] 4297                      clr.l      (a7)
[0000366e] 7e00                      moveq.l    #0,d7
[00003670] 3e2e fffe                 move.w     -2(a6),d7
[00003674] 2f07                      move.l     d7,-(a7)
[00003676] 4eb9 0000 0416            jsr        _buflush
[0000367c] 588f                      addq.l     #4,a7
_puti_7:
[0000367e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003682] 4e5e                      unlk       a6
[00003684] 4e75                      rts

_putsb:
[00003686] 4e56 0000                 link       a6,#0
[0000368a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000368e] 2a6e 0008                 movea.l    8(a6),a5
[00003692] 2e0d                      move.l     a5,d7
[00003694] 674a                      beq.s      _putsb_1
[00003696] 2e8d                      move.l     a5,(a7)
[00003698] 4eb9 0000 0c18            jsr        _getaddr
[0000369e] 2647                      movea.l    d7,a3
[000036a0] 277c 4057 534c 0198       move.l     #$4057534C,408(a3)
[000036a8] 2779 0000 b59c 019c       move.l     _time,412(a3)
[000036b0] 2e8b                      move.l     a3,(a7)
[000036b2] 4eb9 0000 36f2            jsr        _sflip
[000036b8] 7e00                      moveq.l    #0,d7
[000036ba] 3e2d 0012                 move.w     18(a5),d7
[000036be] 2e87                      move.l     d7,(a7)
[000036c0] 4eb9 0000 248c            jsr        _getmount
[000036c6] 2847                      movea.l    d7,a4
[000036c8] 2e0c                      move.l     a4,d7
[000036ca] 6706                      beq.s      _putsb_2
[000036cc] 4a2c 000e                 tst.b      14(a4)
[000036d0] 6716                      beq.s      _putsb_3
_putsb_2:
[000036d2] 2e8d                      move.l     a5,(a7)
[000036d4] 4eb9 0000 0390            jsr        _brelse
_putsb_4:
[000036da] 4eb9 0000 03f4            jsr        _bsell
_putsb_1:
[000036e0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000036e4] 4e5e                      unlk       a6
[000036e6] 4e75                      rts
_putsb_3:
[000036e8] 2e8d                      move.l     a5,(a7)
[000036ea] 4eb9 0000 0a82            jsr        _writdb
[000036f0] 60e8                      bra.s      _putsb_4

_sflip:
[000036f2] 4e56 0000                 link       a6,#0
[000036f6] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000036fa] 2a6e 0008                 movea.l    8(a6),a5
[000036fe] 7e00                      moveq.l    #0,d7
[00003700] 0687 0000 0198            addi.l     #$00000198,d7
[00003706] e28f                      lsr.l      #1,d7
[00003708] 2e87                      move.l     d7,(a7)
[0000370a] 2f0d                      move.l     a5,-(a7)
[0000370c] 4eb9 0000 0000            jsr        _bflip
[00003712] 588f                      addq.l     #4,a7
[00003714] 43ed 0198                 lea.l      408(a5),a1
[00003718] 2649                      movea.l    a1,a3
[0000371a] 43ed 01ac                 lea.l      428(a5),a1
[0000371e] 2849                      movea.l    a1,a4
_sflip_2:
[00003720] b7cc                      cmpa.l     a4,a3
[00003722] 640e                      bcc.s      _sflip_1
[00003724] 2e93                      move.l     (a3),(a7)
[00003726] 4eb9 0000 0000            jsr        _tflip
[0000372c] 2687                      move.l     d7,(a3)
[0000372e] 588b                      addq.l     #4,a3
[00003730] 60ee                      bra.s      _sflip_2
_sflip_1:
[00003732] 2e8c                      move.l     a4,(a7)
[00003734] 4eb9 0000 26ac            jsr        _lstou
[0000373a] 3887                      move.w     d7,(a4)
[0000373c] 2e0d                      move.l     a5,d7
[0000373e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003742] 4e5e                      unlk       a6
[00003744] 4e75                      rts

_trunci:
[00003746] 4e56 fff6                 link       a6,#-10
[0000374a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000374e] 2a6e 0008                 movea.l    8(a6),a5
[00003752] 7e00                      moveq.l    #0,d7
[00003754] 3e2d 001a                 move.w     26(a5),d7
[00003758] 0287 0000 6000            andi.l     #$00006000,d7
[0000375e] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00003764] 6726                      beq.s      _trunci_1
[00003766] 7e00                      moveq.l    #0,d7
[00003768] 3e2d 001a                 move.w     26(a5),d7
[0000376c] 0287 0000 6000            andi.l     #$00006000,d7
[00003772] 0c87 0000 6000            cmpi.l     #$00006000,d7
[00003778] 6712                      beq.s      _trunci_1
[0000377a] 7e00                      moveq.l    #0,d7
[0000377c] 3e2d 0016                 move.w     22(a5),d7
[00003780] 2e87                      move.l     d7,(a7)
[00003782] 4eba f5ba                 jsr        _getsb(pc)
[00003786] 2847                      movea.l    d7,a4
[00003788] 2e0c                      move.l     a4,d7
[0000378a] 6608                      bne.s      _trunci_2
_trunci_1:
[0000378c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003790] 4e5e                      unlk       a6
[00003792] 4e75                      rts
_trunci_2:
[00003794] 082d 0004 001a            btst       #4,26(a5)
[0000379a] 6700 00c6                 beq        _trunci_3
[0000379e] 4a6d 0030                 tst.w      48(a5)
[000037a2] 6700 0094                 beq        _trunci_4
[000037a6] 3a3c 0100                 move.w     #$0100,d5
[000037aa] 48c5                      ext.l      d5
_trunci_9:
[000037ac] 4297                      clr.l      (a7)
[000037ae] 4eb9 0000 2868            jsr        _uerror
[000037b4] 4a87                      tst.l      d7
[000037b6] 6600 0080                 bne        _trunci_4 ; possibly optimized to short
[000037ba] 5385                      subq.l     #1,d5
[000037bc] 6d7a                      blt.s      _trunci_4
[000037be] 7e00                      moveq.l    #0,d7
[000037c0] 3e2d 0030                 move.w     48(a5),d7
[000037c4] 2e87                      move.l     d7,(a7)
[000037c6] 7e00                      moveq.l    #0,d7
[000037c8] 3e2d 0016                 move.w     22(a5),d7
[000037cc] 2f07                      move.l     d7,-(a7)
[000037ce] 4eb9 0000 095c            jsr        _readb
[000037d4] 588f                      addq.l     #4,a7
[000037d6] 2d47 fff6                 move.l     d7,-10(a6)
[000037da] 2eae fff6                 move.l     -10(a6),(a7)
[000037de] 4eb9 0000 0c18            jsr        _getaddr
[000037e4] 2c05                      move.l     d5,d6
[000037e6] e386                      asl.l      #1,d6
[000037e8] de86                      add.l      d6,d7
[000037ea] 2d47 fffc                 move.l     d7,-4(a6)
_trunci_6:
[000037ee] 4a85                      tst.l      d5
[000037f0] 6d10                      blt.s      _trunci_5
[000037f2] 226e fffc                 movea.l    -4(a6),a1
[000037f6] 4a51                      tst.w      (a1)
[000037f8] 6608                      bne.s      _trunci_5
[000037fa] 55ae fffc                 subq.l     #2,-4(a6)
[000037fe] 5385                      subq.l     #1,d5
[00003800] 60ec                      bra.s      _trunci_6
_trunci_5:
[00003802] 4a85                      tst.l      d5
[00003804] 6d0c                      blt.s      _trunci_7
[00003806] 2eae fffc                 move.l     -4(a6),(a7)
[0000380a] 4eb9 0000 26ac            jsr        _lstou
[00003810] 6002                      bra.s      _trunci_8
_trunci_7:
[00003812] 7e00                      moveq.l    #0,d7
_trunci_8:
[00003814] 3d47 fffa                 move.w     d7,-6(a6)
[00003818] 2eae fff6                 move.l     -10(a6),(a7)
[0000381c] 4eb9 0000 0390            jsr        _brelse
[00003822] 4297                      clr.l      (a7)
[00003824] 7e00                      moveq.l    #0,d7
[00003826] 3e2e fffa                 move.w     -6(a6),d7
[0000382a] 2f07                      move.l     d7,-(a7)
[0000382c] 2f0c                      move.l     a4,-(a7)
[0000382e] 4eba f35e                 jsr        _freebl(pc)
[00003832] 508f                      addq.l     #8,a7
[00003834] 6000 ff76                 bra        _trunci_9
_trunci_4:
[00003838] 7a08                      moveq.l    #8,d5
_trunci_11:
[0000383a] 5385                      subq.l     #1,d5
[0000383c] 6d1e                      blt.s      _trunci_10
[0000383e] 4297                      clr.l      (a7)
[00003840] 2e05                      move.l     d5,d7
[00003842] e387                      asl.l      #1,d7
[00003844] 2247                      movea.l    d7,a1
[00003846] 45ed 0022                 lea.l      34(a5),a2
[0000384a] 7e00                      moveq.l    #0,d7
[0000384c] 3e31 a800                 move.w     0(a1,a2.l),d7
[00003850] 2f07                      move.l     d7,-(a7)
[00003852] 2f0c                      move.l     a4,-(a7)
[00003854] 4eba f338                 jsr        _freebl(pc)
[00003858] 508f                      addq.l     #8,a7
[0000385a] 60de                      bra.s      _trunci_11
_trunci_10:
[0000385c] 08ad 0004 001a            bclr       #4,26(a5)
_trunci_3:
[00003862] 486d 0022                 pea.l      34(a5)
[00003866] 42a7                      clr.l      -(a7)
[00003868] 2f0c                      move.l     a4,-(a7)
[0000386a] 4eba f322                 jsr        _freebl(pc)
[0000386e] 4fef 000c                 lea.l      12(a7),a7
[00003872] 2e8c                      move.l     a4,(a7)
[00003874] 4eba fe10                 jsr        _putsb(pc)
[00003878] 2e8d                      move.l     a5,(a7)
[0000387a] 4eb9 0000 3b64            jsr        _zeroi
[00003880] 08ed 0003 000d            bset       #3,13(a5)
[00003886] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000388a] 4e5e                      unlk       a6
[0000388c] 4e75                      rts

_updi:
[0000388e] 4e56 0000                 link       a6,#0
[00003892] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003896] 2a6e 0008                 movea.l    8(a6),a5
[0000389a] 3e2d 000c                 move.w     12(a5),d7
[0000389e] 0247 0209                 andi.w     #$0209,d7
[000038a2] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000038a8] 6700 00e8                 beq        _updi_1
[000038ac] 082d 0006 000d            btst       #6,13(a5)
[000038b2] 6600 00de                 bne        _updi_1
[000038b6] 7e00                      moveq.l    #0,d7
[000038b8] 3e2d 0016                 move.w     22(a5),d7
[000038bc] 2e87                      move.l     d7,(a7)
[000038be] 4eb9 0000 248c            jsr        _getmount
[000038c4] 2247                      movea.l    d7,a1
[000038c6] 4a29 000e                 tst.b      14(a1)
[000038ca] 6600 00c6                 bne        _updi_1
[000038ce] 7e00                      moveq.l    #0,d7
[000038d0] 3e2d 0018                 move.w     24(a5),d7
[000038d4] 2e87                      move.l     d7,(a7)
[000038d6] 7e00                      moveq.l    #0,d7
[000038d8] 3e2d 0016                 move.w     22(a5),d7
[000038dc] 2f07                      move.l     d7,-(a7)
[000038de] 4eba f8fc                 jsr        _ireadb(pc)
[000038e2] 588f                      addq.l     #4,a7
[000038e4] 2847                      movea.l    d7,a4
[000038e6] 082c 0003 0011            btst       #3,17(a4)
[000038ec] 6728                      beq.s      _updi_2
[000038ee] 7e00                      moveq.l    #0,d7
[000038f0] 3e2d 0018                 move.w     24(a5),d7
[000038f4] 2e87                      move.l     d7,(a7)
[000038f6] 2f3c 0000 b218            move.l     #$00015F86,-(a7)
[000038fc] 2f0c                      move.l     a4,-(a7)
[000038fe] 4eb9 0000 1f58            jsr        _deverr
[00003904] 508f                      addq.l     #8,a7
[00003906] 2e8c                      move.l     a4,(a7)
[00003908] 4eb9 0000 0390            jsr        _brelse
[0000390e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003912] 4e5e                      unlk       a6
[00003914] 4e75                      rts
_updi_2:
[00003916] 7e00                      moveq.l    #0,d7
[00003918] 3e2d 0018                 move.w     24(a5),d7
[0000391c] 2e87                      move.l     d7,(a7)
[0000391e] 2f0c                      move.l     a4,-(a7)
[00003920] 4eba f892                 jsr        _iboff(pc)
[00003924] 588f                      addq.l     #4,a7
[00003926] 2647                      movea.l    d7,a3
[00003928] 2e8b                      move.l     a3,(a7)
[0000392a] 486d 001a                 pea.l      26(a5)
[0000392e] 4eb9 0000 0000            jsr        _iflip
[00003934] 588f                      addq.l     #4,a7
[00003936] 082d 0003 000d            btst       #3,13(a5)
[0000393c] 6710                      beq.s      _updi_3
[0000393e] 2eb9 0000 b59c            move.l     _time,(a7)
[00003944] 4eb9 0000 0000            jsr        _tflip
[0000394a] 2747 0018                 move.l     d7,24(a3)
_updi_3:
[0000394e] 082d 0001 000c            btst       #1,12(a5)
[00003954] 670e                      beq.s      _updi_4
[00003956] 2eae 000c                 move.l     12(a6),(a7)
[0000395a] 4eb9 0000 0000            jsr        _tflip
[00003960] 2747 0018                 move.l     d7,24(a3)
_updi_4:
[00003964] 3e2d 000c                 move.w     12(a5),d7
[00003968] 0247 0209                 andi.w     #$0209,d7
[0000396c] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003972] 6710                      beq.s      _updi_5
[00003974] 2eb9 0000 b59c            move.l     _time,(a7)
[0000397a] 4eb9 0000 0000            jsr        _tflip
[00003980] 2747 001c                 move.l     d7,28(a3)
_updi_5:
[00003984] 2e8c                      move.l     a4,(a7)
[00003986] 4eb9 0000 0a82            jsr        _writdb
[0000398c] 026d fdf6 000c            andi.w     #$FDF6,12(a5)
_updi_1:
[00003992] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003996] 4e5e                      unlk       a6
[00003998] 4e75                      rts

_ustat:
[0000399a] 4e56 ffd4                 link       a6,#-44
[0000399e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000039a2] 2a6e 0008                 movea.l    8(a6),a5
[000039a6] 4878 6000                 pea.l      ($00006000).w
[000039aa] 4878 0001                 pea.l      ($00000001).w
[000039ae] 2f15                      move.l     (a5),-(a7)
[000039b0] 4eb9 0000 0cc0            jsr        _opendev
[000039b6] 4fef 000c                 lea.l      12(a7),a7
[000039ba] 4a87                      tst.l      d7
[000039bc] 6700 00fe                 beq        _ustat_1
[000039c0] 2e95                      move.l     (a5),(a7)
[000039c2] 4eba f37a                 jsr        _getsb(pc)
[000039c6] 2d47 fffc                 move.l     d7,-4(a6)
[000039ca] 6610                      bne.s      _ustat_2
[000039cc] 4878 0016                 pea.l      ($00000016).w
[000039d0] 4eb9 0000 2868            jsr        _uerror
[000039d6] 588f                      addq.l     #4,a7
[000039d8] 6000 00d0                 bra        _ustat_3
_ustat_2:
[000039dc] 2eae fffc                 move.l     -4(a6),(a7)
[000039e0] 4eb9 0000 0c18            jsr        _getaddr
[000039e6] 2d47 fff8                 move.l     d7,-8(a6)
[000039ea] 4878 0012                 pea.l      ($00000012).w
[000039ee] 486e ffd8                 pea.l      -40(a6)
[000039f2] 2e2e fff8                 move.l     -8(a6),d7
[000039f6] 2f07                      move.l     d7,-(a7)
[000039f8] 0697 0000 01a8            addi.l     #$000001A8,(a7)
[000039fe] 4eb9 0000 2754            jsr        _movbuf
[00003a04] 4fef 000c                 lea.l      12(a7),a7
[00003a08] 226e fff8                 movea.l    -8(a6),a1
[00003a0c] 3d51 ffd4                 move.w     (a1),-44(a6)
[00003a10] 226e fff8                 movea.l    -8(a6),a1
[00003a14] 3d69 0002 ffd6            move.w     2(a1),-42(a6)
[00003a1a] 2e95                      move.l     (a5),(a7)
[00003a1c] 4eb9 0000 248c            jsr        _getmount
[00003a22] 2847                      movea.l    d7,a4
[00003a24] 2e0c                      move.l     a4,d7
[00003a26] 6606                      bne.s      _ustat_4
[00003a28] 426e ffee                 clr.w      -18(a6)
[00003a2c] 6042                      bra.s      _ustat_5
_ustat_4:
[00003a2e] 3e2c 0008                 move.w     8(a4),d7
[00003a32] be79 0000 0000            cmp.w      _rootdev,d7
[00003a38] 6610                      bne.s      _ustat_6
[00003a3a] 3d79 0000 0000 ffee       move.w     _rootdev,-18(a6)
[00003a42] 3d7c 0001 fff0            move.w     #$0001,-16(a6)
[00003a48] 6014                      bra.s      _ustat_7
_ustat_6:
[00003a4a] 226c 0004                 movea.l    4(a4),a1
[00003a4e] 3d69 0016 ffee            move.w     22(a1),-18(a6)
[00003a54] 226c 0004                 movea.l    4(a4),a1
[00003a58] 3d69 0018 fff0            move.w     24(a1),-16(a6)
_ustat_7:
[00003a5e] 3d6c 000a fff2            move.w     10(a4),-14(a6)
[00003a64] 3d6c 000c fff4            move.w     12(a4),-12(a6)
[00003a6a] 1d6c 000e fff6            move.b     14(a4),-10(a6)
_ustat_5:
[00003a70] 3d6d 0002 ffea            move.w     2(a5),-22(a6)
[00003a76] 3d7c 0001 ffec            move.w     #$0001,-20(a6)
[00003a7c] 4878 0024                 pea.l      ($00000024).w
[00003a80] 2f2d 0004                 move.l     4(a5),-(a7)
[00003a84] 486e ffd4                 pea.l      -44(a6)
[00003a88] 4eb9 0000 0000            jsr        _outbuf
[00003a8e] 4fef 000c                 lea.l      12(a7),a7
[00003a92] 4a87                      tst.l      d7
[00003a94] 670c                      beq.s      _ustat_8
[00003a96] 4878 000e                 pea.l      ($0000000E).w
[00003a9a] 4eb9 0000 2868            jsr        _uerror
[00003aa0] 588f                      addq.l     #4,a7
_ustat_8:
[00003aa2] 2eae fffc                 move.l     -4(a6),(a7)
[00003aa6] 4eba fbde                 jsr        _putsb(pc)
_ustat_3:
[00003aaa] 4878 6000                 pea.l      ($00006000).w
[00003aae] 42a7                      clr.l      -(a7)
[00003ab0] 2f15                      move.l     (a5),-(a7)
[00003ab2] 4eb9 0000 0ab2            jsr        _closed
[00003ab8] 4fef 000c                 lea.l      12(a7),a7
_ustat_1:
[00003abc] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00003ac0] 4e5e                      unlk       a6
[00003ac2] 4e75                      rts

_utime:
[00003ac4] 4e56 fffc                 link       a6,#-4
[00003ac8] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003acc] 2a6e 0008                 movea.l    8(a6),a5
[00003ad0] 2679 0000 0000            movea.l    _pu,a3
[00003ad6] 4297                      clr.l      (a7)
[00003ad8] 2f15                      move.l     (a5),-(a7)
[00003ada] 4eb9 0000 3ebe            jsr        _findi
[00003ae0] 588f                      addq.l     #4,a7
[00003ae2] 2847                      movea.l    d7,a4
[00003ae4] 2e0c                      move.l     a4,d7
[00003ae6] 6774                      beq.s      _utime_1
[00003ae8] 4aad 0004                 tst.l      4(a5)
[00003aec] 6730                      beq.s      _utime_2
[00003aee] 4a2b 0130                 tst.b      304(a3)
[00003af2] 6712                      beq.s      _utime_3
[00003af4] 1e2b 0130                 move.b     304(a3),d7
[00003af8] be2c 001d                 cmp.b      29(a4),d7
[00003afc] 6708                      beq.s      _utime_3
[00003afe] 177c 0001 0142            move.b     #$01,322(a3)
[00003b04] 6032                      bra.s      _utime_4
_utime_3:
[00003b06] 4878 0004                 pea.l      ($00000004).w
[00003b0a] 486e fffc                 pea.l      -4(a6)
[00003b0e] 2f2d 0004                 move.l     4(a5),-(a7)
[00003b12] 4eb9 0000 0000            jsr        _inbuf
[00003b18] 4fef 000c                 lea.l      12(a7),a7
[00003b1c] 601a                      bra.s      _utime_4
_utime_2:
[00003b1e] 4878 0080                 pea.l      ($00000080).w
[00003b22] 2f0c                      move.l     a4,-(a7)
[00003b24] 4eb9 0000 2532            jsr        _isacc
[00003b2a] 508f                      addq.l     #8,a7
[00003b2c] 4a87                      tst.l      d7
[00003b2e] 6708                      beq.s      _utime_4
[00003b30] 2d79 0000 b59c fffc       move.l     _time,-4(a6)
_utime_4:
[00003b38] 4a2b 0142                 tst.b      322(a3)
[00003b3c] 6612                      bne.s      _utime_5
[00003b3e] 08ec 0001 000c            bset       #1,12(a4)
[00003b44] 2eae fffc                 move.l     -4(a6),(a7)
[00003b48] 2f0c                      move.l     a4,-(a7)
[00003b4a] 4eba fd42                 jsr        _updi(pc)
[00003b4e] 588f                      addq.l     #4,a7
_utime_5:
[00003b50] 4878 0001                 pea.l      ($00000001).w
[00003b54] 2f0c                      move.l     a4,-(a7)
[00003b56] 4eba f9e8                 jsr        _puti(pc)
[00003b5a] 508f                      addq.l     #8,a7
_utime_1:
[00003b5c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003b60] 4e5e                      unlk       a6
[00003b62] 4e75                      rts

_zeroi:
[00003b64] 4e56 0000                 link       a6,#0
[00003b68] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00003b6c] 2a6e 0008                 movea.l    8(a6),a5
[00003b70] 422d 001f                 clr.b      31(a5)
[00003b74] 426d 0020                 clr.w      32(a5)
[00003b78] 7a08                      moveq.l    #8,d5
_zeroi_2:
[00003b7a] 5385                      subq.l     #1,d5
[00003b7c] 6d10                      blt.s      _zeroi_1
[00003b7e] 2e05                      move.l     d5,d7
[00003b80] e387                      asl.l      #1,d7
[00003b82] 2247                      movea.l    d7,a1
[00003b84] 45ed 0022                 lea.l      34(a5),a2
[00003b88] 4271 a800                 clr.w      0(a1,a2.l)
[00003b8c] 60ec                      bra.s      _zeroi_2
_zeroi_1:
[00003b8e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00003b92] 4e5e                      unlk       a6
[00003b94] 4e75                      rts

_cdir:
[00003b96] 4e56 0000                 link       a6,#0
[00003b9a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00003b9e] 2a6e 000c                 movea.l    12(a6),a5
[00003ba2] 2679 0000 0000            movea.l    _pu,a3
[00003ba8] 4297                      clr.l      (a7)
[00003baa] 226e 0008                 movea.l    8(a6),a1
[00003bae] 2f11                      move.l     (a1),-(a7)
[00003bb0] 4eb9 0000 3ebe            jsr        _findi
[00003bb6] 588f                      addq.l     #4,a7
[00003bb8] 2847                      movea.l    d7,a4
[00003bba] 2e0c                      move.l     a4,d7
[00003bbc] 6730                      beq.s      _cdir_1
[00003bbe] 2e8c                      move.l     a4,(a7)
[00003bc0] 4eb9 0000 25da            jsr        _isdir
[00003bc6] 4a87                      tst.l      d7
[00003bc8] 6712                      beq.s      _cdir_2
[00003bca] 4878 0040                 pea.l      ($00000040).w
[00003bce] 2f0c                      move.l     a4,-(a7)
[00003bd0] 4eb9 0000 2532            jsr        _isacc
[00003bd6] 508f                      addq.l     #8,a7
[00003bd8] 4a87                      tst.l      d7
[00003bda] 661a                      bne.s      _cdir_3
_cdir_2:
[00003bdc] 177c 0014 0142            move.b     #$14,322(a3)
[00003be2] 4297                      clr.l      (a7)
[00003be4] 2f0c                      move.l     a4,-(a7)
[00003be6] 4eb9 0000 3540            jsr        _puti
[00003bec] 588f                      addq.l     #4,a7
_cdir_1:
[00003bee] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00003bf2] 4e5e                      unlk       a6
[00003bf4] 4e75                      rts
_cdir_3:
[00003bf6] 2e8c                      move.l     a4,(a7)
[00003bf8] 4eb9 0000 278c            jsr        _reli
[00003bfe] 4878 fffe                 pea.l      ($FFFFFFFE).w
[00003c02] 2f15                      move.l     (a5),-(a7)
[00003c04] 4eb9 0000 2646            jsr        _locki
[00003c0a] 508f                      addq.l     #8,a7
[00003c0c] 4297                      clr.l      (a7)
[00003c0e] 2f15                      move.l     (a5),-(a7)
[00003c10] 4eb9 0000 3540            jsr        _puti
[00003c16] 588f                      addq.l     #4,a7
[00003c18] 2a8c                      move.l     a4,(a5)
[00003c1a] 60d2                      bra.s      _cdir_1

_chkmode:
[00003c1c] 4e56 fffc                 link       a6,#-4
[00003c20] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00003c24] 2a2e 0008                 move.l     8(a6),d5
[00003c28] 2a79 0000 0000            movea.l    _pu,a5
[00003c2e] 4a2d 0130                 tst.b      304(a5)
[00003c32] 6616                      bne.s      _chkmode_1
[00003c34] 3e05                      move.w     d5,d7
[00003c36] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003c3c] 0287 0000 6249            andi.l     #$00006249,d7
[00003c42] 0c87 0000 0200            cmpi.l     #$00000200,d7
[00003c48] 6606                      bne.s      _chkmode_2
_chkmode_1:
[00003c4a] 08ae 0001 0012            bclr       #1,18(a6)
_chkmode_2:
[00003c50] 2e2e 0010                 move.l     16(a6),d7
[00003c54] 4687                      not.l      d7
[00003c56] ce85                      and.l      d5,d7
[00003c58] 2c2e 000c                 move.l     12(a6),d6
[00003c5c] ccae 0010                 and.l      16(a6),d6
[00003c60] 8e86                      or.l       d6,d7
[00003c62] 2807                      move.l     d7,d4
[00003c64] 3e04                      move.w     d4,d7
[00003c66] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003c6c] 0287 0000 6249            andi.l     #$00006249,d7
[00003c72] 0c87 0000 0200            cmpi.l     #$00000200,d7
[00003c78] 6604                      bne.s      _chkmode_3
[00003c7a] 7e01                      moveq.l    #1,d7
[00003c7c] 6002                      bra.s      _chkmode_4
_chkmode_3:
[00003c7e] 7e00                      moveq.l    #0,d7
_chkmode_4:
[00003c80] 2d47 fffc                 move.l     d7,-4(a6)
[00003c84] 3e05                      move.w     d5,d7
[00003c86] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00003c8c] 0287 0000 6249            andi.l     #$00006249,d7
[00003c92] 0c87 0000 0200            cmpi.l     #$00000200,d7
[00003c98] 6604                      bne.s      _chkmode_5
[00003c9a] 7e01                      moveq.l    #1,d7
[00003c9c] 6002                      bra.s      _chkmode_6
_chkmode_5:
[00003c9e] 7e00                      moveq.l    #0,d7
_chkmode_6:
[00003ca0] 202e fffc                 move.l     -4(a6),d0
[00003ca4] b187                      eor.l      d0,d7
[00003ca6] 670a                      beq.s      _chkmode_7
[00003ca8] 1b7c 001d 0142            move.b     #$1D,322(a5)
[00003cae] 2e05                      move.l     d5,d7
[00003cb0] 6002                      bra.s      _chkmode_8
_chkmode_7:
[00003cb2] 2e04                      move.l     d4,d7
_chkmode_8:
[00003cb4] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00003cb8] 4e5e                      unlk       a6
[00003cba] 4e75                      rts

_crop:
[00003cbc] 4e56 fff6                 link       a6,#-10
[00003cc0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003cc4] 2a2e 000c                 move.l     12(a6),d5
[00003cc8] 2879 0000 0000            movea.l    _pu,a4
[00003cce] 42ae fffc                 clr.l      -4(a6)
[00003cd2] 0805 0008                 btst       #8,d5
[00003cd6] 6704                      beq.s      _crop_1
[00003cd8] 7e01                      moveq.l    #1,d7
[00003cda] 6002                      bra.s      _crop_2
_crop_1:
[00003cdc] 7e00                      moveq.l    #0,d7
_crop_2:
[00003cde] 2e87                      move.l     d7,(a7)
[00003ce0] 2f2e 0008                 move.l     8(a6),-(a7)
[00003ce4] 4eb9 0000 3ebe            jsr        _findi
[00003cea] 588f                      addq.l     #4,a7
[00003cec] 2a47                      movea.l    d7,a5
[00003cee] 2e0d                      move.l     a5,d7
[00003cf0] 664c                      bne.s      _crop_3
[00003cf2] 7e00                      moveq.l    #0,d7
[00003cf4] 3e2c 013c                 move.w     316(a4),d7
[00003cf8] 4687                      not.l      d7
[00003cfa] 0287 0000 0fff            andi.l     #$00000FFF,d7
[00003d00] 2e87                      move.l     d7,(a7)
[00003d02] 2f2e 0010                 move.l     16(a6),-(a7)
[00003d06] 42a7                      clr.l      -(a7)
[00003d08] 4eba ff12                 jsr        _chkmode(pc)
[00003d0c] 508f                      addq.l     #8,a7
[00003d0e] 2d47 0010                 move.l     d7,16(a6)
[00003d12] 4a2c 0142                 tst.b      322(a4)
[00003d16] 661c                      bne.s      _crop_4
[00003d18] 2eae 0010                 move.l     16(a6),(a7)
[00003d1c] 4eb9 0000 4202            jsr        _makei
[00003d22] 2a47                      movea.l    d7,a5
[00003d24] 2e0d                      move.l     a5,d7
[00003d26] 670c                      beq.s      _crop_4
[00003d28] 0885 0009                 bclr       #9,d5
[00003d2c] 7001                      moveq.l    #1,d0
[00003d2e] 2d40 fffc                 move.l     d0,-4(a6)
[00003d32] 6078                      bra.s      _crop_5
_crop_4:
[00003d34] 7eff                      moveq.l    #-1,d7
[00003d36] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003d3a] 4e5e                      unlk       a6
[00003d3c] 4e75                      rts
_crop_3:
[00003d3e] 2e05                      move.l     d5,d7
[00003d40] 0287 0000 0500            andi.l     #$00000500,d7
[00003d46] 0c87 0000 0500            cmpi.l     #$00000500,d7
[00003d4c] 6608                      bne.s      _crop_6
[00003d4e] 197c 0011 0142            move.b     #$11,322(a4)
[00003d54] 6056                      bra.s      _crop_5
_crop_6:
[00003d56] 0805 0001                 btst       #1,d5
[00003d5a] 6714                      beq.s      _crop_7
[00003d5c] 2e8d                      move.l     a5,(a7)
[00003d5e] 4eb9 0000 25da            jsr        _isdir
[00003d64] 4a87                      tst.l      d7
[00003d66] 6708                      beq.s      _crop_7
[00003d68] 197c 0015 0142            move.b     #$15,322(a4)
[00003d6e] 603c                      bra.s      _crop_5
_crop_7:
[00003d70] 0805 0001                 btst       #1,d5
[00003d74] 6712                      beq.s      _crop_8
[00003d76] 4878 0080                 pea.l      ($00000080).w
[00003d7a] 2f0d                      move.l     a5,-(a7)
[00003d7c] 4eb9 0000 2532            jsr        _isacc
[00003d82] 508f                      addq.l     #8,a7
[00003d84] 4a87                      tst.l      d7
[00003d86] 671e                      beq.s      _crop_9
_crop_8:
[00003d88] 0805 0000                 btst       #0,d5
[00003d8c] 6712                      beq.s      _crop_10
[00003d8e] 4878 0100                 pea.l      ($00000100).w
[00003d92] 2f0d                      move.l     a5,-(a7)
[00003d94] 4eb9 0000 2532            jsr        _isacc
[00003d9a] 508f                      addq.l     #8,a7
[00003d9c] 4a87                      tst.l      d7
[00003d9e] 6706                      beq.s      _crop_9
_crop_10:
[00003da0] 7e03                      moveq.l    #3,d7
[00003da2] ce85                      and.l      d5,d7
[00003da4] 6606                      bne.s      _crop_5
_crop_9:
[00003da6] 197c 000d 0142            move.b     #$0D,322(a4)
_crop_5:
[00003dac] 4a2c 0142                 tst.b      322(a4)
[00003db0] 6600 00f6                 bne        _crop_11
[00003db4] 486e fffa                 pea.l      -6(a6)
[00003db8] 4eb9 0000 2418            jsr        _getfd
[00003dbe] 588f                      addq.l     #4,a7
[00003dc0] 2d47 fff6                 move.l     d7,-10(a6)
[00003dc4] 6700 00e2                 beq        _crop_11
[00003dc8] 0805 0009                 btst       #9,d5
[00003dcc] 6708                      beq.s      _crop_12
[00003dce] 2e8d                      move.l     a5,(a7)
[00003dd0] 4eb9 0000 3746            jsr        _trunci
_crop_12:
[00003dd6] 4aae fffc                 tst.l      -4(a6)
[00003dda] 671a                      beq.s      _crop_13
[00003ddc] 2e8d                      move.l     a5,(a7)
[00003dde] 4eb9 0000 388e            jsr        _updi
[00003de4] 4297                      clr.l      (a7)
[00003de6] 7e00                      moveq.l    #0,d7
[00003de8] 3e2d 0016                 move.w     22(a5),d7
[00003dec] 2f07                      move.l     d7,-(a7)
[00003dee] 4eb9 0000 0416            jsr        _buflush
[00003df4] 588f                      addq.l     #4,a7
_crop_13:
[00003df6] 2e8d                      move.l     a5,(a7)
[00003df8] 4eb9 0000 278c            jsr        _reli
[00003dfe] 226e fff6                 movea.l    -10(a6),a1
[00003e02] 7e1f                      moveq.l    #31,d7
[00003e04] ce85                      and.l      d5,d7
[00003e06] 1347 0008                 move.b     d7,8(a1)
[00003e0a] 226e fff6                 movea.l    -10(a6),a1
[00003e0e] 228d                      move.l     a5,(a1)
[00003e10] 0805 0000                 btst       #0,d5
[00003e14] 6704                      beq.s      _crop_14
[00003e16] 526d 0012                 addq.w     #1,18(a5)
_crop_14:
[00003e1a] 7e00                      moveq.l    #0,d7
[00003e1c] 3e2d 001a                 move.w     26(a5),d7
[00003e20] 0287 0000 6000            andi.l     #$00006000,d7
[00003e26] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00003e2c] 660a                      bne.s      _crop_15
[00003e2e] 226e fff6                 movea.l    -10(a6),a1
[00003e32] 08e9 0006 0008            bset       #6,8(a1)
_crop_15:
[00003e38] 2e8d                      move.l     a5,(a7)
[00003e3a] 2f2e fff6                 move.l     -10(a6),-(a7)
[00003e3e] 4eb9 0000 5552            jsr        _openfifo
[00003e44] 588f                      addq.l     #4,a7
[00003e46] 4a87                      tst.l      d7
[00003e48] 6628                      bne.s      _crop_16
[00003e4a] 7e00                      moveq.l    #0,d7
[00003e4c] 3e2d 001a                 move.w     26(a5),d7
[00003e50] 2e87                      move.l     d7,(a7)
[00003e52] 226e fff6                 movea.l    -10(a6),a1
[00003e56] 7e00                      moveq.l    #0,d7
[00003e58] 1e29 0008                 move.b     8(a1),d7
[00003e5c] 2f07                      move.l     d7,-(a7)
[00003e5e] 7e00                      moveq.l    #0,d7
[00003e60] 3e2d 0022                 move.w     34(a5),d7
[00003e64] 2f07                      move.l     d7,-(a7)
[00003e66] 4eb9 0000 0cc0            jsr        _opendev
[00003e6c] 508f                      addq.l     #8,a7
[00003e6e] 4a87                      tst.l      d7
[00003e70] 6708                      beq.s      _crop_17
_crop_16:
[00003e72] 3e2e fffa                 move.w     -6(a6),d7
[00003e76] 48c7                      ext.l      d7
[00003e78] 603c                      bra.s      _crop_18
_crop_17:
[00003e7a] 0805 0000                 btst       #0,d5
[00003e7e] 6704                      beq.s      _crop_19
[00003e80] 536d 0012                 subq.w     #1,18(a5)
_crop_19:
[00003e84] 3e2e fffa                 move.w     -6(a6),d7
[00003e88] 48c7                      ext.l      d7
[00003e8a] e587                      asl.l      #2,d7
[00003e8c] 2247                      movea.l    d7,a1
[00003e8e] 45ec 0044                 lea.l      68(a4),a2
[00003e92] 42b1 a800                 clr.l      0(a1,a2.l)
[00003e96] 4297                      clr.l      (a7)
[00003e98] 2f2e fff6                 move.l     -10(a6),-(a7)
[00003e9c] 4878 000a                 pea.l      ($0000000A).w
[00003ea0] 4eb9 0000 0114            jsr        _free
[00003ea6] 508f                      addq.l     #8,a7
_crop_11:
[00003ea8] 4297                      clr.l      (a7)
[00003eaa] 2f0d                      move.l     a5,-(a7)
[00003eac] 4eb9 0000 3540            jsr        _puti
[00003eb2] 588f                      addq.l     #4,a7
[00003eb4] 7eff                      moveq.l    #-1,d7
_crop_18:
[00003eb6] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003eba] 4e5e                      unlk       a6
[00003ebc] 4e75                      rts

_findi:
[00003ebe] 4e56 fff8                 link       a6,#-8
[00003ec2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00003ec6] 2879 0000 0000            movea.l    _pu,a4
[00003ecc] 296e 0008 0028            move.l     8(a6),40(a4)
[00003ed2] 70ff                      moveq.l    #-1,d0
[00003ed4] 2940 002c                 move.l     d0,44(a4)
[00003ed8] 7e04                      moveq.l    #4,d7
[00003eda] ceae 000c                 and.l      12(a6),d7
[00003ede] 1947 0143                 move.b     d7,323(a4)
[00003ee2] 08ae 0002 000f            bclr       #2,15(a6)
[00003ee8] 4eb9 0000 23c0            jsr        _fetch
[00003eee] 2a07                      move.l     d7,d5
[00003ef0] 0c85 0000 002f            cmpi.l     #$0000002F,d5
[00003ef6] 6606                      bne.s      _findi_1
[00003ef8] 2e2c 0038                 move.l     56(a4),d7
[00003efc] 6004                      bra.s      _findi_2
_findi_1:
[00003efe] 2e2c 0034                 move.l     52(a4),d7
_findi_2:
[00003f02] 2a47                      movea.l    d7,a5
[00003f04] 7e00                      moveq.l    #0,d7
[00003f06] 3e2d 0018                 move.w     24(a5),d7
[00003f0a] 2e87                      move.l     d7,(a7)
[00003f0c] 7e00                      moveq.l    #0,d7
[00003f0e] 3e2d 0016                 move.w     22(a5),d7
[00003f12] 2f07                      move.l     d7,-(a7)
[00003f14] 4eb9 0000 2dd8            jsr        _geti
[00003f1a] 588f                      addq.l     #4,a7
_findi_4:
[00003f1c] 0c85 0000 002f            cmpi.l     #$0000002F,d5
[00003f22] 660a                      bne.s      _findi_3
[00003f24] 4eb9 0000 23c0            jsr        _fetch
[00003f2a] 2a07                      move.l     d7,d5
[00003f2c] 60ee                      bra.s      _findi_4
_findi_3:
[00003f2e] 4a85                      tst.l      d5
[00003f30] 6616                      bne.s      _findi_5
[00003f32] 4aae 000c                 tst.l      12(a6)
[00003f36] 660a                      bne.s      _findi_6
[00003f38] 2e0d                      move.l     a5,d7
[00003f3a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00003f3e] 4e5e                      unlk       a6
[00003f40] 4e75                      rts
_findi_6:
[00003f42] 197c 0002 0142            move.b     #$02,322(a4)
_findi_5:
[00003f48] 4a2c 0142                 tst.b      322(a4)
[00003f4c] 6600 01ce                 bne        _findi_7
[00003f50] 396d 0016 013e            move.w     22(a5),318(a4)
[00003f56] 396d 0018 0140            move.w     24(a5),320(a4)
[00003f5c] 2e8d                      move.l     a5,(a7)
[00003f5e] 4eb9 0000 25da            jsr        _isdir
[00003f64] 4a87                      tst.l      d7
[00003f66] 6718                      beq.s      _findi_8
[00003f68] 4a2c 0130                 tst.b      304(a4)
[00003f6c] 671c                      beq.s      _findi_9
[00003f6e] 4878 0040                 pea.l      ($00000040).w
[00003f72] 2f0d                      move.l     a5,-(a7)
[00003f74] 4eb9 0000 2532            jsr        _isacc
[00003f7a] 508f                      addq.l     #8,a7
[00003f7c] 4a87                      tst.l      d7
[00003f7e] 660a                      bne.s      _findi_9
_findi_8:
[00003f80] 197c 0014 0142            move.b     #$14,322(a4)
[00003f86] 6000 0194                 bra        _findi_7
_findi_9:
[00003f8a] 426e fffe                 clr.w      -2(a6)
_findi_12:
[00003f8e] 4a85                      tst.l      d5
[00003f90] 6734                      beq.s      _findi_10
[00003f92] 0c85 0000 002f            cmpi.l     #$0000002F,d5
[00003f98] 672c                      beq.s      _findi_10
[00003f9a] 4a2c 0142                 tst.b      322(a4)
[00003f9e] 6626                      bne.s      _findi_10
[00003fa0] 0c6e 000e fffe            cmpi.w     #$000E,-2(a6)
[00003fa6] 6c14                      bge.s      _findi_11
[00003fa8] 3e2e fffe                 move.w     -2(a6),d7
[00003fac] 526e fffe                 addq.w     #1,-2(a6)
[00003fb0] 48c7                      ext.l      d7
[00003fb2] 2247                      movea.l    d7,a1
[00003fb4] 45ec 0156                 lea.l      342(a4),a2
[00003fb8] 1385 a800                 move.b     d5,0(a1,a2.l)
_findi_11:
[00003fbc] 4eb9 0000 23c0            jsr        _fetch
[00003fc2] 2a07                      move.l     d7,d5
[00003fc4] 60c8                      bra.s      _findi_12
_findi_10:
[00003fc6] 0c6e 000e fffe            cmpi.w     #$000E,-2(a6)
[00003fcc] 6c16                      bge.s      _findi_13
[00003fce] 3e2e fffe                 move.w     -2(a6),d7
[00003fd2] 526e fffe                 addq.w     #1,-2(a6)
[00003fd6] 48c7                      ext.l      d7
[00003fd8] 2247                      movea.l    d7,a1
[00003fda] 45ec 0156                 lea.l      342(a4),a2
[00003fde] 4231 a800                 clr.b      0(a1,a2.l)
[00003fe2] 60e2                      bra.s      _findi_10
_findi_13:
[00003fe4] 0c85 0000 002f            cmpi.l     #$0000002F,d5
[00003fea] 660a                      bne.s      _findi_14
[00003fec] 4eb9 0000 23c0            jsr        _fetch
[00003ff2] 2a07                      move.l     d7,d5
[00003ff4] 60ee                      bra.s      _findi_13
_findi_14:
[00003ff6] 4eb9 0000 41ce            jsr        _isdotdot
[00003ffc] 4a87                      tst.l      d7
[00003ffe] 6770                      beq.s      _findi_15
[00004000] bbec 0038                 cmpa.l     56(a4),a5
[00004004] 6606                      bne.s      _findi_16
[00004006] 422c 0157                 clr.b      343(a4)
[0000400a] 6064                      bra.s      _findi_15
_findi_16:
[0000400c] 4a85                      tst.l      d5
[0000400e] 660a                      bne.s      _findi_17
[00004010] 0cae 0000 0002 000c       cmpi.l     #$00000002,12(a6)
[00004018] 6756                      beq.s      _findi_15
_findi_17:
[0000401a] 3e2d 0018                 move.w     24(a5),d7
[0000401e] 0c47 0001                 cmpi.w     #$0001,d7
[00004022] 664c                      bne.s      _findi_15
[00004024] 422c 0157                 clr.b      343(a4)
[00004028] 7e00                      moveq.l    #0,d7
[0000402a] 3e2d 0016                 move.w     22(a5),d7
[0000402e] 2e87                      move.l     d7,(a7)
[00004030] 4eb9 0000 248c            jsr        _getmount
[00004036] 2d47 fff8                 move.l     d7,-8(a6)
[0000403a] 4297                      clr.l      (a7)
[0000403c] 2f0d                      move.l     a5,-(a7)
[0000403e] 4eb9 0000 3540            jsr        _puti
[00004044] 588f                      addq.l     #4,a7
[00004046] 226e fff8                 movea.l    -8(a6),a1
[0000404a] 7e00                      moveq.l    #0,d7
[0000404c] 3e29 000c                 move.w     12(a1),d7
[00004050] 2e87                      move.l     d7,(a7)
[00004052] 226e fff8                 movea.l    -8(a6),a1
[00004056] 7e00                      moveq.l    #0,d7
[00004058] 3e29 000a                 move.w     10(a1),d7
[0000405c] 2f07                      move.l     d7,-(a7)
[0000405e] 4eb9 0000 2dd8            jsr        _geti
[00004064] 588f                      addq.l     #4,a7
[00004066] 2a47                      movea.l    d7,a5
[00004068] 2e0d                      move.l     a5,d7
[0000406a] 6604                      bne.s      _findi_15
[0000406c] 7e00                      moveq.l    #0,d7
[0000406e] 604c                      bra.s      _findi_18
_findi_15:
[00004070] 2e8d                      move.l     a5,(a7)
[00004072] 4eb9 0000 4298            jsr        _scndir
[00004078] 4a87                      tst.l      d7
[0000407a] 6772                      beq.s      _findi_19
[0000407c] 4a85                      tst.l      d5
[0000407e] 660a                      bne.s      _findi_20
[00004080] 0cae 0000 0002 000c       cmpi.l     #$00000002,12(a6)
[00004088] 6744                      beq.s      _findi_21
_findi_20:
[0000408a] 3d6d 0016 fffc            move.w     22(a5),-4(a6)
[00004090] 4297                      clr.l      (a7)
[00004092] 2f0d                      move.l     a5,-(a7)
[00004094] 4eb9 0000 3540            jsr        _puti
[0000409a] 588f                      addq.l     #4,a7
[0000409c] 7e00                      moveq.l    #0,d7
[0000409e] 3e2c 0154                 move.w     340(a4),d7
[000040a2] 2e87                      move.l     d7,(a7)
[000040a4] 7e00                      moveq.l    #0,d7
[000040a6] 3e2e fffc                 move.w     -4(a6),d7
[000040aa] 2f07                      move.l     d7,-(a7)
[000040ac] 4eb9 0000 2dd8            jsr        _geti
[000040b2] 588f                      addq.l     #4,a7
[000040b4] 2a47                      movea.l    d7,a5
[000040b6] 2e0d                      move.l     a5,d7
[000040b8] 660a                      bne.s      _findi_22
[000040ba] 7e00                      moveq.l    #0,d7
_findi_18:
[000040bc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000040c0] 4e5e                      unlk       a6
[000040c2] 4e75                      rts
_findi_22:
[000040c4] 4a85                      tst.l      d5
[000040c6] 6600 fe80                 bne        _findi_5
[000040ca] 2e0d                      move.l     a5,d7
[000040cc] 60ee                      bra.s      _findi_18
_findi_21:
[000040ce] 0cae 0000 0002 000c       cmpi.l     #$00000002,12(a6)
[000040d6] 6612                      bne.s      _findi_23
[000040d8] 4878 0080                 pea.l      ($00000080).w
[000040dc] 2f0d                      move.l     a5,-(a7)
[000040de] 4eb9 0000 2532            jsr        _isacc
[000040e4] 508f                      addq.l     #8,a7
[000040e6] 4a87                      tst.l      d7
[000040e8] 6732                      beq.s      _findi_7
_findi_23:
[000040ea] 2e0d                      move.l     a5,d7
[000040ec] 60ce                      bra.s      _findi_18
_findi_19:
[000040ee] 4a85                      tst.l      d5
[000040f0] 660a                      bne.s      _findi_24
[000040f2] 0cae 0000 0001 000c       cmpi.l     #$00000001,12(a6)
[000040fa] 670a                      beq.s      _findi_25
_findi_24:
[000040fc] 197c 0002 0142            move.b     #$02,322(a4)
[00004102] 6000 fe44                 bra        _findi_5
_findi_25:
[00004106] 4878 0080                 pea.l      ($00000080).w
[0000410a] 2f0d                      move.l     a5,-(a7)
[0000410c] 4eb9 0000 2532            jsr        _isacc
[00004112] 508f                      addq.l     #8,a7
[00004114] 4a87                      tst.l      d7
[00004116] 6704                      beq.s      _findi_7
[00004118] 7e00                      moveq.l    #0,d7
[0000411a] 600e                      bra.s      _findi_26
_findi_7:
[0000411c] 4297                      clr.l      (a7)
[0000411e] 2f0d                      move.l     a5,-(a7)
[00004120] 4eb9 0000 3540            jsr        _puti
[00004126] 588f                      addq.l     #4,a7
[00004128] 7e00                      moveq.l    #0,d7
_findi_26:
[0000412a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000412e] 4e5e                      unlk       a6
[00004130] 4e75                      rts

_initdir:
[00004132] 4e56 0000                 link       a6,#0
[00004136] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000413a] 2a6e 0008                 movea.l    8(a6),a5
[0000413e] 286e 000c                 movea.l    12(a6),a4
[00004142] 2679 0000 0000            movea.l    _pu,a3
[00004148] 274c 003c                 move.l     a4,60(a3)
[0000414c] 42ab 0030                 clr.l      48(a3)
[00004150] 4878 0010                 pea.l      ($00000010).w
[00004154] 486b 0154                 pea.l      340(a3)
[00004158] 2f3c 0000 b230            move.l     #$00015F9E,-(a7)
[0000415e] 4eb9 0000 2754            jsr        _movbuf
[00004164] 4fef 000c                 lea.l      12(a7),a7
[00004168] 4878 0001                 pea.l      ($00000001).w
[0000416c] 2f0c                      move.l     a4,-(a7)
[0000416e] 4eb9 0000 4448            jsr        _wlink
[00004174] 508f                      addq.l     #8,a7
[00004176] 177c 002e 0157            move.b     #$2E,343(a3)
[0000417c] 4878 0001                 pea.l      ($00000001).w
[00004180] 3e2d 0016                 move.w     22(a5),d7
[00004184] be6c 0016                 cmp.w      22(a4),d7
[00004188] 6604                      bne.s      _initdir_1
[0000418a] 2e0d                      move.l     a5,d7
[0000418c] 6002                      bra.s      _initdir_2
_initdir_1:
[0000418e] 2e0c                      move.l     a4,d7
_initdir_2:
[00004190] 2f07                      move.l     d7,-(a7)
[00004192] 4eb9 0000 4448            jsr        _wlink
[00004198] 508f                      addq.l     #8,a7
[0000419a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000419e] 4e5e                      unlk       a6
[000041a0] 4e75                      rts

_isdot:
[000041a2] 48e7 8004                 movem.l    d0/a5,-(a7)
[000041a6] 2e39 0000 0000            move.l     _pu,d7
[000041ac] 0687 0000 0154            addi.l     #$00000154,d7
[000041b2] 5487                      addq.l     #2,d7
[000041b4] 2a47                      movea.l    d7,a5
[000041b6] 0c15 002e                 cmpi.b     #$2E,(a5)
[000041ba] 660a                      bne.s      _isdot_1
[000041bc] 528d                      addq.l     #1,a5
[000041be] 4a15                      tst.b      (a5)
[000041c0] 6604                      bne.s      _isdot_1
[000041c2] 7e01                      moveq.l    #1,d7
[000041c4] 6002                      bra.s      _isdot_2
_isdot_1:
[000041c6] 7e00                      moveq.l    #0,d7
_isdot_2:
[000041c8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000041cc] 4e75                      rts

_isdotdot:
[000041ce] 48e7 8004                 movem.l    d0/a5,-(a7)
[000041d2] 2e39 0000 0000            move.l     _pu,d7
[000041d8] 0687 0000 0154            addi.l     #$00000154,d7
[000041de] 5487                      addq.l     #2,d7
[000041e0] 2a47                      movea.l    d7,a5
[000041e2] 0c15 002e                 cmpi.b     #$2E,(a5)
[000041e6] 6612                      bne.s      _isdotdot_1
[000041e8] 528d                      addq.l     #1,a5
[000041ea] 0c15 002e                 cmpi.b     #$2E,(a5)
[000041ee] 660a                      bne.s      _isdotdot_1
[000041f0] 528d                      addq.l     #1,a5
[000041f2] 4a15                      tst.b      (a5)
[000041f4] 6604                      bne.s      _isdotdot_1
[000041f6] 7e01                      moveq.l    #1,d7
[000041f8] 6002                      bra.s      _isdotdot_2
_isdotdot_1:
[000041fa] 7e00                      moveq.l    #0,d7
_isdotdot_2:
[000041fc] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004200] 4e75                      rts

_makei:
[00004202] 4e56 0000                 link       a6,#0
[00004206] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000420a] 2879 0000 0000            movea.l    _pu,a4
[00004210] 266c 003c                 movea.l    60(a4),a3
[00004214] 7e00                      moveq.l    #0,d7
[00004216] 3e2b 0016                 move.w     22(a3),d7
[0000421a] 2e87                      move.l     d7,(a7)
[0000421c] 4eb9 0000 3238            jsr        _newi
[00004222] 2a47                      movea.l    d7,a5
[00004224] 2e0d                      move.l     a5,d7
[00004226] 6752                      beq.s      _makei_1
[00004228] 08ed 0003 000d            bset       #3,13(a5)
[0000422e] 2e2e 0008                 move.l     8(a6),d7
[00004232] 08c7 000f                 bset       #15,d7
[00004236] 3b47 001a                 move.w     d7,26(a5)
[0000423a] 422d 001c                 clr.b      28(a5)
[0000423e] 1b6c 0130 001d            move.b     304(a4),29(a5)
[00004244] 1b6c 0131 001e            move.b     305(a4),30(a5)
[0000424a] 4878 0001                 pea.l      ($00000001).w
[0000424e] 2f0d                      move.l     a5,-(a7)
[00004250] 4eb9 0000 4448            jsr        _wlink
[00004256] 508f                      addq.l     #8,a7
[00004258] 3e2e 000a                 move.w     10(a6),d7
[0000425c] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00004262] 0287 0000 6000            andi.l     #$00006000,d7
[00004268] 0c87 0000 4000            cmpi.l     #$00004000,d7
[0000426e] 660a                      bne.s      _makei_1
[00004270] 2e8d                      move.l     a5,(a7)
[00004272] 2f0b                      move.l     a3,-(a7)
[00004274] 4eba febc                 jsr        _initdir(pc)
[00004278] 588f                      addq.l     #4,a7
_makei_1:
[0000427a] 2e8b                      move.l     a3,(a7)
[0000427c] 4eb9 0000 388e            jsr        _updi
[00004282] 4297                      clr.l      (a7)
[00004284] 2f0b                      move.l     a3,-(a7)
[00004286] 4eb9 0000 3540            jsr        _puti
[0000428c] 588f                      addq.l     #4,a7
[0000428e] 2e0d                      move.l     a5,d7
[00004290] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00004294] 4e5e                      unlk       a6
[00004296] 4e75                      rts

_scndir:
[00004298] 4e56 ffe4                 link       a6,#-28
[0000429c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000042a0] 2a6e 0008                 movea.l    8(a6),a5
[000042a4] 2879 0000 0000            movea.l    _pu,a4
[000042aa] 4a2d 001f                 tst.b      31(a5)
[000042ae] 6708                      beq.s      _scndir_1
[000042b0] 2e3c 0000 fe00            move.l     #$0000FE00,d7
[000042b6] 6006                      bra.s      _scndir_2
_scndir_1:
[000042b8] 7e00                      moveq.l    #0,d7
[000042ba] 3e2d 0020                 move.w     32(a5),d7
_scndir_2:
[000042be] 2d47 ffec                 move.l     d7,-20(a6)
[000042c2] 294d 003c                 move.l     a5,60(a4)
[000042c6] 42ae fff0                 clr.l      -16(a6)
[000042ca] 4eba fed6                 jsr        _isdot(pc)
[000042ce] 4a87                      tst.l      d7
[000042d0] 6714                      beq.s      _scndir_3
[000042d2] 42ac 0030                 clr.l      48(a4)
[000042d6] 396d 0018 0154            move.w     24(a5),340(a4)
[000042dc] 7e01                      moveq.l    #1,d7
[000042de] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000042e2] 4e5e                      unlk       a6
[000042e4] 4e75                      rts
_scndir_3:
[000042e6] 7a00                      moveq.l    #0,d5
_scndir_11:
[000042e8] baae ffec                 cmp.l      -20(a6),d5
[000042ec] 6400 0116                 bcc        _scndir_4
[000042f0] 4a2c 0142                 tst.b      322(a4)
[000042f4] 6600 010e                 bne        _scndir_4
[000042f8] 486e fffc                 pea.l      -4(a6)
[000042fc] 486e fffe                 pea.l      -2(a6)
[00004300] 2e05                      move.l     d5,d7
[00004302] 7c09                      moveq.l    #9,d6
[00004304] ecaf                      lsr.l      d6,d7
[00004306] 2f07                      move.l     d7,-(a7)
[00004308] 2f0d                      move.l     a5,-(a7)
[0000430a] 4eb9 0000 50a8            jsr        _maprbl
[00004310] 508f                      addq.l     #8,a7
[00004312] 2f07                      move.l     d7,-(a7)
[00004314] 7e00                      moveq.l    #0,d7
[00004316] 3e2d 0016                 move.w     22(a5),d7
[0000431a] 2f07                      move.l     d7,-(a7)
[0000431c] 4eb9 0000 095c            jsr        _readb
[00004322] 4fef 0010                 lea.l      16(a7),a7
[00004326] 2d47 fff8                 move.l     d7,-8(a6)
[0000432a] 2eae ffec                 move.l     -20(a6),(a7)
[0000432e] 2e05                      move.l     d5,d7
[00004330] 2f07                      move.l     d7,-(a7)
[00004332] 0697 0000 0200            addi.l     #$00000200,(a7)
[00004338] 4eb9 0000 26f4            jsr        _minu
[0000433e] 588f                      addq.l     #4,a7
[00004340] 2d47 fff4                 move.l     d7,-12(a6)
[00004344] 2eae fff8                 move.l     -8(a6),(a7)
[00004348] 4eb9 0000 0c18            jsr        _getaddr
[0000434e] 2d47 ffe6                 move.l     d7,-26(a6)
_scndir_8:
[00004352] baae fff4                 cmp.l      -12(a6),d5
[00004356] 6400 0084                 bcc        _scndir_5
[0000435a] 226e ffe6                 movea.l    -26(a6),a1
[0000435e] 4a51                      tst.w      (a1)
[00004360] 661a                      bne.s      _scndir_6
[00004362] 4aae fff0                 tst.l      -16(a6)
[00004366] 6604                      bne.s      _scndir_7
[00004368] 2d45 fff0                 move.l     d5,-16(a6)
_scndir_7:
[0000436c] 0685 0000 0010            addi.l     #$00000010,d5
[00004372] 06ae 0000 0010 ffe6       addi.l     #$00000010,-26(a6)
[0000437a] 60d6                      bra.s      _scndir_8
_scndir_6:
[0000437c] 426e ffea                 clr.w      -22(a6)
_scndir_10:
[00004380] 0c6e 000e ffea            cmpi.w     #$000E,-22(a6)
[00004386] 6c4e                      bge.s      _scndir_9
[00004388] 43ec 0156                 lea.l      342(a4),a1
[0000438c] 3e2e ffea                 move.w     -22(a6),d7
[00004390] 48c7                      ext.l      d7
[00004392] 1e31 7800                 move.b     0(a1,d7.l),d7
[00004396] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000439c] 226e ffe6                 movea.l    -26(a6),a1
[000043a0] 43e9 0002                 lea.l      2(a1),a1
[000043a4] 3c2e ffea                 move.w     -22(a6),d6
[000043a8] 48c6                      ext.l      d6
[000043aa] 1c31 6800                 move.b     0(a1,d6.l),d6
[000043ae] 0286 0000 00ff            andi.l     #$000000FF,d6
[000043b4] 9e86                      sub.l      d6,d7
[000043b6] 1d47 ffe5                 move.b     d7,-27(a6)
[000043ba] 661a                      bne.s      _scndir_9
[000043bc] 226e ffe6                 movea.l    -26(a6),a1
[000043c0] 43e9 0002                 lea.l      2(a1),a1
[000043c4] 3e2e ffea                 move.w     -22(a6),d7
[000043c8] 48c7                      ext.l      d7
[000043ca] 4a31 7800                 tst.b      0(a1,d7.l)
[000043ce] 6706                      beq.s      _scndir_9
[000043d0] 526e ffea                 addq.w     #1,-22(a6)
[000043d4] 60aa                      bra.s      _scndir_10
_scndir_9:
[000043d6] 4a2e ffe5                 tst.b      -27(a6)
[000043da] 6690                      bne.s      _scndir_7
_scndir_5:
[000043dc] 2eae fff8                 move.l     -8(a6),(a7)
[000043e0] 4eb9 0000 0390            jsr        _brelse
[000043e6] baae fff4                 cmp.l      -12(a6),d5
[000043ea] 6400 fefc                 bcc        _scndir_11
[000043ee] 2945 0030                 move.l     d5,48(a4)
[000043f2] 2eae ffe6                 move.l     -26(a6),(a7)
[000043f6] 4eb9 0000 26ac            jsr        _lstou
[000043fc] 3947 0154                 move.w     d7,340(a4)
[00004400] 7e01                      moveq.l    #1,d7
[00004402] 6014                      bra.s      _scndir_12
_scndir_4:
[00004404] 4aae fff0                 tst.l      -16(a6)
[00004408] 6706                      beq.s      _scndir_13
[0000440a] 2e2e fff0                 move.l     -16(a6),d7
[0000440e] 6002                      bra.s      _scndir_14
_scndir_13:
[00004410] 2e05                      move.l     d5,d7
_scndir_14:
[00004412] 2947 0030                 move.l     d7,48(a4)
[00004416] 7e00                      moveq.l    #0,d7
_scndir_12:
[00004418] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000441c] 4e5e                      unlk       a6
[0000441e] 4e75                      rts

_wdecnlink:
[00004420] 4e56 0000                 link       a6,#0
[00004424] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004428] 2a6e 0008                 movea.l    8(a6),a5
[0000442c] 4a2d 001c                 tst.b      28(a5)
[00004430] 670e                      beq.s      _wdecnlink_1
[00004432] 1e2d 001c                 move.b     28(a5),d7
[00004436] 0c07 00ff                 cmpi.b     #$FF,d7
[0000443a] 6704                      beq.s      _wdecnlink_1
[0000443c] 532d 001c                 subq.b     #1,28(a5)
_wdecnlink_1:
[00004440] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004444] 4e5e                      unlk       a6
[00004446] 4e75                      rts

_wlink:
[00004448] 4e56 0000                 link       a6,#0
[0000444c] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004450] 2a6e 0008                 movea.l    8(a6),a5
[00004454] 2879 0000 0000            movea.l    _pu,a4
[0000445a] 226c 003c                 movea.l    60(a4),a1
[0000445e] 3e29 0016                 move.w     22(a1),d7
[00004462] be6d 0016                 cmp.w      22(a5),d7
[00004466] 6708                      beq.s      _wlink_1
[00004468] 197c 0012 0142            move.b     #$12,322(a4)
[0000446e] 6058                      bra.s      _wlink_2
_wlink_1:
[00004470] 4aae 000c                 tst.l      12(a6)
[00004474] 6724                      beq.s      _wlink_3
[00004476] 7e00                      moveq.l    #0,d7
[00004478] 3e2d 0018                 move.w     24(a5),d7
[0000447c] 2e87                      move.l     d7,(a7)
[0000447e] 486c 0154                 pea.l      340(a4)
[00004482] 4eb9 0000 2622            jsr        _itols
[00004488] 588f                      addq.l     #4,a7
[0000448a] 1e2d 001c                 move.b     28(a5),d7
[0000448e] 0c07 00ff                 cmpi.b     #$FF,d7
[00004492] 6710                      beq.s      _wlink_4
[00004494] 522d 001c                 addq.b     #1,28(a5)
[00004498] 600a                      bra.s      _wlink_4
_wlink_3:
[0000449a] 426c 0154                 clr.w      340(a4)
[0000449e] 2e8d                      move.l     a5,(a7)
[000044a0] 4eba ff7e                 jsr        _wdecnlink(pc)
_wlink_4:
[000044a4] 08ed 0000 000d            bset       #0,13(a5)
[000044aa] 43ec 0154                 lea.l      340(a4),a1
[000044ae] 2949 0028                 move.l     a1,40(a4)
[000044b2] 7010                      moveq.l    #16,d0
[000044b4] 2940 002c                 move.l     d0,44(a4)
[000044b8] 197c 0001 0143            move.b     #$01,323(a4)
[000044be] 2eac 003c                 move.l     60(a4),(a7)
[000044c2] 4eb9 0000 5d9a            jsr        _writei
_wlink_2:
[000044c8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000044cc] 4e5e                      unlk       a6
[000044ce] 4e75                      rts

x44d0:
[000044d0] 4e56 fff0                 link       a6,#-16
[000044d4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000044d8] 2a6e 0008                 movea.l    8(a6),a5
[000044dc] 4eb9 0000 2320            jsr        _curproc
[000044e2] 2d47 fffc                 move.l     d7,-4(a6)
[000044e6] 2e2e 0010                 move.l     16(a6),d7
[000044ea] deae 0014                 add.l      20(a6),d7
[000044ee] 2d47 fff0                 move.l     d7,-16(a6)
[000044f2] 42ae fff8                 clr.l      -8(a6)
[000044f6] 43ed 0004                 lea.l      4(a5),a1
[000044fa] 2849                      movea.l    a1,a4
[000044fc] 2654                      movea.l    (a4),a3
x44d0_3:
[000044fe] 2e0b                      move.l     a3,d7
[00004500] 6700 00c2                 beq        x44d0_1
[00004504] 2e2b 0008                 move.l     8(a3),d7
[00004508] beae 0010                 cmp.l      16(a6),d7
[0000450c] 6208                      bhi.s      x44d0_2
[0000450e] 284b                      movea.l    a3,a4
[00004510] 6004                      bra.s      x44d0_2
x44d0_5:
[00004512] 2653                      movea.l    (a3),a3
[00004514] 60e8                      bra.s      x44d0_3
x44d0_2:
[00004516] 2e2e fff0                 move.l     -16(a6),d7
[0000451a] beab 0008                 cmp.l      8(a3),d7
[0000451e] 6300 00a4                 bls        x44d0_1
[00004522] 2eab 000c                 move.l     12(a3),(a7)
[00004526] 2f2b 0008                 move.l     8(a3),-(a7)
[0000452a] 2f2e 0014                 move.l     20(a6),-(a7)
[0000452e] 2f2e 0010                 move.l     16(a6),-(a7)
[00004532] 4eb9 0000 48e4            jsr        _lolap
[00004538] 4fef 000c                 lea.l      12(a7),a7
[0000453c] 4a87                      tst.l      d7
[0000453e] 663a                      bne.s      x44d0_4
[00004540] 2e2b 0004                 move.l     4(a3),d7
[00004544] beae fffc                 cmp.l      -4(a6),d7
[00004548] 66c8                      bne.s      x44d0_5
[0000454a] 1e2b 0010                 move.b     16(a3),d7
[0000454e] 2c2e 000c                 move.l     12(a6),d6
[00004552] ce06                      and.b      d6,d7
[00004554] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000455a] 67b6                      beq.s      x44d0_5
[0000455c] 2e2e fff0                 move.l     -16(a6),d7
[00004560] beab 0008                 cmp.l      8(a3),d7
[00004564] 670e                      beq.s      x44d0_6
[00004566] 2e2b 0008                 move.l     8(a3),d7
[0000456a] deab 000c                 add.l      12(a3),d7
[0000456e] beae 0010                 cmp.l      16(a6),d7
[00004572] 669e                      bne.s      x44d0_5
x44d0_6:
[00004574] 2d4b fff8                 move.l     a3,-8(a6)
[00004578] 6098                      bra.s      x44d0_5
x44d0_4:
[0000457a] 2e2b 0004                 move.l     4(a3),d7
[0000457e] beae fffc                 cmp.l      -4(a6),d7
[00004582] 6616                      bne.s      x44d0_7
[00004584] 2e2e 000c                 move.l     12(a6),d7
[00004588] 7c00                      moveq.l    #0,d6
[0000458a] 1c2b 0010                 move.b     16(a3),d6
[0000458e] ce86                      and.l      d6,d7
[00004590] 6708                      beq.s      x44d0_7
[00004592] 2d4b fff8                 move.l     a3,-8(a6)
[00004596] 6000 ff7a                 bra        x44d0_5
x44d0_7:
[0000459a] 2e2e 000c                 move.l     12(a6),d7
[0000459e] 7c00                      moveq.l    #0,d6
[000045a0] 1c2b 0010                 move.b     16(a3),d6
[000045a4] 8e86                      or.l       d6,d7
[000045a6] 0807 0001                 btst       #1,d7
[000045aa] 6704                      beq.s      x44d0_8
[000045ac] 2e0b                      move.l     a3,d7
[000045ae] 601c                      bra.s      x44d0_9
x44d0_8:
[000045b0] 2e2b 0004                 move.l     4(a3),d7
[000045b4] beae fffc                 cmp.l      -4(a6),d7
[000045b8] 6600 ff58                 bne        x44d0_5
[000045bc] 2d4b fff8                 move.l     a3,-8(a6)
[000045c0] 6000 ff50                 bra        x44d0_5
x44d0_1:
[000045c4] 4aae 0018                 tst.l      24(a6)
[000045c8] 670a                      beq.s      x44d0_10
[000045ca] 7e00                      moveq.l    #0,d7
x44d0_9:
[000045cc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000045d0] 4e5e                      unlk       a6
[000045d2] 4e75                      rts
x44d0_10:
[000045d4] 266e fff8                 movea.l    -8(a6),a3
[000045d8] 2e0b                      move.l     a3,d7
[000045da] 6700 00cc                 beq        x44d0_11
[000045de] 2e2b 0004                 move.l     4(a3),d7
[000045e2] beae fffc                 cmp.l      -4(a6),d7
[000045e6] 6600 00c0                 bne        x44d0_11
[000045ea] 1e2b 0010                 move.b     16(a3),d7
[000045ee] 2c2e 000c                 move.l     12(a6),d6
[000045f2] ce06                      and.b      d6,d7
[000045f4] 0287 0000 00ff            andi.l     #$000000FF,d7
[000045fa] 6700 00ac                 beq        x44d0_11
[000045fe] 2d4b fff8                 move.l     a3,-8(a6)
[00004602] 284b                      movea.l    a3,a4
x44d0_14:
[00004604] 2654                      movea.l    (a4),a3
[00004606] 2e0b                      move.l     a3,d7
[00004608] 6760                      beq.s      x44d0_12
[0000460a] 2e2e fff0                 move.l     -16(a6),d7
[0000460e] beab 0008                 cmp.l      8(a3),d7
[00004612] 6406                      bcc.s      x44d0_13
[00004614] 6054                      bra.s      x44d0_12
x44d0_15:
[00004616] 284b                      movea.l    a3,a4
[00004618] 60ea                      bra.s      x44d0_14
x44d0_13:
[0000461a] 2e2b 0004                 move.l     4(a3),d7
[0000461e] beae fffc                 cmp.l      -4(a6),d7
[00004622] 66f2                      bne.s      x44d0_15
[00004624] 1e2b 0010                 move.b     16(a3),d7
[00004628] 2c2e 000c                 move.l     12(a6),d6
[0000462c] ce06                      and.b      d6,d7
[0000462e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004634] 67e0                      beq.s      x44d0_15
[00004636] 2e2b 0008                 move.l     8(a3),d7
[0000463a] deab 000c                 add.l      12(a3),d7
[0000463e] 2d47 fff0                 move.l     d7,-16(a6)
[00004642] 2ebc 0000 b240            move.l     #$00015FAE,(a7)
[00004648] 2f0b                      move.l     a3,-(a7)
[0000464a] 4eb9 0000 8b66            jsr        _wakeupl
[00004650] 588f                      addq.l     #4,a7
[00004652] 2e93                      move.l     (a3),(a7)
[00004654] 2f0b                      move.l     a3,-(a7)
[00004656] 4878 0014                 pea.l      ($00000014).w
[0000465a] 4eb9 0000 0114            jsr        _free
[00004660] 508f                      addq.l     #8,a7
[00004662] 2887                      move.l     d7,(a4)
[00004664] 53b9 0000 b248            subq.l     #1,_nlock
x44d0_12:
[0000466a] 266e fff8                 movea.l    -8(a6),a3
[0000466e] 2e2b 0008                 move.l     8(a3),d7
[00004672] deab 000c                 add.l      12(a3),d7
[00004676] 2d47 fff4                 move.l     d7,-12(a6)
[0000467a] 2e2e 0010                 move.l     16(a6),d7
[0000467e] beab 0008                 cmp.l      8(a3),d7
[00004682] 6406                      bcc.s      x44d0_16
[00004684] 276e 0010 0008            move.l     16(a6),8(a3)
x44d0_16:
[0000468a] 2e2e fff4                 move.l     -12(a6),d7
[0000468e] beae fff0                 cmp.l      -16(a6),d7
[00004692] 6406                      bcc.s      x44d0_17
[00004694] 2d6e fff0 fff4            move.l     -16(a6),-12(a6)
x44d0_17:
[0000469a] 2e2e fff4                 move.l     -12(a6),d7
[0000469e] 9eab 0008                 sub.l      8(a3),d7
[000046a2] 2747 000c                 move.l     d7,12(a3)
[000046a6] 602e                      bra.s      x44d0_18
x44d0_11:
[000046a8] 2e39 0000 b244            move.l     _maxlock,d7
[000046ae] beb9 0000 b248            cmp.l      _nlock,d7
[000046b4] 6314                      bls.s      x44d0_19
[000046b6] 2e94                      move.l     (a4),(a7)
[000046b8] 4878 0014                 pea.l      ($00000014).w
[000046bc] 4eb9 0000 00f6            jsr        _alloc
[000046c2] 588f                      addq.l     #4,a7
[000046c4] 2647                      movea.l    d7,a3
[000046c6] 2e0b                      move.l     a3,d7
[000046c8] 661e                      bne.s      x44d0_20
x44d0_19:
[000046ca] 4878 0025                 pea.l      ($00000025).w
[000046ce] 4eb9 0000 2868            jsr        _uerror
[000046d4] 588f                      addq.l     #4,a7
x44d0_18:
[000046d6] 2e8d                      move.l     a5,(a7)
[000046d8] 4eb9 0000 4912            jsr        $00004912
[000046de] 7e00                      moveq.l    #0,d7
[000046e0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000046e4] 4e5e                      unlk       a6
[000046e6] 4e75                      rts
x44d0_20:
[000046e8] 52b9 0000 b248            addq.l     #1,_nlock
[000046ee] 276e 0010 0008            move.l     16(a6),8(a3)
[000046f4] 276e 0014 000c            move.l     20(a6),12(a3)
[000046fa] 422b 0011                 clr.b      17(a3)
[000046fe] 176e 000f 0010            move.b     15(a6),16(a3)
[00004704] 276e fffc 0004            move.l     -4(a6),4(a3)
[0000470a] 4eb9 0000 230e            jsr        _curpid
[00004710] 3747 0012                 move.w     d7,18(a3)
[00004714] 288b                      move.l     a3,(a4)
[00004716] 60be                      bra.s      x44d0_18
[00004718] 4e56 0000                 link       a6,#0
[0000471c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004720] 2a6e 0008                 movea.l    8(a6),a5
x44d0_22:
[00004724] 2ebc 0000 b240            move.l     #$00015FAE,(a7)
[0000472a] 2f2d 0004                 move.l     4(a5),-(a7)
[0000472e] 4eb9 0000 8bb0            jsr        _wchan
[00004734] 588f                      addq.l     #4,a7
[00004736] 2a47                      movea.l    d7,a5
[00004738] 2e0d                      move.l     a5,d7
[0000473a] 671c                      beq.s      x44d0_21
[0000473c] 4eb9 0000 2320            jsr        _curproc
[00004742] bead 0004                 cmp.l      4(a5),d7
[00004746] 66dc                      bne.s      x44d0_22
[00004748] 4878 0024                 pea.l      ($00000024).w
[0000474c] 4eb9 0000 2868            jsr        _uerror
[00004752] 588f                      addq.l     #4,a7
[00004754] 7e01                      moveq.l    #1,d7
[00004756] 6002                      bra.s      x44d0_23
x44d0_21:
[00004758] 7e00                      moveq.l    #0,d7
x44d0_23:
[0000475a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000475e] 4e5e                      unlk       a6
[00004760] 4e75                      rts

_lockf:
[00004762] 4e56 ffe0                 link       a6,#-32
[00004766] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000476a] 2a6e 0008                 movea.l    8(a6),a5
[0000476e] 2855                      movea.l    (a5),a4
[00004770] 4878 0014                 pea.l      ($00000014).w
[00004774] 486e ffe8                 pea.l      -24(a6)
[00004778] 2f2e 0010                 move.l     16(a6),-(a7)
[0000477c] 4eb9 0000 0000            jsr        _inbuf
[00004782] 4fef 000c                 lea.l      12(a7),a7
[00004786] 4a87                      tst.l      d7
[00004788] 670a                      beq.s      _lockf_1
[0000478a] 7e16                      moveq.l    #22,d7
[0000478c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00004790] 4e5e                      unlk       a6
[00004792] 4e75                      rts
_lockf_1:
[00004794] 7e00                      moveq.l    #0,d7
[00004796] 1e2e fff9                 move.b     -7(a6),d7
[0000479a] 2e87                      move.l     d7,(a7)
[0000479c] 2f2e fff0                 move.l     -16(a6),-(a7)
[000047a0] 2f0d                      move.l     a5,-(a7)
[000047a2] 4eb9 0000 5c46            jsr        _seekp
[000047a8] 508f                      addq.l     #8,a7
[000047aa] 2d47 ffe4                 move.l     d7,-28(a6)
[000047ae] 6c04                      bge.s      _lockf_2
[000047b0] 42ae ffe4                 clr.l      -28(a6)
_lockf_2:
[000047b4] 0cae 0100 0000 ffe4       cmpi.l     #$01000000,-28(a6)
[000047bc] 6508                      bcs.s      _lockf_3
[000047be] 2d7c 00ff ffff ffe4       move.l     #$00FFFFFF,-28(a6)
_lockf_3:
[000047c6] 2d6e fff4 ffe0            move.l     -12(a6),-32(a6)
[000047cc] 6608                      bne.s      _lockf_4
[000047ce] 2d7c 0100 0000 ffe0       move.l     #$01000000,-32(a6)
_lockf_4:
[000047d6] 2e2e ffe4                 move.l     -28(a6),d7
[000047da] deae ffe0                 add.l      -32(a6),d7
[000047de] 0c87 0100 0000            cmpi.l     #$01000000,d7
[000047e4] 630e                      bls.s      _lockf_5
[000047e6] 2e3c 0100 0000            move.l     #$01000000,d7
[000047ec] 9eae ffe4                 sub.l      -28(a6),d7
[000047f0] 2d47 ffe0                 move.l     d7,-32(a6)
_lockf_5:
[000047f4] 42ae fffc                 clr.l      -4(a6)
[000047f8] 2e2e 000c                 move.l     12(a6),d7
[000047fc] 41f9 0000 b24c            lea.l      $00015FBA,a0
[00004802] 4ef9 0000 0000            jmp        a~jtab
[00004808] 4878 0001                 pea.l      ($00000001).w
[0000480c] 2f2e ffe0                 move.l     -32(a6),-(a7)
[00004810] 2f2e ffe4                 move.l     -28(a6),-(a7)
[00004814] 7e00                      moveq.l    #0,d7
[00004816] 1e2e fff8                 move.b     -8(a6),d7
[0000481a] 2f07                      move.l     d7,-(a7)
[0000481c] 2f0c                      move.l     a4,-(a7)
[0000481e] 4eba fcb0                 jsr        $000044D0(pc)
[00004822] 4fef 0014                 lea.l      20(a7),a7
[00004826] 2647                      movea.l    d7,a3
[00004828] 2e0b                      move.l     a3,d7
[0000482a] 660a                      bne.s      _lockf_6
[0000482c] 43ee ffe8                 lea.l      -24(a6),a1
[00004830] 2649                      movea.l    a1,a3
[00004832] 422e fff8                 clr.b      -8(a6)
_lockf_6:
[00004836] 4878 0014                 pea.l      ($00000014).w
[0000483a] 2f2e 0010                 move.l     16(a6),-(a7)
[0000483e] 2f0b                      move.l     a3,-(a7)
[00004840] 4eb9 0000 0000            jsr        _outbuf
[00004846] 4fef 000c                 lea.l      12(a7),a7
[0000484a] 6000 008e                 bra        _lockf_7
[0000484e] 7001                      moveq.l    #1,d0
[00004850] 2d40 fffc                 move.l     d0,-4(a6)
[00004854] 4a2e fff8                 tst.b      -8(a6)
[00004858] 6716                      beq.s      _lockf_8
[0000485a] 1e2e fff8                 move.b     -8(a6),d7
[0000485e] 1c2d 0008                 move.b     8(a5),d6
[00004862] ce06                      and.b      d6,d7
[00004864] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000486a] 6604                      bne.s      _lockf_8
[0000486c] 7e0d                      moveq.l    #13,d7
[0000486e] 604c                      bra.s      _lockf_9
_lockf_8:
[00004870] 2eae ffe0                 move.l     -32(a6),(a7)
[00004874] 2f2e ffe4                 move.l     -28(a6),-(a7)
[00004878] 2f0c                      move.l     a4,-(a7)
[0000487a] 4eb9 0000 494e            jsr        _unlock
[00004880] 508f                      addq.l     #8,a7
[00004882] 4a2e fff8                 tst.b      -8(a6)
[00004886] 6752                      beq.s      _lockf_7
_lockf_12:
[00004888] 4297                      clr.l      (a7)
[0000488a] 2f2e ffe0                 move.l     -32(a6),-(a7)
[0000488e] 2f2e ffe4                 move.l     -28(a6),-(a7)
[00004892] 7e00                      moveq.l    #0,d7
[00004894] 1e2e fff8                 move.b     -8(a6),d7
[00004898] 2f07                      move.l     d7,-(a7)
[0000489a] 2f0c                      move.l     a4,-(a7)
[0000489c] 4eba fc32                 jsr        $000044D0(pc)
[000048a0] 4fef 0010                 lea.l      16(a7),a7
[000048a4] 2647                      movea.l    d7,a3
[000048a6] 2e0b                      move.l     a3,d7
[000048a8] 6730                      beq.s      _lockf_7
[000048aa] 4aae fffc                 tst.l      -4(a6)
[000048ae] 670a                      beq.s      _lockf_10
[000048b0] 2e8b                      move.l     a3,(a7)
[000048b2] 4eba fe64                 jsr        $00004718(pc)
[000048b6] 4a87                      tst.l      d7
[000048b8] 670a                      beq.s      _lockf_11
_lockf_10:
[000048ba] 7e0b                      moveq.l    #11,d7
_lockf_9:
[000048bc] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000048c0] 4e5e                      unlk       a6
[000048c2] 4e75                      rts
_lockf_11:
[000048c4] 2ebc 0000 b240            move.l     #$00015FAE,(a7)
[000048ca] 4878 0005                 pea.l      ($00000005).w
[000048ce] 2f0b                      move.l     a3,-(a7)
[000048d0] 4eb9 0000 8862            jsr        _sleepl
[000048d6] 508f                      addq.l     #8,a7
[000048d8] 60ae                      bra.s      _lockf_12
_lockf_7:
[000048da] 4297                      clr.l      (a7)
[000048dc] 4eb9 0000 2868            jsr        _uerror
[000048e2] 60d8                      bra.s      _lockf_9

_lolap:
[000048e4] 4e56 0000                 link       a6,#0
[000048e8] 2e2e 0010                 move.l     16(a6),d7
[000048ec] deae 0014                 add.l      20(a6),d7
[000048f0] 2c2e 0008                 move.l     8(a6),d6
[000048f4] bc87                      cmp.l      d7,d6
[000048f6] 6414                      bcc.s      _lolap_1
[000048f8] 2e2e 0008                 move.l     8(a6),d7
[000048fc] deae 000c                 add.l      12(a6),d7
[00004900] 2c2e 0010                 move.l     16(a6),d6
[00004904] bc87                      cmp.l      d7,d6
[00004906] 6404                      bcc.s      _lolap_1
[00004908] 7e01                      moveq.l    #1,d7
[0000490a] 6002                      bra.s      _lolap_2
_lolap_1:
[0000490c] 7e00                      moveq.l    #0,d7
_lolap_2:
[0000490e] 4e5e                      unlk       a6
[00004910] 4e75                      rts

x4912:
[00004912] 4e56 0000                 link       a6,#0
[00004916] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000491a] 2a6e 0008                 movea.l    8(a6),a5
[0000491e] 7e00                      moveq.l    #0,d7
[00004920] 3e2d 001a                 move.w     26(a5),d7
[00004924] 0287 0000 0449            andi.l     #$00000449,d7
[0000492a] 0c87 0000 0400            cmpi.l     #$00000400,d7
[00004930] 660e                      bne.s      x4912_1
[00004932] 4aad 0004                 tst.l      4(a5)
[00004936] 6708                      beq.s      x4912_1
[00004938] 08ed 0000 000c            bset       #0,12(a5)
[0000493e] 6006                      bra.s      x4912_2
x4912_1:
[00004940] 08ad 0000 000c            bclr       #0,12(a5)
x4912_2:
[00004946] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000494a] 4e5e                      unlk       a6
[0000494c] 4e75                      rts

_unlock:
[0000494e] 4e56 ffee                 link       a6,#-18
[00004952] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00004956] 2a6e 0008                 movea.l    8(a6),a5
[0000495a] 2e2e 000c                 move.l     12(a6),d7
[0000495e] deae 0010                 add.l      16(a6),d7
[00004962] 2d47 fff0                 move.l     d7,-16(a6)
[00004966] 43ed 0004                 lea.l      4(a5),a1
[0000496a] 2849                      movea.l    a1,a4
_unlock_4:
[0000496c] 2654                      movea.l    (a4),a3
[0000496e] 2e0b                      move.l     a3,d7
[00004970] 6700 00d6                 beq        _unlock_1
[00004974] 4eb9 0000 2320            jsr        _curproc
[0000497a] beab 0004                 cmp.l      4(a3),d7
[0000497e] 661c                      bne.s      _unlock_2
[00004980] 2eab 000c                 move.l     12(a3),(a7)
[00004984] 2f2b 0008                 move.l     8(a3),-(a7)
[00004988] 2f2e 0010                 move.l     16(a6),-(a7)
[0000498c] 2f2e 000c                 move.l     12(a6),-(a7)
[00004990] 4eba ff52                 jsr        _lolap(pc)
[00004994] 4fef 000c                 lea.l      12(a7),a7
[00004998] 4a87                      tst.l      d7
[0000499a] 6604                      bne.s      _unlock_3
_unlock_2:
[0000499c] 2854                      movea.l    (a4),a4
[0000499e] 60cc                      bra.s      _unlock_4
_unlock_3:
[000049a0] 1d6b 0010 ffef            move.b     16(a3),-17(a6)
[000049a6] 2d6b 0008 fff8            move.l     8(a3),-8(a6)
[000049ac] 2d6b 000c fffc            move.l     12(a3),-4(a6)
[000049b2] 2e2e fff8                 move.l     -8(a6),d7
[000049b6] deae fffc                 add.l      -4(a6),d7
[000049ba] 2d47 fff4                 move.l     d7,-12(a6)
[000049be] 2ebc 0000 b240            move.l     #$00015FAE,(a7)
[000049c4] 2f0b                      move.l     a3,-(a7)
[000049c6] 4eb9 0000 8b66            jsr        _wakeupl
[000049cc] 588f                      addq.l     #4,a7
[000049ce] 2e93                      move.l     (a3),(a7)
[000049d0] 2f0b                      move.l     a3,-(a7)
[000049d2] 4878 0014                 pea.l      ($00000014).w
[000049d6] 4eb9 0000 0114            jsr        _free
[000049dc] 508f                      addq.l     #8,a7
[000049de] 2887                      move.l     d7,(a4)
[000049e0] 53b9 0000 b248            subq.l     #1,_nlock
[000049e6] 2e2e fff8                 move.l     -8(a6),d7
[000049ea] beae 000c                 cmp.l      12(a6),d7
[000049ee] 6422                      bcc.s      _unlock_5
[000049f0] 4297                      clr.l      (a7)
[000049f2] 2e2e 000c                 move.l     12(a6),d7
[000049f6] 9eae fff8                 sub.l      -8(a6),d7
[000049fa] 2f07                      move.l     d7,-(a7)
[000049fc] 2f2e fff8                 move.l     -8(a6),-(a7)
[00004a00] 7e00                      moveq.l    #0,d7
[00004a02] 1e2e ffef                 move.b     -17(a6),d7
[00004a06] 2f07                      move.l     d7,-(a7)
[00004a08] 2f0d                      move.l     a5,-(a7)
[00004a0a] 4eba fac4                 jsr        $000044D0(pc)
[00004a0e] 4fef 0010                 lea.l      16(a7),a7
_unlock_5:
[00004a12] 2e2e fff0                 move.l     -16(a6),d7
[00004a16] beae fff4                 cmp.l      -12(a6),d7
[00004a1a] 6422                      bcc.s      _unlock_6
[00004a1c] 4297                      clr.l      (a7)
[00004a1e] 2e2e fff4                 move.l     -12(a6),d7
[00004a22] 9eae fff0                 sub.l      -16(a6),d7
[00004a26] 2f07                      move.l     d7,-(a7)
[00004a28] 2f2e fff0                 move.l     -16(a6),-(a7)
[00004a2c] 7e00                      moveq.l    #0,d7
[00004a2e] 1e2e ffef                 move.b     -17(a6),d7
[00004a32] 2f07                      move.l     d7,-(a7)
[00004a34] 2f0d                      move.l     a5,-(a7)
[00004a36] 4eba fa98                 jsr        $000044D0(pc)
[00004a3a] 4fef 0010                 lea.l      16(a7),a7
_unlock_6:
[00004a3e] 43ed 0004                 lea.l      4(a5),a1
[00004a42] 2849                      movea.l    a1,a4
[00004a44] 6000 ff26                 bra        _unlock_4
_unlock_1:
[00004a48] 2e8d                      move.l     a5,(a7)
[00004a4a] 4eba fec6                 jsr        $00004912(pc)
[00004a4e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00004a52] 4e5e                      unlk       a6
[00004a54] 4e75                      rts

_waitlock:
[00004a56] 4e56 0000                 link       a6,#0
[00004a5a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004a5e] 2a6e 0008                 movea.l    8(a6),a5
[00004a62] 286d 0004                 movea.l    4(a5),a4
_waitlock_3:
[00004a66] 2e0c                      move.l     a4,d7
[00004a68] 6700 0096                 beq        _waitlock_1
[00004a6c] 2e2e 0010                 move.l     16(a6),d7
[00004a70] deae 0014                 add.l      20(a6),d7
[00004a74] beac 0008                 cmp.l      8(a4),d7
[00004a78] 6208                      bhi.s      _waitlock_2
[00004a7a] 6000 0084                 bra        _waitlock_1
_waitlock_4:
[00004a7e] 2854                      movea.l    (a4),a4
[00004a80] 60e4                      bra.s      _waitlock_3
_waitlock_2:
[00004a82] 4eb9 0000 2320            jsr        _curproc
[00004a88] beac 0004                 cmp.l      4(a4),d7
[00004a8c] 67f0                      beq.s      _waitlock_4
[00004a8e] 7e01                      moveq.l    #1,d7
[00004a90] 7c00                      moveq.l    #0,d6
[00004a92] 1c2c 0010                 move.b     16(a4),d6
[00004a96] ce86                      and.l      d6,d7
[00004a98] ceae 000c                 and.l      12(a6),d7
[00004a9c] 66e0                      bne.s      _waitlock_4
[00004a9e] 2eac 000c                 move.l     12(a4),(a7)
[00004aa2] 2f2c 0008                 move.l     8(a4),-(a7)
[00004aa6] 2f2e 0014                 move.l     20(a6),-(a7)
[00004aaa] 2f2e 0010                 move.l     16(a6),-(a7)
[00004aae] 4eba fe34                 jsr        _lolap(pc)
[00004ab2] 4fef 000c                 lea.l      12(a7),a7
[00004ab6] 4a87                      tst.l      d7
[00004ab8] 67c4                      beq.s      _waitlock_4
[00004aba] 082e 0002 001b            btst       #2,27(a6)
[00004ac0] 660a                      bne.s      _waitlock_5
[00004ac2] 2e8c                      move.l     a4,(a7)
[00004ac4] 4eba fc52                 jsr        $00004718(pc)
[00004ac8] 4a87                      tst.l      d7
[00004aca] 6704                      beq.s      _waitlock_6
_waitlock_5:
[00004acc] 2e0c                      move.l     a4,d7
[00004ace] 6032                      bra.s      _waitlock_7
_waitlock_6:
[00004ad0] 2ebc 0000 b240            move.l     #$00015FAE,(a7)
[00004ad6] 4878 0005                 pea.l      ($00000005).w
[00004ada] 2f0c                      move.l     a4,-(a7)
[00004adc] 4eb9 0000 8862            jsr        _sleepl
[00004ae2] 508f                      addq.l     #8,a7
[00004ae4] 082e 0003 001b            btst       #3,27(a6)
[00004aea] 670c                      beq.s      _waitlock_8
[00004aec] 2e8d                      move.l     a5,(a7)
[00004aee] 4eb9 0000 2686            jsr        _lsize
[00004af4] 2d47 0010                 move.l     d7,16(a6)
_waitlock_8:
[00004af8] 286d 0004                 movea.l    4(a5),a4
[00004afc] 6000 ff80                 bra.w      _waitlock_4
_waitlock_1:
[00004b00] 7e00                      moveq.l    #0,d7
_waitlock_7:
[00004b02] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00004b06] 4e5e                      unlk       a6
[00004b08] 4e75                      rts

x4b0a:
[00004b0a] 4e56 0000                 link       a6,#0
[00004b0e] 2e2e 0008                 move.l     8(a6),d7
[00004b12] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004b18] 0c87 0000 000b            cmpi.l     #$0000000B,d7
[00004b1e] 6624                      bne.s      x4b0a_1
[00004b20] 4878 2000                 pea.l      ($00002000).w
[00004b24] 2f2e 000c                 move.l     12(a6),-(a7)
[00004b28] 2279 0000 0000            movea.l    _pu,a1
[00004b2e] 2269 0010                 movea.l    16(a1),a1
[00004b32] 7e00                      moveq.l    #0,d7
[00004b34] 3e29 0020                 move.w     32(a1),d7
[00004b38] 2f07                      move.l     d7,-(a7)
[00004b3a] 4eb9 0000 0ab2            jsr        _closed
[00004b40] 4fef 000c                 lea.l      12(a7),a7
x4b0a_1:
[00004b44] 4e5e                      unlk       a6
[00004b46] 4e75                      rts

x4b48:
[00004b48] 4e56 fffe                 link       a6,#-2
[00004b4c] 2e2e 0008                 move.l     8(a6),d7
[00004b50] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004b56] 0c87 0000 000b            cmpi.l     #$0000000B,d7
[00004b5c] 663a                      bne.s      x4b48_1
[00004b5e] 2279 0000 0000            movea.l    _pu,a1
[00004b64] 2269 0010                 movea.l    16(a1),a1
[00004b68] 3d69 0020 fffe            move.w     32(a1),-2(a6)
[00004b6e] 660e                      bne.s      x4b48_2
[00004b70] 4878 0006                 pea.l      ($00000006).w
[00004b74] 4eb9 0000 2868            jsr        _uerror
[00004b7a] 588f                      addq.l     #4,a7
[00004b7c] 601a                      bra.s      x4b48_1
x4b48_2:
[00004b7e] 4878 2000                 pea.l      ($00002000).w
[00004b82] 2f2e 000c                 move.l     12(a6),-(a7)
[00004b86] 7e00                      moveq.l    #0,d7
[00004b88] 3e2e fffe                 move.w     -2(a6),d7
[00004b8c] 2f07                      move.l     d7,-(a7)
[00004b8e] 4eb9 0000 0cc0            jsr        _opendev
[00004b94] 4fef 000c                 lea.l      12(a7),a7
x4b48_1:
[00004b98] 4e5e                      unlk       a6
[00004b9a] 4e75                      rts

x4b9c:
[00004b9c] 4e56 0000                 link       a6,#0
[00004ba0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004ba4] 2879 0000 0000            movea.l    _pu,a4
[00004baa] 42b9 0000 b270            clr.l      $00015FDE
[00004bb0] 2e2e 0008                 move.l     8(a6),d7
[00004bb4] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004bba] 41f9 0000 b2d2            lea.l      $00016040,a0
[00004bc0] 4ef9 0000 0000            jmp        a~jtab
x4b9c_2:
[00004bc6] 2eac 0030                 move.l     48(a4),(a7)
[00004bca] 4eb9 0000 0000            jsr        _gsbyte
[00004bd0] 2e87                      move.l     d7,(a7)
[00004bd2] 4eb9 0000 27d6            jsr        _setch
[00004bd8] 4a87                      tst.l      d7
[00004bda] 6d00 018e                 blt        x4b9c_1
[00004bde] 60e6                      bra.s      x4b9c_2
[00004be0] 6000 0188                 bra        x4b9c_1
[00004be4] 2a79 0000 b514            movea.l    _plist,a5
x4b9c_4:
[00004bea] 2e0d                      move.l     a5,d7
[00004bec] 6700 017c                 beq        x4b9c_1
[00004bf0] 4878 0044                 pea.l      ($00000044).w
[00004bf4] 2f0d                      move.l     a5,-(a7)
[00004bf6] 4eb9 0000 4e6e            jsr        $00004E6E
[00004bfc] 508f                      addq.l     #8,a7
[00004bfe] 4a87                      tst.l      d7
[00004c00] 6600 0168                 bne        x4b9c_1
[00004c04] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00004c0a] 6716                      beq.s      x4b9c_3
[00004c0c] 4878 001c                 pea.l      ($0000001C).w
[00004c10] 2f2d 0026                 move.l     38(a5),-(a7)
[00004c14] 4eb9 0000 4ea2            jsr        $00004EA2
[00004c1a] 508f                      addq.l     #8,a7
[00004c1c] 4a87                      tst.l      d7
[00004c1e] 6600 014a                 bne        x4b9c_1
x4b9c_3:
[00004c22] 2a55                      movea.l    (a5),a5
[00004c24] 60c4                      bra.s      x4b9c_4
[00004c26] 2a79 0000 b514            movea.l    _plist,a5
x4b9c_6:
[00004c2c] 2e0d                      move.l     a5,d7
[00004c2e] 6700 013a                 beq        x4b9c_1
[00004c32] 226c 0010                 movea.l    16(a4),a1
[00004c36] 3e29 0020                 move.w     32(a1),d7
[00004c3a] be6d 0020                 cmp.w      32(a5),d7
[00004c3e] 6704                      beq.s      x4b9c_5
x4b9c_7:
[00004c40] 2a55                      movea.l    (a5),a5
[00004c42] 60e8                      bra.s      x4b9c_6
x4b9c_5:
[00004c44] 4878 0044                 pea.l      ($00000044).w
[00004c48] 2f0d                      move.l     a5,-(a7)
[00004c4a] 4eb9 0000 4e6e            jsr        $00004E6E
[00004c50] 508f                      addq.l     #8,a7
[00004c52] 4a87                      tst.l      d7
[00004c54] 6600 0114                 bne        x4b9c_1
[00004c58] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00004c5e] 67e0                      beq.s      x4b9c_7
[00004c60] 4878 001c                 pea.l      ($0000001C).w
[00004c64] 2f2d 0026                 move.l     38(a5),-(a7)
[00004c68] 4eb9 0000 4ea2            jsr        $00004EA2
[00004c6e] 508f                      addq.l     #8,a7
[00004c70] 4a87                      tst.l      d7
[00004c72] 67cc                      beq.s      x4b9c_7
[00004c74] 6000 00f4                 bra        x4b9c_1
[00004c78] 4878 0010                 pea.l      ($00000010).w
[00004c7c] 2f39 0000 b0ec            move.l     _mlist,-(a7)
[00004c82] 4eb9 0000 4ea2            jsr        $00004EA2
[00004c88] 508f                      addq.l     #8,a7
[00004c8a] 6000 00de                 bra        x4b9c_1
[00004c8e] 4878 0032                 pea.l      ($00000032).w
[00004c92] 2f39 0000 b0e8            move.l     _ilist,-(a7)
[00004c98] 4eb9 0000 4ea2            jsr        $00004EA2
[00004c9e] 508f                      addq.l     #8,a7
[00004ca0] 6000 00c8                 bra        x4b9c_1
[00004ca4] 2ebc 0000 0000            move.l     #_where,(a7)
[00004caa] 4eb9 0000 4ed6            jsr        $00004ED6
[00004cb0] 6000 00b8                 bra        x4b9c_1
[00004cb4] 7a00                      moveq.l    #0,d5
x4b9c_8:
[00004cb6] bab9 0000 0000            cmp.l      _nblkdev,d5
[00004cbc] 6400 00ac                 bcc        x4b9c_1
[00004cc0] 2e05                      move.l     d5,d7
[00004cc2] e587                      asl.l      #2,d7
[00004cc4] 2247                      movea.l    d7,a1
[00004cc6] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00004ccc] 2251                      movea.l    (a1),a1
[00004cce] 2ea9 0010                 move.l     16(a1),(a7)
[00004cd2] 4eb9 0000 4ed6            jsr        $00004ED6
[00004cd8] 5285                      addq.l     #1,d5
[00004cda] 60da                      bra.s      x4b9c_8
[00004cdc] 7a00                      moveq.l    #0,d5
x4b9c_9:
[00004cde] bab9 0000 0000            cmp.l      _nchrdev,d5
[00004ce4] 6400 0084                 bcc        x4b9c_1
[00004ce8] 2e05                      move.l     d5,d7
[00004cea] e587                      asl.l      #2,d7
[00004cec] 2247                      movea.l    d7,a1
[00004cee] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00004cf4] 2251                      movea.l    (a1),a1
[00004cf6] 2ea9 0014                 move.l     20(a1),(a7)
[00004cfa] 4eb9 0000 4ed6            jsr        $00004ED6
[00004d00] 5285                      addq.l     #1,d5
[00004d02] 60da                      bra.s      x4b9c_9
x4b9c_10:
[00004d04] 4297                      clr.l      (a7)
[00004d06] 4eb9 0000 27d6            jsr        _setch
[00004d0c] 4a87                      tst.l      d7
[00004d0e] 6d5a                      blt.s      x4b9c_1
[00004d10] 60f2                      bra.s      x4b9c_10
[00004d12] 2279 0000 0000            movea.l    _pu,a1
[00004d18] 2269 0010                 movea.l    16(a1),a1
[00004d1c] 7e00                      moveq.l    #0,d7
[00004d1e] 3e29 0020                 move.w     32(a1),d7
[00004d22] 2e87                      move.l     d7,(a7)
[00004d24] 4eb9 0000 0d70            jsr        _readev
[00004d2a] 603e                      bra.s      x4b9c_1
[00004d2c] 2e3c 0000 b6e0            move.l     #_stat_hi,d7
[00004d32] 0487 0000 b6b8            subi.l     #_stat_lo,d7
[00004d38] 23c7 0000 b6b8            move.l     d7,_stat_lo
[00004d3e] 2a7c 0000 b6b8            movea.l    #_stat_lo,a5
x4b9c_11:
[00004d44] bbfc 0000 b6e0            cmpa.l     #_stat_hi,a5
[00004d4a] 641e                      bcc.s      x4b9c_1
[00004d4c] 7e00                      moveq.l    #0,d7
[00004d4e] 1e15                      move.b     (a5),d7
[00004d50] 2e87                      move.l     d7,(a7)
[00004d52] 4eb9 0000 4e36            jsr        $00004E36
[00004d58] 4a87                      tst.l      d7
[00004d5a] 660e                      bne.s      x4b9c_1
[00004d5c] 2e0d                      move.l     a5,d7
[00004d5e] 5287                      addq.l     #1,d7
[00004d60] 2a47                      movea.l    d7,a5
[00004d62] 60e0                      bra.s      x4b9c_11
[00004d64] 197c 0006 0142            move.b     #$06,322(a4)
x4b9c_1:
[00004d6a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004d6e] 4e5e                      unlk       a6
[00004d70] 4e75                      rts

_memsg:
[00004d72] 4e56 fffa                 link       a6,#-6
[00004d76] 2e2e 0008                 move.l     8(a6),d7
[00004d7a] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004d80] 0c87 0000 000b            cmpi.l     #$0000000B,d7
[00004d86] 6638                      bne.s      _memsg_1
[00004d88] 2279 0000 0000            movea.l    _pu,a1
[00004d8e] 2269 0010                 movea.l    16(a1),a1
[00004d92] 3d69 0020 fffe            move.w     32(a1),-2(a6)
[00004d98] 2eae 000c                 move.l     12(a6),(a7)
[00004d9c] 7e00                      moveq.l    #0,d7
[00004d9e] 3e2e fffe                 move.w     -2(a6),d7
[00004da2] 2f07                      move.l     d7,-(a7)
[00004da4] 7e00                      moveq.l    #0,d7
[00004da6] 3e2e fffe                 move.w     -2(a6),d7
[00004daa] e087                      asr.l      #8,d7
[00004dac] e587                      asl.l      #2,d7
[00004dae] 2247                      movea.l    d7,a1
[00004db0] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00004db6] 2251                      movea.l    (a1),a1
[00004db8] 2269 0010                 movea.l    16(a1),a1
[00004dbc] 4e91                      jsr        (a1)
[00004dbe] 588f                      addq.l     #4,a7
_memsg_1:
[00004dc0] 4e5e                      unlk       a6
[00004dc2] 4e75                      rts

x4dc4:
[00004dc4] 4e56 0000                 link       a6,#0
[00004dc8] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00004dcc] 2a79 0000 0000            movea.l    _pu,a5
[00004dd2] 2e2e 0008                 move.l     8(a6),d7
[00004dd6] 0287 0000 00ff            andi.l     #$000000FF,d7
[00004ddc] 41f9 0000 b316            lea.l      $00016084,a0
[00004de2] 4ef9 0000 0000            jmp        a~jtab
x4dc4_2:
[00004de8] 4eb9 0000 23c0            jsr        _fetch
[00004dee] 2a07                      move.l     d7,d5
[00004df0] 6d3c                      blt.s      x4dc4_1
[00004df2] 2e85                      move.l     d5,(a7)
[00004df4] 2e2d 0030                 move.l     48(a5),d7
[00004df8] 2f07                      move.l     d7,-(a7)
[00004dfa] 5397                      subq.l     #1,(a7)
[00004dfc] 4eb9 0000 0000            jsr        _ssbyte
[00004e02] 588f                      addq.l     #4,a7
[00004e04] 60e2                      bra.s      x4dc4_2
[00004e06] 42ad 002c                 clr.l      44(a5)
[00004e0a] 6022                      bra.s      x4dc4_1
[00004e0c] 6020                      bra.s      x4dc4_1
[00004e0e] 2279 0000 0000            movea.l    _pu,a1
[00004e14] 2269 0010                 movea.l    16(a1),a1
[00004e18] 7e00                      moveq.l    #0,d7
[00004e1a] 3e29 0020                 move.w     32(a1),d7
[00004e1e] 2e87                      move.l     d7,(a7)
[00004e20] 4eb9 0000 0d9a            jsr        _wridev
[00004e26] 6006                      bra.s      x4dc4_1
[00004e28] 1b7c 0006 0142            move.b     #$06,322(a5)
x4dc4_1:
[00004e2e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00004e32] 4e5e                      unlk       a6
[00004e34] 4e75                      rts

x4e36:
[00004e36] 4e56 fffc                 link       a6,#-4
[00004e3a] 2279 0000 0000            movea.l    _pu,a1
[00004e40] 2e29 0030                 move.l     48(a1),d7
[00004e44] 52b9 0000 b270            addq.l     #1,$00015FDE
[00004e4a] beb9 0000 b270            cmp.l      $00015FDE,d7
[00004e50] 6c16                      bge.s      x4e36_1
[00004e52] 2eae 0008                 move.l     8(a6),(a7)
[00004e56] 4eb9 0000 27d6            jsr        _setch
[00004e5c] 4a87                      tst.l      d7
[00004e5e] 6c04                      bge.s      x4e36_2
[00004e60] 7e01                      moveq.l    #1,d7
[00004e62] 6002                      bra.s      x4e36_3
x4e36_2:
[00004e64] 7e00                      moveq.l    #0,d7
x4e36_3:
[00004e66] 6002                      bra.s      x4e36_4
x4e36_1:
[00004e68] 7e00                      moveq.l    #0,d7
x4e36_4:
[00004e6a] 4e5e                      unlk       a6
[00004e6c] 4e75                      rts

x4e6e:
[00004e6e] 4e56 0000                 link       a6,#0
[00004e72] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00004e76] 2a6e 0008                 movea.l    8(a6),a5
[00004e7a] 2a2e 000c                 move.l     12(a6),d5
x4e6e_4:
[00004e7e] 5385                      subq.l     #1,d5
[00004e80] 6d16                      blt.s      x4e6e_1
[00004e82] 7e00                      moveq.l    #0,d7
[00004e84] 1e15                      move.b     (a5),d7
[00004e86] 2e87                      move.l     d7,(a7)
[00004e88] 4eba ffac                 jsr        $00004E36(pc)
[00004e8c] 4a87                      tst.l      d7
[00004e8e] 6704                      beq.s      x4e6e_2
[00004e90] 7e01                      moveq.l    #1,d7
[00004e92] 6006                      bra.s      x4e6e_3
x4e6e_2:
[00004e94] 528d                      addq.l     #1,a5
[00004e96] 60e6                      bra.s      x4e6e_4
x4e6e_1:
[00004e98] 7e00                      moveq.l    #0,d7
x4e6e_3:
[00004e9a] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00004e9e] 4e5e                      unlk       a6
[00004ea0] 4e75                      rts

x4ea2:
[00004ea2] 4e56 0000                 link       a6,#0
[00004ea6] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00004eaa] 2a6e 0008                 movea.l    8(a6),a5
[00004eae] 2a2e 000c                 move.l     12(a6),d5
x4ea2_4:
[00004eb2] 2e0d                      move.l     a5,d7
[00004eb4] 6716                      beq.s      x4ea2_1
[00004eb6] 2e85                      move.l     d5,(a7)
[00004eb8] 2f0d                      move.l     a5,-(a7)
[00004eba] 4eba ffb2                 jsr        $00004E6E(pc)
[00004ebe] 588f                      addq.l     #4,a7
[00004ec0] 4a87                      tst.l      d7
[00004ec2] 6704                      beq.s      x4ea2_2
[00004ec4] 7e01                      moveq.l    #1,d7
[00004ec6] 6006                      bra.s      x4ea2_3
x4ea2_2:
[00004ec8] 2a55                      movea.l    (a5),a5
[00004eca] 60e6                      bra.s      x4ea2_4
x4ea2_1:
[00004ecc] 7e00                      moveq.l    #0,d7
x4ea2_3:
[00004ece] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00004ed2] 4e5e                      unlk       a6
[00004ed4] 4e75                      rts

x4ed6:
[00004ed6] 4e56 0000                 link       a6,#0
[00004eda] 48e7 8004                 movem.l    d0/a5,-(a7)
[00004ede] 2a6e 0008                 movea.l    8(a6),a5
x4ed6_4:
[00004ee2] 4a15                      tst.b      (a5)
[00004ee4] 6716                      beq.s      x4ed6_1
[00004ee6] 7e00                      moveq.l    #0,d7
[00004ee8] 1e15                      move.b     (a5),d7
[00004eea] 2e87                      move.l     d7,(a7)
[00004eec] 4eba ff48                 jsr        $00004E36(pc)
[00004ef0] 4a87                      tst.l      d7
[00004ef2] 6704                      beq.s      x4ed6_2
[00004ef4] 7e01                      moveq.l    #1,d7
[00004ef6] 600e                      bra.s      x4ed6_3
x4ed6_2:
[00004ef8] 528d                      addq.l     #1,a5
[00004efa] 60e6                      bra.s      x4ed6_4
x4ed6_1:
[00004efc] 4878 000a                 pea.l      ($0000000A).w
[00004f00] 4eba ff34                 jsr        $00004E36(pc)
[00004f04] 588f                      addq.l     #4,a7
x4ed6_3:
[00004f06] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00004f0a] 4e5e                      unlk       a6
[00004f0c] 4e75                      rts

_clkout:
[00004f0e] 4e56 fffc                 link       a6,#-4
[00004f12] 2eae 000c                 move.l     12(a6),(a7)
[00004f16] 2f2e 0008                 move.l     8(a6),-(a7)
[00004f1a] 2f3c 0000 4f8a            move.l     #_trapout,-(a7)
[00004f20] 4eb9 0000 9206            jsr        _timeout
[00004f26] 508f                      addq.l     #8,a7
[00004f28] 4e5e                      unlk       a6
[00004f2a] 4e75                      rts

_dounits:
[00004f2c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00004f30] 4eb9 0000 0000            jsr        _spl7
[00004f36] 2a07                      move.l     d7,d5
[00004f38] 4239 0000 b34a            clr.b      _onflag
[00004f3e] 42b9 0000 b346            clr.l      _onlast
[00004f44] 2a79 0000 b342            movea.l    _onfirst,a5
[00004f4a] 42b9 0000 b342            clr.l      _onfirst
_dounits_2:
[00004f50] 2e0d                      move.l     a5,d7
[00004f52] 6730                      beq.s      _dounits_1
[00004f54] 2e0d                      move.l     a5,d7
[00004f56] 0c87 0000 0001            cmpi.l     #$00000001,d7
[00004f5c] 6726                      beq.s      _dounits_1
[00004f5e] 2855                      movea.l    (a5),a4
[00004f60] 4295                      clr.l      (a5)
[00004f62] 4eb9 0000 0000            jsr        _spl0
[00004f68] 2ead 000c                 move.l     12(a5),(a7)
[00004f6c] 2f2d 0008                 move.l     8(a5),-(a7)
[00004f70] 226d 0004                 movea.l    4(a5),a1
[00004f74] 4e91                      jsr        (a1)
[00004f76] 588f                      addq.l     #4,a7
[00004f78] 2e85                      move.l     d5,(a7)
[00004f7a] 4eb9 0000 0000            jsr        _spl
[00004f80] 2a4c                      movea.l    a4,a5
[00004f82] 60cc                      bra.s      _dounits_2
_dounits_1:
[00004f84] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00004f88] 4e75                      rts

_trapout:
[00004f8a] 4e56 0000                 link       a6,#0
[00004f8e] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00004f92] 2a6e 0008                 movea.l    8(a6),a5
[00004f96] 4eb9 0000 0000            jsr        _spl7
[00004f9c] 2a07                      move.l     d7,d5
[00004f9e] 4a95                      tst.l      (a5)
[00004fa0] 6704                      beq.s      _trapout_1
[00004fa2] 7800                      moveq.l    #0,d4
[00004fa4] 602c                      bra.s      _trapout_2
_trapout_1:
[00004fa6] 7001                      moveq.l    #1,d0
[00004fa8] 2a80                      move.l     d0,(a5)
[00004faa] 4ab9 0000 b346            tst.l      _onlast
[00004fb0] 670a                      beq.s      _trapout_3
[00004fb2] 2279 0000 b346            movea.l    _onlast,a1
[00004fb8] 228d                      move.l     a5,(a1)
[00004fba] 6006                      bra.s      _trapout_4
_trapout_3:
[00004fbc] 23cd 0000 b342            move.l     a5,_onfirst
_trapout_4:
[00004fc2] 23cd 0000 b346            move.l     a5,_onlast
[00004fc8] 13fc 0001 0000 b34a       move.b     #$01,_onflag
[00004fd0] 7801                      moveq.l    #1,d4
_trapout_2:
[00004fd2] 2e85                      move.l     d5,(a7)
[00004fd4] 4eb9 0000 0000            jsr        _spl
[00004fda] 2e04                      move.l     d4,d7
[00004fdc] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00004fe0] 4e5e                      unlk       a6
[00004fe2] 4e75                      rts

_growind:
[00004fe4] 4e56 fffe                 link       a6,#-2
[00004fe8] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00004fec] 2a6e 0008                 movea.l    8(a6),a5
[00004ff0] 4aae 000c                 tst.l      12(a6)
[00004ff4] 660a                      bne.s      _growind_1
[00004ff6] 7e00                      moveq.l    #0,d7
[00004ff8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00004ffc] 4e5e                      unlk       a6
[00004ffe] 4e75                      rts
_growind_1:
[00005000] 2eae 000c                 move.l     12(a6),(a7)
[00005004] 7e00                      moveq.l    #0,d7
[00005006] 3e2d 0016                 move.w     22(a5),d7
[0000500a] 2f07                      move.l     d7,-(a7)
[0000500c] 4eb9 0000 095c            jsr        _readb
[00005012] 588f                      addq.l     #4,a7
[00005014] 2847                      movea.l    d7,a4
[00005016] 2e8c                      move.l     a4,(a7)
[00005018] 4eb9 0000 0c18            jsr        _getaddr
[0000501e] 2c2e 0010                 move.l     16(a6),d6
[00005022] e386                      asl.l      #1,d6
[00005024] de86                      add.l      d6,d7
[00005026] 2e87                      move.l     d7,(a7)
[00005028] 4eb9 0000 26ac            jsr        _lstou
[0000502e] 3d47 fffe                 move.w     d7,-2(a6)
[00005032] 2e8c                      move.l     a4,(a7)
[00005034] 4eb9 0000 0390            jsr        _brelse
[0000503a] 486e fffe                 pea.l      -2(a6)
[0000503e] 7e00                      moveq.l    #0,d7
[00005040] 3e2d 0016                 move.w     22(a5),d7
[00005044] 2f07                      move.l     d7,-(a7)
[00005046] 4eb9 0000 3084            jsr        _grow
[0000504c] 508f                      addq.l     #8,a7
[0000504e] 4a87                      tst.l      d7
[00005050] 6748                      beq.s      _growind_2
[00005052] 2eae 000c                 move.l     12(a6),(a7)
[00005056] 7e00                      moveq.l    #0,d7
[00005058] 3e2d 0016                 move.w     22(a5),d7
[0000505c] 2f07                      move.l     d7,-(a7)
[0000505e] 4eb9 0000 095c            jsr        _readb
[00005064] 588f                      addq.l     #4,a7
[00005066] 2847                      movea.l    d7,a4
[00005068] 7e00                      moveq.l    #0,d7
[0000506a] 3e2e fffe                 move.w     -2(a6),d7
[0000506e] 2e87                      move.l     d7,(a7)
[00005070] 2f0c                      move.l     a4,-(a7)
[00005072] 4eb9 0000 0c18            jsr        _getaddr
[00005078] 588f                      addq.l     #4,a7
[0000507a] 2c2e 0010                 move.l     16(a6),d6
[0000507e] e386                      asl.l      #1,d6
[00005080] de86                      add.l      d6,d7
[00005082] 2f07                      move.l     d7,-(a7)
[00005084] 4eb9 0000 2622            jsr        _itols
[0000508a] 588f                      addq.l     #4,a7
[0000508c] 2e8c                      move.l     a4,(a7)
[0000508e] 4eb9 0000 0a82            jsr        _writdb
[00005094] 08ed 0003 000d            bset       #3,13(a5)
_growind_2:
[0000509a] 7e00                      moveq.l    #0,d7
[0000509c] 3e2e fffe                 move.w     -2(a6),d7
[000050a0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000050a4] 4e5e                      unlk       a6
[000050a6] 4e75                      rts

_maprbl:
[000050a8] 4e56 fff8                 link       a6,#-8
[000050ac] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[000050b0] 2a6e 0008                 movea.l    8(a6),a5
[000050b4] 082d 0001 000d            btst       #1,13(a5)
[000050ba] 6610                      bne.s      _maprbl_1
[000050bc] 2ebc 0000 b354            move.l     #$000160C2,(a7)
[000050c2] 2f0d                      move.l     a5,-(a7)
[000050c4] 4eb9 0000 3470            jsr        _printi
[000050ca] 588f                      addq.l     #4,a7
_maprbl_1:
[000050cc] 226e 0014                 movea.l    20(a6),a1
[000050d0] 4251                      clr.w      (a1)
[000050d2] 226e 0010                 movea.l    16(a6),a1
[000050d6] 4251                      clr.w      (a1)
[000050d8] 43ed 0022                 lea.l      34(a5),a1
[000050dc] 2849                      movea.l    a1,a4
[000050de] 4eb9 0000 250c            jsr        _iocount
[000050e4] 7c09                      moveq.l    #9,d6
[000050e6] eca7                      asr.l      d6,d7
[000050e8] 2e87                      move.l     d7,(a7)
[000050ea] 7e00                      moveq.l    #0,d7
[000050ec] 3e39 0000 b350            move.w     _maxctig,d7
[000050f2] 2f07                      move.l     d7,-(a7)
[000050f4] 4eb9 0000 26f4            jsr        _minu
[000050fa] 588f                      addq.l     #4,a7
[000050fc] 3d47 fffc                 move.w     d7,-4(a6)
[00005100] 0cae 0000 8000 000c       cmpi.l     #$00008000,12(a6)
[00005108] 6d04                      blt.s      _maprbl_2
[0000510a] 7e00                      moveq.l    #0,d7
[0000510c] 6032                      bra.s      _maprbl_3
_maprbl_2:
[0000510e] 082d 0004 001a            btst       #4,26(a5)
[00005114] 6732                      beq.s      _maprbl_4
[00005116] 2e2e 000c                 move.l     12(a6),d7
[0000511a] e087                      asr.l      #8,d7
[0000511c] 2a07                      move.l     d7,d5
[0000511e] 0c85 0000 0007            cmpi.l     #$00000007,d5
[00005124] 6d04                      blt.s      _maprbl_5
[00005126] 7e07                      moveq.l    #7,d7
[00005128] 6002                      bra.s      _maprbl_6
_maprbl_5:
[0000512a] 2e05                      move.l     d5,d7
_maprbl_6:
[0000512c] e387                      asl.l      #1,d7
[0000512e] 2247                      movea.l    d7,a1
[00005130] 45ed 0022                 lea.l      34(a5),a2
[00005134] 3d71 a800 fffe            move.w     0(a1,a2.l),-2(a6)
[0000513a] 6600 00b2                 bne        _maprbl_7
[0000513e] 7e00                      moveq.l    #0,d7
_maprbl_3:
[00005140] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00005144] 4e5e                      unlk       a6
[00005146] 4e75                      rts
_maprbl_4:
[00005148] 0cae 0000 0007 000c       cmpi.l     #$00000007,12(a6)
[00005150] 6e10                      bgt.s      _maprbl_8
[00005152] 2e2e 000c                 move.l     12(a6),d7
[00005156] e387                      asl.l      #1,d7
[00005158] 2247                      movea.l    d7,a1
[0000515a] 3d71 c800 fffe            move.w     0(a1,a4.l),-2(a6)
[00005160] 6604                      bne.s      _maprbl_9
_maprbl_8:
[00005162] 7e00                      moveq.l    #0,d7
[00005164] 60da                      bra.s      _maprbl_3
_maprbl_9:
[00005166] 226e 0010                 movea.l    16(a6),a1
[0000516a] 2e2e 000c                 move.l     12(a6),d7
[0000516e] e387                      asl.l      #1,d7
[00005170] 2447                      movea.l    d7,a2
[00005172] 47ec 0002                 lea.l      2(a4),a3
[00005176] 32b2 b800                 move.w     0(a2,a3.l),(a1)
_maprbl_11:
[0000517a] 4a6e fffc                 tst.w      -4(a6)
[0000517e] 6740                      beq.s      _maprbl_10
[00005180] 0cae 0000 0007 000c       cmpi.l     #$00000007,12(a6)
[00005188] 6c36                      bge.s      _maprbl_10
[0000518a] 226e 0014                 movea.l    20(a6),a1
[0000518e] 5251                      addq.w     #1,(a1)
[00005190] 2e2e 000c                 move.l     12(a6),d7
[00005194] e387                      asl.l      #1,d7
[00005196] 2247                      movea.l    d7,a1
[00005198] 7e00                      moveq.l    #0,d7
[0000519a] 3e31 c800                 move.w     0(a1,a4.l),d7
[0000519e] 5287                      addq.l     #1,d7
[000051a0] 2c2e 000c                 move.l     12(a6),d6
[000051a4] e386                      asl.l      #1,d6
[000051a6] 2246                      movea.l    d6,a1
[000051a8] 45ec 0002                 lea.l      2(a4),a2
[000051ac] 7c00                      moveq.l    #0,d6
[000051ae] 3c31 a800                 move.w     0(a1,a2.l),d6
[000051b2] be86                      cmp.l      d6,d7
[000051b4] 660a                      bne.s      _maprbl_10
[000051b6] 536e fffc                 subq.w     #1,-4(a6)
[000051ba] 52ae 000c                 addq.l     #1,12(a6)
[000051be] 60ba                      bra.s      _maprbl_11
_maprbl_10:
[000051c0] 0cae 0000 0007 000c       cmpi.l     #$00000007,12(a6)
[000051c8] 6c14                      bge.s      _maprbl_12
[000051ca] 2e2e 000c                 move.l     12(a6),d7
[000051ce] e387                      asl.l      #1,d7
[000051d0] 2247                      movea.l    d7,a1
[000051d2] 45ec 0002                 lea.l      2(a4),a2
[000051d6] 7e00                      moveq.l    #0,d7
[000051d8] 3e31 a800                 move.w     0(a1,a2.l),d7
[000051dc] 6002                      bra.s      _maprbl_13
_maprbl_12:
[000051de] 7e00                      moveq.l    #0,d7
_maprbl_13:
[000051e0] 226e 0010                 movea.l    16(a6),a1
[000051e4] 3287                      move.w     d7,(a1)
[000051e6] 7e00                      moveq.l    #0,d7
[000051e8] 3e2e fffe                 move.w     -2(a6),d7
[000051ec] 6056                      bra.s      _maprbl_14
_maprbl_7:
[000051ee] 7e00                      moveq.l    #0,d7
[000051f0] 3e2e fffe                 move.w     -2(a6),d7
[000051f4] 2e87                      move.l     d7,(a7)
[000051f6] 7e00                      moveq.l    #0,d7
[000051f8] 3e2d 0016                 move.w     22(a5),d7
[000051fc] 2f07                      move.l     d7,-(a7)
[000051fe] 4eb9 0000 095c            jsr        _readb
[00005204] 588f                      addq.l     #4,a7
[00005206] 2d47 fff8                 move.l     d7,-8(a6)
[0000520a] 0c85 0000 0007            cmpi.l     #$00000007,d5
[00005210] 6d56                      blt.s      _maprbl_15
[00005212] 2eae fff8                 move.l     -8(a6),(a7)
[00005216] 4eb9 0000 0c18            jsr        _getaddr
[0000521c] 2c05                      move.l     d5,d6
[0000521e] e386                      asl.l      #1,d6
[00005220] 78f2                      moveq.l    #-14,d4
[00005222] d886                      add.l      d6,d4
[00005224] de84                      add.l      d4,d7
[00005226] 2e87                      move.l     d7,(a7)
[00005228] 4eb9 0000 26ac            jsr        _lstou
[0000522e] 3d47 fffe                 move.w     d7,-2(a6)
[00005232] 2eae fff8                 move.l     -8(a6),(a7)
[00005236] 4eb9 0000 0390            jsr        _brelse
[0000523c] 4a6e fffe                 tst.w      -2(a6)
[00005240] 660a                      bne.s      _maprbl_16
[00005242] 7e00                      moveq.l    #0,d7
_maprbl_14:
[00005244] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00005248] 4e5e                      unlk       a6
[0000524a] 4e75                      rts
_maprbl_16:
[0000524c] 7e00                      moveq.l    #0,d7
[0000524e] 3e2e fffe                 move.w     -2(a6),d7
[00005252] 2e87                      move.l     d7,(a7)
[00005254] 7e00                      moveq.l    #0,d7
[00005256] 3e2d 0016                 move.w     22(a5),d7
[0000525a] 2f07                      move.l     d7,-(a7)
[0000525c] 4eb9 0000 095c            jsr        _readb
[00005262] 588f                      addq.l     #4,a7
[00005264] 2d47 fff8                 move.l     d7,-8(a6)
_maprbl_15:
[00005268] 2e2e 000c                 move.l     12(a6),d7
[0000526c] 0287 0000 00ff            andi.l     #$000000FF,d7
[00005272] 2a07                      move.l     d7,d5
[00005274] 4878 0100                 pea.l      ($00000100).w
[00005278] 2f2e fff8                 move.l     -8(a6),-(a7)
[0000527c] 4eb9 0000 0c18            jsr        _getaddr
[00005282] 588f                      addq.l     #4,a7
[00005284] 2f07                      move.l     d7,-(a7)
[00005286] 4eb9 0000 0000            jsr        _bflip
[0000528c] 508f                      addq.l     #8,a7
[0000528e] 2847                      movea.l    d7,a4
[00005290] 2e05                      move.l     d5,d7
[00005292] e387                      asl.l      #1,d7
[00005294] 2247                      movea.l    d7,a1
[00005296] 3d71 c800 fffe            move.w     0(a1,a4.l),-2(a6)
[0000529c] 0c85 0000 00ff            cmpi.l     #$000000FF,d5
[000052a2] 6d08                      blt.s      _maprbl_17
[000052a4] 226e 0010                 movea.l    16(a6),a1
[000052a8] 4251                      clr.w      (a1)
[000052aa] 6050                      bra.s      _maprbl_18
_maprbl_17:
[000052ac] 226e 0010                 movea.l    16(a6),a1
[000052b0] 2e05                      move.l     d5,d7
[000052b2] e387                      asl.l      #1,d7
[000052b4] 2447                      movea.l    d7,a2
[000052b6] 47ec 0002                 lea.l      2(a4),a3
[000052ba] 32b2 b800                 move.w     0(a2,a3.l),(a1)
_maprbl_19:
[000052be] 4a6e fffc                 tst.w      -4(a6)
[000052c2] 6738                      beq.s      _maprbl_18
[000052c4] 0c85 0000 00ff            cmpi.l     #$000000FF,d5
[000052ca] 6c30                      bge.s      _maprbl_18
[000052cc] 226e 0014                 movea.l    20(a6),a1
[000052d0] 5251                      addq.w     #1,(a1)
[000052d2] 2e05                      move.l     d5,d7
[000052d4] e387                      asl.l      #1,d7
[000052d6] 2247                      movea.l    d7,a1
[000052d8] 7e00                      moveq.l    #0,d7
[000052da] 3e31 c800                 move.w     0(a1,a4.l),d7
[000052de] 5287                      addq.l     #1,d7
[000052e0] 2c05                      move.l     d5,d6
[000052e2] e386                      asl.l      #1,d6
[000052e4] 2246                      movea.l    d6,a1
[000052e6] 45ec 0002                 lea.l      2(a4),a2
[000052ea] 7c00                      moveq.l    #0,d6
[000052ec] 3c31 a800                 move.w     0(a1,a2.l),d6
[000052f0] be86                      cmp.l      d6,d7
[000052f2] 6608                      bne.s      _maprbl_18
[000052f4] 536e fffc                 subq.w     #1,-4(a6)
[000052f8] 5285                      addq.l     #1,d5
[000052fa] 60c2                      bra.s      _maprbl_19
_maprbl_18:
[000052fc] 4878 0100                 pea.l      ($00000100).w
[00005300] 2f0c                      move.l     a4,-(a7)
[00005302] 4eb9 0000 0000            jsr        _bflip
[00005308] 508f                      addq.l     #8,a7
[0000530a] 2eae fff8                 move.l     -8(a6),(a7)
[0000530e] 4eb9 0000 0390            jsr        _brelse
[00005314] 2279 0000 0000            movea.l    _pu,a1
[0000531a] 4a29 0142                 tst.b      322(a1)
[0000531e] 6704                      beq.s      _maprbl_20
[00005320] 7e00                      moveq.l    #0,d7
[00005322] 6006                      bra.s      _maprbl_21
_maprbl_20:
[00005324] 7e00                      moveq.l    #0,d7
[00005326] 3e2e fffe                 move.w     -2(a6),d7
_maprbl_21:
[0000532a] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[0000532e] 4e5e                      unlk       a6
[00005330] 4e75                      rts

_mapwbl:
[00005332] 4e56 fffa                 link       a6,#-6
[00005336] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000533a] 2a6e 0008                 movea.l    8(a6),a5
[0000533e] 082d 0001 000d            btst       #1,13(a5)
[00005344] 6610                      bne.s      _mapwbl_1
[00005346] 2ebc 0000 b369            move.l     #$000160D7,(a7)
[0000534c] 2f0d                      move.l     a5,-(a7)
[0000534e] 4eb9 0000 3470            jsr        _printi
[00005354] 588f                      addq.l     #4,a7
_mapwbl_1:
[00005356] 426e fffe                 clr.w      -2(a6)
[0000535a] 0cae 0000 8000 000c       cmpi.l     #$00008000,12(a6)
[00005362] 6d10                      blt.s      _mapwbl_2
[00005364] 2279 0000 0000            movea.l    _pu,a1
[0000536a] 137c 001b 0142            move.b     #$1B,322(a1)
[00005370] 7e00                      moveq.l    #0,d7
[00005372] 6044                      bra.s      _mapwbl_3
_mapwbl_2:
[00005374] 082d 0004 001a            btst       #4,26(a5)
[0000537a] 6600 00dc                 bne        _mapwbl_4
[0000537e] 0cae 0000 0007 000c       cmpi.l     #$00000007,12(a6)
[00005386] 6e38                      bgt.s      _mapwbl_5
[00005388] 2e2e 000c                 move.l     12(a6),d7
[0000538c] e387                      asl.l      #1,d7
[0000538e] 43ed 0022                 lea.l      34(a5),a1
[00005392] 43f1 7800                 lea.l      0(a1,d7.l),a1
[00005396] 2849                      movea.l    a1,a4
[00005398] 2e8c                      move.l     a4,(a7)
[0000539a] 7e00                      moveq.l    #0,d7
[0000539c] 3e2d 0016                 move.w     22(a5),d7
[000053a0] 2f07                      move.l     d7,-(a7)
[000053a2] 4eb9 0000 3084            jsr        _grow
[000053a8] 588f                      addq.l     #4,a7
[000053aa] 4a87                      tst.l      d7
[000053ac] 6706                      beq.s      _mapwbl_6
[000053ae] 08ed 0003 000d            bset       #3,13(a5)
_mapwbl_6:
[000053b4] 7e00                      moveq.l    #0,d7
[000053b6] 3e14                      move.w     (a4),d7
_mapwbl_3:
[000053b8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000053bc] 4e5e                      unlk       a6
[000053be] 4e75                      rts
_mapwbl_5:
[000053c0] 486e fffe                 pea.l      -2(a6)
[000053c4] 7e00                      moveq.l    #0,d7
[000053c6] 3e2d 0016                 move.w     22(a5),d7
[000053ca] 2f07                      move.l     d7,-(a7)
[000053cc] 4eb9 0000 3084            jsr        _grow
[000053d2] 508f                      addq.l     #8,a7
[000053d4] 4a87                      tst.l      d7
[000053d6] 6604                      bne.s      _mapwbl_7
[000053d8] 7e00                      moveq.l    #0,d7
[000053da] 60dc                      bra.s      _mapwbl_3
_mapwbl_7:
[000053dc] 7e00                      moveq.l    #0,d7
[000053de] 3e2e fffe                 move.w     -2(a6),d7
[000053e2] 2e87                      move.l     d7,(a7)
[000053e4] 7e00                      moveq.l    #0,d7
[000053e6] 3e2d 0016                 move.w     22(a5),d7
[000053ea] 2f07                      move.l     d7,-(a7)
[000053ec] 4eb9 0000 095c            jsr        _readb
[000053f2] 588f                      addq.l     #4,a7
[000053f4] 2d47 fffa                 move.l     d7,-6(a6)
[000053f8] 7a08                      moveq.l    #8,d5
_mapwbl_9:
[000053fa] 5385                      subq.l     #1,d5
[000053fc] 6d3e                      blt.s      _mapwbl_8
[000053fe] 2e05                      move.l     d5,d7
[00005400] e387                      asl.l      #1,d7
[00005402] 2247                      movea.l    d7,a1
[00005404] 45ed 0022                 lea.l      34(a5),a2
[00005408] 7e00                      moveq.l    #0,d7
[0000540a] 3e31 a800                 move.w     0(a1,a2.l),d7
[0000540e] 2e87                      move.l     d7,(a7)
[00005410] 2f2e fffa                 move.l     -6(a6),-(a7)
[00005414] 4eb9 0000 0c18            jsr        _getaddr
[0000541a] 588f                      addq.l     #4,a7
[0000541c] 2c05                      move.l     d5,d6
[0000541e] e386                      asl.l      #1,d6
[00005420] de86                      add.l      d6,d7
[00005422] 2f07                      move.l     d7,-(a7)
[00005424] 4eb9 0000 2622            jsr        _itols
[0000542a] 588f                      addq.l     #4,a7
[0000542c] 2e05                      move.l     d5,d7
[0000542e] e387                      asl.l      #1,d7
[00005430] 2247                      movea.l    d7,a1
[00005432] 45ed 0022                 lea.l      34(a5),a2
[00005436] 4271 a800                 clr.w      0(a1,a2.l)
[0000543a] 60be                      bra.s      _mapwbl_9
_mapwbl_8:
[0000543c] 2eae fffa                 move.l     -6(a6),(a7)
[00005440] 4eb9 0000 0390            jsr        _brelse
[00005446] 08ed 0003 000d            bset       #3,13(a5)
[0000544c] 08ed 0004 001a            bset       #4,26(a5)
[00005452] 3b6e fffe 0022            move.w     -2(a6),34(a5)
_mapwbl_4:
[00005458] 2e2e 000c                 move.l     12(a6),d7
[0000545c] e087                      asr.l      #8,d7
[0000545e] 2a07                      move.l     d7,d5
[00005460] 0c85 0000 0007            cmpi.l     #$00000007,d5
[00005466] 6d04                      blt.s      _mapwbl_10
[00005468] 7e07                      moveq.l    #7,d7
[0000546a] 6002                      bra.s      _mapwbl_11
_mapwbl_10:
[0000546c] 2e05                      move.l     d5,d7
_mapwbl_11:
[0000546e] e387                      asl.l      #1,d7
[00005470] 43ed 0022                 lea.l      34(a5),a1
[00005474] 43f1 7800                 lea.l      0(a1,d7.l),a1
[00005478] 2849                      movea.l    a1,a4
[0000547a] 2e8c                      move.l     a4,(a7)
[0000547c] 7e00                      moveq.l    #0,d7
[0000547e] 3e2d 0016                 move.w     22(a5),d7
[00005482] 2f07                      move.l     d7,-(a7)
[00005484] 4eb9 0000 3084            jsr        _grow
[0000548a] 588f                      addq.l     #4,a7
[0000548c] 4a87                      tst.l      d7
[0000548e] 6706                      beq.s      _mapwbl_12
[00005490] 08ed 0003 000d            bset       #3,13(a5)
_mapwbl_12:
[00005496] 0c85 0000 0007            cmpi.l     #$00000007,d5
[0000549c] 6d18                      blt.s      _mapwbl_13
[0000549e] 2e05                      move.l     d5,d7
[000054a0] 2f07                      move.l     d7,-(a7)
[000054a2] 5f97                      subq.l     #7,(a7)
[000054a4] 7e00                      moveq.l    #0,d7
[000054a6] 3e14                      move.w     (a4),d7
[000054a8] 2f07                      move.l     d7,-(a7)
[000054aa] 2f0d                      move.l     a5,-(a7)
[000054ac] 4eba fb36                 jsr        _growind(pc)
[000054b0] 4fef 000c                 lea.l      12(a7),a7
[000054b4] 6004                      bra.s      _mapwbl_14
_mapwbl_13:
[000054b6] 7e00                      moveq.l    #0,d7
[000054b8] 3e14                      move.w     (a4),d7
_mapwbl_14:
[000054ba] 3d47 fffe                 move.w     d7,-2(a6)
[000054be] 2e2e 000c                 move.l     12(a6),d7
[000054c2] 0287 0000 00ff            andi.l     #$000000FF,d7
[000054c8] 2e87                      move.l     d7,(a7)
[000054ca] 7e00                      moveq.l    #0,d7
[000054cc] 3e2e fffe                 move.w     -2(a6),d7
[000054d0] 2f07                      move.l     d7,-(a7)
[000054d2] 2f0d                      move.l     a5,-(a7)
[000054d4] 4eba fb0e                 jsr        _growind(pc)
[000054d8] 508f                      addq.l     #8,a7
[000054da] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000054de] 4e5e                      unlk       a6
[000054e0] 4e75                      rts

_movio:
[000054e2] 4e56 0000                 link       a6,#0
[000054e6] 48e7 8004                 movem.l    d0/a5,-(a7)
[000054ea] 2a79 0000 0000            movea.l    _pu,a5
[000054f0] 4a2d 0143                 tst.b      323(a5)
[000054f4] 6716                      beq.s      _movio_1
[000054f6] 2eae 0010                 move.l     16(a6),(a7)
[000054fa] 2f2e 000c                 move.l     12(a6),-(a7)
[000054fe] 2f2e 0008                 move.l     8(a6),-(a7)
[00005502] 4eb9 0000 2754            jsr        _movbuf
[00005508] 508f                      addq.l     #8,a7
[0000550a] 601e                      bra.s      _movio_2
_movio_1:
[0000550c] 2eae 0010                 move.l     16(a6),(a7)
[00005510] 2f2e 000c                 move.l     12(a6),-(a7)
[00005514] 2f2e 0008                 move.l     8(a6),-(a7)
[00005518] 226e 0014                 movea.l    20(a6),a1
[0000551c] 4e91                      jsr        (a1)
[0000551e] 508f                      addq.l     #8,a7
[00005520] 4a87                      tst.l      d7
[00005522] 6706                      beq.s      _movio_2
[00005524] 1b7c 000e 0142            move.b     #$0E,322(a5)
_movio_2:
[0000552a] 2e2e 0010                 move.l     16(a6),d7
[0000552e] dfad 0028                 add.l      d7,40(a5)
[00005532] 2e2e 0010                 move.l     16(a6),d7
[00005536] 9fad 002c                 sub.l      d7,44(a5)
[0000553a] 2e2e 0010                 move.l     16(a6),d7
[0000553e] dfad 0030                 add.l      d7,48(a5)
[00005542] 1e2d 0142                 move.b     322(a5),d7
[00005546] 4887                      ext.w      d7
[00005548] 48c7                      ext.l      d7
[0000554a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000554e] 4e5e                      unlk       a6
[00005550] 4e75                      rts

_openfifo:
[00005552] 4e56 0000                 link       a6,#0
[00005556] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000555a] 2a6e 0008                 movea.l    8(a6),a5
[0000555e] 286e 000c                 movea.l    12(a6),a4
[00005562] 7a00                      moveq.l    #0,d5
[00005564] 1a2d 0008                 move.b     8(a5),d5
[00005568] 7e00                      moveq.l    #0,d7
[0000556a] 3e2c 001a                 move.w     26(a4),d7
[0000556e] 0287 0000 6249            andi.l     #$00006249,d7
[00005574] 0c87 0000 0200            cmpi.l     #$00000200,d7
[0000557a] 670a                      beq.s      _openfifo_1
[0000557c] 7e00                      moveq.l    #0,d7
[0000557e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005582] 4e5e                      unlk       a6
[00005584] 4e75                      rts
_openfifo_1:
[00005586] 08ed 0007 0008            bset       #7,8(a5)
[0000558c] 08ec 0007 000d            bset       #7,13(a4)
[00005592] 0805 0000                 btst       #0,d5
[00005596] 670a                      beq.s      _openfifo_2
[00005598] 0805 0001                 btst       #1,d5
[0000559c] 6704                      beq.s      _openfifo_2
[0000559e] 526c 000e                 addq.w     #1,14(a4)
_openfifo_2:
[000055a2] 0805 0001                 btst       #1,d5
[000055a6] 674e                      beq.s      _openfifo_3
[000055a8] 4878 0001                 pea.l      ($00000001).w
[000055ac] 2f0c                      move.l     a4,-(a7)
[000055ae] 4eb9 0000 5d72            jsr        _wakep
[000055b4] 508f                      addq.l     #8,a7
[000055b6] 4a6c 0012                 tst.w      18(a4)
[000055ba] 6710                      beq.s      _openfifo_4
[000055bc] 4878 0002                 pea.l      ($00000002).w
[000055c0] 2f0c                      move.l     a4,-(a7)
[000055c2] 4eb9 0000 5d72            jsr        _wakep
[000055c8] 508f                      addq.l     #8,a7
[000055ca] 605e                      bra.s      _openfifo_5
_openfifo_4:
[000055cc] 0805 0002                 btst       #2,d5
[000055d0] 670e                      beq.s      _openfifo_6
[000055d2] 4878 0006                 pea.l      ($00000006).w
[000055d6] 4eb9 0000 2868            jsr        _uerror
[000055dc] 588f                      addq.l     #4,a7
[000055de] 604a                      bra.s      _openfifo_5
_openfifo_6:
[000055e0] 4a6c 0012                 tst.w      18(a4)
[000055e4] 6644                      bne.s      _openfifo_5
[000055e6] 4878 0002                 pea.l      ($00000002).w
[000055ea] 2f0c                      move.l     a4,-(a7)
[000055ec] 4eb9 0000 5d44            jsr        _sleepp
[000055f2] 508f                      addq.l     #8,a7
[000055f4] 60ea                      bra.s      _openfifo_6
_openfifo_3:
[000055f6] 4878 0002                 pea.l      ($00000002).w
[000055fa] 2f0c                      move.l     a4,-(a7)
[000055fc] 4eb9 0000 5d72            jsr        _wakep
[00005602] 508f                      addq.l     #8,a7
[00005604] 0805 0002                 btst       #2,d5
[00005608] 6620                      bne.s      _openfifo_5
_openfifo_7:
[0000560a] 7e00                      moveq.l    #0,d7
[0000560c] 3e2c 000e                 move.w     14(a4),d7
[00005610] 7c00                      moveq.l    #0,d6
[00005612] 3c2c 0012                 move.w     18(a4),d6
[00005616] 9e86                      sub.l      d6,d7
[00005618] 6610                      bne.s      _openfifo_5
[0000561a] 4878 0001                 pea.l      ($00000001).w
[0000561e] 2f0c                      move.l     a4,-(a7)
[00005620] 4eb9 0000 5d44            jsr        _sleepp
[00005626] 508f                      addq.l     #8,a7
[00005628] 60e0                      bra.s      _openfifo_7
_openfifo_5:
[0000562a] 4297                      clr.l      (a7)
[0000562c] 4eb9 0000 2868            jsr        _uerror
[00005632] 4a87                      tst.l      d7
[00005634] 6604                      bne.s      _openfifo_8
[00005636] 7e01                      moveq.l    #1,d7
[00005638] 6002                      bra.s      _openfifo_9
_openfifo_8:
[0000563a] 7e00                      moveq.l    #0,d7
_openfifo_9:
[0000563c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005640] 4e5e                      unlk       a6
[00005642] 4e75                      rts

_rdwr:
[00005644] 4e56 0000                 link       a6,#0
[00005648] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000564c] 2679 0000 0000            movea.l    _pu,a3
[00005652] 226e 0008                 movea.l    8(a6),a1
[00005656] 2e91                      move.l     (a1),(a7)
[00005658] 4eb9 0000 2710            jsr        _mapfd
[0000565e] 2a47                      movea.l    d7,a5
[00005660] 2e0d                      move.l     a5,d7
[00005662] 6712                      beq.s      _rdwr_1
[00005664] 1e2d 0008                 move.b     8(a5),d7
[00005668] 2c2e 000c                 move.l     12(a6),d6
[0000566c] ce06                      and.b      d6,d7
[0000566e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00005674] 660e                      bne.s      _rdwr_2
_rdwr_1:
[00005676] 177c 0009 0142            move.b     #$09,322(a3)
[0000567c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00005680] 4e5e                      unlk       a6
[00005682] 4e75                      rts
_rdwr_2:
[00005684] 2855                      movea.l    (a5),a4
[00005686] 226e 0008                 movea.l    8(a6),a1
[0000568a] 2769 0004 0028            move.l     4(a1),40(a3)
[00005690] 226e 0008                 movea.l    8(a6),a1
[00005694] 2769 0008 002c            move.l     8(a1),44(a3)
[0000569a] 276d 0004 0030            move.l     4(a5),48(a3)
[000056a0] 422b 0143                 clr.b      323(a3)
[000056a4] 4247                      clr.w      d7
[000056a6] 1e2d 0008                 move.b     8(a5),d7
[000056aa] 3747 013a                 move.w     d7,314(a3)
[000056ae] 2e2e 000c                 move.l     12(a6),d7
[000056b2] 08c7 0006                 bset       #6,d7
[000056b6] 08c7 0007                 bset       #7,d7
[000056ba] 7c00                      moveq.l    #0,d6
[000056bc] 1c2d 0008                 move.b     8(a5),d6
[000056c0] ce86                      and.l      d6,d7
[000056c2] 41f9 0000 b384            lea.l      $000160F2,a0
[000056c8] 4ef9 0000 0000            jmp        a~jtab
[000056ce] 7e00                      moveq.l    #0,d7
[000056d0] 3e2c 0022                 move.w     34(a4),d7
[000056d4] 2e87                      move.l     d7,(a7)
[000056d6] 4eb9 0000 0d70            jsr        _readev
[000056dc] 6000 00a4                 bra        _rdwr_3
[000056e0] 4878 fffe                 pea.l      ($FFFFFFFE).w
[000056e4] 2f0c                      move.l     a4,-(a7)
[000056e6] 4eb9 0000 2646            jsr        _locki
[000056ec] 508f                      addq.l     #8,a7
[000056ee] 2e8c                      move.l     a4,(a7)
[000056f0] 4eb9 0000 57a2            jsr        _readi
[000056f6] 2e8c                      move.l     a4,(a7)
[000056f8] 4eb9 0000 278c            jsr        _reli
[000056fe] 6000 0082                 bra        _rdwr_3
[00005702] 7e04                      moveq.l    #4,d7
[00005704] 7c00                      moveq.l    #0,d6
[00005706] 1c2d 0008                 move.b     8(a5),d6
[0000570a] ce86                      and.l      d6,d7
[0000570c] 2e87                      move.l     d7,(a7)
[0000570e] 2f0c                      move.l     a4,-(a7)
[00005710] 4eb9 0000 5aaa            jsr        _readp
[00005716] 588f                      addq.l     #4,a7
[00005718] 6068                      bra.s      _rdwr_3
[0000571a] 7e00                      moveq.l    #0,d7
[0000571c] 3e2c 0022                 move.w     34(a4),d7
[00005720] 2e87                      move.l     d7,(a7)
[00005722] 4eb9 0000 0d9a            jsr        _wridev
[00005728] 6058                      bra.s      _rdwr_3
[0000572a] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000572e] 2f0c                      move.l     a4,-(a7)
[00005730] 4eb9 0000 2646            jsr        _locki
[00005736] 508f                      addq.l     #8,a7
[00005738] 082d 0003 0008            btst       #3,8(a5)
[0000573e] 670c                      beq.s      _rdwr_4
[00005740] 2e8c                      move.l     a4,(a7)
[00005742] 4eb9 0000 2686            jsr        _lsize
[00005748] 2747 0030                 move.l     d7,48(a3)
_rdwr_4:
[0000574c] 2e8c                      move.l     a4,(a7)
[0000574e] 4eb9 0000 5d9a            jsr        _writei
[00005754] 2e8c                      move.l     a4,(a7)
[00005756] 4eb9 0000 278c            jsr        _reli
[0000575c] 6024                      bra.s      _rdwr_3
[0000575e] 7e04                      moveq.l    #4,d7
[00005760] 7c00                      moveq.l    #0,d6
[00005762] 1c2d 0008                 move.b     8(a5),d6
[00005766] ce86                      and.l      d6,d7
[00005768] 2e87                      move.l     d7,(a7)
[0000576a] 2f0c                      move.l     a4,-(a7)
[0000576c] 4eb9 0000 5f22            jsr        _writep
[00005772] 588f                      addq.l     #4,a7
[00005774] 600c                      bra.s      _rdwr_3
[00005776] 2ebc 0000 b37e            move.l     #$000160EC,(a7)
[0000577c] 4eb9 0000 0000            jsr        _panic
_rdwr_3:
[00005782] 2b6b 0030 0004            move.l     48(a3),4(a5)
[00005788] 226e 0008                 movea.l    8(a6),a1
[0000578c] 246e 0008                 movea.l    8(a6),a2
[00005790] 2e2a 0008                 move.l     8(a2),d7
[00005794] 9eab 002c                 sub.l      44(a3),d7
[00005798] 2287                      move.l     d7,(a1)
[0000579a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000579e] 4e5e                      unlk       a6
[000057a0] 4e75                      rts

_readi:
[000057a2] 4e56 ffe2                 link       a6,#-30
[000057a6] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000057aa] 2a6e 0008                 movea.l    8(a6),a5
[000057ae] 2879 0000 0000            movea.l    _pu,a4
[000057b4] 082d 0001 000d            btst       #1,13(a5)
[000057ba] 6610                      bne.s      _readi_1
[000057bc] 2ebc 0000 b3c0            move.l     #$0001612E,(a7)
[000057c2] 2f0d                      move.l     a5,-(a7)
[000057c4] 4eb9 0000 3470            jsr        _printi
[000057ca] 588f                      addq.l     #4,a7
_readi_1:
[000057cc] 52b9 0000 b6cc            addq.l     #1,_nreadi
[000057d2] 2e2c 002c                 move.l     44(a4),d7
[000057d6] 7c09                      moveq.l    #9,d6
[000057d8] ecaf                      lsr.l      d6,d7
[000057da] 3d47 fffc                 move.w     d7,-4(a6)
[000057de] 6608                      bne.s      _readi_2
[000057e0] 52b9 0000 b6d0            addq.l     #1,_nread0
[000057e6] 601e                      bra.s      _readi_3
_readi_2:
[000057e8] 3e2e fffc                 move.w     -4(a6),d7
[000057ec] 0c47 0001                 cmpi.w     #$0001,d7
[000057f0] 6608                      bne.s      _readi_4
[000057f2] 52b9 0000 b6d4            addq.l     #1,_nread1
[000057f8] 600c                      bra.s      _readi_3
_readi_4:
[000057fa] 7e00                      moveq.l    #0,d7
[000057fc] 3e2e fffc                 move.w     -4(a6),d7
[00005800] dfb9 0000 b6d8            add.l      d7,_nreadn
_readi_3:
[00005806] 4aac 002c                 tst.l      44(a4)
[0000580a] 6700 0296                 beq        _readi_5
[0000580e] 4a2c 0142                 tst.b      322(a4)
[00005812] 6600 028e                 bne        _readi_5
[00005816] 2e2c 0030                 move.l     48(a4),d7
[0000581a] 7c09                      moveq.l    #9,d6
[0000581c] eca7                      asr.l      d6,d7
[0000581e] 3d47 fffe                 move.w     d7,-2(a6)
[00005822] 2e2c 0030                 move.l     48(a4),d7
[00005826] 0287 0000 01ff            andi.l     #$000001FF,d7
[0000582c] 2d47 ffe8                 move.l     d7,-24(a6)
[00005830] 2eac 002c                 move.l     44(a4),(a7)
[00005834] 2e3c 0000 0200            move.l     #$00000200,d7
[0000583a] 9eae ffe8                 sub.l      -24(a6),d7
[0000583e] 2f07                      move.l     d7,-(a7)
[00005840] 4eb9 0000 26f4            jsr        _minu
[00005846] 588f                      addq.l     #4,a7
[00005848] 2a07                      move.l     d7,d5
[0000584a] 7e00                      moveq.l    #0,d7
[0000584c] 3e2d 001a                 move.w     26(a5),d7
[00005850] 0287 0000 6000            andi.l     #$00006000,d7
[00005856] 0c87 0000 6000            cmpi.l     #$00006000,d7
[0000585c] 6628                      bne.s      _readi_6
[0000585e] 3d6d 0022 ffe6            move.w     34(a5),-26(a6)
[00005864] 3d6e fffe fff8            move.w     -2(a6),-8(a6)
[0000586a] 7e00                      moveq.l    #0,d7
[0000586c] 3e2e fffe                 move.w     -2(a6),d7
[00005870] 5287                      addq.l     #1,d7
[00005872] 3d47 fffc                 move.w     d7,-4(a6)
[00005876] 2e2c 002c                 move.l     44(a4),d7
[0000587a] 7c09                      moveq.l    #9,d6
[0000587c] ecaf                      lsr.l      d6,d7
[0000587e] 3d47 fffa                 move.w     d7,-6(a6)
[00005882] 6000 007e                 bra.w      _readi_7
_readi_6:
[00005886] 2e8d                      move.l     a5,(a7)
[00005888] 4eb9 0000 2686            jsr        _lsize
[0000588e] 9eac 0030                 sub.l      48(a4),d7
[00005892] 2d47 ffe2                 move.l     d7,-30(a6)
[00005896] 2e2c 0030                 move.l     48(a4),d7
[0000589a] 7c19                      moveq.l    #25,d6
[0000589c] eca7                      asr.l      d6,d7
[0000589e] 6606                      bne.s      _readi_8
[000058a0] 4aae ffe2                 tst.l      -30(a6)
[000058a4] 6e08                      bgt.s      _readi_9
_readi_8:
[000058a6] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000058aa] 4e5e                      unlk       a6
[000058ac] 4e75                      rts
_readi_9:
[000058ae] 2e2e ffe2                 move.l     -30(a6),d7
[000058b2] be85                      cmp.l      d5,d7
[000058b4] 6404                      bcc.s      _readi_10
[000058b6] 2a2e ffe2                 move.l     -30(a6),d5
_readi_10:
[000058ba] 3d6d 0016 ffe6            move.w     22(a5),-26(a6)
[000058c0] 486e fffa                 pea.l      -6(a6)
[000058c4] 486e fffc                 pea.l      -4(a6)
[000058c8] 7e00                      moveq.l    #0,d7
[000058ca] 3e2e fffe                 move.w     -2(a6),d7
[000058ce] 2f07                      move.l     d7,-(a7)
[000058d0] 2f0d                      move.l     a5,-(a7)
[000058d2] 4eba f7d4                 jsr        _maprbl(pc)
[000058d6] 4fef 0010                 lea.l      16(a7),a7
[000058da] 3d47 fff8                 move.w     d7,-8(a6)
[000058de] 2e2e ffe2                 move.l     -30(a6),d7
[000058e2] 7c09                      moveq.l    #9,d6
[000058e4] eca7                      asr.l      d6,d7
[000058e6] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000058ec] 2e87                      move.l     d7,(a7)
[000058ee] 7e00                      moveq.l    #0,d7
[000058f0] 3e2e fffa                 move.w     -6(a6),d7
[000058f4] 2f07                      move.l     d7,-(a7)
[000058f6] 4eb9 0000 26f4            jsr        _minu
[000058fc] 588f                      addq.l     #4,a7
[000058fe] 3d47 fffa                 move.w     d7,-6(a6)
_readi_7:
[00005902] 4a2c 0143                 tst.b      323(a4)
[00005906] 6626                      bne.s      _readi_11
[00005908] 0c85 0000 0200            cmpi.l     #$00000200,d5
[0000590e] 661e                      bne.s      _readi_11
[00005910] 4a6e fffa                 tst.w      -6(a6)
[00005914] 6718                      beq.s      _readi_11
[00005916] 082c 0004 013b            btst       #4,315(a4)
[0000591c] 660c                      bne.s      _readi_12
[0000591e] 3e39 0000 b352            move.w     _minctig,d7
[00005924] be6e fffa                 cmp.w      -6(a6),d7
[00005928] 6204                      bhi.s      _readi_11
_readi_12:
[0000592a] 7e01                      moveq.l    #1,d7
[0000592c] 6002                      bra.s      _readi_13
_readi_11:
[0000592e] 7e00                      moveq.l    #0,d7
_readi_13:
[00005930] 2d47 fff0                 move.l     d7,-16(a6)
[00005934] 526d 0014                 addq.w     #1,20(a5)
[00005938] 42ae fff4                 clr.l      -12(a6)
[0000593c] 4a2c 0142                 tst.b      322(a4)
[00005940] 6708                      beq.s      _readi_14
[00005942] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005946] 4e5e                      unlk       a6
[00005948] 4e75                      rts
_readi_14:
[0000594a] 4a6e fff8                 tst.w      -8(a6)
[0000594e] 662e                      bne.s      _readi_15
[00005950] 7e00                      moveq.l    #0,d7
[00005952] 3e2d 001a                 move.w     26(a5),d7
[00005956] 0287 0000 6000            andi.l     #$00006000,d7
[0000595c] 0c87 0000 6000            cmpi.l     #$00006000,d7
[00005962] 671a                      beq.s      _readi_15
[00005964] 4297                      clr.l      (a7)
[00005966] 4eb9 0000 04f4            jsr        _getblk
[0000596c] 2d47 ffec                 move.l     d7,-20(a6)
[00005970] 2eae ffec                 move.l     -20(a6),(a7)
[00005974] 4eb9 0000 04ca            jsr        _clrbuf
[0000597a] 6000 00a6                 bra        _readi_16
_readi_15:
[0000597e] 4aae fff0                 tst.l      -16(a6)
[00005982] 6760                      beq.s      _readi_17
[00005984] 7e00                      moveq.l    #0,d7
[00005986] 3e2e fffa                 move.w     -6(a6),d7
[0000598a] 2e87                      move.l     d7,(a7)
[0000598c] 7e00                      moveq.l    #0,d7
[0000598e] 3e2e fff8                 move.w     -8(a6),d7
[00005992] 2f07                      move.l     d7,-(a7)
[00005994] 7e00                      moveq.l    #0,d7
[00005996] 3e2e ffe6                 move.w     -26(a6),d7
[0000599a] 2f07                      move.l     d7,-(a7)
[0000599c] 4eb9 0000 0780            jsr        _locctig
[000059a2] 508f                      addq.l     #8,a7
[000059a4] 3d47 fffa                 move.w     d7,-6(a6)
[000059a8] 673a                      beq.s      _readi_17
[000059aa] 7e00                      moveq.l    #0,d7
[000059ac] 3e2e fffa                 move.w     -6(a6),d7
[000059b0] 2e87                      move.l     d7,(a7)
[000059b2] 7e00                      moveq.l    #0,d7
[000059b4] 3e2e fff8                 move.w     -8(a6),d7
[000059b8] 2f07                      move.l     d7,-(a7)
[000059ba] 7e00                      moveq.l    #0,d7
[000059bc] 3e2e ffe6                 move.w     -26(a6),d7
[000059c0] 2f07                      move.l     d7,-(a7)
[000059c2] 4eb9 0000 5b4e            jsr        _readphys
[000059c8] 508f                      addq.l     #8,a7
[000059ca] 2d47 ffec                 move.l     d7,-20(a6)
[000059ce] 6714                      beq.s      _readi_17
[000059d0] 7001                      moveq.l    #1,d0
[000059d2] 2d40 fff4                 move.l     d0,-12(a6)
[000059d6] 7e00                      moveq.l    #0,d7
[000059d8] 3e2e fffa                 move.w     -6(a6),d7
[000059dc] dfb9 0000 b6dc            add.l      d7,_nreadp
[000059e2] 603e                      bra.s      _readi_16
_readi_17:
[000059e4] 4aae ffe8                 tst.l      -24(a6)
[000059e8] 6610                      bne.s      _readi_18
[000059ea] 4aae fff0                 tst.l      -16(a6)
[000059ee] 660a                      bne.s      _readi_18
[000059f0] 3e2d 0014                 move.w     20(a5),d7
[000059f4] be6e fffe                 cmp.w      -2(a6),d7
[000059f8] 6704                      beq.s      _readi_19
_readi_18:
[000059fa] 426e fffc                 clr.w      -4(a6)
_readi_19:
[000059fe] 7e00                      moveq.l    #0,d7
[00005a00] 3e2e fffc                 move.w     -4(a6),d7
[00005a04] 2e87                      move.l     d7,(a7)
[00005a06] 7e00                      moveq.l    #0,d7
[00005a08] 3e2e fff8                 move.w     -8(a6),d7
[00005a0c] 2f07                      move.l     d7,-(a7)
[00005a0e] 7e00                      moveq.l    #0,d7
[00005a10] 3e2e ffe6                 move.w     -26(a6),d7
[00005a14] 2f07                      move.l     d7,-(a7)
[00005a16] 4eb9 0000 08fe            jsr        _readab
[00005a1c] 508f                      addq.l     #8,a7
[00005a1e] 2d47 ffec                 move.l     d7,-20(a6)
_readi_16:
[00005a22] 3b6e fffe 0014            move.w     -2(a6),20(a5)
[00005a28] 082d 0006 000d            btst       #6,13(a5)
[00005a2e] 6716                      beq.s      _readi_20
[00005a30] 2e2c 0030                 move.l     48(a4),d7
[00005a34] 0287 0000 01ff            andi.l     #$000001FF,d7
[00005a3a] 660a                      bne.s      _readi_20
[00005a3c] 226e ffec                 movea.l    -20(a6),a1
[00005a40] 08a9 0002 0011            bclr       #2,17(a1)
_readi_20:
[00005a46] 4aae fff4                 tst.l      -12(a6)
[00005a4a] 6722                      beq.s      _readi_21
[00005a4c] 7e00                      moveq.l    #0,d7
[00005a4e] 3e2e fffa                 move.w     -6(a6),d7
[00005a52] 5387                      subq.l     #1,d7
[00005a54] df6d 0014                 add.w      d7,20(a5)
[00005a58] 4297                      clr.l      (a7)
[00005a5a] 2f2e ffec                 move.l     -20(a6),-(a7)
[00005a5e] 4878 002e                 pea.l      ($0000002E).w
[00005a62] 4eb9 0000 0114            jsr        _free
[00005a68] 508f                      addq.l     #8,a7
[00005a6a] 6000 fd9a                 bra        _readi_3
_readi_21:
[00005a6e] 2ebc 0000 0000            move.l     #_outbuf,(a7)
[00005a74] 2f05                      move.l     d5,-(a7)
[00005a76] 2f2c 0028                 move.l     40(a4),-(a7)
[00005a7a] 2f2e ffec                 move.l     -20(a6),-(a7)
[00005a7e] 4eb9 0000 0c18            jsr        _getaddr
[00005a84] 588f                      addq.l     #4,a7
[00005a86] deae ffe8                 add.l      -24(a6),d7
[00005a8a] 2f07                      move.l     d7,-(a7)
[00005a8c] 4eba fa54                 jsr        _movio(pc)
[00005a90] 4fef 000c                 lea.l      12(a7),a7
[00005a94] 2eae ffec                 move.l     -20(a6),(a7)
[00005a98] 4eb9 0000 0390            jsr        _brelse
[00005a9e] 6000 fd66                 bra        _readi_3
_readi_5:
[00005aa2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005aa6] 4e5e                      unlk       a6
[00005aa8] 4e75                      rts

_readp:
[00005aaa] 4e56 0000                 link       a6,#0
[00005aae] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00005ab2] 2a6e 0008                 movea.l    8(a6),a5
[00005ab6] 2879 0000 0000            movea.l    _pu,a4
_readp_5:
[00005abc] 4878 0006                 pea.l      ($00000006).w
[00005ac0] 2f0d                      move.l     a5,-(a7)
[00005ac2] 4eb9 0000 2646            jsr        _locki
[00005ac8] 508f                      addq.l     #8,a7
[00005aca] 2247                      movea.l    d7,a1
[00005acc] 3e29 0020                 move.w     32(a1),d7
[00005ad0] be6d 0010                 cmp.w      16(a5),d7
[00005ad4] 6658                      bne.s      _readp_1
[00005ad6] 4a6d 0020                 tst.w      32(a5)
[00005ada] 6716                      beq.s      _readp_2
[00005adc] 426d 0010                 clr.w      16(a5)
[00005ae0] 426d 0020                 clr.w      32(a5)
[00005ae4] 4878 0004                 pea.l      ($00000004).w
[00005ae8] 2f0d                      move.l     a5,-(a7)
[00005aea] 4eb9 0000 5d72            jsr        _wakep
[00005af0] 508f                      addq.l     #8,a7
_readp_2:
[00005af2] 2e8d                      move.l     a5,(a7)
[00005af4] 4eb9 0000 278c            jsr        _reli
[00005afa] 7e00                      moveq.l    #0,d7
[00005afc] 3e2d 000e                 move.w     14(a5),d7
[00005b00] 7c00                      moveq.l    #0,d6
[00005b02] 3c2d 0012                 move.w     18(a5),d6
[00005b06] 9e86                      sub.l      d6,d7
[00005b08] 670c                      beq.s      _readp_3
[00005b0a] 4aae 000c                 tst.l      12(a6)
[00005b0e] 670e                      beq.s      _readp_4
[00005b10] 197c 000b 0142            move.b     #$0B,322(a4)
_readp_3:
[00005b16] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00005b1a] 4e5e                      unlk       a6
[00005b1c] 4e75                      rts
_readp_4:
[00005b1e] 4878 0003                 pea.l      ($00000003).w
[00005b22] 2f0d                      move.l     a5,-(a7)
[00005b24] 4eb9 0000 5d44            jsr        _sleepp
[00005b2a] 508f                      addq.l     #8,a7
[00005b2c] 608e                      bra.s      _readp_5
_readp_1:
[00005b2e] 7e00                      moveq.l    #0,d7
[00005b30] 3e2d 0010                 move.w     16(a5),d7
[00005b34] 2947 0030                 move.l     d7,48(a4)
[00005b38] 2e8d                      move.l     a5,(a7)
[00005b3a] 4eba fc66                 jsr        _readi(pc)
[00005b3e] 3b6c 0032 0010            move.w     50(a4),16(a5)
[00005b44] 2e8d                      move.l     a5,(a7)
[00005b46] 4eb9 0000 278c            jsr        _reli
[00005b4c] 60c8                      bra.s      _readp_3

_readphys:
[00005b4e] 4e56 fff4                 link       a6,#-12
[00005b52] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00005b56] 2879 0000 0000            movea.l    _pu,a4
[00005b5c] 4878 002e                 pea.l      ($0000002E).w
[00005b60] 4eb9 0000 00f6            jsr        _alloc
[00005b66] 588f                      addq.l     #4,a7
[00005b68] 2a47                      movea.l    d7,a5
[00005b6a] 2e0d                      move.l     a5,d7
[00005b6c] 6700 00ce                 beq        _readphys_1
[00005b70] 2d6c 0030 fff4            move.l     48(a4),-12(a6)
[00005b76] 2e2e 000c                 move.l     12(a6),d7
[00005b7a] 7c09                      moveq.l    #9,d6
[00005b7c] eda7                      asl.l      d6,d7
[00005b7e] 2947 0030                 move.l     d7,48(a4)
[00005b82] 2e2e 0010                 move.l     16(a6),d7
[00005b86] 7c09                      moveq.l    #9,d6
[00005b88] eda7                      asl.l      d6,d7
[00005b8a] 2d47 fff8                 move.l     d7,-8(a6)
[00005b8e] 2d6c 002c fffc            move.l     44(a4),-4(a6)
[00005b94] 296e fff8 002c            move.l     -8(a6),44(a4)
[00005b9a] 426d 0010                 clr.w      16(a5)
[00005b9e] 4ab9 0000 b34c            tst.l      _Drdwr
[00005ba4] 6740                      beq.s      _readphys_2
[00005ba6] 2eae fff4                 move.l     -12(a6),(a7)
[00005baa] 2f2e fffc                 move.l     -4(a6),-(a7)
[00005bae] 2f2e fff8                 move.l     -8(a6),-(a7)
[00005bb2] 2f3c 0000 b3d4            move.l     #$00016142,-(a7)
[00005bb8] 4eb9 0000 20d6            jsr        _putfmt
[00005bbe] 4fef 000c                 lea.l      12(a7),a7
[00005bc2] 4297                      clr.l      (a7)
[00005bc4] 2f2e 0008                 move.l     8(a6),-(a7)
[00005bc8] 4eb9 0000 204c            jsr        _putdnm
[00005bce] 588f                      addq.l     #4,a7
[00005bd0] 2eae 0010                 move.l     16(a6),(a7)
[00005bd4] 2f2e 000c                 move.l     12(a6),-(a7)
[00005bd8] 2f3c 0000 b3f7            move.l     #$00016165,-(a7)
[00005bde] 4eb9 0000 20d6            jsr        _putfmt
[00005be4] 508f                      addq.l     #8,a7
_readphys_2:
[00005be6] 4878 2010                 pea.l      ($00002010).w
[00005bea] 2f2e 0008                 move.l     8(a6),-(a7)
[00005bee] 2f0d                      move.l     a5,-(a7)
[00005bf0] 3e2e 000a                 move.w     10(a6),d7
[00005bf4] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00005bfa] e087                      asr.l      #8,d7
[00005bfc] e587                      asl.l      #2,d7
[00005bfe] 2247                      movea.l    d7,a1
[00005c00] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00005c06] 2251                      movea.l    (a1),a1
[00005c08] 2f29 0008                 move.l     8(a1),-(a7)
[00005c0c] 4eb9 0000 0000            jsr        _physio
[00005c12] 4fef 0010                 lea.l      16(a7),a7
[00005c16] 4aac 002c                 tst.l      44(a4)
[00005c1a] 6708                      beq.s      _readphys_3
[00005c1c] 197c 0005 0142            move.b     #$05,322(a4)
[00005c22] 6018                      bra.s      _readphys_1
_readphys_3:
[00005c24] 2e2e fff4                 move.l     -12(a6),d7
[00005c28] deae fff8                 add.l      -8(a6),d7
[00005c2c] 2947 0030                 move.l     d7,48(a4)
[00005c30] 2e2e fffc                 move.l     -4(a6),d7
[00005c34] 9eae fff8                 sub.l      -8(a6),d7
[00005c38] 2947 002c                 move.l     d7,44(a4)
_readphys_1:
[00005c3c] 2e0d                      move.l     a5,d7
[00005c3e] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00005c42] 4e5e                      unlk       a6
[00005c44] 4e75                      rts

_seekp:
[00005c46] 4e56 0000                 link       a6,#0
[00005c4a] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00005c4e] 2a6e 0008                 movea.l    8(a6),a5
[00005c52] 2a2e 000c                 move.l     12(a6),d5
[00005c56] 282e 0010                 move.l     16(a6),d4
[00005c5a] 0c84 0000 0003            cmpi.l     #$00000003,d4
[00005c60] 6d06                      blt.s      _seekp_1
[00005c62] 7e09                      moveq.l    #9,d7
[00005c64] efa5                      asl.l      d7,d5
[00005c66] 5784                      subq.l     #3,d4
_seekp_1:
[00005c68] 0c84 0000 0001            cmpi.l     #$00000001,d4
[00005c6e] 6606                      bne.s      _seekp_2
[00005c70] daad 0004                 add.l      4(a5),d5
[00005c74] 6012                      bra.s      _seekp_3
_seekp_2:
[00005c76] 0c84 0000 0002            cmpi.l     #$00000002,d4
[00005c7c] 660a                      bne.s      _seekp_3
[00005c7e] 2e95                      move.l     (a5),(a7)
[00005c80] 4eb9 0000 2686            jsr        _lsize
[00005c86] da87                      add.l      d7,d5
_seekp_3:
[00005c88] 4a85                      tst.l      d5
[00005c8a] 6c04                      bge.s      _seekp_4
[00005c8c] 7e00                      moveq.l    #0,d7
[00005c8e] 6002                      bra.s      _seekp_5
_seekp_4:
[00005c90] 2e05                      move.l     d5,d7
_seekp_5:
[00005c92] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00005c96] 4e5e                      unlk       a6
[00005c98] 4e75                      rts

_setget:
[00005c9a] 4e56 fffe                 link       a6,#-2
[00005c9e] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00005ca2] 2a6e 0008                 movea.l    8(a6),a5
[00005ca6] 2e95                      move.l     (a5),(a7)
[00005ca8] 4eb9 0000 2710            jsr        _mapfd
[00005cae] 2847                      movea.l    d7,a4
[00005cb0] 2e0c                      move.l     a4,d7
[00005cb2] 6700 0088                 beq        _setget_1
[00005cb6] 2654                      movea.l    (a4),a3
[00005cb8] 7e00                      moveq.l    #0,d7
[00005cba] 3e2b 001a                 move.w     26(a3),d7
[00005cbe] 0287 0000 6000            andi.l     #$00006000,d7
[00005cc4] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00005cca] 670e                      beq.s      _setget_2
[00005ccc] 4878 0019                 pea.l      ($00000019).w
[00005cd0] 4eb9 0000 2868            jsr        _uerror
[00005cd6] 588f                      addq.l     #4,a7
[00005cd8] 6062                      bra.s      _setget_1
_setget_2:
[00005cda] 2279 0000 0000            movea.l    _pu,a1
[00005ce0] 236d 0004 0028            move.l     4(a5),40(a1)
[00005ce6] 2279 0000 0000            movea.l    _pu,a1
[00005cec] 70ff                      moveq.l    #-1,d0
[00005cee] 2340 002c                 move.l     d0,44(a1)
[00005cf2] 2279 0000 0000            movea.l    _pu,a1
[00005cf8] 4229 0143                 clr.b      323(a1)
[00005cfc] 2279 0000 0000            movea.l    _pu,a1
[00005d02] 4247                      clr.w      d7
[00005d04] 1e2c 0008                 move.b     8(a4),d7
[00005d08] 3347 013a                 move.w     d7,314(a1)
[00005d0c] 4295                      clr.l      (a5)
[00005d0e] 3d6b 0022 fffe            move.w     34(a3),-2(a6)
[00005d14] 2eae 000c                 move.l     12(a6),(a7)
[00005d18] 7e00                      moveq.l    #0,d7
[00005d1a] 3e2e fffe                 move.w     -2(a6),d7
[00005d1e] 2f07                      move.l     d7,-(a7)
[00005d20] 7e00                      moveq.l    #0,d7
[00005d22] 3e2e fffe                 move.w     -2(a6),d7
[00005d26] e087                      asr.l      #8,d7
[00005d28] e587                      asl.l      #2,d7
[00005d2a] 2247                      movea.l    d7,a1
[00005d2c] d3fc 0000 0000            adda.l     #_chrdevs,a1
[00005d32] 2251                      movea.l    (a1),a1
[00005d34] 2269 0010                 movea.l    16(a1),a1
[00005d38] 4e91                      jsr        (a1)
[00005d3a] 588f                      addq.l     #4,a7
_setget_1:
[00005d3c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00005d40] 4e5e                      unlk       a6
[00005d42] 4e75                      rts

_sleepp:
[00005d44] 4e56 0000                 link       a6,#0
[00005d48] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005d4c] 2a6e 0008                 movea.l    8(a6),a5
[00005d50] 486d 0008                 pea.l      8(a5)
[00005d54] 4878 0006                 pea.l      ($00000006).w
[00005d58] 2e0d                      move.l     a5,d7
[00005d5a] deae 000c                 add.l      12(a6),d7
[00005d5e] 2f07                      move.l     d7,-(a7)
[00005d60] 4eb9 0000 8862            jsr        _sleepl
[00005d66] 4fef 000c                 lea.l      12(a7),a7
[00005d6a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00005d6e] 4e5e                      unlk       a6
[00005d70] 4e75                      rts

_wakep:
[00005d72] 4e56 0000                 link       a6,#0
[00005d76] 48e7 8004                 movem.l    d0/a5,-(a7)
[00005d7a] 2a6e 0008                 movea.l    8(a6),a5
[00005d7e] 486d 0008                 pea.l      8(a5)
[00005d82] 2e0d                      move.l     a5,d7
[00005d84] deae 000c                 add.l      12(a6),d7
[00005d88] 2f07                      move.l     d7,-(a7)
[00005d8a] 4eb9 0000 8b66            jsr        _wakeupl
[00005d90] 508f                      addq.l     #8,a7
[00005d92] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00005d96] 4e5e                      unlk       a6
[00005d98] 4e75                      rts

_writei:
[00005d9a] 4e56 fff0                 link       a6,#-16
[00005d9e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00005da2] 2a6e 0008                 movea.l    8(a6),a5
[00005da6] 2879 0000 0000            movea.l    _pu,a4
[00005dac] 082d 0001 000d            btst       #1,13(a5)
[00005db2] 6610                      bne.s      _writei_1
[00005db4] 2ebc 0000 b407            move.l     #$00016175,(a7)
[00005dba] 2f0d                      move.l     a5,-(a7)
[00005dbc] 4eb9 0000 3470            jsr        _printi
[00005dc2] 588f                      addq.l     #4,a7
_writei_1:
[00005dc4] 4aac 002c                 tst.l      44(a4)
[00005dc8] 6700 0150                 beq        _writei_2
[00005dcc] 4a2c 0142                 tst.b      322(a4)
[00005dd0] 6600 0148                 bne        _writei_2
[00005dd4] 2e2c 0030                 move.l     48(a4),d7
[00005dd8] 7c09                      moveq.l    #9,d6
[00005dda] eca7                      asr.l      d6,d7
[00005ddc] 3d47 fffe                 move.w     d7,-2(a6)
[00005de0] 2e2c 0030                 move.l     48(a4),d7
[00005de4] 0287 0000 01ff            andi.l     #$000001FF,d7
[00005dea] 2d47 fff6                 move.l     d7,-10(a6)
[00005dee] 2eac 002c                 move.l     44(a4),(a7)
[00005df2] 2e3c 0000 0200            move.l     #$00000200,d7
[00005df8] 9eae fff6                 sub.l      -10(a6),d7
[00005dfc] 2f07                      move.l     d7,-(a7)
[00005dfe] 4eb9 0000 26f4            jsr        _minu
[00005e04] 588f                      addq.l     #4,a7
[00005e06] 2a07                      move.l     d7,d5
[00005e08] 7e00                      moveq.l    #0,d7
[00005e0a] 3e2d 001a                 move.w     26(a5),d7
[00005e0e] 0287 0000 6000            andi.l     #$00006000,d7
[00005e14] 0c87 0000 6000            cmpi.l     #$00006000,d7
[00005e1a] 6608                      bne.s      _writei_3
[00005e1c] 3d6d 0022 fff4            move.w     34(a5),-12(a6)
[00005e22] 602e                      bra.s      _writei_4
_writei_3:
[00005e24] 3d6d 0016 fff4            move.w     22(a5),-12(a6)
[00005e2a] 2e2c 0030                 move.l     48(a4),d7
[00005e2e] 7c19                      moveq.l    #25,d6
[00005e30] eca7                      asr.l      d6,d7
[00005e32] 6616                      bne.s      _writei_5
[00005e34] 7e00                      moveq.l    #0,d7
[00005e36] 3e2e fffe                 move.w     -2(a6),d7
[00005e3a] 2e87                      move.l     d7,(a7)
[00005e3c] 2f0d                      move.l     a5,-(a7)
[00005e3e] 4eba f4f2                 jsr        _mapwbl(pc)
[00005e42] 588f                      addq.l     #4,a7
[00005e44] 3d47 fffe                 move.w     d7,-2(a6)
[00005e48] 6608                      bne.s      _writei_4
_writei_5:
[00005e4a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005e4e] 4e5e                      unlk       a6
[00005e50] 4e75                      rts
_writei_4:
[00005e52] 0c85 0000 0200            cmpi.l     #$00000200,d5
[00005e58] 661a                      bne.s      _writei_6
[00005e5a] 7e00                      moveq.l    #0,d7
[00005e5c] 3e2e fffe                 move.w     -2(a6),d7
[00005e60] 2e87                      move.l     d7,(a7)
[00005e62] 7e00                      moveq.l    #0,d7
[00005e64] 3e2e fff4                 move.w     -12(a6),d7
[00005e68] 2f07                      move.l     d7,-(a7)
[00005e6a] 4eb9 0000 04f4            jsr        _getblk
[00005e70] 588f                      addq.l     #4,a7
[00005e72] 6018                      bra.s      _writei_7
_writei_6:
[00005e74] 7e00                      moveq.l    #0,d7
[00005e76] 3e2e fffe                 move.w     -2(a6),d7
[00005e7a] 2e87                      move.l     d7,(a7)
[00005e7c] 7e00                      moveq.l    #0,d7
[00005e7e] 3e2e fff4                 move.w     -12(a6),d7
[00005e82] 2f07                      move.l     d7,-(a7)
[00005e84] 4eb9 0000 095c            jsr        _readb
[00005e8a] 588f                      addq.l     #4,a7
_writei_7:
[00005e8c] 2d47 fffa                 move.l     d7,-6(a6)
[00005e90] 4a2c 0142                 tst.b      322(a4)
[00005e94] 662a                      bne.s      _writei_8
[00005e96] 2ebc 0000 0000            move.l     #_inbuf,(a7)
[00005e9c] 2f05                      move.l     d5,-(a7)
[00005e9e] 2f2e fffa                 move.l     -6(a6),-(a7)
[00005ea2] 4eb9 0000 0c18            jsr        _getaddr
[00005ea8] 588f                      addq.l     #4,a7
[00005eaa] deae fff6                 add.l      -10(a6),d7
[00005eae] 2f07                      move.l     d7,-(a7)
[00005eb0] 2f2c 0028                 move.l     40(a4),-(a7)
[00005eb4] 4eba f62c                 jsr        _movio(pc)
[00005eb8] 4fef 000c                 lea.l      12(a7),a7
[00005ebc] 4a87                      tst.l      d7
[00005ebe] 670c                      beq.s      _writei_9
_writei_8:
[00005ec0] 2eae fffa                 move.l     -6(a6),(a7)
[00005ec4] 4eb9 0000 0390            jsr        _brelse
[00005eca] 604e                      bra.s      _writei_2
_writei_9:
[00005ecc] 2e2c 0030                 move.l     48(a4),d7
[00005ed0] 0287 0000 01ff            andi.l     #$000001FF,d7
[00005ed6] 670c                      beq.s      _writei_10
[00005ed8] 2eae fffa                 move.l     -6(a6),(a7)
[00005edc] 4eb9 0000 0a82            jsr        _writdb
[00005ee2] 600a                      bra.s      _writei_11
_writei_10:
[00005ee4] 2eae fffa                 move.l     -6(a6),(a7)
[00005ee8] 4eb9 0000 0a3e            jsr        _writb
_writei_11:
[00005eee] 08ed 0003 000d            bset       #3,13(a5)
[00005ef4] 2e8d                      move.l     a5,(a7)
[00005ef6] 4eb9 0000 2686            jsr        _lsize
[00005efc] beac 0030                 cmp.l      48(a4),d7
[00005f00] 6c00 fec2                 bge        _writei_1
[00005f04] 2e2c 0030                 move.l     48(a4),d7
[00005f08] 7c10                      moveq.l    #16,d6
[00005f0a] eca7                      asr.l      d6,d7
[00005f0c] 1b47 001f                 move.b     d7,31(a5)
[00005f10] 3b6c 0032 0020            move.w     50(a4),32(a5)
[00005f16] 6000 feac                 bra        _writei_1
_writei_2:
[00005f1a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00005f1e] 4e5e                      unlk       a6
[00005f20] 4e75                      rts

_writep:
[00005f22] 4e56 0000                 link       a6,#0
[00005f26] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00005f2a] 2a6e 0008                 movea.l    8(a6),a5
[00005f2e] 2879 0000 0000            movea.l    _pu,a4
_writep_3:
[00005f34] 4aac 002c                 tst.l      44(a4)
[00005f38] 6700 00da                 beq        _writep_1
[00005f3c] 4a2c 0142                 tst.b      322(a4)
[00005f40] 6600 00d2                 bne        _writep_1
[00005f44] 4878 0006                 pea.l      ($00000006).w
[00005f48] 2f0d                      move.l     a5,-(a7)
[00005f4a] 4eb9 0000 2646            jsr        _locki
[00005f50] 508f                      addq.l     #8,a7
[00005f52] 2247                      movea.l    d7,a1
[00005f54] 4a69 0012                 tst.w      18(a1)
[00005f58] 6620                      bne.s      _writep_2
[00005f5a] 2e8d                      move.l     a5,(a7)
[00005f5c] 4eb9 0000 278c            jsr        _reli
[00005f62] 197c 0020 0142            move.b     #$20,322(a4)
[00005f68] 4878 000d                 pea.l      ($0000000D).w
[00005f6c] 2f2c 0010                 move.l     16(a4),-(a7)
[00005f70] 4eb9 0000 86ce            jsr        _sendsig
[00005f76] 508f                      addq.l     #8,a7
[00005f78] 60ba                      bra.s      _writep_3
_writep_2:
[00005f7a] 2eac 002c                 move.l     44(a4),(a7)
[00005f7e] 2f39 0000 0000            move.l     _maxpipe,-(a7)
[00005f84] 4eb9 0000 26f4            jsr        _minu
[00005f8a] 588f                      addq.l     #4,a7
[00005f8c] 2c39 0000 0000            move.l     _maxpipe,d6
[00005f92] 7800                      moveq.l    #0,d4
[00005f94] 382d 0020                 move.w     32(a5),d4
[00005f98] 9c84                      sub.l      d4,d6
[00005f9a] be86                      cmp.l      d6,d7
[00005f9c] 6258                      bhi.s      _writep_4
[00005f9e] 42ae 000c                 clr.l      12(a6)
[00005fa2] 2a2c 002c                 move.l     44(a4),d5
[00005fa6] 2e85                      move.l     d5,(a7)
[00005fa8] 2e39 0000 0000            move.l     _maxpipe,d7
[00005fae] 7c00                      moveq.l    #0,d6
[00005fb0] 3c2d 0020                 move.w     32(a5),d6
[00005fb4] 9e86                      sub.l      d6,d7
[00005fb6] 2f07                      move.l     d7,-(a7)
[00005fb8] 4eb9 0000 26f4            jsr        _minu
[00005fbe] 588f                      addq.l     #4,a7
[00005fc0] 2947 002c                 move.l     d7,44(a4)
[00005fc4] 9aac 002c                 sub.l      44(a4),d5
[00005fc8] 7e00                      moveq.l    #0,d7
[00005fca] 3e2d 0020                 move.w     32(a5),d7
[00005fce] 2947 0030                 move.l     d7,48(a4)
[00005fd2] 2e8d                      move.l     a5,(a7)
[00005fd4] 4eba fdc4                 jsr        _writei(pc)
[00005fd8] 4878 0003                 pea.l      ($00000003).w
[00005fdc] 2f0d                      move.l     a5,-(a7)
[00005fde] 4eb9 0000 278c            jsr        _reli
[00005fe4] 588f                      addq.l     #4,a7
[00005fe6] 2f07                      move.l     d7,-(a7)
[00005fe8] 4eba fd88                 jsr        _wakep(pc)
[00005fec] 508f                      addq.l     #8,a7
[00005fee] dbac 002c                 add.l      d5,44(a4)
[00005ff2] 6000 ff40                 bra        _writep_3
_writep_4:
[00005ff6] 2e8d                      move.l     a5,(a7)
[00005ff8] 4eb9 0000 278c            jsr        _reli
[00005ffe] 4aae 000c                 tst.l      12(a6)
[00006002] 6610                      bne.s      _writep_1
[00006004] 4878 0004                 pea.l      ($00000004).w
[00006008] 2f0d                      move.l     a5,-(a7)
[0000600a] 4eba fd38                 jsr        _sleepp(pc)
[0000600e] 508f                      addq.l     #8,a7
[00006010] 6000 ff22                 bra        _writep_3
_writep_1:
[00006014] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00006018] 4e5e                      unlk       a6
[0000601a] 4e75                      rts

x601c_2:
[0000601c] 4a39 0000 b422            tst.b      $00016190
[00006022] 671c                      beq.s      x601c_1
[00006024] 13fc 0001 0000 b423       move.b     #$01,$00016191
[0000602c] 4878 fffd                 pea.l      ($FFFFFFFD).w
[00006030] 2f3c 0000 b423            move.l     #$00016191,-(a7)
[00006036] 4eb9 0000 8844            jsr        _sleep
[0000603c] 508f                      addq.l     #8,a7
[0000603e] 60dc                      bra.s      x601c_2
x601c_1:
[00006040] 2279 0000 0000            movea.l    _pu,a1
[00006046] 23e9 0010 0000 b41c       move.l     16(a1),_exproc
[0000604e] 13fc 0001 0000 b422       move.b     #$01,$00016190
[00006056] 4e75                      rts

_exsell:
[00006058] 4e56 fffc                 link       a6,#-4
[0000605c] 2279 0000 0000            movea.l    _pu,a1
[00006062] 2e29 0010                 move.l     16(a1),d7
[00006066] beb9 0000 b41c            cmp.l      _exproc,d7
[0000606c] 6626                      bne.s      _exsell_1
[0000606e] 4a39 0000 b423            tst.b      $00016191
[00006074] 670c                      beq.s      _exsell_2
[00006076] 2ebc 0000 b423            move.l     #$00016191,(a7)
[0000607c] 4eb9 0000 8b4c            jsr        _wakeup
_exsell_2:
[00006082] 4239 0000 b422            clr.b      $00016190
[00006088] 4239 0000 b423            clr.b      $00016191
[0000608e] 42b9 0000 b41c            clr.l      _exproc
_exsell_1:
[00006094] 4e5e                      unlk       a6
[00006096] 4e75                      rts

_syenv:
[00006098] 4e56 ffda                 link       a6,#-38
[0000609c] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000060a0] 2a79 0000 0000            movea.l    _pu,a5
[000060a6] 286d 0010                 movea.l    16(a5),a4
[000060aa] 4297                      clr.l      (a7)
[000060ac] 226e 0008                 movea.l    8(a6),a1
[000060b0] 2f11                      move.l     (a1),-(a7)
[000060b2] 4eb9 0000 3ebe            jsr        _findi
[000060b8] 588f                      addq.l     #4,a7
[000060ba] 2b47 003c                 move.l     d7,60(a5)
[000060be] 6608                      bne.s      _syenv_1
[000060c0] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000060c4] 4e5e                      unlk       a6
[000060c6] 4e75                      rts
_syenv_1:
[000060c8] 7a00                      moveq.l    #0,d5
[000060ca] 3b7c 0010 013a            move.w     #$0010,314(a5)
[000060d0] 7002                      moveq.l    #2,d0
[000060d2] 2d40 ffda                 move.l     d0,-38(a6)
[000060d6] 226e 0008                 movea.l    8(a6),a1
[000060da] 4aa9 000c                 tst.l      12(a1)
[000060de] 6726                      beq.s      _syenv_2
[000060e0] 4878 0020                 pea.l      ($00000020).w
[000060e4] 486e ffda                 pea.l      -38(a6)
[000060e8] 226e 0008                 movea.l    8(a6),a1
[000060ec] 2f29 000c                 move.l     12(a1),-(a7)
[000060f0] 4eb9 0000 0000            jsr        _inbuf
[000060f6] 4fef 000c                 lea.l      12(a7),a7
[000060fa] 4a87                      tst.l      d7
[000060fc] 6708                      beq.s      _syenv_2
[000060fe] 1b7c 000e 0142            move.b     #$0E,322(a5)
[00006104] 6028                      bra.s      _syenv_3
_syenv_2:
[00006106] 4878 0040                 pea.l      ($00000040).w
[0000610a] 2f2d 003c                 move.l     60(a5),-(a7)
[0000610e] 4eb9 0000 2532            jsr        _isacc
[00006114] 508f                      addq.l     #8,a7
[00006116] 4a87                      tst.l      d7
[00006118] 670e                      beq.s      _syenv_4
[0000611a] 2ead 003c                 move.l     60(a5),(a7)
[0000611e] 4eb9 0000 25da            jsr        _isdir
[00006124] 4a87                      tst.l      d7
[00006126] 6716                      beq.s      _syenv_5
_syenv_4:
[00006128] 1b7c 000d 0142            move.b     #$0D,322(a5)
_syenv_3:
[0000612e] 4a2d 0142                 tst.b      322(a5)
[00006132] 6700 013a                 beq        _syenv_6
[00006136] 4eba ff20                 jsr        _exsell(pc)
[0000613a] 6000 0296                 bra        _syenv_7
_syenv_5:
[0000613e] 082e 0006 ffdd            btst       #6,-35(a6)
[00006144] 6706                      beq.s      _syenv_8
[00006146] 2e2e ffea                 move.l     -22(a6),d7
[0000614a] 6002                      bra.s      _syenv_9
_syenv_8:
[0000614c] 7e00                      moveq.l    #0,d7
_syenv_9:
[0000614e] 2e87                      move.l     d7,(a7)
[00006150] 4eb9 0000 6a54            jsr        _xhdr
[00006156] 4a87                      tst.l      d7
[00006158] 67d4                      beq.s      _syenv_3
[0000615a] 226e 0008                 movea.l    8(a6),a1
[0000615e] 2ea9 0008                 move.l     8(a1),(a7)
[00006162] 226e 0008                 movea.l    8(a6),a1
[00006166] 2f29 0004                 move.l     4(a1),-(a7)
[0000616a] 4eb9 0000 673a            jsr        _xgargs
[00006170] 588f                      addq.l     #4,a7
[00006172] 2a07                      move.l     d7,d5
[00006174] 67b8                      beq.s      _syenv_3
[00006176] 4eba fea4                 jsr        $0000601C(pc)
[0000617a] 4878 0020                 pea.l      ($00000020).w
[0000617e] 2f3c 0000 b424            move.l     #$00016192,-(a7)
[00006184] 486e ffda                 pea.l      -38(a6)
[00006188] 4eb9 0000 2754            jsr        _movbuf
[0000618e] 4fef 000c                 lea.l      12(a7),a7
[00006192] 7e03                      moveq.l    #3,d7
[00006194] ceae ffda                 and.l      -38(a6),d7
[00006198] 0c87 0000 0002            cmpi.l     #$00000002,d7
[0000619e] 6704                      beq.s      _syenv_10
[000061a0] 7e01                      moveq.l    #1,d7
[000061a2] 6002                      bra.s      _syenv_11
_syenv_10:
[000061a4] 7e00                      moveq.l    #0,d7
_syenv_11:
[000061a6] 4a87                      tst.l      d7
[000061a8] 6784                      beq.s      _syenv_3
[000061aa] 4297                      clr.l      (a7)
[000061ac] 4eb9 0000 8206            jsr        _makep
[000061b2] 2d47 fffa                 move.l     d7,-6(a6)
[000061b6] 6700 ff76                 beq        _syenv_3
[000061ba] 2279 0000 0000            movea.l    _pu,a1
[000061c0] 2ea9 0004                 move.l     4(a1),(a7)
[000061c4] 4eb9 0000 0000            jsr        _setjmp
[000061ca] 4a87                      tst.l      d7
[000061cc] 6712                      beq.s      _syenv_12
[000061ce] 3e2e fffe                 move.w     -2(a6),d7
[000061d2] 48c7                      ext.l      d7
[000061d4] 2b47 0144                 move.l     d7,324(a5)
[000061d8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000061dc] 4e5e                      unlk       a6
[000061de] 4e75                      rts
_syenv_12:
[000061e0] 226e fffa                 movea.l    -6(a6),a1
[000061e4] 3d69 001c fffe            move.w     28(a1),-2(a6)
[000061ea] 23ee fffa 0000 b41c       move.l     -6(a6),_exproc
[000061f2] 7e00                      moveq.l    #0,d7
[000061f4] 3e39 0000 b420            move.w     _exbase,d7
[000061fa] 2e87                      move.l     d7,(a7)
[000061fc] 4eb9 0000 0000            jsr        _ufork
[00006202] 2a47                      movea.l    d7,a5
[00006204] 2879 0000 b41c            movea.l    _exproc,a4
[0000620a] 2b4c 0010                 move.l     a4,16(a5)
[0000620e] 2e8c                      move.l     a4,(a7)
[00006210] 4eb9 0000 85c6            jsr        _runproc
[00006216] 4aac 0022                 tst.l      34(a4)
[0000621a] 6710                      beq.s      _syenv_13
[0000621c] 43f8 0022                 lea.l      ($00000022).w,a1
[00006220] d3ec 0022                 adda.l     34(a4),a1
[00006224] 5369 0008                 subq.w     #1,8(a1)
[00006228] 42ac 0022                 clr.l      34(a4)
_syenv_13:
[0000622c] 08ec 0006 0010            bset       #6,16(a4)
[00006232] 3979 0000 b420 0008       move.w     _exbase,8(a4)
[0000623a] 3979 0000 0002 000a       move.w     _usize+$00000002,10(a4)
[00006242] 4878 0020                 pea.l      ($00000020).w
[00006246] 486e ffda                 pea.l      -38(a6)
[0000624a] 2f3c 0000 b424            move.l     #$00016192,-(a7)
[00006250] 4eb9 0000 2754            jsr        _movbuf
[00006256] 4fef 000c                 lea.l      12(a7),a7
[0000625a] 42ad 0114                 clr.l      276(a5)
[0000625e] 42ad 0110                 clr.l      272(a5)
[00006262] 42ad 011c                 clr.l      284(a5)
[00006266] 42ad 0118                 clr.l      280(a5)
[0000626a] 6000 fec2                 bra        _syenv_3
_syenv_6:
[0000626e] 4eb9 0000 6466            jsr        _xchk
[00006274] 4a87                      tst.l      d7
[00006276] 6700 015a                 beq        _syenv_7
[0000627a] 022c 00e7 0010            andi.b     #$E7,16(a4)
[00006280] 08ec 0000 0010            bset       #0,16(a4)
[00006286] 4aad 0150                 tst.l      336(a5)
[0000628a] 6736                      beq.s      _syenv_14
[0000628c] 3e39 0000 b420            move.w     _exbase,d7
[00006292] be79 0000 0000            cmp.w      _curbase,d7
[00006298] 6718                      beq.s      _syenv_15
[0000629a] 4297                      clr.l      (a7)
[0000629c] 42a7                      clr.l      -(a7)
[0000629e] 7e00                      moveq.l    #0,d7
[000062a0] 3e39 0000 b420            move.w     _exbase,d7
[000062a6] 2f07                      move.l     d7,-(a7)
[000062a8] 4eb9 0000 0000            jsr        _uinit
[000062ae] 508f                      addq.l     #8,a7
[000062b0] 2a47                      movea.l    d7,a5
_syenv_15:
[000062b2] 4878 0001                 pea.l      ($00000001).w
[000062b6] 2f2d 0150                 move.l     336(a5),-(a7)
[000062ba] 4eb9 0000 7ae0            jsr        _movein
[000062c0] 508f                      addq.l     #8,a7
_syenv_14:
[000062c2] 4aac 0022                 tst.l      34(a4)
[000062c6] 670c                      beq.s      _syenv_16
[000062c8] 226c 0022                 movea.l    34(a4),a1
[000062cc] 0829 0002 0010            btst       #2,16(a1)
[000062d2] 6706                      beq.s      _syenv_17
_syenv_16:
[000062d4] 4a6c 0008                 tst.w      8(a4)
[000062d8] 6672                      bne.s      _syenv_18
_syenv_17:
[000062da] 4a6c 0008                 tst.w      8(a4)
[000062de] 6726                      beq.s      _syenv_19
[000062e0] 2eb9 0000 0000            move.l     _usize,(a7)
[000062e6] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[000062ec] 7e00                      moveq.l    #0,d7
[000062ee] 3e2c 0008                 move.w     8(a4),d7
[000062f2] 2f07                      move.l     d7,-(a7)
[000062f4] 7e00                      moveq.l    #0,d7
[000062f6] 3e2c 000a                 move.w     10(a4),d7
[000062fa] 2f07                      move.l     d7,-(a7)
[000062fc] 4eb9 0000 0000            jsr        _memfree
[00006302] 4fef 000c                 lea.l      12(a7),a7
_syenv_19:
[00006306] 3e39 0000 b420            move.w     _exbase,d7
[0000630c] be79 0000 0000            cmp.w      _curbase,d7
[00006312] 6718                      beq.s      _syenv_20
[00006314] 4297                      clr.l      (a7)
[00006316] 42a7                      clr.l      -(a7)
[00006318] 7e00                      moveq.l    #0,d7
[0000631a] 3e39 0000 b420            move.w     _exbase,d7
[00006320] 2f07                      move.l     d7,-(a7)
[00006322] 4eb9 0000 0000            jsr        _uinit
[00006328] 508f                      addq.l     #8,a7
[0000632a] 2a47                      movea.l    d7,a5
_syenv_20:
[0000632c] 2ebc 0000 b500            move.l     #_outproc,(a7)
[00006332] 4eb9 0000 7b76            jsr        _schp0
[00006338] 4878 0002                 pea.l      ($00000002).w
[0000633c] 2f0c                      move.l     a4,-(a7)
[0000633e] 4eb9 0000 835a            jsr        _offrun
[00006344] 508f                      addq.l     #8,a7
[00006346] 4eb9 0000 8974            jsr        _switchp
_syenv_18:
[0000634c] 022c 00b6 0010            andi.b     #$B6,16(a4)
[00006352] 2ead 0168                 move.l     360(a5),(a7)
[00006356] 2f2d 014c                 move.l     332(a5),-(a7)
[0000635a] 7e00                      moveq.l    #0,d7
[0000635c] 3e2c 0008                 move.w     8(a4),d7
[00006360] 7c00                      moveq.l    #0,d6
[00006362] 3c2c 000a                 move.w     10(a4),d6
[00006366] de86                      add.l      d6,d7
[00006368] 9eb9 0000 0000            sub.l      _usize,d7
[0000636e] 2f07                      move.l     d7,-(a7)
[00006370] 4eb9 0000 0000            jsr        _uinit
[00006376] 508f                      addq.l     #8,a7
[00006378] 2a47                      movea.l    d7,a5
[0000637a] 2ebc 0000 b424            move.l     #$00016192,(a7)
[00006380] 4eb9 0000 75aa            jsr        _xreset
[00006386] 4eba fcd0                 jsr        _exsell(pc)
[0000638a] 2e85                      move.l     d5,(a7)
[0000638c] 4eb9 0000 712e            jsr        _xload
[00006392] 4a87                      tst.l      d7
[00006394] 672e                      beq.s      _syenv_21
[00006396] 08ec 0004 0010            bset       #4,16(a4)
[0000639c] 2ead 0018                 move.l     24(a5),(a7)
[000063a0] 2f2d 014c                 move.l     332(a5),-(a7)
[000063a4] 7e00                      moveq.l    #0,d7
[000063a6] 3e2c 0008                 move.w     8(a4),d7
[000063aa] 7c00                      moveq.l    #0,d6
[000063ac] 3c2c 000a                 move.w     10(a4),d6
[000063b0] de86                      add.l      d6,d7
[000063b2] 9eb9 0000 0000            sub.l      _usize,d7
[000063b8] 2f07                      move.l     d7,-(a7)
[000063ba] 4eb9 0000 0000            jsr        _uinit
[000063c0] 508f                      addq.l     #8,a7
[000063c2] 2a47                      movea.l    d7,a5
_syenv_21:
[000063c4] 2e2d 014c                 move.l     332(a5),d7
[000063c8] 9ead 0014                 sub.l      20(a5),d7
[000063cc] 2947 0036                 move.l     d7,54(a4)
[000063d0] 7a00                      moveq.l    #0,d5
_syenv_7:
[000063d2] 4a85                      tst.l      d5
[000063d4] 6726                      beq.s      _syenv_22
[000063d6] 0cad 0000 0200 0148       cmpi.l     #$00000200,328(a5)
[000063de] 6210                      bhi.s      _syenv_23
[000063e0] 2e85                      move.l     d5,(a7)
[000063e2] 4eb9 0000 0390            jsr        _brelse
[000063e8] 4eb9 0000 03f4            jsr        _bsell
[000063ee] 600c                      bra.s      _syenv_22
_syenv_23:
[000063f0] 4297                      clr.l      (a7)
[000063f2] 2f05                      move.l     d5,-(a7)
[000063f4] 4eb9 0000 3540            jsr        _puti
[000063fa] 588f                      addq.l     #4,a7
_syenv_22:
[000063fc] 4297                      clr.l      (a7)
[000063fe] 2f2d 003c                 move.l     60(a5),-(a7)
[00006402] 4eb9 0000 3540            jsr        _puti
[00006408] 588f                      addq.l     #4,a7
[0000640a] 0c2d 000e 0142            cmpi.b     #$0E,322(a5)
[00006410] 6712                      beq.s      _syenv_24
[00006412] 4a6c 0008                 tst.w      8(a4)
[00006416] 670c                      beq.s      _syenv_24
[00006418] 3e2c 0008                 move.w     8(a4),d7
[0000641c] be79 0000 b420            cmp.w      _exbase,d7
[00006422] 6616                      bne.s      _syenv_25
_syenv_24:
[00006424] 1e2d 0142                 move.b     322(a5),d7
[00006428] 4887                      ext.w      d7
[0000642a] 48c7                      ext.l      d7
[0000642c] e187                      asl.l      #8,d7
[0000642e] 2e87                      move.l     d7,(a7)
[00006430] 42a7                      clr.l      -(a7)
[00006432] 4eb9 0000 a7f0            jsr        _syexit
[00006438] 588f                      addq.l     #4,a7
_syenv_25:
[0000643a] 42ad 0144                 clr.l      324(a5)
[0000643e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00006442] 4e5e                      unlk       a6
[00006444] 4e75                      rts

_syexec:
[00006446] 4e56 fffc                 link       a6,#-4
[0000644a] 226e 0008                 movea.l    8(a6),a1
[0000644e] 42a9 0008                 clr.l      8(a1)
[00006452] 226e 0008                 movea.l    8(a6),a1
[00006456] 42a9 000c                 clr.l      12(a1)
[0000645a] 2eae 0008                 move.l     8(a6),(a7)
[0000645e] 4eba fc38                 jsr        _syenv(pc)
[00006462] 4e5e                      unlk       a6
[00006464] 4e75                      rts

_xchk:
[00006466] 4e56 ffe4                 link       a6,#-28
[0000646a] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000646e] 2a79 0000 0000            movea.l    _pu,a5
[00006474] 286d 0010                 movea.l    16(a5),a4
[00006478] 2e2d 0164                 move.l     356(a5),d7
[0000647c] 0887 0000                 bclr       #0,d7
[00006480] 2d47 fff8                 move.l     d7,-8(a6)
[00006484] 7e02                      moveq.l    #2,d7
[00006486] 7c00                      moveq.l    #0,d6
[00006488] 3c2d 0154                 move.w     340(a5),d6
[0000648c] ce86                      and.l      d6,d7
[0000648e] 2d47 fff4                 move.l     d7,-12(a6)
[00006492] 2e2d 014c                 move.l     332(a5),d7
[00006496] dead 0144                 add.l      324(a5),d7
[0000649a] e587                      asl.l      #2,d7
[0000649c] 7c0c                      moveq.l    #12,d6
[0000649e] dc87                      add.l      d7,d6
[000064a0] dcad 0148                 add.l      328(a5),d6
[000064a4] 7e00                      moveq.l    #0,d7
[000064a6] 5487                      addq.l     #2,d7
[000064a8] dc87                      add.l      d7,d6
[000064aa] 7e00                      moveq.l    #0,d7
[000064ac] 5487                      addq.l     #2,d7
[000064ae] 5387                      subq.l     #1,d7
[000064b0] cead 0148                 and.l      328(a5),d7
[000064b4] 9c87                      sub.l      d7,d6
[000064b6] 2b46 014c                 move.l     d6,332(a5)
[000064ba] 2e2d 014c                 move.l     332(a5),d7
[000064be] dead 015c                 add.l      348(a5),d7
[000064c2] dead 0160                 add.l      352(a5),d7
[000064c6] 2d47 fff0                 move.l     d7,-16(a6)
[000064ca] 4aae fff4                 tst.l      -12(a6)
[000064ce] 6730                      beq.s      _xchk_1
[000064d0] 2d6d 0158 ffec            move.l     344(a5),-20(a6)
[000064d6] 2e2e ffec                 move.l     -20(a6),d7
[000064da] 7c00                      moveq.l    #0,d6
[000064dc] 3c39 0000 0000            move.w     _xmemall,d6
[000064e2] de86                      add.l      d6,d7
[000064e4] 3c39 0000 0000            move.w     _xmemshft,d6
[000064ea] ecaf                      lsr.l      d6,d7
[000064ec] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[000064f2] 2e87                      move.l     d7,(a7)
[000064f4] 4eb9 0000 0000            jsr        _mapsize
[000064fa] 3d47 fffe                 move.w     d7,-2(a6)
[000064fe] 6010                      bra.s      _xchk_2
_xchk_1:
[00006500] 42ae ffec                 clr.l      -20(a6)
[00006504] 426e fffe                 clr.w      -2(a6)
[00006508] 2e2d 0158                 move.l     344(a5),d7
[0000650c] dfae fff0                 add.l      d7,-16(a6)
_xchk_2:
[00006510] 2e2e fff0                 move.l     -16(a6),d7
[00006514] deae fff8                 add.l      -8(a6),d7
[00006518] 7c00                      moveq.l    #0,d6
[0000651a] 3c39 0000 0000            move.w     _xmemall,d6
[00006520] de86                      add.l      d6,d7
[00006522] 3c39 0000 0000            move.w     _xmemshft,d6
[00006528] ecaf                      lsr.l      d6,d7
[0000652a] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00006530] 2e87                      move.l     d7,(a7)
[00006532] 4eb9 0000 0000            jsr        _mapsize
[00006538] deb9 0000 0000            add.l      _usize,d7
[0000653e] 3d47 fffc                 move.w     d7,-4(a6)
[00006542] 7e00                      moveq.l    #0,d7
[00006544] 3e2e fffc                 move.w     -4(a6),d7
[00006548] 7c00                      moveq.l    #0,d6
[0000654a] 3c2e fffe                 move.w     -2(a6),d6
[0000654e] de86                      add.l      d6,d7
[00006550] 7c00                      moveq.l    #0,d6
[00006552] 3c39 0000 0000            move.w     _contig,d6
[00006558] bc87                      cmp.l      d7,d6
[0000655a] 6c00 00ea                 bge        _xchk_3
[0000655e] 082d 0000 0167            btst       #0,359(a5)
[00006564] 6700 00e0                 beq        _xchk_3
[00006568] 3e2e fffe                 move.w     -2(a6),d7
[0000656c] be79 0000 0000            cmp.w      _contig,d7
[00006572] 6400 00d2                 bcc        _xchk_3
[00006576] 7e00                      moveq.l    #0,d7
[00006578] 3e39 0000 0000            move.w     _contig,d7
[0000657e] 7c00                      moveq.l    #0,d6
[00006580] 3c2e fffe                 move.w     -2(a6),d6
[00006584] 9e86                      sub.l      d6,d7
[00006586] 3c39 0000 0000            move.w     _xmemshft,d6
[0000658c] eda7                      asl.l      d6,d7
[0000658e] 2d47 ffe8                 move.l     d7,-24(a6)
[00006592] 2d79 0000 0000 ffe4       move.l     _xaspc,-28(a6)
[0000659a] 4ab9 0000 0000            tst.l      _sepid
[000065a0] 670e                      beq.s      _xchk_4
[000065a2] 4aae fff4                 tst.l      -12(a6)
[000065a6] 6708                      beq.s      _xchk_4
[000065a8] 2e2d 0158                 move.l     344(a5),d7
[000065ac] dfae ffe4                 add.l      d7,-28(a6)
_xchk_4:
[000065b0] 2e2d 016c                 move.l     364(a5),d7
[000065b4] 9fae ffe4                 sub.l      d7,-28(a6)
[000065b8] 2e2e ffe4                 move.l     -28(a6),d7
[000065bc] beae ffe8                 cmp.l      -24(a6),d7
[000065c0] 6406                      bcc.s      _xchk_5
[000065c2] 2d6e ffe4 ffe8            move.l     -28(a6),-24(a6)
_xchk_5:
[000065c8] 2e2e fff0                 move.l     -16(a6),d7
[000065cc] beae ffe8                 cmp.l      -24(a6),d7
[000065d0] 6474                      bcc.s      _xchk_3
[000065d2] 2e2e ffe8                 move.l     -24(a6),d7
[000065d6] 9eae fff0                 sub.l      -16(a6),d7
[000065da] 2d47 fff8                 move.l     d7,-8(a6)
_xchk_6:
[000065de] 7e00                      moveq.l    #0,d7
[000065e0] 3e39 0000 0000            move.w     _xmemall,d7
[000065e6] beae fff8                 cmp.l      -8(a6),d7
[000065ea] 625a                      bhi.s      _xchk_3
[000065ec] 2e2e fff0                 move.l     -16(a6),d7
[000065f0] deae fff8                 add.l      -8(a6),d7
[000065f4] 7c00                      moveq.l    #0,d6
[000065f6] 3c39 0000 0000            move.w     _xmemall,d6
[000065fc] de86                      add.l      d6,d7
[000065fe] 3c39 0000 0000            move.w     _xmemshft,d6
[00006604] ecaf                      lsr.l      d6,d7
[00006606] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[0000660c] 2e87                      move.l     d7,(a7)
[0000660e] 4eb9 0000 0000            jsr        _mapsize
[00006614] deb9 0000 0000            add.l      _usize,d7
[0000661a] 3d47 fffc                 move.w     d7,-4(a6)
[0000661e] 7e00                      moveq.l    #0,d7
[00006620] 3e2e fffe                 move.w     -2(a6),d7
[00006624] 7c00                      moveq.l    #0,d6
[00006626] 3c2e fffc                 move.w     -4(a6),d6
[0000662a] de86                      add.l      d6,d7
[0000662c] 7c00                      moveq.l    #0,d6
[0000662e] 3c39 0000 0000            move.w     _contig,d6
[00006634] be86                      cmp.l      d6,d7
[00006636] 6f0e                      ble.s      _xchk_3
[00006638] 7e00                      moveq.l    #0,d7
[0000663a] 3e39 0000 0000            move.w     _xmemall,d7
[00006640] 9fae fff8                 sub.l      d7,-8(a6)
[00006644] 6098                      bra.s      _xchk_6
_xchk_3:
[00006646] 7e00                      moveq.l    #0,d7
[00006648] 3e2e fffc                 move.w     -4(a6),d7
[0000664c] 9eb9 0000 0000            sub.l      _usize,d7
[00006652] 3c39 0000 0000            move.w     _xmemshft,d6
[00006658] eda7                      asl.l      d6,d7
[0000665a] 2d47 fff0                 move.l     d7,-16(a6)
[0000665e] 4aae fff4                 tst.l      -12(a6)
[00006662] 6608                      bne.s      _xchk_7
[00006664] 2e2d 0158                 move.l     344(a5),d7
[00006668] 9fae fff0                 sub.l      d7,-16(a6)
_xchk_7:
[0000666c] 7e00                      moveq.l    #0,d7
[0000666e] 3e2e fffe                 move.w     -2(a6),d7
[00006672] 7c00                      moveq.l    #0,d6
[00006674] 3c2e fffc                 move.w     -4(a6),d6
[00006678] de86                      add.l      d6,d7
[0000667a] 7c00                      moveq.l    #0,d6
[0000667c] 3c39 0000 0000            move.w     _contig,d6
[00006682] bc87                      cmp.l      d7,d6
[00006684] 6d44                      blt.s      _xchk_8
[00006686] 2e39 0000 0000            move.l     _xaspc,d7
[0000668c] beae fff0                 cmp.l      -16(a6),d7
[00006690] 6538                      bcs.s      _xchk_8
[00006692] 2e2d 0168                 move.l     360(a5),d7
[00006696] dead 0158                 add.l      344(a5),d7
[0000669a] 2c39 0000 0000            move.l     _xaspc,d6
[000066a0] bc87                      cmp.l      d7,d6
[000066a2] 6526                      bcs.s      _xchk_8
[000066a4] 2eae fff0                 move.l     -16(a6),(a7)
[000066a8] 2f2d 016c                 move.l     364(a5),-(a7)
[000066ac] 2f2d 0158                 move.l     344(a5),-(a7)
[000066b0] 2f2d 0168                 move.l     360(a5),-(a7)
[000066b4] 4eb9 0000 8d68            jsr        _olap
[000066ba] 4fef 000c                 lea.l      12(a7),a7
[000066be] 4a87                      tst.l      d7
[000066c0] 6712                      beq.s      _xchk_9
[000066c2] 4ab9 0000 0000            tst.l      _sepid
[000066c8] 660a                      bne.s      _xchk_9
_xchk_8:
[000066ca] 1b7c 000c 0142            move.b     #$0C,322(a5)
[000066d0] 7e00                      moveq.l    #0,d7
[000066d2] 6022                      bra.s      _xchk_10
_xchk_9:
[000066d4] 7e00                      moveq.l    #0,d7
[000066d6] 3e2e fffe                 move.w     -2(a6),d7
[000066da] 2e87                      move.l     d7,(a7)
[000066dc] 7e00                      moveq.l    #0,d7
[000066de] 3e2e fffc                 move.w     -4(a6),d7
[000066e2] 2f07                      move.l     d7,-(a7)
[000066e4] 2f2e fff4                 move.l     -12(a6),-(a7)
[000066e8] 4eb9 0000 6c94            jsr        _xlink
[000066ee] 508f                      addq.l     #8,a7
[000066f0] 4a87                      tst.l      d7
[000066f2] 660a                      bne.s      _xchk_11
[000066f4] 7e00                      moveq.l    #0,d7
_xchk_10:
[000066f6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000066fa] 4e5e                      unlk       a6
[000066fc] 4e75                      rts
_xchk_11:
[000066fe] 2b6d 0168 0018            move.l     360(a5),24(a5)
[00006704] 2b6d 0158 001c            move.l     344(a5),28(a5)
[0000670a] 2b6d 016c 0020            move.l     364(a5),32(a5)
[00006710] 2b6e fff0 0024            move.l     -16(a6),36(a5)
[00006716] 2e2e fff0                 move.l     -16(a6),d7
[0000671a] 9ead 014c                 sub.l      332(a5),d7
[0000671e] dead 0020                 add.l      32(a5),d7
[00006722] 2b47 014c                 move.l     d7,332(a5)
[00006726] 2e2d 016c                 move.l     364(a5),d7
[0000672a] dead 015c                 add.l      348(a5),d7
[0000672e] dead 0160                 add.l      352(a5),d7
[00006732] 2b47 0014                 move.l     d7,20(a5)
[00006736] 7e01                      moveq.l    #1,d7
[00006738] 60bc                      bra.s      _xchk_10

_xgargs:
[0000673a] 4e56 ffe8                 link       a6,#-24
[0000673e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00006742] 2879 0000 0000            movea.l    _pu,a4
[00006748] 4297                      clr.l      (a7)
[0000674a] 4eb9 0000 0358            jsr        _bbuy
[00006750] 4297                      clr.l      (a7)
[00006752] 4eb9 0000 04f4            jsr        _getblk
[00006758] 2d47 fff8                 move.l     d7,-8(a6)
[0000675c] 42ae fff4                 clr.l      -12(a6)
[00006760] 42ae ffec                 clr.l      -20(a6)
[00006764] 7a01                      moveq.l    #1,d5
_xgargs_11:
[00006766] 4aae ffec                 tst.l      -20(a6)
[0000676a] 662a                      bne.s      _xgargs_1
[0000676c] 3d7c 0200 fffe            move.w     #$0200,-2(a6)
[00006772] 2eae fff8                 move.l     -8(a6),(a7)
[00006776] 4eb9 0000 0c18            jsr        _getaddr
[0000677c] 2d47 ffec                 move.l     d7,-20(a6)
[00006780] 2d6e 0008 ffe8            move.l     8(a6),-24(a6)
[00006786] 42ae fff0                 clr.l      -16(a6)
[0000678a] 42ac 014c                 clr.l      332(a4)
[0000678e] 42ac 0144                 clr.l      324(a4)
[00006792] 42ac 0148                 clr.l      328(a4)
_xgargs_1:
[00006796] 4aae ffe8                 tst.l      -24(a6)
[0000679a] 6608                      bne.s      _xgargs_2
[0000679c] 08c5 0002                 bset       #2,d5
[000067a0] 6000 0090                 bra        _xgargs_3
_xgargs_2:
[000067a4] 4a6e fffe                 tst.w      -2(a6)
[000067a8] 6f00 0088                 ble        _xgargs_3
[000067ac] 4aae fff0                 tst.l      -16(a6)
[000067b0] 6712                      beq.s      _xgargs_4
[000067b2] 224d                      movea.l    a5,a1
[000067b4] 528d                      addq.l     #1,a5
[000067b6] 2e89                      move.l     a1,(a7)
[000067b8] 4eb9 0000 0000            jsr        _inbyte
[000067be] 2d47 fff0                 move.l     d7,-16(a6)
[000067c2] 6048                      bra.s      _xgargs_5
_xgargs_4:
[000067c4] 2eae ffe8                 move.l     -24(a6),(a7)
[000067c8] 4eb9 0000 0000            jsr        _inword
[000067ce] 2a47                      movea.l    d7,a5
[000067d0] 2e0d                      move.l     a5,d7
[000067d2] 6606                      bne.s      _xgargs_6
[000067d4] 08c5 0002                 bset       #2,d5
[000067d8] 6058                      bra.s      _xgargs_3
_xgargs_6:
[000067da] 2e0d                      move.l     a5,d7
[000067dc] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000067e2] 6604                      bne.s      _xgargs_7
[000067e4] 7a08                      moveq.l    #8,d5
[000067e6] 604a                      bra.s      _xgargs_3
_xgargs_7:
[000067e8] 58ae ffe8                 addq.l     #4,-24(a6)
[000067ec] 0805 0000                 btst       #0,d5
[000067f0] 6706                      beq.s      _xgargs_8
[000067f2] 52ac 0144                 addq.l     #1,324(a4)
[000067f6] 6004                      bra.s      _xgargs_9
_xgargs_8:
[000067f8] 52ac 014c                 addq.l     #1,332(a4)
_xgargs_9:
[000067fc] 224d                      movea.l    a5,a1
[000067fe] 528d                      addq.l     #1,a5
[00006800] 2e89                      move.l     a1,(a7)
[00006802] 4eb9 0000 0000            jsr        _inbyte
[00006808] 2d47 fff0                 move.l     d7,-16(a6)
_xgargs_5:
[0000680c] 0cae ffff ffff fff0       cmpi.l     #$FFFFFFFF,-16(a6)
[00006814] 6604                      bne.s      _xgargs_10
[00006816] 7a08                      moveq.l    #8,d5
[00006818] 6018                      bra.s      _xgargs_3
_xgargs_10:
[0000681a] 52ac 0148                 addq.l     #1,328(a4)
[0000681e] 226e ffec                 movea.l    -20(a6),a1
[00006822] 52ae ffec                 addq.l     #1,-20(a6)
[00006826] 12ae fff3                 move.b     -13(a6),(a1)
[0000682a] 536e fffe                 subq.w     #1,-2(a6)
[0000682e] 6000 ff74                 bra        _xgargs_2
_xgargs_3:
[00006832] 2e05                      move.l     d5,d7
[00006834] 41f9 0000 b444            lea.l      $000161B2,a0
[0000683a] 4ef9 0000 0000            jmp        a~jtab
[00006840] 2d6e 000c ffe8            move.l     12(a6),-24(a6)
[00006846] 0285 ffff fffa            andi.l     #$FFFFFFFA,d5
[0000684c] 6000 ff18                 bra        _xgargs_11
[00006850] 2e2e fff8                 move.l     -8(a6),d7
[00006854] 605e                      bra.s      _xgargs_12
[00006856] 4aae fff0                 tst.l      -16(a6)
[0000685a] 6616                      bne.s      _xgargs_13
[0000685c] 2eae ffe8                 move.l     -24(a6),(a7)
[00006860] 4eb9 0000 0000            jsr        _inword
[00006866] 4a87                      tst.l      d7
[00006868] 6608                      bne.s      _xgargs_13
[0000686a] 08c5 0002                 bset       #2,d5
[0000686e] 6000 fef6                 bra        _xgargs_11
_xgargs_13:
[00006872] 2eae fff8                 move.l     -8(a6),(a7)
[00006876] 4eb9 0000 0390            jsr        _brelse
[0000687c] 4eb9 0000 03f4            jsr        _bsell
[00006882] 7e00                      moveq.l    #0,d7
[00006884] 3e39 0000 0000            move.w     _pipedev,d7
[0000688a] 2e87                      move.l     d7,(a7)
[0000688c] 4eb9 0000 248c            jsr        _getmount
[00006892] 4a87                      tst.l      d7
[00006894] 6716                      beq.s      _xgargs_14
[00006896] 7e00                      moveq.l    #0,d7
[00006898] 3e39 0000 0000            move.w     _pipedev,d7
[0000689e] 2e87                      move.l     d7,(a7)
[000068a0] 4eb9 0000 3238            jsr        _newi
[000068a6] 2d47 fff4                 move.l     d7,-12(a6)
[000068aa] 6610                      bne.s      _xgargs_15
_xgargs_14:
[000068ac] 197c 0007 0142            move.b     #$07,322(a4)
[000068b2] 7e00                      moveq.l    #0,d7
_xgargs_12:
[000068b4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000068b8] 4e5e                      unlk       a6
[000068ba] 4e75                      rts
_xgargs_15:
[000068bc] 226e fff4                 movea.l    -12(a6),a1
[000068c0] 08e9 0006 000d            bset       #6,13(a1)
[000068c6] 226e fff4                 movea.l    -12(a6),a1
[000068ca] 337c 8000 001a            move.w     #$8000,26(a1)
[000068d0] 226e fff4                 movea.l    -12(a6),a1
[000068d4] 4229 001c                 clr.b      28(a1)
[000068d8] 426e fffc                 clr.w      -4(a6)
[000068dc] 7e00                      moveq.l    #0,d7
[000068de] 3e2e fffc                 move.w     -4(a6),d7
[000068e2] 2e87                      move.l     d7,(a7)
[000068e4] 2f2e fff4                 move.l     -12(a6),-(a7)
[000068e8] 4eb9 0000 69c4            jsr        $000069C4
[000068ee] 588f                      addq.l     #4,a7
[000068f0] 2d47 fff8                 move.l     d7,-8(a6)
[000068f4] 6612                      bne.s      _xgargs_16
[000068f6] 4297                      clr.l      (a7)
[000068f8] 2f2e fff4                 move.l     -12(a6),-(a7)
[000068fc] 4eb9 0000 3540            jsr        _puti
[00006902] 588f                      addq.l     #4,a7
[00006904] 7e00                      moveq.l    #0,d7
[00006906] 60ac                      bra.s      _xgargs_12
_xgargs_16:
[00006908] 42ae ffec                 clr.l      -20(a6)
[0000690c] 7a03                      moveq.l    #3,d5
[0000690e] 6000 fe56                 bra        _xgargs_11
[00006912] 2eae fff8                 move.l     -8(a6),(a7)
[00006916] 4eb9 0000 0a82            jsr        _writdb
[0000691c] 226e fff4                 movea.l    -12(a6),a1
[00006920] 336c 014a 0020            move.w     330(a4),32(a1)
[00006926] 2e2e fff4                 move.l     -12(a6),d7
[0000692a] 6088                      bra.s      _xgargs_12
[0000692c] 2eae fff8                 move.l     -8(a6),(a7)
[00006930] 4eb9 0000 0a82            jsr        _writdb
[00006936] 42ae fff8                 clr.l      -8(a6)
[0000693a] 2e39 0000 0000            move.l     _maxargs,d7
[00006940] beac 0148                 cmp.l      328(a4),d7
[00006944] 6208                      bhi.s      _xgargs_17
[00006946] 197c 0007 0142            move.b     #$07,322(a4)
[0000694c] 6036                      bra.s      _xgargs_18
_xgargs_17:
[0000694e] 526e fffc                 addq.w     #1,-4(a6)
[00006952] 7e00                      moveq.l    #0,d7
[00006954] 3e2e fffc                 move.w     -4(a6),d7
[00006958] 2e87                      move.l     d7,(a7)
[0000695a] 2f2e fff4                 move.l     -12(a6),-(a7)
[0000695e] 4eb9 0000 69c4            jsr        $000069C4
[00006964] 588f                      addq.l     #4,a7
[00006966] 2d47 fff8                 move.l     d7,-8(a6)
[0000696a] 6718                      beq.s      _xgargs_18
[0000696c] 3d7c 0200 fffe            move.w     #$0200,-2(a6)
[00006972] 2eae fff8                 move.l     -8(a6),(a7)
[00006976] 4eb9 0000 0c18            jsr        _getaddr
[0000697c] 2d47 ffec                 move.l     d7,-20(a6)
[00006980] 6000 fde4                 bra        _xgargs_11
_xgargs_18:
[00006984] 4aae fff8                 tst.l      -8(a6)
[00006988] 670a                      beq.s      _xgargs_19
[0000698a] 2eae fff8                 move.l     -8(a6),(a7)
[0000698e] 4eb9 0000 0390            jsr        _brelse
_xgargs_19:
[00006994] 4aae fff4                 tst.l      -12(a6)
[00006998] 6608                      bne.s      _xgargs_20
[0000699a] 4eb9 0000 03f4            jsr        _bsell
[000069a0] 600e                      bra.s      _xgargs_21
_xgargs_20:
[000069a2] 4297                      clr.l      (a7)
[000069a4] 2f2e fff4                 move.l     -12(a6),-(a7)
[000069a8] 4eb9 0000 3540            jsr        _puti
[000069ae] 588f                      addq.l     #4,a7
_xgargs_21:
[000069b0] 197c 000e 0142            move.b     #$0E,322(a4)
[000069b6] 7e00                      moveq.l    #0,d7
[000069b8] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000069bc] 4e5e                      unlk       a6
[000069be] 4e75                      rts

x69c0_1:
[000069c0] 6000 fda4                 bra        x69c0_1
[000069c4] 4e56 0000                 link       a6,#0
[000069c8] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[000069cc] 2a2e 000c                 move.l     12(a6),d5
[000069d0] 2e85                      move.l     d5,(a7)
[000069d2] 2f2e 0008                 move.l     8(a6),-(a7)
[000069d6] 4eb9 0000 5332            jsr        _mapwbl
[000069dc] 588f                      addq.l     #4,a7
[000069de] 2807                      move.l     d7,d4
[000069e0] 6716                      beq.s      x69c0_2
[000069e2] 2e84                      move.l     d4,(a7)
[000069e4] 7e00                      moveq.l    #0,d7
[000069e6] 3e39 0000 0000            move.w     _pipedev,d7
[000069ec] 2f07                      move.l     d7,-(a7)
[000069ee] 4eb9 0000 04f4            jsr        _getblk
[000069f4] 588f                      addq.l     #4,a7
[000069f6] 600e                      bra.s      x69c0_3
x69c0_2:
[000069f8] 2279 0000 0000            movea.l    _pu,a1
[000069fe] 137c 0007 0142            move.b     #$07,322(a1)
[00006a04] 7e00                      moveq.l    #0,d7
x69c0_3:
[00006a06] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00006a0a] 4e5e                      unlk       a6
[00006a0c] 4e75                      rts

_xgbyte:
[00006a0e] 4e56 fff8                 link       a6,#-8
[00006a12] 2eae 0008                 move.l     8(a6),(a7)
[00006a16] 4eb9 0000 0000            jsr        _inbyte
[00006a1c] 2d47 fffc                 move.l     d7,-4(a6)
[00006a20] 0cae ffff ffff fffc       cmpi.l     #$FFFFFFFF,-4(a6)
[00006a28] 6612                      bne.s      _xgbyte_1
[00006a2a] 4878 000e                 pea.l      ($0000000E).w
[00006a2e] 4eb9 0000 2868            jsr        _uerror
[00006a34] 588f                      addq.l     #4,a7
[00006a36] 7eff                      moveq.l    #-1,d7
[00006a38] 4e5e                      unlk       a6
[00006a3a] 4e75                      rts
_xgbyte_1:
[00006a3c] 2e39 0000 0000            move.l     _pu,d7
[00006a42] 2247                      movea.l    d7,a1
[00006a44] 43e9 0144                 lea.l      324(a1),a1
[00006a48] 52a9 0004                 addq.l     #1,4(a1)
[00006a4c] 2e2e fffc                 move.l     -4(a6),d7
[00006a50] 4e5e                      unlk       a6
[00006a52] 4e75                      rts

_xhdr:
[00006a54] 4e56 fffc                 link       a6,#-4
[00006a58] 48e7 9c04                 movem.l    d0/d3-d5/a5,-(a7)
[00006a5c] 2a79 0000 0000            movea.l    _pu,a5
[00006a62] 43ed 0154                 lea.l      340(a5),a1
[00006a66] 2b49 0028                 move.l     a1,40(a5)
[00006a6a] 701c                      moveq.l    #28,d0
[00006a6c] 2b40 002c                 move.l     d0,44(a5)
[00006a70] 42ad 0030                 clr.l      48(a5)
[00006a74] 1b7c 0001 0143            move.b     #$01,323(a5)
[00006a7a] 2ead 003c                 move.l     60(a5),(a7)
[00006a7e] 4eb9 0000 57a2            jsr        _readi
[00006a84] 486d 0154                 pea.l      340(a5)
[00006a88] 4eb9 0000 0000            jsr        _xtrns
[00006a8e] 588f                      addq.l     #4,a7
[00006a90] 7a01                      moveq.l    #1,d5
[00006a92] 7800                      moveq.l    #0,d4
[00006a94] 4ab9 0000 0000            tst.l      _mmupres
[00006a9a] 671c                      beq.s      _xhdr_1
[00006a9c] 7e00                      moveq.l    #0,d7
[00006a9e] 3e2d 0154                 move.w     340(a5),d7
[00006aa2] 7c00                      moveq.l    #0,d6
[00006aa4] 3c39 0000 0000            move.w     _xamask,d6
[00006aaa] ce86                      and.l      d6,d7
[00006aac] 7c00                      moveq.l    #0,d6
[00006aae] 3c39 0000 0000            move.w     _xamagic,d6
[00006ab4] be86                      cmp.l      d6,d7
[00006ab6] 6604                      bne.s      _xhdr_2
_xhdr_1:
[00006ab8] 7e01                      moveq.l    #1,d7
[00006aba] 6002                      bra.s      _xhdr_3
_xhdr_2:
[00006abc] 7e00                      moveq.l    #0,d7
_xhdr_3:
[00006abe] 2607                      move.l     d7,d3
[00006ac0] 7e00                      moveq.l    #0,d7
[00006ac2] 3e2d 0154                 move.w     340(a5),d7
[00006ac6] 7c00                      moveq.l    #0,d6
[00006ac8] 3c39 0000 0000            move.w     _xmask,d6
[00006ace] ce86                      and.l      d6,d7
[00006ad0] 7c00                      moveq.l    #0,d6
[00006ad2] 3c39 0000 0000            move.w     _xmagic,d6
[00006ad8] be86                      cmp.l      d6,d7
[00006ada] 660a                      bne.s      _xhdr_4
[00006adc] 2e2d 0158                 move.l     344(a5),d7
[00006ae0] 8ead 015c                 or.l       348(a5),d7
[00006ae4] 661e                      bne.s      _xhdr_5
_xhdr_4:
[00006ae6] 7a00                      moveq.l    #0,d5
_xhdr_9:
[00006ae8] 4a85                      tst.l      d5
[00006aea] 6760                      beq.s      _xhdr_6
[00006aec] 4a83                      tst.l      d3
[00006aee] 6762                      beq.s      _xhdr_7
[00006af0] 3e2d 0154                 move.w     340(a5),d7
[00006af4] ce79 0000 0000            and.w      _xreloc,d7
[00006afa] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[00006b00] 6750                      beq.s      _xhdr_7
[00006b02] 6048                      bra.s      _xhdr_6
_xhdr_5:
[00006b04] 4ab9 0000 0000            tst.l      _sharetext
[00006b0a] 671e                      beq.s      _xhdr_8
[00006b0c] 4a83                      tst.l      d3
[00006b0e] 661a                      bne.s      _xhdr_8
[00006b10] 4aad 0158                 tst.l      344(a5)
[00006b14] 6714                      beq.s      _xhdr_8
[00006b16] 2e2d 0168                 move.l     360(a5),d7
[00006b1a] 8ead 016c                 or.l       364(a5),d7
[00006b1e] ceb9 0000 0000            and.l      _xpage,d7
[00006b24] 6604                      bne.s      _xhdr_8
[00006b26] 7801                      moveq.l    #1,d4
[00006b28] 60be                      bra.s      _xhdr_9
_xhdr_8:
[00006b2a] 2e2d 0168                 move.l     360(a5),d7
[00006b2e] dead 0158                 add.l      344(a5),d7
[00006b32] bead 016c                 cmp.l      364(a5),d7
[00006b36] 67b0                      beq.s      _xhdr_9
[00006b38] 4ab9 0000 0000            tst.l      _absok
[00006b3e] 6704                      beq.s      _xhdr_10
[00006b40] 7601                      moveq.l    #1,d3
[00006b42] 60a4                      bra.s      _xhdr_9
_xhdr_10:
[00006b44] 4a83                      tst.l      d3
[00006b46] 66a0                      bne.s      _xhdr_9
[00006b48] 7a00                      moveq.l    #0,d5
[00006b4a] 609c                      bra.s      _xhdr_9
_xhdr_6:
[00006b4c] 1b7c 0008 0142            move.b     #$08,322(a5)
_xhdr_7:
[00006b52] 4a83                      tst.l      d3
[00006b54] 6704                      beq.s      _xhdr_11
[00006b56] 7e01                      moveq.l    #1,d7
[00006b58] 6002                      bra.s      _xhdr_12
_xhdr_11:
[00006b5a] 7e00                      moveq.l    #0,d7
_xhdr_12:
[00006b5c] 2d47 fffc                 move.l     d7,-4(a6)
[00006b60] 4a84                      tst.l      d4
[00006b62] 6704                      beq.s      _xhdr_13
[00006b64] 7e02                      moveq.l    #2,d7
[00006b66] 6002                      bra.s      _xhdr_14
_xhdr_13:
[00006b68] 7e00                      moveq.l    #0,d7
_xhdr_14:
[00006b6a] 8eae fffc                 or.l       -4(a6),d7
[00006b6e] 3b47 0154                 move.w     d7,340(a5)
[00006b72] 4aae 0008                 tst.l      8(a6)
[00006b76] 6706                      beq.s      _xhdr_15
[00006b78] 2b6e 0008 0164            move.l     8(a6),356(a5)
_xhdr_15:
[00006b7e] 2e2d 0164                 move.l     356(a5),d7
[00006b82] 0887 0000                 bclr       #0,d7
[00006b86] 4a87                      tst.l      d7
[00006b88] 660a                      bne.s      _xhdr_16
[00006b8a] 2e39 0000 0000            move.l     _stdheap,d7
[00006b90] dfad 0164                 add.l      d7,356(a5)
_xhdr_16:
[00006b94] 4a2d 0142                 tst.b      322(a5)
[00006b98] 6604                      bne.s      _xhdr_17
[00006b9a] 7e01                      moveq.l    #1,d7
[00006b9c] 6002                      bra.s      _xhdr_18
_xhdr_17:
[00006b9e] 7e00                      moveq.l    #0,d7
_xhdr_18:
[00006ba0] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[00006ba4] 4e5e                      unlk       a6
[00006ba6] 4e75                      rts

x6ba8:
[00006ba8] 4e56 fffe                 link       a6,#-2
[00006bac] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00006bb0] 2a6e 0008                 movea.l    8(a6),a5
[00006bb4] 2879 0000 0000            movea.l    _pu,a4
[00006bba] 7e00                      moveq.l    #0,d7
[00006bbc] 3e2d 001a                 move.w     26(a5),d7
[00006bc0] 0287 0000 6000            andi.l     #$00006000,d7
[00006bc6] 0c87 0000 6000            cmpi.l     #$00006000,d7
[00006bcc] 6710                      beq.s      x6ba8_1
[00006bce] 2e8d                      move.l     a5,(a7)
[00006bd0] 4eb9 0000 57a2            jsr        _readi
[00006bd6] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00006bda] 4e5e                      unlk       a6
[00006bdc] 4e75                      rts
x6ba8_1:
[00006bde] 3d6d 0022 fffe            move.w     34(a5),-2(a6)
[00006be4] 2e2c 0030                 move.l     48(a4),d7
[00006be8] 0287 0000 01ff            andi.l     #$000001FF,d7
[00006bee] 2807                      move.l     d7,d4
[00006bf0] 2a2c 002c                 move.l     44(a4),d5
[00006bf4] 4a84                      tst.l      d4
[00006bf6] 6724                      beq.s      x6ba8_2
[00006bf8] 2e3c 0000 0200            move.l     #$00000200,d7
[00006bfe] 9e84                      sub.l      d4,d7
[00006c00] 2e87                      move.l     d7,(a7)
[00006c02] 2f05                      move.l     d5,-(a7)
[00006c04] 4eb9 0000 26f4            jsr        _minu
[00006c0a] 588f                      addq.l     #4,a7
[00006c0c] 2947 002c                 move.l     d7,44(a4)
[00006c10] 9aac 002c                 sub.l      44(a4),d5
[00006c14] 2e8d                      move.l     a5,(a7)
[00006c16] 4eb9 0000 57a2            jsr        _readi
x6ba8_2:
[00006c1c] 4a85                      tst.l      d5
[00006c1e] 675c                      beq.s      x6ba8_3
[00006c20] 2e05                      move.l     d5,d7
[00006c22] 0287 ffff fe00            andi.l     #$FFFFFE00,d7
[00006c28] 2947 002c                 move.l     d7,44(a4)
[00006c2c] 9aac 002c                 sub.l      44(a4),d5
[00006c30] 4aac 002c                 tst.l      44(a4)
[00006c34] 6746                      beq.s      x6ba8_3
[00006c36] 4297                      clr.l      (a7)
[00006c38] 7e00                      moveq.l    #0,d7
[00006c3a] 3e2e fffe                 move.w     -2(a6),d7
[00006c3e] 2f07                      move.l     d7,-(a7)
[00006c40] 4eb9 0000 0416            jsr        _buflush
[00006c46] 588f                      addq.l     #4,a7
[00006c48] 4878 0010                 pea.l      ($00000010).w
[00006c4c] 7e00                      moveq.l    #0,d7
[00006c4e] 3e2e fffe                 move.w     -2(a6),d7
[00006c52] 2f07                      move.l     d7,-(a7)
[00006c54] 2f3c 0000 b47c            move.l     #$000161EA,-(a7)
[00006c5a] 7e00                      moveq.l    #0,d7
[00006c5c] 3e2e fffe                 move.w     -2(a6),d7
[00006c60] e087                      asr.l      #8,d7
[00006c62] e587                      asl.l      #2,d7
[00006c64] 2247                      movea.l    d7,a1
[00006c66] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00006c6c] 2251                      movea.l    (a1),a1
[00006c6e] 2f29 0008                 move.l     8(a1),-(a7)
[00006c72] 4eb9 0000 0000            jsr        _physio
[00006c78] 4fef 0010                 lea.l      16(a7),a7
x6ba8_3:
[00006c7c] 4a85                      tst.l      d5
[00006c7e] 670c                      beq.s      x6ba8_4
[00006c80] 2945 002c                 move.l     d5,44(a4)
[00006c84] 2e8d                      move.l     a5,(a7)
[00006c86] 4eb9 0000 57a2            jsr        _readi
x6ba8_4:
[00006c8c] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00006c90] 4e5e                      unlk       a6
[00006c92] 4e75                      rts

_xlink:
[00006c94] 4e56 ffea                 link       a6,#-22
[00006c98] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[00006c9c] 2679 0000 0000            movea.l    _pu,a3
[00006ca2] 2a2b 003c                 move.l     60(a3),d5
[00006ca6] 3d7c ffff fffa            move.w     #$FFFF,-6(a6)
[00006cac] 2a6b 0010                 movea.l    16(a3),a5
[00006cb0] 99cc                      suba.l     a4,a4
[00006cb2] 426e fffc                 clr.w      -4(a6)
[00006cb6] 4aae 0008                 tst.l      8(a6)
[00006cba] 6700 00ec                 beq        _xlink_1
[00006cbe] 2245                      movea.l    d5,a1
[00006cc0] 43e9 0018                 lea.l      24(a1),a1
[00006cc4] 7e00                      moveq.l    #0,d7
[00006cc6] 3e11                      move.w     (a1),d7
[00006cc8] 2e87                      move.l     d7,(a7)
[00006cca] 2245                      movea.l    d5,a1
[00006ccc] 43e9 0016                 lea.l      22(a1),a1
[00006cd0] 7e00                      moveq.l    #0,d7
[00006cd2] 3e11                      move.w     (a1),d7
[00006cd4] 2f07                      move.l     d7,-(a7)
[00006cd6] 4eb9 0000 31dc            jsr        _ireadb
[00006cdc] 588f                      addq.l     #4,a7
[00006cde] 2807                      move.l     d7,d4
[00006ce0] 2245                      movea.l    d5,a1
[00006ce2] 43e9 0018                 lea.l      24(a1),a1
[00006ce6] 7e00                      moveq.l    #0,d7
[00006ce8] 3e11                      move.w     (a1),d7
[00006cea] 2e87                      move.l     d7,(a7)
[00006cec] 2f04                      move.l     d4,-(a7)
[00006cee] 4eb9 0000 31b4            jsr        _iboff
[00006cf4] 588f                      addq.l     #4,a7
[00006cf6] 2247                      movea.l    d7,a1
[00006cf8] 2ea9 001c                 move.l     28(a1),(a7)
[00006cfc] 4eb9 0000 0000            jsr        _tflip
[00006d02] 2d47 ffea                 move.l     d7,-22(a6)
[00006d06] 2e84                      move.l     d4,(a7)
[00006d08] 4eb9 0000 0390            jsr        _brelse
[00006d0e] 2879 0000 b514            movea.l    _plist,a4
_xlink_4:
[00006d14] 2e0c                      move.l     a4,d7
[00006d16] 6732                      beq.s      _xlink_2
[00006d18] 0c2c 0005 0011            cmpi.b     #$05,17(a4)
[00006d1e] 6626                      bne.s      _xlink_3
[00006d20] 2245                      movea.l    d5,a1
[00006d22] 43e9 0018                 lea.l      24(a1),a1
[00006d26] 3e11                      move.w     (a1),d7
[00006d28] be6c 0024                 cmp.w      36(a4),d7
[00006d2c] 6618                      bne.s      _xlink_3
[00006d2e] 2245                      movea.l    d5,a1
[00006d30] 43e9 0016                 lea.l      22(a1),a1
[00006d34] 3e11                      move.w     (a1),d7
[00006d36] be6c 0022                 cmp.w      34(a4),d7
[00006d3a] 660a                      bne.s      _xlink_3
[00006d3c] 2e2e ffea                 move.l     -22(a6),d7
[00006d40] beac 0026                 cmp.l      38(a4),d7
[00006d44] 6704                      beq.s      _xlink_2
_xlink_3:
[00006d46] 2854                      movea.l    (a4),a4
[00006d48] 60ca                      bra.s      _xlink_4
_xlink_2:
[00006d4a] 2e0c                      move.l     a4,d7
[00006d4c] 6728                      beq.s      _xlink_5
[00006d4e] 526c 002a                 addq.w     #1,42(a4)
[00006d52] 526c 002c                 addq.w     #1,44(a4)
_xlink_7:
[00006d56] 082c 0006 0010            btst       #6,16(a4)
[00006d5c] 6710                      beq.s      _xlink_6
[00006d5e] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00006d62] 2f0c                      move.l     a4,-(a7)
[00006d64] 4eb9 0000 8844            jsr        _sleep
[00006d6a] 508f                      addq.l     #8,a7
[00006d6c] 60e8                      bra.s      _xlink_7
_xlink_6:
[00006d6e] 3d6e fffa fffc            move.w     -6(a6),-4(a6)
[00006d74] 6032                      bra.s      _xlink_1
_xlink_5:
[00006d76] 4297                      clr.l      (a7)
[00006d78] 4878 0044                 pea.l      ($00000044).w
[00006d7c] 4eb9 0000 00f6            jsr        _alloc
[00006d82] 588f                      addq.l     #4,a7
[00006d84] 2847                      movea.l    d7,a4
[00006d86] 2e0c                      move.l     a4,d7
[00006d88] 670e                      beq.s      _xlink_8
[00006d8a] 197c 0005 0011            move.b     #$05,17(a4)
[00006d90] 197c 0048 0010            move.b     #$48,16(a4)
[00006d96] 6010                      bra.s      _xlink_1
_xlink_8:
[00006d98] 177c 000b 0142            move.b     #$0B,322(a3)
[00006d9e] 7e00                      moveq.l    #0,d7
[00006da0] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00006da4] 4e5e                      unlk       a6
[00006da6] 4e75                      rts
_xlink_1:
[00006da8] 2d6d 0022 fff2            move.l     34(a5),-14(a6)
[00006dae] 6714                      beq.s      _xlink_9
[00006db0] 43f8 0022                 lea.l      ($00000022).w,a1
[00006db4] d3ee fff2                 adda.l     -14(a6),a1
[00006db8] 0c69 0001 0008            cmpi.w     #$0001,8(a1)
[00006dbe] 6604                      bne.s      _xlink_9
[00006dc0] 7e01                      moveq.l    #1,d7
[00006dc2] 6002                      bra.s      _xlink_10
_xlink_9:
[00006dc4] 7e00                      moveq.l    #0,d7
_xlink_10:
[00006dc6] 2d47 fff6                 move.l     d7,-10(a6)
[00006dca] 672a                      beq.s      _xlink_11
[00006dcc] 4297                      clr.l      (a7)
[00006dce] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00006dd4] 226e fff2                 movea.l    -14(a6),a1
[00006dd8] 7e00                      moveq.l    #0,d7
[00006dda] 3e29 000c                 move.w     12(a1),d7
[00006dde] 2f07                      move.l     d7,-(a7)
[00006de0] 226e fff2                 movea.l    -14(a6),a1
[00006de4] 7e00                      moveq.l    #0,d7
[00006de6] 3e29 000a                 move.w     10(a1),d7
[00006dea] 2f07                      move.l     d7,-(a7)
[00006dec] 4eb9 0000 0000            jsr        _swpfree
[00006df2] 4fef 000c                 lea.l      12(a7),a7
_xlink_11:
[00006df6] 4a6d 000c                 tst.w      12(a5)
[00006dfa] 6726                      beq.s      _xlink_12
[00006dfc] 2eb9 0000 0000            move.l     _usize,(a7)
[00006e02] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00006e08] 7e00                      moveq.l    #0,d7
[00006e0a] 3e2d 000c                 move.w     12(a5),d7
[00006e0e] 2f07                      move.l     d7,-(a7)
[00006e10] 7e00                      moveq.l    #0,d7
[00006e12] 3e2d 000a                 move.w     10(a5),d7
[00006e16] 2f07                      move.l     d7,-(a7)
[00006e18] 4eb9 0000 0000            jsr        _swpfree
[00006e1e] 4fef 000c                 lea.l      12(a7),a7
_xlink_12:
[00006e22] 4aae 0008                 tst.l      8(a6)
[00006e26] 671e                      beq.s      _xlink_13
[00006e28] 4a6e fffc                 tst.w      -4(a6)
[00006e2c] 6618                      bne.s      _xlink_13
[00006e2e] 4297                      clr.l      (a7)
[00006e30] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00006e36] 2f2e 0010                 move.l     16(a6),-(a7)
[00006e3a] 4eb9 0000 0000            jsr        _swpalloc
[00006e40] 508f                      addq.l     #8,a7
[00006e42] 3d47 fffc                 move.w     d7,-4(a6)
_xlink_13:
[00006e46] 2eb9 0000 0000            move.l     _usize,(a7)
[00006e4c] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00006e52] 2f2e 000c                 move.l     12(a6),-(a7)
[00006e56] 4eb9 0000 0000            jsr        _swpalloc
[00006e5c] 508f                      addq.l     #8,a7
[00006e5e] 3d47 fffe                 move.w     d7,-2(a6)
[00006e62] 6600 00ca                 bne        _xlink_14
[00006e66] 3e2e fffc                 move.w     -4(a6),d7
[00006e6a] be6e fffa                 cmp.w      -6(a6),d7
[00006e6e] 6724                      beq.s      _xlink_15
[00006e70] 4a6e fffc                 tst.w      -4(a6)
[00006e74] 671e                      beq.s      _xlink_15
[00006e76] 4297                      clr.l      (a7)
[00006e78] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00006e7e] 7e00                      moveq.l    #0,d7
[00006e80] 3e2e fffc                 move.w     -4(a6),d7
[00006e84] 2f07                      move.l     d7,-(a7)
[00006e86] 2f2e 0010                 move.l     16(a6),-(a7)
[00006e8a] 4eb9 0000 0000            jsr        _swpfree
[00006e90] 4fef 000c                 lea.l      12(a7),a7
_xlink_15:
[00006e94] 4a6d 000c                 tst.w      12(a5)
[00006e98] 6722                      beq.s      _xlink_16
[00006e9a] 2ebc 0000 b5a8            move.l     #_slist,(a7)
[00006ea0] 7e00                      moveq.l    #0,d7
[00006ea2] 3e2d 000a                 move.w     10(a5),d7
[00006ea6] 2f07                      move.l     d7,-(a7)
[00006ea8] 7e00                      moveq.l    #0,d7
[00006eaa] 3e2d 000c                 move.w     12(a5),d7
[00006eae] 2f07                      move.l     d7,-(a7)
[00006eb0] 4eb9 0000 8f64            jsr        _srealloc
[00006eb6] 508f                      addq.l     #8,a7
[00006eb8] 4a87                      tst.l      d7
[00006eba] 6730                      beq.s      _xlink_17
_xlink_16:
[00006ebc] 4aae fff6                 tst.l      -10(a6)
[00006ec0] 6736                      beq.s      _xlink_18
[00006ec2] 2ebc 0000 b5a8            move.l     #_slist,(a7)
[00006ec8] 226e fff2                 movea.l    -14(a6),a1
[00006ecc] 7e00                      moveq.l    #0,d7
[00006ece] 3e29 000a                 move.w     10(a1),d7
[00006ed2] 2f07                      move.l     d7,-(a7)
[00006ed4] 226e fff2                 movea.l    -14(a6),a1
[00006ed8] 7e00                      moveq.l    #0,d7
[00006eda] 3e29 000c                 move.w     12(a1),d7
[00006ede] 2f07                      move.l     d7,-(a7)
[00006ee0] 4eb9 0000 8f64            jsr        _srealloc
[00006ee6] 508f                      addq.l     #8,a7
[00006ee8] 4a87                      tst.l      d7
[00006eea] 660c                      bne.s      _xlink_18
_xlink_17:
[00006eec] 2ebc 0000 b4aa            move.l     #$00016218,(a7)
[00006ef2] 4eb9 0000 0000            jsr        _panic
_xlink_18:
[00006ef8] 2e0c                      move.l     a4,d7
[00006efa] 6722                      beq.s      _xlink_19
[00006efc] 082c 0006 0010            btst       #6,16(a4)
[00006f02] 6712                      beq.s      _xlink_20
[00006f04] 4297                      clr.l      (a7)
[00006f06] 2f0c                      move.l     a4,-(a7)
[00006f08] 4878 0044                 pea.l      ($00000044).w
[00006f0c] 4eb9 0000 0114            jsr        _free
[00006f12] 508f                      addq.l     #8,a7
[00006f14] 6008                      bra.s      _xlink_19
_xlink_20:
[00006f16] 2e8c                      move.l     a4,(a7)
[00006f18] 4eb9 0000 81c8            jsr        _txtexit
_xlink_19:
[00006f1e] 177c 000b 0142            move.b     #$0B,322(a3)
[00006f24] 7e00                      moveq.l    #0,d7
[00006f26] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00006f2a] 4e5e                      unlk       a6
[00006f2c] 4e75                      rts
_xlink_14:
[00006f2e] 4aae fff6                 tst.l      -10(a6)
[00006f32] 673e                      beq.s      _xlink_21
[00006f34] 226e fff2                 movea.l    -14(a6),a1
[00006f38] 0829 0002 0010            btst       #2,16(a1)
[00006f3e] 672a                      beq.s      _xlink_22
[00006f40] 4297                      clr.l      (a7)
[00006f42] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00006f48] 226e fff2                 movea.l    -14(a6),a1
[00006f4c] 7e00                      moveq.l    #0,d7
[00006f4e] 3e29 0008                 move.w     8(a1),d7
[00006f52] 2f07                      move.l     d7,-(a7)
[00006f54] 226e fff2                 movea.l    -14(a6),a1
[00006f58] 7e00                      moveq.l    #0,d7
[00006f5a] 3e29 000a                 move.w     10(a1),d7
[00006f5e] 2f07                      move.l     d7,-(a7)
[00006f60] 4eb9 0000 0000            jsr        _memfree
[00006f66] 4fef 000c                 lea.l      12(a7),a7
_xlink_22:
[00006f6a] 226e fff2                 movea.l    -14(a6),a1
[00006f6e] 4269 000a                 clr.w      10(a1)
_xlink_21:
[00006f72] 2eae fff2                 move.l     -14(a6),(a7)
[00006f76] 4eb9 0000 81c8            jsr        _txtexit
[00006f7c] 4297                      clr.l      (a7)
[00006f7e] 42a7                      clr.l      -(a7)
[00006f80] 4eb9 0000 7ae0            jsr        _movein
[00006f86] 588f                      addq.l     #4,a7
[00006f88] 2d47 ffee                 move.l     d7,-18(a6)
[00006f8c] 6730                      beq.s      _xlink_23
[00006f8e] 2eb9 0000 0000            move.l     _usize,(a7)
[00006f94] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00006f9a] 226e ffee                 movea.l    -18(a6),a1
[00006f9e] 7e00                      moveq.l    #0,d7
[00006fa0] 3e29 0008                 move.w     8(a1),d7
[00006fa4] 2f07                      move.l     d7,-(a7)
[00006fa6] 226e ffee                 movea.l    -18(a6),a1
[00006faa] 7e00                      moveq.l    #0,d7
[00006fac] 3e29 000a                 move.w     10(a1),d7
[00006fb0] 2f07                      move.l     d7,-(a7)
[00006fb2] 4eb9 0000 0000            jsr        _memfree
[00006fb8] 4fef 000c                 lea.l      12(a7),a7
[00006fbc] 6032                      bra.s      _xlink_24
_xlink_23:
[00006fbe] 3e2d 0008                 move.w     8(a5),d7
[00006fc2] be79 0000 b420            cmp.w      _exbase,d7
[00006fc8] 6726                      beq.s      _xlink_24
[00006fca] 2eb9 0000 0000            move.l     _usize,(a7)
[00006fd0] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00006fd6] 7e00                      moveq.l    #0,d7
[00006fd8] 3e2d 0008                 move.w     8(a5),d7
[00006fdc] 2f07                      move.l     d7,-(a7)
[00006fde] 7e00                      moveq.l    #0,d7
[00006fe0] 3e2d 000a                 move.w     10(a5),d7
[00006fe4] 2f07                      move.l     d7,-(a7)
[00006fe6] 4eb9 0000 0000            jsr        _memfree
[00006fec] 4fef 000c                 lea.l      12(a7),a7
_xlink_24:
[00006ff0] 276e ffee 0150            move.l     -18(a6),336(a3)
[00006ff6] 2e0c                      move.l     a4,d7
[00006ff8] 6700 00aa                 beq        _xlink_25
[00006ffc] 082c 0006 0010            btst       #6,16(a4)
[00007002] 6700 00a0                 beq        _xlink_25
[00007006] 4eb9 0000 8314            jsr        _newpid
[0000700c] 3947 001c                 move.w     d7,28(a4)
[00007010] 426c 0020                 clr.w      32(a4)
[00007014] 42ac 0004                 clr.l      4(a4)
[00007018] 396e fffc 000c            move.w     -4(a6),12(a4)
[0000701e] 4297                      clr.l      (a7)
[00007020] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007026] 2f2e 0010                 move.l     16(a6),-(a7)
[0000702a] 4eb9 0000 0000            jsr        _memalloc
[00007030] 508f                      addq.l     #8,a7
[00007032] 3947 0008                 move.w     d7,8(a4)
[00007036] 6706                      beq.s      _xlink_26
[00007038] 08ec 0002 0010            bset       #2,16(a4)
_xlink_26:
[0000703e] 396e 0012 000a            move.w     18(a6),10(a4)
[00007044] 396e 0012 000e            move.w     18(a6),14(a4)
[0000704a] 2245                      movea.l    d5,a1
[0000704c] 43e9 0018                 lea.l      24(a1),a1
[00007050] 3951 0024                 move.w     (a1),36(a4)
[00007054] 2245                      movea.l    d5,a1
[00007056] 43e9 0016                 lea.l      22(a1),a1
[0000705a] 3951 0022                 move.w     (a1),34(a4)
[0000705e] 296e ffea 0026            move.l     -22(a6),38(a4)
[00007064] 2245                      movea.l    d5,a1
[00007066] 43e9 001a                 lea.l      26(a1),a1
[0000706a] 0811 0001                 btst       #1,(a1)
[0000706e] 6710                      beq.s      _xlink_27
[00007070] 4a79 0000 0000            tst.w      _swapdev
[00007076] 6708                      beq.s      _xlink_27
[00007078] 397c 0002 002a            move.w     #$0002,42(a4)
[0000707e] 6006                      bra.s      _xlink_28
_xlink_27:
[00007080] 397c 0001 002a            move.w     #$0001,42(a4)
_xlink_28:
[00007086] 397c 0001 002c            move.w     #$0001,44(a4)
[0000708c] 4eb9 0000 0000            jsr        _spl7
[00007092] 28b9 0000 b514            move.l     _plist,(a4)
[00007098] 23cc 0000 b514            move.l     a4,_plist
[0000709e] 4eb9 0000 0000            jsr        _spl0
_xlink_25:
[000070a4] 2eb9 0000 0000            move.l     _usize,(a7)
[000070aa] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[000070b0] 2f2e 000c                 move.l     12(a6),-(a7)
[000070b4] 4eb9 0000 0000            jsr        _memalloc
[000070ba] 508f                      addq.l     #8,a7
[000070bc] 3b47 0008                 move.w     d7,8(a5)
[000070c0] 6636                      bne.s      _xlink_29
[000070c2] 2e0c                      move.l     a4,d7
[000070c4] 6732                      beq.s      _xlink_29
[000070c6] 082c 0006 0010            btst       #6,16(a4)
[000070cc] 672a                      beq.s      _xlink_29
[000070ce] 4a6c 0008                 tst.w      8(a4)
[000070d2] 6724                      beq.s      _xlink_29
[000070d4] 4297                      clr.l      (a7)
[000070d6] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[000070dc] 7e00                      moveq.l    #0,d7
[000070de] 3e2c 0008                 move.w     8(a4),d7
[000070e2] 2f07                      move.l     d7,-(a7)
[000070e4] 2f2e 0010                 move.l     16(a6),-(a7)
[000070e8] 4eb9 0000 0000            jsr        _memfree
[000070ee] 4fef 000c                 lea.l      12(a7),a7
[000070f2] 08ac 0002 0010            bclr       #2,16(a4)
_xlink_29:
[000070f8] 3b6e fffe 000c            move.w     -2(a6),12(a5)
[000070fe] 3b6e 000e 000a            move.w     14(a6),10(a5)
[00007104] 4aae 0008                 tst.l      8(a6)
[00007108] 6704                      beq.s      _xlink_30
[0000710a] 7e00                      moveq.l    #0,d7
[0000710c] 6008                      bra.s      _xlink_31
_xlink_30:
[0000710e] 2e2b 0158                 move.l     344(a3),d7
[00007112] 7c09                      moveq.l    #9,d6
[00007114] ecaf                      lsr.l      d6,d7
_xlink_31:
[00007116] 3b47 000e                 move.w     d7,14(a5)
[0000711a] 08ad 0005 0010            bclr       #5,16(a5)
[00007120] 2b4c 0022                 move.l     a4,34(a5)
[00007124] 7e01                      moveq.l    #1,d7
[00007126] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[0000712a] 4e5e                      unlk       a6
[0000712c] 4e75                      rts

_xload:
[0000712e] 4e56 ffe4                 link       a6,#-28
[00007132] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007136] 2a79 0000 0000            movea.l    _pu,a5
[0000713c] 286d 0010                 movea.l    16(a5),a4
[00007140] 266c 0022                 movea.l    34(a4),a3
[00007144] 7e01                      moveq.l    #1,d7
[00007146] 7c00                      moveq.l    #0,d6
[00007148] 3c2d 0154                 move.w     340(a5),d6
[0000714c] ce86                      and.l      d6,d7
[0000714e] 2d47 fffc                 move.l     d7,-4(a6)
[00007152] 4aae fffc                 tst.l      -4(a6)
[00007156] 660a                      bne.s      _xload_1
[00007158] 42ae fff0                 clr.l      -16(a6)
[0000715c] 42ae ffec                 clr.l      -20(a6)
[00007160] 604e                      bra.s      _xload_2
_xload_1:
[00007162] 08ec 0003 0010            bset       #3,16(a4)
[00007168] 7e00                      moveq.l    #0,d7
[0000716a] 3e2c 0008                 move.w     8(a4),d7
[0000716e] 7c09                      moveq.l    #9,d6
[00007170] eda7                      asl.l      d6,d7
[00007172] 2d47 fff8                 move.l     d7,-8(a6)
[00007176] 2e0b                      move.l     a3,d7
[00007178] 6710                      beq.s      _xload_3
[0000717a] 7e00                      moveq.l    #0,d7
[0000717c] 3e2b 0008                 move.w     8(a3),d7
[00007180] 7c09                      moveq.l    #9,d6
[00007182] eda7                      asl.l      d6,d7
[00007184] 2d47 fff4                 move.l     d7,-12(a6)
[00007188] 600e                      bra.s      _xload_4
_xload_3:
[0000718a] 2d6e fff8 fff4            move.l     -8(a6),-12(a6)
[00007190] 2e2d 0158                 move.l     344(a5),d7
[00007194] dfae fff8                 add.l      d7,-8(a6)
_xload_4:
[00007198] 2e2e fff4                 move.l     -12(a6),d7
[0000719c] 9ead 0168                 sub.l      360(a5),d7
[000071a0] 2d47 ffec                 move.l     d7,-20(a6)
[000071a4] 2e2e fff8                 move.l     -8(a6),d7
[000071a8] 9ead 016c                 sub.l      364(a5),d7
[000071ac] 2d47 fff0                 move.l     d7,-16(a6)
_xload_2:
[000071b0] 2eae fff0                 move.l     -16(a6),(a7)
[000071b4] 2f2e 0008                 move.l     8(a6),-(a7)
[000071b8] 4eb9 0000 73b6            jsr        _xpargs
[000071be] 588f                      addq.l     #4,a7
[000071c0] 4aad 0158                 tst.l      344(a5)
[000071c4] 6616                      bne.s      _xload_5
[000071c6] 7e1c                      moveq.l    #28,d7
[000071c8] dead 015c                 add.l      348(a5),d7
[000071cc] 7c00                      moveq.l    #0,d6
[000071ce] 3c2d 0156                 move.w     342(a5),d6
[000071d2] de86                      add.l      d6,d7
[000071d4] 2d47 ffe4                 move.l     d7,-28(a6)
[000071d8] 6000 00dc                 bra        _xload_6
_xload_5:
[000071dc] 2e0b                      move.l     a3,d7
[000071de] 6712                      beq.s      _xload_7
[000071e0] 082b 0006 0010            btst       #6,16(a3)
[000071e6] 660a                      bne.s      _xload_7
[000071e8] 2d6b 002e ffe4            move.l     46(a3),-28(a6)
[000071ee] 6000 00c6                 bra        _xload_6
_xload_7:
[000071f2] 2e0b                      move.l     a3,d7
[000071f4] 6716                      beq.s      _xload_8
[000071f6] 4878 0008                 pea.l      ($00000008).w
[000071fa] 486b 0014                 pea.l      20(a3)
[000071fe] 486c 0014                 pea.l      20(a4)
[00007202] 4eb9 0000 2754            jsr        _movbuf
[00007208] 4fef 000c                 lea.l      12(a7),a7
_xload_8:
[0000720c] 08ec 0006 0010            bset       #6,16(a4)
[00007212] 4eb9 0000 0000            jsr        _setumap
[00007218] 2b6d 0168 0028            move.l     360(a5),40(a5)
[0000721e] 2b6d 0158 002c            move.l     344(a5),44(a5)
[00007224] 701c                      moveq.l    #28,d0
[00007226] 2b40 0030                 move.l     d0,48(a5)
[0000722a] 422d 0143                 clr.b      323(a5)
[0000722e] 2ead 003c                 move.l     60(a5),(a7)
[00007232] 4eba f974                 jsr        $00006BA8(pc)
[00007236] 2ead 0168                 move.l     360(a5),(a7)
[0000723a] 4eb9 0000 0000            jsr        _xusrsvc
[00007240] 2e2d 015c                 move.l     348(a5),d7
[00007244] 7c00                      moveq.l    #0,d6
[00007246] 3c2d 0156                 move.w     342(a5),d6
[0000724a] de86                      add.l      d6,d7
[0000724c] dfad 0030                 add.l      d7,48(a5)
[00007250] 4aae ffec                 tst.l      -20(a6)
[00007254] 6606                      bne.s      _xload_9
[00007256] 4aae fff0                 tst.l      -16(a6)
[0000725a] 671e                      beq.s      _xload_10
_xload_9:
[0000725c] 2eae fff0                 move.l     -16(a6),(a7)
[00007260] 2f2e ffec                 move.l     -20(a6),-(a7)
[00007264] 2f2e ffec                 move.l     -20(a6),-(a7)
[00007268] 2f2d 0158                 move.l     344(a5),-(a7)
[0000726c] 2f2d 0018                 move.l     24(a5),-(a7)
[00007270] 4eb9 0000 76a8            jsr        $000076A8
[00007276] 4fef 0010                 lea.l      16(a7),a7
_xload_10:
[0000727a] 2d6d 0030 ffe4            move.l     48(a5),-28(a6)
[00007280] 2e0b                      move.l     a3,d7
[00007282] 6732                      beq.s      _xload_6
[00007284] 276e ffe4 002e            move.l     -28(a6),46(a3)
[0000728a] 177c 0004 0010            move.b     #$04,16(a3)
[00007290] 226d 003c                 movea.l    60(a5),a1
[00007294] 0829 0001 001a            btst       #1,26(a1)
[0000729a] 6706                      beq.s      _xload_11
[0000729c] 08eb 0001 0010            bset       #1,16(a3)
_xload_11:
[000072a2] 4aae fffc                 tst.l      -4(a6)
[000072a6] 6706                      beq.s      _xload_12
[000072a8] 08eb 0004 0010            bset       #4,16(a3)
_xload_12:
[000072ae] 2e8b                      move.l     a3,(a7)
[000072b0] 4eb9 0000 8b4c            jsr        _wakeup
_xload_6:
[000072b6] 022c 009f 0010            andi.b     #$9F,16(a4)
[000072bc] 4eb9 0000 0000            jsr        _setumap
[000072c2] 2b6d 016c 0028            move.l     364(a5),40(a5)
[000072c8] 2b6d 015c 002c            move.l     348(a5),44(a5)
[000072ce] 7e1c                      moveq.l    #28,d7
[000072d0] dead 0158                 add.l      344(a5),d7
[000072d4] 2b47 0030                 move.l     d7,48(a5)
[000072d8] 422d 0143                 clr.b      323(a5)
[000072dc] 2ead 003c                 move.l     60(a5),(a7)
[000072e0] 4eba f8c6                 jsr        $00006BA8(pc)
[000072e4] 2e2d 016c                 move.l     364(a5),d7
[000072e8] dead 015c                 add.l      348(a5),d7
[000072ec] 2c2d 014c                 move.l     332(a5),d6
[000072f0] 9c87                      sub.l      d7,d6
[000072f2] 2e86                      move.l     d6,(a7)
[000072f4] 2e2d 016c                 move.l     364(a5),d7
[000072f8] dead 015c                 add.l      348(a5),d7
[000072fc] 2f07                      move.l     d7,-(a7)
[000072fe] 4eb9 0000 0000            jsr        _clrmem
[00007304] 588f                      addq.l     #4,a7
[00007306] 4a87                      tst.l      d7
[00007308] 670c                      beq.s      _xload_13
[0000730a] 4878 000e                 pea.l      ($0000000E).w
[0000730e] 4eb9 0000 2868            jsr        _uerror
[00007314] 588f                      addq.l     #4,a7
_xload_13:
[00007316] 226d 003c                 movea.l    60(a5),a1
[0000731a] 0829 0003 001a            btst       #3,26(a1)
[00007320] 670a                      beq.s      _xload_14
[00007322] 226d 003c                 movea.l    60(a5),a1
[00007326] 1b69 001d 0130            move.b     29(a1),304(a5)
_xload_14:
[0000732c] 226d 003c                 movea.l    60(a5),a1
[00007330] 0829 0002 001a            btst       #2,26(a1)
[00007336] 670a                      beq.s      _xload_15
[00007338] 226d 003c                 movea.l    60(a5),a1
[0000733c] 1b69 001e 0131            move.b     30(a1),305(a5)
_xload_15:
[00007342] 4a2d 0142                 tst.b      322(a5)
[00007346] 6706                      beq.s      _xload_16
[00007348] 1b7c 000e 0142            move.b     #$0E,322(a5)
_xload_16:
[0000734e] 4aae fffc                 tst.l      -4(a6)
[00007352] 6756                      beq.s      _xload_17
[00007354] 2b6e ffe4 0030            move.l     -28(a6),48(a5)
[0000735a] 4aae fff0                 tst.l      -16(a6)
[0000735e] 671e                      beq.s      _xload_18
[00007360] 2eae fff0                 move.l     -16(a6),(a7)
[00007364] 2f2e ffec                 move.l     -20(a6),-(a7)
[00007368] 2f2e fff0                 move.l     -16(a6),-(a7)
[0000736c] 2f2d 015c                 move.l     348(a5),-(a7)
[00007370] 2f2d 0020                 move.l     32(a5),-(a7)
[00007374] 4eb9 0000 76a8            jsr        $000076A8
[0000737a] 4fef 0010                 lea.l      16(a7),a7
_xload_18:
[0000737e] 2e2e ffec                 move.l     -20(a6),d7
[00007382] dfad 0018                 add.l      d7,24(a5)
[00007386] 2e2e fff0                 move.l     -16(a6),d7
[0000738a] dfad 0020                 add.l      d7,32(a5)
[0000738e] 2e2e fff0                 move.l     -16(a6),d7
[00007392] dfad 014c                 add.l      d7,332(a5)
[00007396] 2e2e fff0                 move.l     -16(a6),d7
[0000739a] dfad 0014                 add.l      d7,20(a5)
[0000739e] 08ec 0004 0010            bset       #4,16(a4)
[000073a4] 08ac 0003 0010            bclr       #3,16(a4)
_xload_17:
[000073aa] 2e2e fffc                 move.l     -4(a6),d7
[000073ae] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000073b2] 4e5e                      unlk       a6
[000073b4] 4e75                      rts

_xpargs:
[000073b6] 4e56 fff4                 link       a6,#-12
[000073ba] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000073be] 2679 0000 0000            movea.l    _pu,a3
[000073c4] 2e2b 0020                 move.l     32(a3),d7
[000073c8] deab 0024                 add.l      36(a3),d7
[000073cc] 2847                      movea.l    d7,a4
[000073ce] 7e00                      moveq.l    #0,d7
[000073d0] 5487                      addq.l     #2,d7
[000073d2] 7c00                      moveq.l    #0,d6
[000073d4] 5486                      addq.l     #2,d6
[000073d6] 5386                      subq.l     #1,d6
[000073d8] ccab 0148                 and.l      328(a3),d6
[000073dc] 9e86                      sub.l      d6,d7
[000073de] 2d47 fffc                 move.l     d7,-4(a6)
[000073e2] 2eae fffc                 move.l     -4(a6),(a7)
[000073e6] 2e0c                      move.l     a4,d7
[000073e8] 9eae fffc                 sub.l      -4(a6),d7
[000073ec] 2f07                      move.l     d7,-(a7)
[000073ee] 2f3c 0000 b4b3            move.l     #$00016221,-(a7)
[000073f4] 4eb9 0000 0000            jsr        _outbuf
[000073fa] 508f                      addq.l     #8,a7
[000073fc] 2e2b 0148                 move.l     328(a3),d7
[00007400] deae fffc                 add.l      -4(a6),d7
[00007404] 99c7                      suba.l     d7,a4
[00007406] 2d4c fff4                 move.l     a4,-12(a6)
[0000740a] 422b 0143                 clr.b      323(a3)
[0000740e] 0cab 0000 0200 0148       cmpi.l     #$00000200,328(a3)
[00007416] 622e                      bhi.s      _xpargs_1
[00007418] 2eab 0148                 move.l     328(a3),(a7)
[0000741c] 2f0c                      move.l     a4,-(a7)
[0000741e] 2f2e 0008                 move.l     8(a6),-(a7)
[00007422] 4eb9 0000 0c18            jsr        _getaddr
[00007428] 588f                      addq.l     #4,a7
[0000742a] 2f07                      move.l     d7,-(a7)
[0000742c] 4eb9 0000 0000            jsr        _outbuf
[00007432] 508f                      addq.l     #8,a7
[00007434] 2eae 0008                 move.l     8(a6),(a7)
[00007438] 4eb9 0000 0390            jsr        _brelse
[0000743e] 4eb9 0000 03f4            jsr        _bsell
[00007444] 6026                      bra.s      _xpargs_2
_xpargs_1:
[00007446] 274c 0028                 move.l     a4,40(a3)
[0000744a] 276b 0148 002c            move.l     328(a3),44(a3)
[00007450] 42ab 0030                 clr.l      48(a3)
[00007454] 2eae 0008                 move.l     8(a6),(a7)
[00007458] 4eb9 0000 57a2            jsr        _readi
[0000745e] 4297                      clr.l      (a7)
[00007460] 2f2e 0008                 move.l     8(a6),-(a7)
[00007464] 4eb9 0000 3540            jsr        _puti
[0000746a] 588f                      addq.l     #4,a7
_xpargs_2:
[0000746c] 2a6b 014c                 movea.l    332(a3),a5
[00007470] 2eab 0144                 move.l     324(a3),(a7)
[00007474] 224d                      movea.l    a5,a1
[00007476] 588d                      addq.l     #4,a5
[00007478] 2f09                      move.l     a1,-(a7)
[0000747a] 4eb9 0000 0000            jsr        _outword
[00007480] 588f                      addq.l     #4,a7
[00007482] 2e2b 0144                 move.l     324(a3),d7
[00007486] e587                      asl.l      #2,d7
[00007488] 43f5 7800                 lea.l      0(a5,d7.l),a1
[0000748c] 2d49 fff8                 move.l     a1,-8(a6)
_xpargs_7:
[00007490] bbee fff4                 cmpa.l     -12(a6),a5
[00007494] 644a                      bcc.s      _xpargs_3
_xpargs_5:
[00007496] bbee fff8                 cmpa.l     -8(a6),a5
[0000749a] 6428                      bcc.s      _xpargs_4
[0000749c] 2e0c                      move.l     a4,d7
[0000749e] deae 000c                 add.l      12(a6),d7
[000074a2] 2e87                      move.l     d7,(a7)
[000074a4] 224d                      movea.l    a5,a1
[000074a6] 588d                      addq.l     #4,a5
[000074a8] 2f09                      move.l     a1,-(a7)
[000074aa] 4eb9 0000 0000            jsr        _outword
[000074b0] 588f                      addq.l     #4,a7
_xpargs_6:
[000074b2] 224c                      movea.l    a4,a1
[000074b4] 528c                      addq.l     #1,a4
[000074b6] 2e89                      move.l     a1,(a7)
[000074b8] 4eb9 0000 0000            jsr        _inbyte
[000074be] 4a87                      tst.l      d7
[000074c0] 6fd4                      ble.s      _xpargs_5
[000074c2] 60ee                      bra.s      _xpargs_6
_xpargs_4:
[000074c4] 4297                      clr.l      (a7)
[000074c6] 224d                      movea.l    a5,a1
[000074c8] 588d                      addq.l     #4,a5
[000074ca] 2f09                      move.l     a1,-(a7)
[000074cc] 4eb9 0000 0000            jsr        _outword
[000074d2] 588f                      addq.l     #4,a7
[000074d4] 2e2e fff4                 move.l     -12(a6),d7
[000074d8] 5987                      subq.l     #4,d7
[000074da] 2d47 fff8                 move.l     d7,-8(a6)
[000074de] 60b0                      bra.s      _xpargs_7
_xpargs_3:
[000074e0] 4878 0008                 pea.l      ($00000008).w
[000074e4] 2f2b 0148                 move.l     328(a3),-(a7)
[000074e8] 4eb9 0000 26f4            jsr        _minu
[000074ee] 508f                      addq.l     #8,a7
[000074f0] 2e87                      move.l     d7,(a7)
[000074f2] 2279 0000 0000            movea.l    _pu,a1
[000074f8] 7e14                      moveq.l    #20,d7
[000074fa] dea9 0010                 add.l      16(a1),d7
[000074fe] 2f07                      move.l     d7,-(a7)
[00007500] 2f2e fff4                 move.l     -12(a6),-(a7)
[00007504] 4eb9 0000 0000            jsr        _inbuf
[0000750a] 508f                      addq.l     #8,a7
[0000750c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007510] 4e5e                      unlk       a6
[00007512] 4e75                      rts

x7514:
[00007514] 4e56 0000                 link       a6,#0
[00007518] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000751c] 2a6e 0008                 movea.l    8(a6),a5
[00007520] 2879 0000 0000            movea.l    _pu,a4
[00007526] 4a95                      tst.l      (a5)
[00007528] 6638                      bne.s      x7514_1
[0000752a] 2ead 0004                 move.l     4(a5),(a7)
[0000752e] 4eb9 0000 0c18            jsr        _getaddr
[00007534] 2b47 0008                 move.l     d7,8(a5)
[00007538] 296d 0008 0028            move.l     8(a5),40(a4)
[0000753e] 297c 0000 0200 002c       move.l     #$00000200,44(a4)
[00007546] 197c 0001 0143            move.b     #$01,323(a4)
[0000754c] 2eac 003c                 move.l     60(a4),(a7)
[00007550] 4eb9 0000 57a2            jsr        _readi
[00007556] 2e3c 0000 0200            move.l     #$00000200,d7
[0000755c] 9eac 002c                 sub.l      44(a4),d7
[00007560] 2a87                      move.l     d7,(a5)
x7514_1:
[00007562] 4a95                      tst.l      (a5)
[00007564] 6710                      beq.s      x7514_2
[00007566] 5395                      subq.l     #1,(a5)
[00007568] 226d 0008                 movea.l    8(a5),a1
[0000756c] 52ad 0008                 addq.l     #1,8(a5)
[00007570] 7e00                      moveq.l    #0,d7
[00007572] 1e11                      move.b     (a1),d7
[00007574] 6002                      bra.s      x7514_3
x7514_2:
[00007576] 7e00                      moveq.l    #0,d7
x7514_3:
[00007578] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000757c] 4e5e                      unlk       a6
[0000757e] 4e75                      rts

_xredirect:
[00007580] 4e56 0000                 link       a6,#0
[00007584] 2e2e 0008                 move.l     8(a6),d7
[00007588] beae 000c                 cmp.l      12(a6),d7
[0000758c] 6718                      beq.s      _xredirect_1
[0000758e] 486e 0008                 pea.l      8(a6)
[00007592] 4eb9 0000 9a1c            jsr        _syclose
[00007598] 588f                      addq.l     #4,a7
[0000759a] 486e 000c                 pea.l      12(a6)
[0000759e] 4eb9 0000 9a5a            jsr        _sydup
[000075a4] 588f                      addq.l     #4,a7
_xredirect_1:
[000075a6] 4e5e                      unlk       a6
[000075a8] 4e75                      rts

_xreset:
[000075aa] 4e56 fffc                 link       a6,#-4
[000075ae] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000075b2] 2a6e 0008                 movea.l    8(a6),a5
[000075b6] 2679 0000 0000            movea.l    _pu,a3
[000075bc] 7e18                      moveq.l    #24,d7
[000075be] ce95                      and.l      (a5),d7
[000075c0] 6726                      beq.s      _xreset_1
[000075c2] 082d 0003 0003            btst       #3,3(a5)
[000075c8] 6708                      beq.s      _xreset_2
[000075ca] 7e00                      moveq.l    #0,d7
[000075cc] 1e2b 0132                 move.b     306(a3),d7
[000075d0] 6006                      bra.s      _xreset_3
_xreset_2:
[000075d2] 7e00                      moveq.l    #0,d7
[000075d4] 1e2b 0130                 move.b     304(a3),d7
_xreset_3:
[000075d8] 2d47 fffc                 move.l     d7,-4(a6)
[000075dc] 486e fffc                 pea.l      -4(a6)
[000075e0] 4eb9 0000 98b8            jsr        _sysuid
[000075e6] 588f                      addq.l     #4,a7
_xreset_1:
[000075e8] 082d 0005 0003            btst       #5,3(a5)
[000075ee] 6728                      beq.s      _xreset_4
[000075f0] 2ead 0004                 move.l     4(a5),(a7)
[000075f4] 42a7                      clr.l      -(a7)
[000075f6] 4eba ff88                 jsr        _xredirect(pc)
[000075fa] 588f                      addq.l     #4,a7
[000075fc] 2ead 0008                 move.l     8(a5),(a7)
[00007600] 4878 0001                 pea.l      ($00000001).w
[00007604] 4eba ff7a                 jsr        _xredirect(pc)
[00007608] 588f                      addq.l     #4,a7
[0000760a] 2ead 000c                 move.l     12(a5),(a7)
[0000760e] 4878 0002                 pea.l      ($00000002).w
[00007612] 4eba ff6c                 jsr        _xredirect(pc)
[00007616] 588f                      addq.l     #4,a7
_xreset_4:
[00007618] 42ae fffc                 clr.l      -4(a6)
_xreset_7:
[0000761c] 4aab 0040                 tst.l      64(a3)
[00007620] 672e                      beq.s      _xreset_5
[00007622] 0cae 0000 0020 fffc       cmpi.l     #$00000020,-4(a6)
[0000762a] 6424                      bcc.s      _xreset_5
[0000762c] 082b 0000 0043            btst       #0,67(a3)
[00007632] 670c                      beq.s      _xreset_6
[00007634] 486e fffc                 pea.l      -4(a6)
[00007638] 4eb9 0000 9a1c            jsr        _syclose
[0000763e] 588f                      addq.l     #4,a7
_xreset_6:
[00007640] 52ae fffc                 addq.l     #1,-4(a6)
[00007644] 2e2b 0040                 move.l     64(a3),d7
[00007648] e28f                      lsr.l      #1,d7
[0000764a] 2747 0040                 move.l     d7,64(a3)
[0000764e] 60cc                      bra.s      _xreset_7
_xreset_5:
[00007650] 082d 0002 0003            btst       #2,3(a5)
[00007656] 6718                      beq.s      _xreset_8
[00007658] 43f8 0022                 lea.l      ($00000022).w,a1
[0000765c] d3eb 0010                 adda.l     16(a3),a1
[00007660] 02a9 ffff fff3 0018       andi.l     #$FFFFFFF3,24(a1)
[00007668] 42ab 00d0                 clr.l      208(a3)
[0000766c] 42ab 00d4                 clr.l      212(a3)
_xreset_8:
[00007670] 43eb 00c8                 lea.l      200(a3),a1
[00007674] 2849                      movea.l    a1,a4
[00007676] 7012                      moveq.l    #18,d0
[00007678] 2d40 fffc                 move.l     d0,-4(a6)
_xreset_11:
[0000767c] 53ae fffc                 subq.l     #1,-4(a6)
[00007680] 6d0e                      blt.s      _xreset_9
[00007682] 0c94 0000 0001            cmpi.l     #$00000001,(a4)
[00007688] 6702                      beq.s      _xreset_10
[0000768a] 4294                      clr.l      (a4)
_xreset_10:
[0000768c] 588c                      addq.l     #4,a4
[0000768e] 60ec                      bra.s      _xreset_11
_xreset_9:
[00007690] 42ab 00c4                 clr.l      196(a3)
[00007694] 42ab 012c                 clr.l      300(a3)
[00007698] 42ab 0040                 clr.l      64(a3)
[0000769c] 422b 0142                 clr.b      322(a3)
[000076a0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000076a4] 4e5e                      unlk       a6
[000076a6] 4e75                      rts

x76a8:
[000076a8] 4e56 fff0                 link       a6,#-16
[000076ac] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000076b0] 2a6e 0008                 movea.l    8(a6),a5
[000076b4] 4297                      clr.l      (a7)
[000076b6] 4eb9 0000 0358            jsr        _bbuy
[000076bc] 4297                      clr.l      (a7)
[000076be] 4eb9 0000 04f4            jsr        _getblk
[000076c4] 2d47 fff4                 move.l     d7,-12(a6)
[000076c8] 42ae fff0                 clr.l      -16(a6)
x76a8_3:
[000076cc] 2279 0000 0000            movea.l    _pu,a1
[000076d2] 4a29 0142                 tst.b      322(a1)
[000076d6] 6600 0132                 bne        x76a8_1
[000076da] 486e fff0                 pea.l      -16(a6)
[000076de] 4eba fe34                 jsr        $00007514(pc)
[000076e2] 588f                      addq.l     #4,a7
[000076e4] 2a07                      move.l     d7,d5
[000076e6] 6620                      bne.s      x76a8_2
[000076e8] 2279 0000 0000            movea.l    _pu,a1
[000076ee] 2e2e fff0                 move.l     -16(a6),d7
[000076f2] 9fa9 0030                 sub.l      d7,48(a1)
[000076f6] 6000 0112                 bra        x76a8_1
x76a8_13:
[000076fa] dbee fffc                 adda.l     -4(a6),a5
[000076fe] 2e2e fffc                 move.l     -4(a6),d7
[00007702] 9fae 000c                 sub.l      d7,12(a6)
[00007706] 60c4                      bra.s      x76a8_3
x76a8_2:
[00007708] 0c85 0000 0020            cmpi.l     #$00000020,d5
[0000770e] 6c08                      bge.s      x76a8_4
[00007710] 2d45 fffc                 move.l     d5,-4(a6)
[00007714] 6000 00d8                 bra        x76a8_5
x76a8_4:
[00007718] 0c85 0000 0040            cmpi.l     #$00000040,d5
[0000771e] 6c1e                      bge.s      x76a8_6
[00007720] 486e fff0                 pea.l      -16(a6)
[00007724] 4eba fdee                 jsr        $00007514(pc)
[00007728] 588f                      addq.l     #4,a7
[0000772a] 7ce0                      moveq.l    #-32,d6
[0000772c] dc85                      add.l      d5,d6
[0000772e] e186                      asl.l      #8,d6
[00007730] 7820                      moveq.l    #32,d4
[00007732] d886                      add.l      d6,d4
[00007734] d887                      add.l      d7,d4
[00007736] 2d44 fffc                 move.l     d4,-4(a6)
[0000773a] 6000 00b2                 bra        x76a8_5
x76a8_6:
[0000773e] 0c85 0000 0050            cmpi.l     #$00000050,d5
[00007744] 6d10                      blt.s      x76a8_7
[00007746] 2279 0000 0000            movea.l    _pu,a1
[0000774c] 137c 000e 0142            move.b     #$0E,322(a1)
[00007752] 6000 009a                 bra        x76a8_5
x76a8_7:
[00007756] 0805 0001                 btst       #1,d5
[0000775a] 674a                      beq.s      x76a8_8
[0000775c] 7004                      moveq.l    #4,d0
[0000775e] 2d40 fffc                 move.l     d0,-4(a6)
[00007762] 0805 0000                 btst       #0,d5
[00007766] 6712                      beq.s      x76a8_9
[00007768] 2e2e 0010                 move.l     16(a6),d7
[0000776c] 4487                      neg.l      d7
[0000776e] 2e87                      move.l     d7,(a7)
[00007770] 2f0d                      move.l     a5,-(a7)
[00007772] 4eb9 0000 0000            jsr        _addlum
[00007778] 588f                      addq.l     #4,a7
x76a8_9:
[0000777a] 0805 0003                 btst       #3,d5
[0000777e] 6710                      beq.s      x76a8_10
[00007780] 2eae 0018                 move.l     24(a6),(a7)
[00007784] 2f0d                      move.l     a5,-(a7)
[00007786] 4eb9 0000 0000            jsr        _addlum
[0000778c] 588f                      addq.l     #4,a7
[0000778e] 605e                      bra.s      x76a8_5
x76a8_10:
[00007790] 0805 0002                 btst       #2,d5
[00007794] 6758                      beq.s      x76a8_5
[00007796] 2eae 0014                 move.l     20(a6),(a7)
[0000779a] 2f0d                      move.l     a5,-(a7)
[0000779c] 4eb9 0000 0000            jsr        _addlum
[000077a2] 588f                      addq.l     #4,a7
[000077a4] 6048                      bra.s      x76a8_5
x76a8_8:
[000077a6] 7002                      moveq.l    #2,d0
[000077a8] 2d40 fffc                 move.l     d0,-4(a6)
[000077ac] 0805 0000                 btst       #0,d5
[000077b0] 6712                      beq.s      x76a8_11
[000077b2] 2e2e 0010                 move.l     16(a6),d7
[000077b6] 4487                      neg.l      d7
[000077b8] 2e87                      move.l     d7,(a7)
[000077ba] 2f0d                      move.l     a5,-(a7)
[000077bc] 4eb9 0000 0000            jsr        _addsum
[000077c2] 588f                      addq.l     #4,a7
x76a8_11:
[000077c4] 0805 0003                 btst       #3,d5
[000077c8] 6710                      beq.s      x76a8_12
[000077ca] 2eae 0018                 move.l     24(a6),(a7)
[000077ce] 2f0d                      move.l     a5,-(a7)
[000077d0] 4eb9 0000 0000            jsr        _addsum
[000077d6] 588f                      addq.l     #4,a7
[000077d8] 6014                      bra.s      x76a8_5
x76a8_12:
[000077da] 0805 0002                 btst       #2,d5
[000077de] 670e                      beq.s      x76a8_5
[000077e0] 2eae 0014                 move.l     20(a6),(a7)
[000077e4] 2f0d                      move.l     a5,-(a7)
[000077e6] 4eb9 0000 0000            jsr        _addsum
[000077ec] 588f                      addq.l     #4,a7
x76a8_5:
[000077ee] 2e2e 000c                 move.l     12(a6),d7
[000077f2] beae fffc                 cmp.l      -4(a6),d7
[000077f6] 6400 ff02                 bcc        x76a8_13
[000077fa] 2279 0000 0000            movea.l    _pu,a1
[00007800] 137c 000e 0142            move.b     #$0E,322(a1)
[00007806] 6000 fef2                 bra        x76a8_13
x76a8_1:
[0000780a] 2eae fff4                 move.l     -12(a6),(a7)
[0000780e] 4eb9 0000 0390            jsr        _brelse
[00007814] 4eb9 0000 03f4            jsr        _bsell
[0000781a] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000781e] 4e5e                      unlk       a6
[00007820] 4e75                      rts

_freemem:
[00007822] 4e56 fffe                 link       a6,#-2
[00007826] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000782a] 2a6e 0008                 movea.l    8(a6),a5
[0000782e] 2a2e 000c                 move.l     12(a6),d5
[00007832] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00007838] 6604                      bne.s      _freemem_1
[0000783a] 7e00                      moveq.l    #0,d7
[0000783c] 6006                      bra.s      _freemem_2
_freemem_1:
[0000783e] 2e39 0000 0000            move.l     _usize,d7
_freemem_2:
[00007844] 3d47 fffe                 move.w     d7,-2(a6)
[00007848] 2e0d                      move.l     a5,d7
[0000784a] 6700 00dc                 beq        _freemem_3
[0000784e] 2e39 0000 b41c            move.l     _exproc,d7
[00007854] be8d                      cmp.l      a5,d7
[00007856] 660a                      bne.s      _freemem_4
[00007858] 4eb9 0000 6058            jsr        _exsell
[0000785e] 6000 0086                 bra        _freemem_5
_freemem_4:
[00007862] 082d 0002 0010            btst       #2,16(a5)
[00007868] 6754                      beq.s      _freemem_6
[0000786a] 2ebc 0000 b504            move.l     #_swpwait,(a7)
[00007870] 4eb9 0000 7b76            jsr        _schp0
[00007876] 7e00                      moveq.l    #0,d7
[00007878] 3e2e fffe                 move.w     -2(a6),d7
[0000787c] 2e87                      move.l     d7,(a7)
[0000787e] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007884] 7e00                      moveq.l    #0,d7
[00007886] 3e2d 0008                 move.w     8(a5),d7
[0000788a] 2f07                      move.l     d7,-(a7)
[0000788c] 7e00                      moveq.l    #0,d7
[0000788e] 3e2d 000a                 move.w     10(a5),d7
[00007892] 2f07                      move.l     d7,-(a7)
[00007894] 4eb9 0000 0000            jsr        _memfree
[0000789a] 4fef 000c                 lea.l      12(a7),a7
[0000789e] 4a85                      tst.l      d5
[000078a0] 671c                      beq.s      _freemem_6
[000078a2] 7e00                      moveq.l    #0,d7
[000078a4] 3e2e fffe                 move.w     -2(a6),d7
[000078a8] 2e87                      move.l     d7,(a7)
[000078aa] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[000078b0] 2f05                      move.l     d5,-(a7)
[000078b2] 4eb9 0000 0000            jsr        _memalloc
[000078b8] 508f                      addq.l     #8,a7
[000078ba] 3b47 0008                 move.w     d7,8(a5)
_freemem_6:
[000078be] 7e00                      moveq.l    #0,d7
[000078c0] 3e2e fffe                 move.w     -2(a6),d7
[000078c4] 2e87                      move.l     d7,(a7)
[000078c6] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[000078cc] 7e00                      moveq.l    #0,d7
[000078ce] 3e2d 000c                 move.w     12(a5),d7
[000078d2] 2f07                      move.l     d7,-(a7)
[000078d4] 7e00                      moveq.l    #0,d7
[000078d6] 3e2d 000a                 move.w     10(a5),d7
[000078da] 2f07                      move.l     d7,-(a7)
[000078dc] 4eb9 0000 0000            jsr        _swpfree
[000078e2] 4fef 000c                 lea.l      12(a7),a7
_freemem_5:
[000078e6] 4a85                      tst.l      d5
[000078e8] 6722                      beq.s      _freemem_7
[000078ea] 7e00                      moveq.l    #0,d7
[000078ec] 3e2e fffe                 move.w     -2(a6),d7
[000078f0] 2e87                      move.l     d7,(a7)
[000078f2] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[000078f8] 2f05                      move.l     d5,-(a7)
[000078fa] 4eb9 0000 0000            jsr        _swpalloc
[00007900] 508f                      addq.l     #8,a7
[00007902] 3b47 000c                 move.w     d7,12(a5)
[00007906] 3b45 000a                 move.w     d5,10(a5)
[0000790a] 601c                      bra.s      _freemem_3
_freemem_7:
[0000790c] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[00007912] 6714                      beq.s      _freemem_3
[00007914] 2ebc 0000 b514            move.l     #_plist,(a7)
[0000791a] 2f0d                      move.l     a5,-(a7)
[0000791c] 4878 0044                 pea.l      ($00000044).w
[00007920] 4eb9 0000 0138            jsr        _frelst
[00007926] 508f                      addq.l     #8,a7
_freemem_3:
[00007928] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000792c] 4e5e                      unlk       a6
[0000792e] 4e75                      rts

_getin:
[00007930] 4e56 ffe8                 link       a6,#-24
[00007934] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00007938] 2a6e 0008                 movea.l    8(a6),a5
[0000793c] 70ff                      moveq.l    #-1,d0
[0000793e] 2d40 ffe8                 move.l     d0,-24(a6)
[00007942] 286d 0022                 movea.l    34(a5),a4
[00007946] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[0000794c] 6708                      beq.s      _getin_1
[0000794e] 082d 0002 0010            btst       #2,16(a5)
[00007954] 6604                      bne.s      _getin_2
_getin_1:
[00007956] 7e00                      moveq.l    #0,d7
[00007958] 6004                      bra.s      _getin_3
_getin_2:
[0000795a] 2e2e ffe8                 move.l     -24(a6),d7
_getin_3:
[0000795e] 2d47 fff0                 move.l     d7,-16(a6)
[00007962] 2e0c                      move.l     a4,d7
[00007964] 6708                      beq.s      _getin_4
[00007966] 082c 0002 0010            btst       #2,16(a4)
[0000796c] 6706                      beq.s      _getin_5
_getin_4:
[0000796e] 2e2e ffe8                 move.l     -24(a6),d7
[00007972] 6002                      bra.s      _getin_6
_getin_5:
[00007974] 7e00                      moveq.l    #0,d7
_getin_6:
[00007976] 2d47 ffec                 move.l     d7,-20(a6)
[0000797a] 4aae 000c                 tst.l      12(a6)
[0000797e] 6712                      beq.s      _getin_7
[00007980] 4aae fff0                 tst.l      -16(a6)
[00007984] 660c                      bne.s      _getin_7
[00007986] 2e8d                      move.l     a5,(a7)
[00007988] 4eb9 0000 7a6c            jsr        _getmem
[0000798e] 2d47 fff0                 move.l     d7,-16(a6)
_getin_7:
[00007992] 4aae ffec                 tst.l      -20(a6)
[00007996] 660c                      bne.s      _getin_8
[00007998] 2e8c                      move.l     a4,(a7)
[0000799a] 4eb9 0000 7a6c            jsr        _getmem
[000079a0] 2d47 ffec                 move.l     d7,-20(a6)
_getin_8:
[000079a4] 4aae 000c                 tst.l      12(a6)
[000079a8] 6612                      bne.s      _getin_9
[000079aa] 4aae fff0                 tst.l      -16(a6)
[000079ae] 660c                      bne.s      _getin_9
[000079b0] 2e8d                      move.l     a5,(a7)
[000079b2] 4eb9 0000 7a6c            jsr        _getmem
[000079b8] 2d47 fff0                 move.l     d7,-16(a6)
_getin_9:
[000079bc] 4aae fff0                 tst.l      -16(a6)
[000079c0] 6740                      beq.s      _getin_10
[000079c2] 4aae ffec                 tst.l      -20(a6)
[000079c6] 673a                      beq.s      _getin_10
[000079c8] 2e2e ffec                 move.l     -20(a6),d7
[000079cc] beae ffe8                 cmp.l      -24(a6),d7
[000079d0] 670e                      beq.s      _getin_11
[000079d2] 2eae ffec                 move.l     -20(a6),(a7)
[000079d6] 2f0c                      move.l     a4,-(a7)
[000079d8] 4eb9 0000 7c90            jsr        _swapin
[000079de] 588f                      addq.l     #4,a7
_getin_11:
[000079e0] 2e2e fff0                 move.l     -16(a6),d7
[000079e4] beae ffe8                 cmp.l      -24(a6),d7
[000079e8] 670e                      beq.s      _getin_12
[000079ea] 2eae fff0                 move.l     -16(a6),(a7)
[000079ee] 2f0d                      move.l     a5,-(a7)
[000079f0] 4eb9 0000 7c90            jsr        _swapin
[000079f6] 588f                      addq.l     #4,a7
_getin_12:
[000079f8] 08ed 0007 0010            bset       #7,16(a5)
[000079fe] 7e01                      moveq.l    #1,d7
[00007a00] 6062                      bra.s      _getin_13
_getin_10:
[00007a02] 2e2e fff0                 move.l     -16(a6),d7
[00007a06] beae ffe8                 cmp.l      -24(a6),d7
[00007a0a] 6728                      beq.s      _getin_14
[00007a0c] 4aae fff0                 tst.l      -16(a6)
[00007a10] 6722                      beq.s      _getin_14
[00007a12] 2eb9 0000 0000            move.l     _usize,(a7)
[00007a18] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007a1e] 2f2e fff0                 move.l     -16(a6),-(a7)
[00007a22] 7e00                      moveq.l    #0,d7
[00007a24] 3e2d 000a                 move.w     10(a5),d7
[00007a28] 2f07                      move.l     d7,-(a7)
[00007a2a] 4eb9 0000 0000            jsr        _memfree
[00007a30] 4fef 000c                 lea.l      12(a7),a7
_getin_14:
[00007a34] 2e2e ffec                 move.l     -20(a6),d7
[00007a38] beae ffe8                 cmp.l      -24(a6),d7
[00007a3c] 6724                      beq.s      _getin_15
[00007a3e] 4aae ffec                 tst.l      -20(a6)
[00007a42] 671e                      beq.s      _getin_15
[00007a44] 4297                      clr.l      (a7)
[00007a46] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007a4c] 2f2e ffec                 move.l     -20(a6),-(a7)
[00007a50] 7e00                      moveq.l    #0,d7
[00007a52] 3e2c 000a                 move.w     10(a4),d7
[00007a56] 2f07                      move.l     d7,-(a7)
[00007a58] 4eb9 0000 0000            jsr        _memfree
[00007a5e] 4fef 000c                 lea.l      12(a7),a7
_getin_15:
[00007a62] 7e00                      moveq.l    #0,d7
_getin_13:
[00007a64] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00007a68] 4e5e                      unlk       a6
[00007a6a] 4e75                      rts

_getmem:
[00007a6c] 4e56 0000                 link       a6,#0
[00007a70] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007a74] 2a6e 0008                 movea.l    8(a6),a5
[00007a78] 082d 0004 0010            btst       #4,16(a5)
[00007a7e] 672e                      beq.s      _getmem_1
[00007a80] 2ebc 0000 b5a4            move.l     #_memlist,(a7)
[00007a86] 7e00                      moveq.l    #0,d7
[00007a88] 3e2d 000a                 move.w     10(a5),d7
[00007a8c] 2f07                      move.l     d7,-(a7)
[00007a8e] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007a94] 6606                      bne.s      _getmem_2
[00007a96] 2e2d 0004                 move.l     4(a5),d7
[00007a9a] 6006                      bra.s      _getmem_3
_getmem_2:
[00007a9c] 7e00                      moveq.l    #0,d7
[00007a9e] 3e2d 0008                 move.w     8(a5),d7
_getmem_3:
[00007aa2] 2f07                      move.l     d7,-(a7)
[00007aa4] 4eb9 0000 8f64            jsr        _srealloc
[00007aaa] 508f                      addq.l     #8,a7
[00007aac] 602a                      bra.s      _getmem_4
_getmem_1:
[00007aae] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00007ab4] 6604                      bne.s      _getmem_5
[00007ab6] 7e00                      moveq.l    #0,d7
[00007ab8] 6006                      bra.s      _getmem_6
_getmem_5:
[00007aba] 2e39 0000 0000            move.l     _usize,d7
_getmem_6:
[00007ac0] 2e87                      move.l     d7,(a7)
[00007ac2] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007ac8] 7e00                      moveq.l    #0,d7
[00007aca] 3e2d 000a                 move.w     10(a5),d7
[00007ace] 2f07                      move.l     d7,-(a7)
[00007ad0] 4eb9 0000 0000            jsr        _memalloc
[00007ad6] 508f                      addq.l     #8,a7
_getmem_4:
[00007ad8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007adc] 4e5e                      unlk       a6
[00007ade] 4e75                      rts

_movein:
[00007ae0] 4e56 0000                 link       a6,#0
[00007ae4] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007ae8] 2a6e 0008                 movea.l    8(a6),a5
[00007aec] 2e0d                      move.l     a5,d7
[00007aee] 662c                      bne.s      _movein_1
[00007af0] 2a79 0000 b514            movea.l    _plist,a5
_movein_3:
[00007af6] 2e0d                      move.l     a5,d7
[00007af8] 6722                      beq.s      _movein_1
[00007afa] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007b00] 6616                      bne.s      _movein_2
[00007b02] 4eb9 0000 2320            jsr        _curproc
[00007b08] 2247                      movea.l    d7,a1
[00007b0a] 7e00                      moveq.l    #0,d7
[00007b0c] 3e29 0008                 move.w     8(a1),d7
[00007b10] 2c2d 0004                 move.l     4(a5),d6
[00007b14] bc87                      cmp.l      d7,d6
[00007b16] 6704                      beq.s      _movein_1
_movein_2:
[00007b18] 2a55                      movea.l    (a5),a5
[00007b1a] 60da                      bra.s      _movein_3
_movein_1:
[00007b1c] 4aae 000c                 tst.l      12(a6)
[00007b20] 6704                      beq.s      _movein_4
[00007b22] 2e0d                      move.l     a5,d7
[00007b24] 6604                      bne.s      _movein_5
_movein_4:
[00007b26] 2e0d                      move.l     a5,d7
[00007b28] 6044                      bra.s      _movein_6
_movein_5:
[00007b2a] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007b30] 670c                      beq.s      _movein_7
[00007b32] 2ebc 0000 b4c8            move.l     #$00016236,(a7)
[00007b38] 4eb9 0000 0000            jsr        _panic
_movein_7:
[00007b3e] 7e00                      moveq.l    #0,d7
[00007b40] 3e2d 000a                 move.w     10(a5),d7
[00007b44] 2e87                      move.l     d7,(a7)
[00007b46] 2f2d 0004                 move.l     4(a5),-(a7)
[00007b4a] 7e00                      moveq.l    #0,d7
[00007b4c] 3e2d 0008                 move.w     8(a5),d7
[00007b50] 2f07                      move.l     d7,-(a7)
[00007b52] 4eb9 0000 0000            jsr        _memcopy
[00007b58] 508f                      addq.l     #8,a7
[00007b5a] 3b6d 0006 0008            move.w     6(a5),8(a5)
[00007b60] 42ad 0004                 clr.l      4(a5)
[00007b64] 2e8d                      move.l     a5,(a7)
[00007b66] 4eb9 0000 85c6            jsr        _runproc
[00007b6c] 2e0d                      move.l     a5,d7
_movein_6:
[00007b6e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007b72] 4e5e                      unlk       a6
[00007b74] 4e75                      rts

_schp0:
[00007b76] 4e56 0000                 link       a6,#0
[00007b7a] 48e7 8004                 movem.l    d0/a5,-(a7)
[00007b7e] 2a6e 0008                 movea.l    8(a6),a5
[00007b82] 082d 0000 0003            btst       #0,3(a5)
[00007b88] 6708                      beq.s      _schp0_1
[00007b8a] 08ed 0001 0003            bset       #1,3(a5)
[00007b90] 6018                      bra.s      _schp0_2
_schp0_1:
[00007b92] 4a95                      tst.l      (a5)
[00007b94] 6614                      bne.s      _schp0_2
[00007b96] 2ebc 0000 b4c0            move.l     #_swlist,(a7)
[00007b9c] 2f3c 0000 b500            move.l     #_outproc,-(a7)
[00007ba2] 4eb9 0000 8b66            jsr        _wakeupl
[00007ba8] 588f                      addq.l     #4,a7
_schp0_2:
[00007baa] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00007bae] 4e5e                      unlk       a6
[00007bb0] 4e75                      rts

_schswap:
[00007bb2] 4e56 0000                 link       a6,#0
[00007bb6] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00007bba] 2a6e 0008                 movea.l    8(a6),a5
[00007bbe] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00007bc4] 6604                      bne.s      _schswap_1
[00007bc6] 7e01                      moveq.l    #1,d7
[00007bc8] 6002                      bra.s      _schswap_2
_schswap_1:
[00007bca] 7e00                      moveq.l    #0,d7
_schswap_2:
[00007bcc] 2a07                      move.l     d7,d5
[00007bce] 08ad 0002 0010            bclr       #2,16(a5)
[00007bd4] 4a85                      tst.l      d5
[00007bd6] 6612                      bne.s      _schswap_3
[00007bd8] 4aad 0022                 tst.l      34(a5)
[00007bdc] 670c                      beq.s      _schswap_3
[00007bde] 43f8 0022                 lea.l      ($00000022).w,a1
[00007be2] d3ed 0022                 adda.l     34(a5),a1
[00007be6] 5369 000a                 subq.w     #1,10(a1)
_schswap_3:
[00007bea] 7e00                      moveq.l    #0,d7
[00007bec] 3e2d 0008                 move.w     8(a5),d7
[00007bf0] 7c00                      moveq.l    #0,d6
[00007bf2] 3c2d 000a                 move.w     10(a5),d6
[00007bf6] de86                      add.l      d6,d7
[00007bf8] 9eb9 0000 0000            sub.l      _usize,d7
[00007bfe] 7c00                      moveq.l    #0,d6
[00007c00] 3c39 0000 0000            move.w     _curbase,d6
[00007c06] be86                      cmp.l      d6,d7
[00007c08] 670e                      beq.s      _schswap_4
[00007c0a] 3e39 0000 b420            move.w     _exbase,d7
[00007c10] be79 0000 0000            cmp.w      _curbase,d7
[00007c16] 660c                      bne.s      _schswap_5
_schswap_4:
[00007c18] 4eb9 0000 0000            jsr        _uout
[00007c1e] 4279 0000 0000            clr.w      _curbase
_schswap_5:
[00007c24] 082d 0000 0010            btst       #0,16(a5)
[00007c2a] 670a                      beq.s      _schswap_6
[00007c2c] 2e8d                      move.l     a5,(a7)
[00007c2e] 4eb9 0000 85c6            jsr        _runproc
[00007c34] 6038                      bra.s      _schswap_7
_schswap_6:
[00007c36] 2e8d                      move.l     a5,(a7)
[00007c38] 4eb9 0000 7d70            jsr        _swapout
[00007c3e] 4a85                      tst.l      d5
[00007c40] 6704                      beq.s      _schswap_8
[00007c42] 7e00                      moveq.l    #0,d7
[00007c44] 6006                      bra.s      _schswap_9
_schswap_8:
[00007c46] 2e39 0000 0000            move.l     _usize,d7
_schswap_9:
[00007c4c] 2e87                      move.l     d7,(a7)
[00007c4e] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[00007c54] 7e00                      moveq.l    #0,d7
[00007c56] 3e2d 0008                 move.w     8(a5),d7
[00007c5a] 2f07                      move.l     d7,-(a7)
[00007c5c] 7e00                      moveq.l    #0,d7
[00007c5e] 3e2d 000a                 move.w     10(a5),d7
[00007c62] 2f07                      move.l     d7,-(a7)
[00007c64] 4eb9 0000 0000            jsr        _memfree
[00007c6a] 4fef 000c                 lea.l      12(a7),a7
_schswap_7:
[00007c6e] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007c74] 6612                      bne.s      _schswap_10
[00007c76] 3b6d 0006 0008            move.w     6(a5),8(a5)
[00007c7c] 42ad 0004                 clr.l      4(a5)
[00007c80] 2e8d                      move.l     a5,(a7)
[00007c82] 4eb9 0000 85c6            jsr        _runproc
_schswap_10:
[00007c88] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00007c8c] 4e5e                      unlk       a6
[00007c8e] 4e75                      rts

_swapin:
[00007c90] 4e56 0000                 link       a6,#0
[00007c94] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00007c98] 2a6e 0008                 movea.l    8(a6),a5
[00007c9c] 2a2e 000c                 move.l     12(a6),d5
[00007ca0] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007ca6] 6632                      bne.s      _swapin_1
[00007ca8] 2ebc 0000 b5a4            move.l     #_memlist,(a7)
[00007cae] 7e00                      moveq.l    #0,d7
[00007cb0] 3e2d 0008                 move.w     8(a5),d7
[00007cb4] 2f07                      move.l     d7,-(a7)
[00007cb6] 7e00                      moveq.l    #0,d7
[00007cb8] 3e2d 000a                 move.w     10(a5),d7
[00007cbc] 2f07                      move.l     d7,-(a7)
[00007cbe] 4eb9 0000 8e6e            jsr        _sfree
[00007cc4] 508f                      addq.l     #8,a7
[00007cc6] 4878 0001                 pea.l      ($00000001).w
[00007cca] 2f0d                      move.l     a5,-(a7)
[00007ccc] 4eba fe12                 jsr        _movein(pc)
[00007cd0] 508f                      addq.l     #8,a7
[00007cd2] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00007cd6] 4e5e                      unlk       a6
[00007cd8] 4e75                      rts
_swapin_1:
[00007cda] 3b45 0008                 move.w     d5,8(a5)
[00007cde] 082d 0000 0010            btst       #0,16(a5)
[00007ce4] 672c                      beq.s      _swapin_2
[00007ce6] 2eb9 0000 0000            move.l     _usize,(a7)
[00007cec] 2e05                      move.l     d5,d7
[00007cee] 7c00                      moveq.l    #0,d6
[00007cf0] 3c2d 000a                 move.w     10(a5),d6
[00007cf4] de86                      add.l      d6,d7
[00007cf6] 9eb9 0000 0000            sub.l      _usize,d7
[00007cfc] 2f07                      move.l     d7,-(a7)
[00007cfe] 7e00                      moveq.l    #0,d7
[00007d00] 3e39 0000 b420            move.w     _exbase,d7
[00007d06] 2f07                      move.l     d7,-(a7)
[00007d08] 4eb9 0000 0000            jsr        _memcopy
[00007d0e] 508f                      addq.l     #8,a7
[00007d10] 6030                      bra.s      _swapin_3
_swapin_2:
[00007d12] 4878 0010                 pea.l      ($00000010).w
[00007d16] 7e00                      moveq.l    #0,d7
[00007d18] 3e2d 000a                 move.w     10(a5),d7
[00007d1c] 2f07                      move.l     d7,-(a7)
[00007d1e] 2f05                      move.l     d5,-(a7)
[00007d20] 7e00                      moveq.l    #0,d7
[00007d22] 3e2d 000c                 move.w     12(a5),d7
[00007d26] 2f07                      move.l     d7,-(a7)
[00007d28] 4eb9 0000 0000            jsr        _swap
[00007d2e] 4fef 0010                 lea.l      16(a7),a7
[00007d32] 4a87                      tst.l      d7
[00007d34] 670c                      beq.s      _swapin_3
[00007d36] 2ebc 0000 b4cf            move.l     #$0001623D,(a7)
[00007d3c] 4eb9 0000 0000            jsr        _panic
_swapin_3:
[00007d42] 08ad 0000 0010            bclr       #0,16(a5)
[00007d48] 08ed 0002 0010            bset       #2,16(a5)
[00007d4e] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00007d54] 6712                      beq.s      _swapin_4
[00007d56] 4aad 0022                 tst.l      34(a5)
[00007d5a] 670c                      beq.s      _swapin_4
[00007d5c] 43f8 0022                 lea.l      ($00000022).w,a1
[00007d60] d3ed 0022                 adda.l     34(a5),a1
[00007d64] 5269 000a                 addq.w     #1,10(a1)
_swapin_4:
[00007d68] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00007d6c] 4e5e                      unlk       a6
[00007d6e] 4e75                      rts

_swapout:
[00007d70] 4e56 fffc                 link       a6,#-4
[00007d74] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00007d78] 2a6e 0008                 movea.l    8(a6),a5
[00007d7c] 4a79 0000 0000            tst.w      _swapdev
[00007d82] 660c                      bne.s      _swapout_1
[00007d84] 2ebc 0000 b4df            move.l     #$0001624D,(a7)
[00007d8a] 4eb9 0000 0000            jsr        _panic
_swapout_1:
[00007d90] 08ed 0003 0010            bset       #3,16(a5)
[00007d96] 7a00                      moveq.l    #0,d5
[00007d98] 3a2d 000c                 move.w     12(a5),d5
[00007d9c] 7800                      moveq.l    #0,d4
[00007d9e] 382d 0008                 move.w     8(a5),d4
[00007da2] 7e00                      moveq.l    #0,d7
[00007da4] 3e2d 000a                 move.w     10(a5),d7
[00007da8] 2d47 fffc                 move.l     d7,-4(a6)
[00007dac] 082d 0005 0010            btst       #5,16(a5)
[00007db2] 671c                      beq.s      _swapout_2
[00007db4] 7e00                      moveq.l    #0,d7
[00007db6] 3e2d 000e                 move.w     14(a5),d7
[00007dba] 9fae fffc                 sub.l      d7,-4(a6)
[00007dbe] 7e00                      moveq.l    #0,d7
[00007dc0] 3e2d 000e                 move.w     14(a5),d7
[00007dc4] d887                      add.l      d7,d4
[00007dc6] 7e00                      moveq.l    #0,d7
[00007dc8] 3e2d 000e                 move.w     14(a5),d7
[00007dcc] da87                      add.l      d7,d5
[00007dce] 600e                      bra.s      _swapout_3
_swapout_2:
[00007dd0] 082d 0000 0010            btst       #0,16(a5)
[00007dd6] 6606                      bne.s      _swapout_3
[00007dd8] 08ed 0005 0010            bset       #5,16(a5)
_swapout_3:
[00007dde] 4297                      clr.l      (a7)
[00007de0] 2f2e fffc                 move.l     -4(a6),-(a7)
[00007de4] 2f04                      move.l     d4,-(a7)
[00007de6] 2f05                      move.l     d5,-(a7)
[00007de8] 4eb9 0000 0000            jsr        _swap
[00007dee] 4fef 000c                 lea.l      12(a7),a7
[00007df2] 4a87                      tst.l      d7
[00007df4] 670c                      beq.s      _swapout_4
[00007df6] 2ebc 0000 b4ea            move.l     #$00016258,(a7)
[00007dfc] 4eb9 0000 0000            jsr        _panic
_swapout_4:
[00007e02] 022d 00f3 0010            andi.b     #$F3,16(a5)
[00007e08] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00007e0c] 4e5e                      unlk       a6
[00007e0e] 4e75                      rts

_swapp:
[00007e10] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00007e14] 4eb9 0000 0000            jsr        _spl0
[00007e1a] 7001                      moveq.l    #1,d0
[00007e1c] 23c0 0000 b4b8            move.l     d0,_p0st
[00007e22] 4eb9 0000 7ff0            jsr        _swbuy
[00007e28] 7002                      moveq.l    #2,d0
[00007e2a] 23c0 0000 b4b8            move.l     d0,_p0st
_swapp_7:
[00007e30] 7003                      moveq.l    #3,d0
[00007e32] 23c0 0000 b4b8            move.l     d0,_p0st
[00007e38] 99cc                      suba.l     a4,a4
[00007e3a] 23cc 0000 b4c4            move.l     a4,_p0px
[00007e40] 3a3c 7fff                 move.w     #$7FFF,d5
[00007e44] 48c5                      ext.l      d5
[00007e46] 7001                      moveq.l    #1,d0
[00007e48] 23c0 0000 b500            move.l     d0,_outproc
[00007e4e] 7001                      moveq.l    #1,d0
[00007e50] 23c0 0000 b504            move.l     d0,_swpwait
[00007e56] 2a79 0000 b514            movea.l    _plist,a5
_swapp_5:
[00007e5c] 2e0d                      move.l     a5,d7
[00007e5e] 6700 008a                 beq        _swapp_1
[00007e62] 082d 0003 0010            btst       #3,16(a5)
[00007e68] 667a                      bne.s      _swapp_2
[00007e6a] 7e05                      moveq.l    #5,d7
[00007e6c] 7c00                      moveq.l    #0,d6
[00007e6e] 1c2d 0010                 move.b     16(a5),d6
[00007e72] ce86                      and.l      d6,d7
[00007e74] 0c87 0000 0005            cmpi.l     #$00000005,d7
[00007e7a] 661c                      bne.s      _swapp_3
[00007e7c] 7004                      moveq.l    #4,d0
[00007e7e] 23c0 0000 b4b8            move.l     d0,_p0st
[00007e84] 284d                      movea.l    a5,a4
[00007e86] 23cc 0000 b4c4            move.l     a4,_p0px
[00007e8c] 2eb9 0000 b4c4            move.l     _p0px,(a7)
[00007e92] 4eba fd1e                 jsr        _schswap(pc)
[00007e96] 6052                      bra.s      _swapp_1
_swapp_3:
[00007e98] 2e8d                      move.l     a5,(a7)
[00007e9a] 4eb9 0000 8044            jsr        _swppri
[00007ea0] ba87                      cmp.l      d7,d5
[00007ea2] 6d40                      blt.s      _swapp_2
[00007ea4] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00007eaa] 6722                      beq.s      _swapp_4
[00007eac] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[00007eb2] 6630                      bne.s      _swapp_2
[00007eb4] 082d 0002 0010            btst       #2,16(a5)
[00007eba] 6712                      beq.s      _swapp_4
[00007ebc] 4aad 0022                 tst.l      34(a5)
[00007ec0] 6722                      beq.s      _swapp_2
[00007ec2] 226d 0022                 movea.l    34(a5),a1
[00007ec6] 0829 0002 0010            btst       #2,16(a1)
[00007ecc] 6616                      bne.s      _swapp_2
_swapp_4:
[00007ece] 284d                      movea.l    a5,a4
[00007ed0] 23cc 0000 b4c4            move.l     a4,_p0px
[00007ed6] 2eb9 0000 b4c4            move.l     _p0px,(a7)
[00007edc] 4eb9 0000 8044            jsr        _swppri
[00007ee2] 2a07                      move.l     d7,d5
_swapp_2:
[00007ee4] 2a55                      movea.l    (a5),a5
[00007ee6] 6000 ff74                 bra        _swapp_5
_swapp_1:
[00007eea] 2e0c                      move.l     a4,d7
[00007eec] 6652                      bne.s      _swapp_6
[00007eee] 0839 0001 0000 b503       btst       #1,$00016271
[00007ef6] 6600 ff38                 bne        _swapp_7
[00007efa] 7005                      moveq.l    #5,d0
[00007efc] 23c0 0000 b4b8            move.l     d0,_p0st
[00007f02] 4eb9 0000 8022            jsr        _swsell
[00007f08] 42b9 0000 b500            clr.l      _outproc
[00007f0e] 2ebc 0000 b4c0            move.l     #_swlist,(a7)
[00007f14] 4878 fffd                 pea.l      ($FFFFFFFD).w
[00007f18] 2f3c 0000 b500            move.l     #_outproc,-(a7)
[00007f1e] 4eb9 0000 8862            jsr        _sleepl
[00007f24] 508f                      addq.l     #8,a7
[00007f26] 7001                      moveq.l    #1,d0
[00007f28] 23c0 0000 b500            move.l     d0,_outproc
[00007f2e] 7006                      moveq.l    #6,d0
[00007f30] 23c0 0000 b4b8            move.l     d0,_p0st
[00007f36] 4eb9 0000 7ff0            jsr        _swbuy
[00007f3c] 6000 fef2                 bra        _swapp_7
_swapp_6:
[00007f40] 7001                      moveq.l    #1,d0
[00007f42] 23c0 0000 b504            move.l     d0,_swpwait
_swapp_10:
[00007f48] 4297                      clr.l      (a7)
[00007f4a] 2f0c                      move.l     a4,-(a7)
[00007f4c] 4eba f9e2                 jsr        _getin(pc)
[00007f50] 588f                      addq.l     #4,a7
[00007f52] 4a87                      tst.l      d7
[00007f54] 6600 feda                 bne        _swapp_7
[00007f58] 4878 0001                 pea.l      ($00000001).w
[00007f5c] 2f0c                      move.l     a4,-(a7)
[00007f5e] 4eba f9d0                 jsr        _getin(pc)
[00007f62] 508f                      addq.l     #8,a7
[00007f64] 4a87                      tst.l      d7
[00007f66] 6600 fec8                 bne        _swapp_7
[00007f6a] 7007                      moveq.l    #7,d0
[00007f6c] 23c0 0000 b4b8            move.l     d0,_p0st
[00007f72] 2e8c                      move.l     a4,(a7)
[00007f74] 4eb9 0000 8094            jsr        _throwout
[00007f7a] 4a87                      tst.l      d7
[00007f7c] 6604                      bne.s      _swapp_8
[00007f7e] 7e01                      moveq.l    #1,d7
[00007f80] 6002                      bra.s      _swapp_9
_swapp_8:
[00007f82] 7e00                      moveq.l    #0,d7
_swapp_9:
[00007f84] 4a87                      tst.l      d7
[00007f86] 67c0                      beq.s      _swapp_10
[00007f88] 2e39 0000 b504            move.l     _swpwait,d7
[00007f8e] 8eb9 0000 b500            or.l       _outproc,d7
[00007f94] 0807 0001                 btst       #1,d7
[00007f98] 6600 fe96                 bne        _swapp_7
[00007f9c] 7008                      moveq.l    #8,d0
[00007f9e] 23c0 0000 b4b8            move.l     d0,_p0st
[00007fa4] 4eb9 0000 8022            jsr        _swsell
[00007faa] 42b9 0000 b504            clr.l      _swpwait
[00007fb0] 42b9 0000 b500            clr.l      _outproc
[00007fb6] 2ebc 0000 b4c0            move.l     #_swlist,(a7)
[00007fbc] 4878 fffd                 pea.l      ($FFFFFFFD).w
[00007fc0] 2f3c 0000 b500            move.l     #_outproc,-(a7)
[00007fc6] 4eb9 0000 8862            jsr        _sleepl
[00007fcc] 508f                      addq.l     #8,a7
[00007fce] 7001                      moveq.l    #1,d0
[00007fd0] 23c0 0000 b504            move.l     d0,_swpwait
[00007fd6] 7001                      moveq.l    #1,d0
[00007fd8] 23c0 0000 b500            move.l     d0,_outproc
[00007fde] 7009                      moveq.l    #9,d0
[00007fe0] 23c0 0000 b4b8            move.l     d0,_p0st
[00007fe6] 4eb9 0000 7ff0            jsr        _swbuy
[00007fec] 6000 fe42                 bra        _swapp_7

_swbuy:
[00007ff0] 4e56 fffc                 link       a6,#-4
_swbuy_2:
[00007ff4] 4ab9 0000 b4bc            tst.l      _swflag
[00007ffa] 671a                      beq.s      _swbuy_1
[00007ffc] 2ebc 0000 b4c0            move.l     #_swlist,(a7)
[00008002] 4878 fffd                 pea.l      ($FFFFFFFD).w
[00008006] 2f3c 0000 b4bc            move.l     #_swflag,-(a7)
[0000800c] 4eb9 0000 8862            jsr        _sleepl
[00008012] 508f                      addq.l     #8,a7
[00008014] 60de                      bra.s      _swbuy_2
_swbuy_1:
[00008016] 7001                      moveq.l    #1,d0
[00008018] 23c0 0000 b4bc            move.l     d0,_swflag
[0000801e] 4e5e                      unlk       a6
[00008020] 4e75                      rts

_swsell:
[00008022] 4e56 fffc                 link       a6,#-4
[00008026] 42b9 0000 b4bc            clr.l      _swflag
[0000802c] 2ebc 0000 b4c0            move.l     #_swlist,(a7)
[00008032] 2f3c 0000 b4bc            move.l     #_swflag,-(a7)
[00008038] 4eb9 0000 8b66            jsr        _wakeupl
[0000803e] 588f                      addq.l     #4,a7
[00008040] 4e5e                      unlk       a6
[00008042] 4e75                      rts

_swppri:
[00008044] 4e56 0000                 link       a6,#0
[00008048] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000804c] 2a6e 0008                 movea.l    8(a6),a5
[00008050] 1a2d 0012                 move.b     18(a5),d5
[00008054] 4885                      ext.w      d5
[00008056] 48c5                      ext.l      d5
[00008058] 0c2d 0004 0011            cmpi.b     #$04,17(a5)
[0000805e] 6708                      beq.s      _swppri_1
[00008060] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00008066] 6620                      bne.s      _swppri_2
_swppri_1:
[00008068] 4a2d 0013                 tst.b      19(a5)
[0000806c] 6f0a                      ble.s      _swppri_3
[0000806e] 1e2d 0013                 move.b     19(a5),d7
[00008072] 4887                      ext.w      d7
[00008074] 48c7                      ext.l      d7
[00008076] da87                      add.l      d7,d5
_swppri_3:
[00008078] 0685 0000 001e            addi.l     #$0000001E,d5
_swppri_4:
[0000807e] 2e05                      move.l     d5,d7
[00008080] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00008084] 4e5e                      unlk       a6
[00008086] 4e75                      rts
_swppri_2:
[00008088] 082d 0000 0010            btst       #0,16(a5)
[0000808e] 67ee                      beq.s      _swppri_4
[00008090] 7a80                      moveq.l    #-128,d5
[00008092] 60ea                      bra.s      _swppri_4

_throwout:
[00008094] 4e56 fffc                 link       a6,#-4
[00008098] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000809c] 2a6e 0008                 movea.l    8(a6),a5
[000080a0] 97cb                      suba.l     a3,a3
[000080a2] 2e8d                      move.l     a5,(a7)
[000080a4] 4eba ff9e                 jsr        _swppri(pc)
[000080a8] 3d47 fffc                 move.w     d7,-4(a6)
[000080ac] 426e fffe                 clr.w      -2(a6)
[000080b0] 2879 0000 b514            movea.l    _plist,a4
_throwout_3:
[000080b6] 2e0c                      move.l     a4,d7
[000080b8] 6700 00d0                 beq        _throwout_1
[000080bc] 7e0d                      moveq.l    #13,d7
[000080be] 7c00                      moveq.l    #0,d6
[000080c0] 1c2c 0010                 move.b     16(a4),d6
[000080c4] ce86                      and.l      d6,d7
[000080c6] 0c87 0000 0004            cmpi.l     #$00000004,d7
[000080cc] 6704                      beq.s      _throwout_2
_throwout_5:
[000080ce] 2854                      movea.l    (a4),a4
[000080d0] 60e4                      bra.s      _throwout_3
_throwout_2:
[000080d2] 082c 0007 0010            btst       #7,16(a4)
[000080d8] 670e                      beq.s      _throwout_4
[000080da] 0c2c 0003 0011            cmpi.b     #$03,17(a4)
[000080e0] 6606                      bne.s      _throwout_4
[000080e2] 526e fffe                 addq.w     #1,-2(a6)
[000080e6] 60e6                      bra.s      _throwout_5
_throwout_4:
[000080e8] 0c2c 0005 0011            cmpi.b     #$05,17(a4)
[000080ee] 6612                      bne.s      _throwout_6
[000080f0] 4a6c 002c                 tst.w      44(a4)
[000080f4] 66d8                      bne.s      _throwout_5
[000080f6] b9ed 0022                 cmpa.l     34(a5),a4
[000080fa] 67d2                      beq.s      _throwout_5
[000080fc] 264c                      movea.l    a4,a3
[000080fe] 6000 008a                 bra        _throwout_1
_throwout_6:
[00008102] 082d 0004 0010            btst       #4,16(a5)
[00008108] 675e                      beq.s      _throwout_7
[0000810a] 2e8c                      move.l     a4,(a7)
[0000810c] 4eba ff36                 jsr        _swppri(pc)
[00008110] 3c2e fffc                 move.w     -4(a6),d6
[00008114] 48c6                      ext.l      d6
[00008116] bc87                      cmp.l      d7,d6
[00008118] 6eb4                      bgt.s      _throwout_5
[0000811a] 7e00                      moveq.l    #0,d7
[0000811c] 3e2c 000a                 move.w     10(a4),d7
[00008120] 2e87                      move.l     d7,(a7)
[00008122] 7e00                      moveq.l    #0,d7
[00008124] 3e2c 0008                 move.w     8(a4),d7
[00008128] 2f07                      move.l     d7,-(a7)
[0000812a] 7e00                      moveq.l    #0,d7
[0000812c] 3e2d 000a                 move.w     10(a5),d7
[00008130] 2f07                      move.l     d7,-(a7)
[00008132] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[00008138] 6606                      bne.s      _throwout_8
[0000813a] 2e2d 0004                 move.l     4(a5),d7
[0000813e] 6006                      bra.s      _throwout_9
_throwout_8:
[00008140] 7e00                      moveq.l    #0,d7
[00008142] 3e2d 0008                 move.w     8(a5),d7
_throwout_9:
[00008146] 2f07                      move.l     d7,-(a7)
[00008148] 4eb9 0000 8d68            jsr        _olap
[0000814e] 4fef 000c                 lea.l      12(a7),a7
[00008152] 4a87                      tst.l      d7
[00008154] 6700 ff78                 beq        _throwout_5
[00008158] 264c                      movea.l    a4,a3
[0000815a] 2e8b                      move.l     a3,(a7)
[0000815c] 4eba fee6                 jsr        _swppri(pc)
[00008160] 3d47 fffc                 move.w     d7,-4(a6)
[00008164] 6000 ff68                 bra        _throwout_5
_throwout_7:
[00008168] 2e8c                      move.l     a4,(a7)
[0000816a] 4eba fed8                 jsr        _swppri(pc)
[0000816e] 3c2e fffc                 move.w     -4(a6),d6
[00008172] 48c6                      ext.l      d6
[00008174] bc87                      cmp.l      d7,d6
[00008176] 6e00 ff56                 bgt        _throwout_5
[0000817a] 264c                      movea.l    a4,a3
[0000817c] 2e8b                      move.l     a3,(a7)
[0000817e] 4eba fec4                 jsr        _swppri(pc)
[00008182] 3d47 fffc                 move.w     d7,-4(a6)
[00008186] 6000 ff46                 bra        _throwout_5
_throwout_1:
[0000818a] 2e0b                      move.l     a3,d7
[0000818c] 662a                      bne.s      _throwout_10
[0000818e] 4a6e fffe                 tst.w      -2(a6)
[00008192] 6620                      bne.s      _throwout_11
[00008194] 266d 0022                 movea.l    34(a5),a3
[00008198] 2e0b                      move.l     a3,d7
[0000819a] 6718                      beq.s      _throwout_11
[0000819c] 7e0c                      moveq.l    #12,d7
[0000819e] 7c00                      moveq.l    #0,d6
[000081a0] 1c2b 0010                 move.b     16(a3),d6
[000081a4] ce86                      and.l      d6,d7
[000081a6] 0c87 0000 0004            cmpi.l     #$00000004,d7
[000081ac] 6606                      bne.s      _throwout_11
[000081ae] 4a6b 002c                 tst.w      44(a3)
[000081b2] 6704                      beq.s      _throwout_10
_throwout_11:
[000081b4] 7e00                      moveq.l    #0,d7
[000081b6] 6008                      bra.s      _throwout_12
_throwout_10:
[000081b8] 2e8b                      move.l     a3,(a7)
[000081ba] 4eba f9f6                 jsr        _schswap(pc)
[000081be] 7e01                      moveq.l    #1,d7
_throwout_12:
[000081c0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000081c4] 4e5e                      unlk       a6
[000081c6] 4e75                      rts

_txtexit:
[000081c8] 4e56 0000                 link       a6,#0
[000081cc] 48e7 8004                 movem.l    d0/a5,-(a7)
[000081d0] 2a6e 0008                 movea.l    8(a6),a5
[000081d4] 2e0d                      move.l     a5,d7
[000081d6] 6714                      beq.s      _txtexit_1
[000081d8] 536d 002c                 subq.w     #1,44(a5)
[000081dc] 536d 002a                 subq.w     #1,42(a5)
[000081e0] 6e0a                      bgt.s      _txtexit_1
[000081e2] 4297                      clr.l      (a7)
[000081e4] 2f0d                      move.l     a5,-(a7)
[000081e6] 4eba f63a                 jsr        _freemem(pc)
[000081ea] 588f                      addq.l     #4,a7
_txtexit_1:
[000081ec] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000081f0] 4e5e                      unlk       a6
[000081f2] 4e75                      rts

_baduser:
[000081f4] 4279 0000 0000            clr.w      _curbase
[000081fa] 23fc 0000 0000 0000 0000  move.l     #_u0,_pu
[00008204] 4e75                      rts

_makep:
[00008206] 4e56 0000                 link       a6,#0
[0000820a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000820e] 7a00                      moveq.l    #0,d5
[00008210] 4297                      clr.l      (a7)
[00008212] 4878 0044                 pea.l      ($00000044).w
[00008216] 4eb9 0000 00f6            jsr        _alloc
[0000821c] 588f                      addq.l     #4,a7
[0000821e] 2a47                      movea.l    d7,a5
[00008220] 2e0d                      move.l     a5,d7
[00008222] 6730                      beq.s      _makep_1
[00008224] 4aae 0008                 tst.l      8(a6)
[00008228] 6754                      beq.s      _makep_2
[0000822a] 2eb9 0000 0000            move.l     _usize,(a7)
[00008230] 2f3c 0000 b5a8            move.l     #_slist,-(a7)
[00008236] 2279 0000 0000            movea.l    _pu,a1
[0000823c] 2269 0010                 movea.l    16(a1),a1
[00008240] 7e00                      moveq.l    #0,d7
[00008242] 3e29 000a                 move.w     10(a1),d7
[00008246] 2f07                      move.l     d7,-(a7)
[00008248] 4eb9 0000 0000            jsr        _swpalloc
[0000824e] 508f                      addq.l     #8,a7
[00008250] 2a07                      move.l     d7,d5
[00008252] 662a                      bne.s      _makep_2
_makep_1:
[00008254] 2e0d                      move.l     a5,d7
[00008256] 6710                      beq.s      _makep_3
[00008258] 4297                      clr.l      (a7)
[0000825a] 2f0d                      move.l     a5,-(a7)
[0000825c] 4878 0044                 pea.l      ($00000044).w
[00008260] 4eb9 0000 0114            jsr        _free
[00008266] 508f                      addq.l     #8,a7
_makep_3:
[00008268] 2279 0000 0000            movea.l    _pu,a1
[0000826e] 137c 000b 0142            move.b     #$0B,322(a1)
[00008274] 7e00                      moveq.l    #0,d7
[00008276] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000827a] 4e5e                      unlk       a6
[0000827c] 4e75                      rts
_makep_2:
[0000827e] 4878 0044                 pea.l      ($00000044).w
[00008282] 2f0d                      move.l     a5,-(a7)
[00008284] 2279 0000 0000            movea.l    _pu,a1
[0000828a] 2869 0010                 movea.l    16(a1),a4
[0000828e] 2f0c                      move.l     a4,-(a7)
[00008290] 4eb9 0000 2754            jsr        _movbuf
[00008296] 4fef 000c                 lea.l      12(a7),a7
[0000829a] 4eb9 0000 8314            jsr        _newpid
[000082a0] 3b47 001c                 move.w     d7,28(a5)
[000082a4] 1b7c 0002 0011            move.b     #$02,17(a5)
[000082aa] 7e10                      moveq.l    #16,d7
[000082ac] 7c00                      moveq.l    #0,d6
[000082ae] 1c2c 0010                 move.b     16(a4),d6
[000082b2] ce86                      and.l      d6,d7
[000082b4] 7c0c                      moveq.l    #12,d6
[000082b6] 8c87                      or.l       d7,d6
[000082b8] 1b46 0010                 move.b     d6,16(a5)
[000082bc] 422d 0042                 clr.b      66(a5)
[000082c0] 3b45 000c                 move.w     d5,12(a5)
[000082c4] 3b6c 001c 003e            move.w     28(a4),62(a5)
[000082ca] 42ad 0026                 clr.l      38(a5)
[000082ce] 42ad 0004                 clr.l      4(a5)
[000082d2] 42ad 0032                 clr.l      50(a5)
[000082d6] 42ad 002a                 clr.l      42(a5)
[000082da] 4eb9 0000 0000            jsr        _spl7
[000082e0] 2ab9 0000 b514            move.l     _plist,(a5)
[000082e6] 23cd 0000 b514            move.l     a5,_plist
[000082ec] 4eb9 0000 0000            jsr        _spl0
[000082f2] 4eb9 0000 2374            jsr        _dupfiles
[000082f8] 4aad 0022                 tst.l      34(a5)
[000082fc] 670c                      beq.s      _makep_4
[000082fe] 43f8 0022                 lea.l      ($00000022).w,a1
[00008302] d3ed 0022                 adda.l     34(a5),a1
[00008306] 5269 0008                 addq.w     #1,8(a1)
_makep_4:
[0000830a] 2e0d                      move.l     a5,d7
[0000830c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00008310] 4e5e                      unlk       a6
[00008312] 4e75                      rts

_newpid:
[00008314] 48e7 8004                 movem.l    d0/a5,-(a7)
_newpid_4:
[00008318] 5279 0000 b52a            addq.w     #1,$00016298
[0000831e] 4a79 0000 b52a            tst.w      $00016298
[00008324] 6e08                      bgt.s      _newpid_1
[00008326] 33fc 0002 0000 b52a       move.w     #$0002,$00016298
_newpid_1:
[0000832e] 2a79 0000 b514            movea.l    _plist,a5
_newpid_3:
[00008334] 2e0d                      move.l     a5,d7
[00008336] 6710                      beq.s      _newpid_2
[00008338] 3e2d 001c                 move.w     28(a5),d7
[0000833c] be79 0000 b52a            cmp.w      $00016298,d7
[00008342] 6704                      beq.s      _newpid_2
[00008344] 2a55                      movea.l    (a5),a5
[00008346] 60ec                      bra.s      _newpid_3
_newpid_2:
[00008348] 2e0d                      move.l     a5,d7
[0000834a] 66cc                      bne.s      _newpid_4
[0000834c] 3e39 0000 b52a            move.w     $00016298,d7
[00008352] 48c7                      ext.l      d7
[00008354] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00008358] 4e75                      rts

_offrun:
[0000835a] 4e56 0000                 link       a6,#0
[0000835e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00008362] 2a6e 0008                 movea.l    8(a6),a5
[00008366] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[0000836c] 670e                      beq.s      _offrun_1
[0000836e] 2ebc 0000 b52c            move.l     #$0001629A,(a7)
[00008374] 4eb9 0000 20d6            jsr        _putfmt
[0000837a] 6044                      bra.s      _offrun_2
_offrun_1:
[0000837c] 287c 0000 b518            movea.l    #_runlist,a4
_offrun_5:
[00008382] 2e14                      move.l     (a4),d7
[00008384] be8d                      cmp.l      a5,d7
[00008386] 671a                      beq.s      _offrun_3
[00008388] 4a94                      tst.l      (a4)
[0000838a] 660c                      bne.s      _offrun_4
[0000838c] 2ebc 0000 b535            move.l     #$000162A3,(a7)
[00008392] 4eb9 0000 0000            jsr        _panic
_offrun_4:
[00008398] 7e22                      moveq.l    #34,d7
[0000839a] de94                      add.l      (a4),d7
[0000839c] 5087                      addq.l     #8,d7
[0000839e] 2847                      movea.l    d7,a4
[000083a0] 60e0                      bra.s      _offrun_5
_offrun_3:
[000083a2] 5379 0000 b50e            subq.w     #1,_nrun
[000083a8] 6c0c                      bge.s      _offrun_6
[000083aa] 2ebc 0000 b543            move.l     #$000162B1,(a7)
[000083b0] 4eb9 0000 0000            jsr        _panic
_offrun_6:
[000083b6] 28ad 002a                 move.l     42(a5),(a4)
[000083ba] 1b6e 000f 0011            move.b     15(a6),17(a5)
_offrun_2:
[000083c0] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000083c4] 4e5e                      unlk       a6
[000083c6] 4e75                      rts

_onplist:
[000083c8] 4e56 0000                 link       a6,#0
[000083cc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000083d0] 2a6e 0008                 movea.l    8(a6),a5
[000083d4] 2879 0000 b514            movea.l    _plist,a4
_onplist_4:
[000083da] 2e0c                      move.l     a4,d7
[000083dc] 670c                      beq.s      _onplist_1
[000083de] b9cd                      cmpa.l     a5,a4
[000083e0] 6604                      bne.s      _onplist_2
[000083e2] 7e01                      moveq.l    #1,d7
[000083e4] 6006                      bra.s      _onplist_3
_onplist_2:
[000083e6] 2854                      movea.l    (a4),a4
[000083e8] 60f0                      bra.s      _onplist_4
_onplist_1:
[000083ea] 7e00                      moveq.l    #0,d7
_onplist_3:
[000083ec] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000083f0] 4e5e                      unlk       a6
[000083f2] 4e75                      rts

_prsig:
[000083f4] 4e56 fffc                 link       a6,#-4
[000083f8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000083fc] 2a79 0000 0000            movea.l    _pu,a5
[00008402] 286d 0010                 movea.l    16(a5),a4
[00008406] 7a00                      moveq.l    #0,d5
[00008408] 1a2c 0042                 move.b     66(a4),d5
[0000840c] 422c 0042                 clr.b      66(a4)
[00008410] 2e05                      move.l     d5,d7
[00008412] e587                      asl.l      #2,d7
[00008414] 2247                      movea.l    d7,a1
[00008416] 45ed 00c8                 lea.l      200(a5),a2
[0000841a] 2d71 a800 fffc            move.l     0(a1,a2.l),-4(a6)
[00008420] 6742                      beq.s      _prsig_1
[00008422] 0c85 0000 0004            cmpi.l     #$00000004,d5
[00008428] 6716                      beq.s      _prsig_2
[0000842a] 0c85 0000 0005            cmpi.l     #$00000005,d5
[00008430] 670e                      beq.s      _prsig_2
[00008432] 2e05                      move.l     d5,d7
[00008434] e587                      asl.l      #2,d7
[00008436] 2247                      movea.l    d7,a1
[00008438] 45ed 00c8                 lea.l      200(a5),a2
[0000843c] 42b1 a800                 clr.l      0(a1,a2.l)
_prsig_2:
[00008440] 2e2d 0014                 move.l     20(a5),d7
[00008444] deb9 0000 0000            add.l      _sig_chk,d7
[0000844a] 2e87                      move.l     d7,(a7)
[0000844c] 2f2d 00c4                 move.l     196(a5),-(a7)
[00008450] 2f05                      move.l     d5,-(a7)
[00008452] 2f2e fffc                 move.l     -4(a6),-(a7)
[00008456] 486e 0008                 pea.l      8(a6)
[0000845a] 4eb9 0000 0000            jsr        _onentry
[00008460] 4fef 0010                 lea.l      16(a7),a7
_prsig_1:
[00008464] 7e01                      moveq.l    #1,d7
[00008466] eba7                      asl.l      d5,d7
[00008468] ceb9 0000 b526            and.l      _coresig,d7
[0000846e] 6716                      beq.s      _prsig_3
[00008470] 486e 0008                 pea.l      8(a6)
[00008474] 2f05                      move.l     d5,-(a7)
[00008476] 4eb9 0000 2aac            jsr        _core
[0000847c] 508f                      addq.l     #8,a7
[0000847e] 4a87                      tst.l      d7
[00008480] 6704                      beq.s      _prsig_3
[00008482] 08c5 0007                 bset       #7,d5
_prsig_3:
[00008486] 2e85                      move.l     d5,(a7)
[00008488] 42a7                      clr.l      -(a7)
[0000848a] 4eb9 0000 a7f0            jsr        _syexit
[00008490] 588f                      addq.l     #4,a7
[00008492] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00008496] 4e5e                      unlk       a6
[00008498] 4e75                      rts

_quantum:
[0000849a] 4e56 0000                 link       a6,#0
[0000849e] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000084a2] 2a6e 0008                 movea.l    8(a6),a5
[000084a6] 182d 0012                 move.b     18(a5),d4
[000084aa] 4884                      ext.w      d4
[000084ac] 48c4                      ext.l      d4
[000084ae] 4a84                      tst.l      d4
[000084b0] 6c06                      bge.s      _quantum_1
[000084b2] 2e04                      move.l     d4,d7
[000084b4] 4487                      neg.l      d7
[000084b6] 6012                      bra.s      _quantum_2
_quantum_1:
[000084b8] 4a2d 0013                 tst.b      19(a5)
[000084bc] 670a                      beq.s      _quantum_3
[000084be] 1e2d 0013                 move.b     19(a5),d7
[000084c2] 4887                      ext.w      d7
[000084c4] 48c7                      ext.l      d7
[000084c6] 6002                      bra.s      _quantum_2
_quantum_3:
[000084c8] 2e04                      move.l     d4,d7
_quantum_2:
[000084ca] 3c39 0000 b50a            move.w     _minquan,d6
[000084d0] 48c6                      ext.l      d6
[000084d2] de86                      add.l      d6,d7
[000084d4] 2a07                      move.l     d7,d5
[000084d6] 3e39 0000 b50c            move.w     _maxquan,d7
[000084dc] 48c7                      ext.l      d7
[000084de] ba87                      cmp.l      d7,d5
[000084e0] 6e04                      bgt.s      _quantum_4
[000084e2] 2e05                      move.l     d5,d7
[000084e4] 6008                      bra.s      _quantum_5
_quantum_4:
[000084e6] 3e39 0000 b50c            move.w     _maxquan,d7
[000084ec] 48c7                      ext.l      d7
_quantum_5:
[000084ee] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[000084f2] 4e5e                      unlk       a6
[000084f4] 4e75                      rts

_revpri:
[000084f6] 4e56 0000                 link       a6,#0
[000084fa] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[000084fe] 2a6e 0008                 movea.l    8(a6),a5
[00008502] 2a2e 000c                 move.l     12(a6),d5
[00008506] 162d 0012                 move.b     18(a5),d3
[0000850a] 4883                      ext.w      d3
[0000850c] 48c3                      ext.l      d3
[0000850e] 1e2d 0013                 move.b     19(a5),d7
[00008512] 4887                      ext.w      d7
[00008514] 48c7                      ext.l      d7
[00008516] 5a87                      addq.l     #5,d7
[00008518] 2847                      movea.l    d7,a4
[0000851a] 2e03                      move.l     d3,d7
[0000851c] de85                      add.l      d5,d7
[0000851e] 2807                      move.l     d7,d4
[00008520] 4a2d 0013                 tst.b      19(a5)
[00008524] 6c0a                      bge.s      _revpri_1
[00008526] 182d 0013                 move.b     19(a5),d4
[0000852a] 4884                      ext.w      d4
[0000852c] 48c4                      ext.l      d4
[0000852e] 6026                      bra.s      _revpri_2
_revpri_1:
[00008530] 4a85                      tst.l      d5
[00008532] 6c08                      bge.s      _revpri_3
[00008534] b68c                      cmp.l      a4,d3
[00008536] 6c04                      bge.s      _revpri_3
[00008538] 2803                      move.l     d3,d4
[0000853a] 601a                      bra.s      _revpri_2
_revpri_3:
[0000853c] 4a85                      tst.l      d5
[0000853e] 6c08                      bge.s      _revpri_4
[00008540] b88c                      cmp.l      a4,d4
[00008542] 6c04                      bge.s      _revpri_4
[00008544] 280c                      move.l     a4,d4
[00008546] 600e                      bra.s      _revpri_2
_revpri_4:
[00008548] 4a85                      tst.l      d5
[0000854a] 6f0a                      ble.s      _revpri_2
[0000854c] 0c83 0000 0019            cmpi.l     #$00000019,d3
[00008552] 6d02                      blt.s      _revpri_2
[00008554] 7819                      moveq.l    #25,d4
_revpri_2:
[00008556] 4aae 0010                 tst.l      16(a6)
[0000855a] 6706                      beq.s      _revpri_5
[0000855c] 08ad 0007 0010            bclr       #7,16(a5)
_revpri_5:
[00008562] 1b44 0012                 move.b     d4,18(a5)
[00008566] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[0000856c] 661c                      bne.s      _revpri_6
[0000856e] 4a85                      tst.l      d5
[00008570] 6e04                      bgt.s      _revpri_7
[00008572] b883                      cmp.l      d3,d4
[00008574] 6714                      beq.s      _revpri_6
_revpri_7:
[00008576] 4878 0002                 pea.l      ($00000002).w
[0000857a] 2f0d                      move.l     a5,-(a7)
[0000857c] 4eba fddc                 jsr        _offrun(pc)
[00008580] 508f                      addq.l     #8,a7
[00008582] 2e8d                      move.l     a5,(a7)
[00008584] 4eb9 0000 85c6            jsr        _runproc
_revpri_6:
[0000858a] 2e8d                      move.l     a5,(a7)
[0000858c] 4eba ff0c                 jsr        _quantum(pc)
[00008590] 1b47 0041                 move.b     d7,65(a5)
[00008594] 4aae 0010                 tst.l      16(a6)
[00008598] 6604                      bne.s      _revpri_8
[0000859a] b883                      cmp.l      d3,d4
[0000859c] 6720                      beq.s      _revpri_9
_revpri_8:
[0000859e] 7e00                      moveq.l    #0,d7
[000085a0] 1e2d 0010                 move.b     16(a5),d7
[000085a4] 0287 0000 008c            andi.l     #$0000008C,d7
[000085aa] 0c87 0000 0004            cmpi.l     #$00000004,d7
[000085b0] 660c                      bne.s      _revpri_9
[000085b2] 2ebc 0000 b504            move.l     #_swpwait,(a7)
[000085b8] 4eb9 0000 7b76            jsr        _schp0
_revpri_9:
[000085be] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000085c2] 4e5e                      unlk       a6
[000085c4] 4e75                      rts

_runproc:
[000085c6] 4e56 0000                 link       a6,#0
[000085ca] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000085ce] 2a6e 0008                 movea.l    8(a6),a5
[000085d2] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[000085d8] 6614                      bne.s      _runproc_1
[000085da] 2ebc 0000 b54d            move.l     #$000162BB,(a7)
[000085e0] 4eb9 0000 20d6            jsr        _putfmt
[000085e6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000085ea] 4e5e                      unlk       a6
[000085ec] 4e75                      rts
_runproc_1:
[000085ee] 0c2d 0004 0011            cmpi.b     #$04,17(a5)
[000085f4] 6708                      beq.s      _runproc_2
[000085f6] 0c2d 0001 0011            cmpi.b     #$01,17(a5)
[000085fc] 6606                      bne.s      _runproc_3
_runproc_2:
[000085fe] 1b6d 0013 0012            move.b     19(a5),18(a5)
_runproc_3:
[00008604] 287c 0000 b518            movea.l    #_runlist,a4
_runproc_5:
[0000860a] 4a94                      tst.l      (a4)
[0000860c] 6716                      beq.s      _runproc_4
[0000860e] 2254                      movea.l    (a4),a1
[00008610] 1e29 0012                 move.b     18(a1),d7
[00008614] be2d 0012                 cmp.b      18(a5),d7
[00008618] 6e0a                      bgt.s      _runproc_4
[0000861a] 7e22                      moveq.l    #34,d7
[0000861c] de94                      add.l      (a4),d7
[0000861e] 5087                      addq.l     #8,d7
[00008620] 2847                      movea.l    d7,a4
[00008622] 60e6                      bra.s      _runproc_5
_runproc_4:
[00008624] 4eb9 0000 0000            jsr        _spl7
[0000862a] 2b54 002a                 move.l     (a4),42(a5)
[0000862e] 288d                      move.l     a5,(a4)
[00008630] 42ad 0004                 clr.l      4(a5)
[00008634] 1b7c 0003 0011            move.b     #$03,17(a5)
[0000863a] 42ad 002e                 clr.l      46(a5)
[0000863e] 5279 0000 b50e            addq.w     #1,_nrun
[00008644] 4eb9 0000 0000            jsr        _spl0
[0000864a] 082d 0002 0010            btst       #2,16(a5)
[00008650] 6712                      beq.s      _runproc_6
[00008652] 4aad 0022                 tst.l      34(a5)
[00008656] 6718                      beq.s      _runproc_7
[00008658] 226d 0022                 movea.l    34(a5),a1
[0000865c] 0829 0002 0010            btst       #2,16(a1)
[00008662] 660c                      bne.s      _runproc_7
_runproc_6:
[00008664] 2ebc 0000 b500            move.l     #_outproc,(a7)
[0000866a] 4eb9 0000 7b76            jsr        _schp0
_runproc_7:
[00008670] 1e2d 0012                 move.b     18(a5),d7
[00008674] 4887                      ext.w      d7
[00008676] be79 0000 b508            cmp.w      _hipri,d7
[0000867c] 6e08                      bgt.s      _runproc_8
[0000867e] 7001                      moveq.l    #1,d0
[00008680] 23c0 0000 b4fc            move.l     d0,_hiproc
_runproc_8:
[00008686] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000868a] 4e5e                      unlk       a6
[0000868c] 4e75                      rts

_schwake:
[0000868e] 4e56 0000                 link       a6,#0
[00008692] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00008696] 2a6e 0008                 movea.l    8(a6),a5
[0000869a] 4eb9 0000 0000            jsr        _spl7
[000086a0] 2a07                      move.l     d7,d5
[000086a2] 4aad 002e                 tst.l      46(a5)
[000086a6] 6616                      bne.s      _schwake_1
[000086a8] 2b79 0000 b510 002e       move.l     _wakelist,46(a5)
[000086b0] 23cd 0000 b510            move.l     a5,_wakelist
[000086b6] 7001                      moveq.l    #1,d0
[000086b8] 23c0 0000 b4fc            move.l     d0,_hiproc
_schwake_1:
[000086be] 2e85                      move.l     d5,(a7)
[000086c0] 4eb9 0000 0000            jsr        _spl
[000086c6] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000086ca] 4e5e                      unlk       a6
[000086cc] 4e75                      rts

_sendsig:
[000086ce] 4e56 0000                 link       a6,#0
[000086d2] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000086d6] 2a6e 0008                 movea.l    8(a6),a5
[000086da] 2a2e 000c                 move.l     12(a6),d5
[000086de] 4a85                      tst.l      d5
[000086e0] 6f3e                      ble.s      _sendsig_1
[000086e2] 0c85 0000 0012            cmpi.l     #$00000012,d5
[000086e8] 6c36                      bge.s      _sendsig_1
[000086ea] 7e01                      moveq.l    #1,d7
[000086ec] eba7                      asl.l      d5,d7
[000086ee] cead 003a                 and.l      58(a5),d7
[000086f2] 662c                      bne.s      _sendsig_1
[000086f4] 2e8d                      move.l     a5,(a7)
[000086f6] 4eba fcd0                 jsr        _onplist(pc)
[000086fa] 4a87                      tst.l      d7
[000086fc] 6722                      beq.s      _sendsig_1
[000086fe] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[00008704] 671a                      beq.s      _sendsig_1
[00008706] 0c2d 0009 0042            cmpi.b     #$09,66(a5)
[0000870c] 6704                      beq.s      _sendsig_2
[0000870e] 1b45 0042                 move.b     d5,66(a5)
_sendsig_2:
[00008712] 0c2d 0004 0011            cmpi.b     #$04,17(a5)
[00008718] 6606                      bne.s      _sendsig_1
[0000871a] 2e8d                      move.l     a5,(a7)
[0000871c] 4eba ff70                 jsr        _schwake(pc)
_sendsig_1:
[00008720] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00008724] 4e5e                      unlk       a6
[00008726] 4e75                      rts

_setlock:
[00008728] 4e56 0000                 link       a6,#0
[0000872c] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00008730] 2279 0000 0000            movea.l    _pu,a1
[00008736] 7e10                      moveq.l    #16,d7
[00008738] dea9 0010                 add.l      16(a1),d7
[0000873c] 2a47                      movea.l    d7,a5
[0000873e] 7e08                      moveq.l    #8,d7
[00008740] 1c15                      move.b     (a5),d6
[00008742] 4886                      ext.w      d6
[00008744] 48c6                      ext.l      d6
[00008746] ce86                      and.l      d6,d7
[00008748] 2a07                      move.l     d7,d5
[0000874a] 4aae 0008                 tst.l      8(a6)
[0000874e] 6706                      beq.s      _setlock_1
[00008750] 08d5 0003                 bset       #3,(a5)
[00008754] 6004                      bra.s      _setlock_2
_setlock_1:
[00008756] 0895 0003                 bclr       #3,(a5)
_setlock_2:
[0000875a] 2e05                      move.l     d5,d7
[0000875c] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00008760] 4e5e                      unlk       a6
[00008762] 4e75                      rts

_setpu:
[00008764] 4e56 fffc                 link       a6,#-4
[00008768] 2e2e 0008                 move.l     8(a6),d7
[0000876c] 0c87 0000 0000            cmpi.l     #_proc0,d7
[00008772] 660a                      bne.s      _setpu_1
[00008774] 4297                      clr.l      (a7)
[00008776] 4eb9 0000 0000            jsr        _setpu1
[0000877c] 6024                      bra.s      _setpu_2
_setpu_1:
[0000877e] 226e 0008                 movea.l    8(a6),a1
[00008782] 7e00                      moveq.l    #0,d7
[00008784] 3e29 0008                 move.w     8(a1),d7
[00008788] 226e 0008                 movea.l    8(a6),a1
[0000878c] 7c00                      moveq.l    #0,d6
[0000878e] 3c29 000a                 move.w     10(a1),d6
[00008792] de86                      add.l      d6,d7
[00008794] 9eb9 0000 0000            sub.l      _usize,d7
[0000879a] 2e87                      move.l     d7,(a7)
[0000879c] 4eb9 0000 0000            jsr        _setpu1
_setpu_2:
[000087a2] 4e5e                      unlk       a6
[000087a4] 4e75                      rts

_settyp:
[000087a6] 4e56 0000                 link       a6,#0
[000087aa] 48e7 8004                 movem.l    d0/a5,-(a7)
[000087ae] 2279 0000 0000            movea.l    _pu,a1
[000087b4] 7e20                      moveq.l    #32,d7
[000087b6] dea9 0010                 add.l      16(a1),d7
[000087ba] 2a47                      movea.l    d7,a5
[000087bc] 4aae 000c                 tst.l      12(a6)
[000087c0] 6622                      bne.s      _settyp_1
[000087c2] 2e2e 0008                 move.l     8(a6),d7
[000087c6] 7c00                      moveq.l    #0,d6
[000087c8] 3c15                      move.w     (a5),d6
[000087ca] be86                      cmp.l      d6,d7
[000087cc] 6616                      bne.s      _settyp_1
[000087ce] 2279 0000 0000            movea.l    _pu,a1
[000087d4] 4a29 0130                 tst.b      304(a1)
[000087d8] 660a                      bne.s      _settyp_1
[000087da] 4255                      clr.w      (a5)
[000087dc] 5279 0000 b558            addq.w     #1,$000162C6
[000087e2] 601c                      bra.s      _settyp_2
_settyp_1:
[000087e4] 4aae 000c                 tst.l      12(a6)
[000087e8] 6716                      beq.s      _settyp_2
[000087ea] 4a55                      tst.w      (a5)
[000087ec] 6612                      bne.s      _settyp_2
[000087ee] 4a79 0000 b558            tst.w      $000162C6
[000087f4] 670a                      beq.s      _settyp_2
[000087f6] 3aae 000a                 move.w     10(a6),(a5)
[000087fa] 5379 0000 b558            subq.w     #1,$000162C6
_settyp_2:
[00008800] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00008804] 4e5e                      unlk       a6
[00008806] 4e75                      rts

_signal:
[00008808] 4e56 0000                 link       a6,#0
[0000880c] 48e7 8004                 movem.l    d0/a5,-(a7)
[00008810] 4aae 0008                 tst.l      8(a6)
[00008814] 6726                      beq.s      _signal_1
[00008816] 2a79 0000 b514            movea.l    _plist,a5
_signal_3:
[0000881c] 2e0d                      move.l     a5,d7
[0000881e] 671c                      beq.s      _signal_1
[00008820] 7e00                      moveq.l    #0,d7
[00008822] 3e2d 0020                 move.w     32(a5),d7
[00008826] beae 0008                 cmp.l      8(a6),d7
[0000882a] 660c                      bne.s      _signal_2
[0000882c] 2eae 000c                 move.l     12(a6),(a7)
[00008830] 2f0d                      move.l     a5,-(a7)
[00008832] 4eba fe9a                 jsr        _sendsig(pc)
[00008836] 588f                      addq.l     #4,a7
_signal_2:
[00008838] 2a55                      movea.l    (a5),a5
[0000883a] 60e0                      bra.s      _signal_3
_signal_1:
[0000883c] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00008840] 4e5e                      unlk       a6
[00008842] 4e75                      rts

_sleep:
[00008844] 4e56 fffc                 link       a6,#-4
[00008848] 2ebc 0000 b51c            move.l     #_waitlist,(a7)
[0000884e] 2f2e 000c                 move.l     12(a6),-(a7)
[00008852] 2f2e 0008                 move.l     8(a6),-(a7)
[00008856] 4eb9 0000 8862            jsr        _sleepl
[0000885c] 508f                      addq.l     #8,a7
[0000885e] 4e5e                      unlk       a6
[00008860] 4e75                      rts

_sleepl:
[00008862] 4e56 fffa                 link       a6,#-6
[00008866] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000886a] 2a6e 0010                 movea.l    16(a6),a5
[0000886e] 2279 0000 0000            movea.l    _pu,a1
[00008874] 2869 0010                 movea.l    16(a1),a4
[00008878] 4aae 000c                 tst.l      12(a6)
[0000887c] 6d0c                      blt.s      _sleepl_1
[0000887e] 2279 0000 b520            movea.l    _psignal,a1
[00008884] 4a11                      tst.b      (a1)
[00008886] 6600 00c4                 bne        _sleepl_2
_sleepl_1:
[0000888a] 1e2c 0013                 move.b     19(a4),d7
[0000888e] 4887                      ext.w      d7
[00008890] 3d47 fffe                 move.w     d7,-2(a6)
[00008894] 4aae 000c                 tst.l      12(a6)
[00008898] 660a                      bne.s      _sleepl_3
[0000889a] 4a2c 0012                 tst.b      18(a4)
[0000889e] 6f04                      ble.s      _sleepl_3
[000088a0] 7e00                      moveq.l    #0,d7
[000088a2] 6008                      bra.s      _sleepl_4
_sleepl_3:
[000088a4] 1e2c 0012                 move.b     18(a4),d7
[000088a8] 4887                      ext.w      d7
[000088aa] 48c7                      ext.l      d7
_sleepl_4:
[000088ac] 1947 0013                 move.b     d7,19(a4)
[000088b0] 1d6c 0041 fffb            move.b     65(a4),-5(a6)
[000088b6] 196e 000f 0012            move.b     15(a6),18(a4)
[000088bc] 08ac 0007 0010            bclr       #7,16(a4)
[000088c2] 4aae 000c                 tst.l      12(a6)
[000088c6] 6c0e                      bge.s      _sleepl_5
[000088c8] 4878 0001                 pea.l      ($00000001).w
[000088cc] 2f0c                      move.l     a4,-(a7)
[000088ce] 4eba fa8a                 jsr        _offrun(pc)
[000088d2] 508f                      addq.l     #8,a7
[000088d4] 6026                      bra.s      _sleepl_6
_sleepl_5:
[000088d6] 4878 0004                 pea.l      ($00000004).w
[000088da] 2f0c                      move.l     a4,-(a7)
[000088dc] 4eba fa7c                 jsr        _offrun(pc)
[000088e0] 508f                      addq.l     #8,a7
[000088e2] 4a6e fffe                 tst.w      -2(a6)
[000088e6] 6f08                      ble.s      _sleepl_7
[000088e8] 3e2e fffe                 move.w     -2(a6),d7
[000088ec] df2c 0012                 add.b      d7,18(a4)
_sleepl_7:
[000088f0] 2ebc 0000 b504            move.l     #_swpwait,(a7)
[000088f6] 4eb9 0000 7b76            jsr        _schp0
_sleepl_6:
[000088fc] 4eb9 0000 0000            jsr        _spl7
[00008902] 3d47 fffc                 move.w     d7,-4(a6)
[00008906] 296e 0008 0004            move.l     8(a6),4(a4)
[0000890c] 4a95                      tst.l      (a5)
[0000890e] 6704                      beq.s      _sleepl_8
[00008910] 2e15                      move.l     (a5),d7
[00008912] 6002                      bra.s      _sleepl_9
_sleepl_8:
[00008914] 2e0d                      move.l     a5,d7
_sleepl_9:
[00008916] 2947 002a                 move.l     d7,42(a4)
[0000891a] 43ec 002a                 lea.l      42(a4),a1
[0000891e] 2a89                      move.l     a1,(a5)
[00008920] 4eb9 0000 0000            jsr        _spl0
[00008926] 4eb9 0000 8974            jsr        _switchp
[0000892c] 4a2e fffb                 tst.b      -5(a6)
[00008930] 6706                      beq.s      _sleepl_10
[00008932] 196e fffb 0041            move.b     -5(a6),65(a4)
_sleepl_10:
[00008938] 196e ffff 0013            move.b     -1(a6),19(a4)
[0000893e] 7e00                      moveq.l    #0,d7
[00008940] 3e2e fffc                 move.w     -4(a6),d7
[00008944] 2e87                      move.l     d7,(a7)
[00008946] 4eb9 0000 0000            jsr        _spl
_sleepl_2:
[0000894c] 4aae 000c                 tst.l      12(a6)
[00008950] 6d1a                      blt.s      _sleepl_11
[00008952] 2279 0000 b520            movea.l    _psignal,a1
[00008958] 4a11                      tst.b      (a1)
[0000895a] 6710                      beq.s      _sleepl_11
[0000895c] 2279 0000 0000            movea.l    _pu,a1
[00008962] 2ea9 0008                 move.l     8(a1),(a7)
[00008966] 4eb9 0000 0000            jsr        _longjmp
_sleepl_11:
[0000896c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00008970] 4e5e                      unlk       a6
[00008972] 4e75                      rts

_switchp:
[00008974] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00008978] 2279 0000 0000            movea.l    _pu,a1
[0000897e] 2a69 0010                 movea.l    16(a1),a5
[00008982] 4eb9 0000 0000            jsr        _spl0
[00008988] 2279 0000 0000            movea.l    _pu,a1
[0000898e] 2ea9 0004                 move.l     4(a1),(a7)
[00008992] 4eb9 0000 0000            jsr        _setjmp
[00008998] 4a87                      tst.l      d7
[0000899a] 6706                      beq.s      _switchp_1
[0000899c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000089a0] 4e75                      rts
_switchp_1:
[000089a2] 4a39 0000 b34a            tst.b      _onflag
[000089a8] 6706                      beq.s      _switchp_2
[000089aa] 4eb9 0000 4f2c            jsr        _dounits
_switchp_2:
[000089b0] 2ebc 0000 0000            move.l     #_proc0,(a7)
[000089b6] 4eba fdac                 jsr        _setpu(pc)
[000089ba] 33fc 7fff 0000 b508       move.w     #$7FFF,_hipri
_switchp_14:
[000089c2] 42b9 0000 b4fc            clr.l      _hiproc
_switchp_4:
[000089c8] 2e39 0000 b510            move.l     _wakelist,d7
[000089ce] 0c87 0000 b510            cmpi.l     #_wakelist,d7
[000089d4] 672a                      beq.s      _switchp_3
[000089d6] 4eb9 0000 0000            jsr        _spl7
[000089dc] 2879 0000 b510            movea.l    _wakelist,a4
[000089e2] 23ec 002e 0000 b510       move.l     46(a4),_wakelist
[000089ea] 4eb9 0000 0000            jsr        _spl0
[000089f0] 2e8c                      move.l     a4,(a7)
[000089f2] 4eb9 0000 8b0c            jsr        _unsleepl
[000089f8] 2e87                      move.l     d7,(a7)
[000089fa] 4eba fbca                 jsr        _runproc(pc)
[000089fe] 60c8                      bra.s      _switchp_4
_switchp_3:
[00008a00] 4a39 0000 b34a            tst.b      _onflag
[00008a06] 6706                      beq.s      _switchp_5
[00008a08] 4eb9 0000 4f2c            jsr        _dounits
_switchp_5:
[00008a0e] 2879 0000 b518            movea.l    _runlist,a4
_switchp_9:
[00008a14] 2e0c                      move.l     a4,d7
[00008a16] 672e                      beq.s      _switchp_6
[00008a18] 082c 0002 0010            btst       #2,16(a4)
[00008a1e] 6720                      beq.s      _switchp_7
[00008a20] 4aac 0022                 tst.l      34(a4)
[00008a24] 670c                      beq.s      _switchp_8
[00008a26] 226c 0022                 movea.l    34(a4),a1
[00008a2a] 0829 0002 0010            btst       #2,16(a1)
[00008a30] 670e                      beq.s      _switchp_7
_switchp_8:
[00008a32] 4eb9 0000 9e84            jsr        _nopreemp
[00008a38] 4a87                      tst.l      d7
[00008a3a] 670a                      beq.s      _switchp_6
[00008a3c] b9cd                      cmpa.l     a5,a4
[00008a3e] 6706                      beq.s      _switchp_6
_switchp_7:
[00008a40] 286c 002a                 movea.l    42(a4),a4
[00008a44] 60ce                      bra.s      _switchp_9
_switchp_6:
[00008a46] 2e0c                      move.l     a4,d7
[00008a48] 6700 0086                 beq        _switchp_10
[00008a4c] 2e8c                      move.l     a4,(a7)
[00008a4e] 4eba fd14                 jsr        _setpu(pc)
[00008a52] 2279 0000 0000            movea.l    _pu,a1
[00008a58] 2e29 0010                 move.l     16(a1),d7
[00008a5c] be8c                      cmp.l      a4,d7
[00008a5e] 6636                      bne.s      _switchp_11
[00008a60] 43ec 0042                 lea.l      66(a4),a1
[00008a64] 23c9 0000 b520            move.l     a1,_psignal
[00008a6a] 1e2c 0012                 move.b     18(a4),d7
[00008a6e] 4887                      ext.w      d7
[00008a70] 33c7 0000 b508            move.w     d7,_hipri
[00008a76] 082c 0001 0010            btst       #1,16(a4)
[00008a7c] 6778                      beq.s      _switchp_12
[00008a7e] 08ac 0001 0010            bclr       #1,16(a4)
[00008a84] 2279 0000 0000            movea.l    _pu,a1
[00008a8a] 2ea9 000c                 move.l     12(a1),(a7)
[00008a8e] 4eb9 0000 0000            jsr        _longjmp
[00008a94] 6060                      bra.s      _switchp_12
_switchp_11:
[00008a96] 486c 0014                 pea.l      20(a4)
[00008a9a] 3e2c 001c                 move.w     28(a4),d7
[00008a9e] 48c7                      ext.l      d7
[00008aa0] 2f07                      move.l     d7,-(a7)
[00008aa2] 2f3c 0000 b55a            move.l     #$000162C8,-(a7)
[00008aa8] 4eb9 0000 20d6            jsr        _putfmt
[00008aae] 4fef 000c                 lea.l      12(a7),a7
[00008ab2] 4eb9 0000 9e92            jsr        _preemp
[00008ab8] 4878 0006                 pea.l      ($00000006).w
[00008abc] 2f0c                      move.l     a4,-(a7)
[00008abe] 4eba f89a                 jsr        _offrun(pc)
[00008ac2] 508f                      addq.l     #8,a7
[00008ac4] 4297                      clr.l      (a7)
[00008ac6] 2f0c                      move.l     a4,-(a7)
[00008ac8] 4eb9 0000 7822            jsr        _freemem
[00008ace] 588f                      addq.l     #4,a7
_switchp_10:
[00008ad0] 4eb9 0000 0000            jsr        _spl7
[00008ad6] 4a39 0000 b34a            tst.b      _onflag
[00008adc] 660e                      bne.s      _switchp_13
[00008ade] 4ab9 0000 b4fc            tst.l      _hiproc
[00008ae4] 6606                      bne.s      _switchp_13
[00008ae6] 4eb9 0000 0000            jsr        _idloop
_switchp_13:
[00008aec] 4eb9 0000 0000            jsr        _spl0
[00008af2] 6000 fece                 bra        _switchp_14
_switchp_12:
[00008af6] 2279 0000 0000            movea.l    _pu,a1
[00008afc] 2ea9 0004                 move.l     4(a1),(a7)
[00008b00] 4eb9 0000 0000            jsr        _longjmp
[00008b06] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00008b0a] 4e75                      rts

_unsleepl:
[00008b0c] 4e56 0000                 link       a6,#0
[00008b10] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00008b14] 7e22                      moveq.l    #34,d7
[00008b16] deae 0008                 add.l      8(a6),d7
[00008b1a] 5087                      addq.l     #8,d7
[00008b1c] 2847                      movea.l    d7,a4
[00008b1e] 2a54                      movea.l    (a4),a5
_unsleepl_2:
[00008b20] 2e15                      move.l     (a5),d7
[00008b22] be8c                      cmp.l      a4,d7
[00008b24] 6704                      beq.s      _unsleepl_1
[00008b26] 2a55                      movea.l    (a5),a5
[00008b28] 60f6                      bra.s      _unsleepl_2
_unsleepl_1:
[00008b2a] 4eb9 0000 0000            jsr        _spl7
[00008b30] 2a94                      move.l     (a4),(a5)
[00008b32] 2e15                      move.l     (a5),d7
[00008b34] be8d                      cmp.l      a5,d7
[00008b36] 6602                      bne.s      _unsleepl_3
[00008b38] 4295                      clr.l      (a5)
_unsleepl_3:
[00008b3a] 4eb9 0000 0000            jsr        _spl0
[00008b40] 2e2e 0008                 move.l     8(a6),d7
[00008b44] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00008b48] 4e5e                      unlk       a6
[00008b4a] 4e75                      rts

_wakeup:
[00008b4c] 4e56 fffc                 link       a6,#-4
[00008b50] 2ebc 0000 b51c            move.l     #_waitlist,(a7)
[00008b56] 2f2e 0008                 move.l     8(a6),-(a7)
[00008b5a] 4eb9 0000 8b66            jsr        _wakeupl
[00008b60] 588f                      addq.l     #4,a7
[00008b62] 4e5e                      unlk       a6
[00008b64] 4e75                      rts

_wakeupl:
[00008b66] 4e56 0000                 link       a6,#0
[00008b6a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00008b6e] 2a6e 000c                 movea.l    12(a6),a5
[00008b72] 4a95                      tst.l      (a5)
[00008b74] 6732                      beq.s      _wakeupl_1
[00008b76] 264d                      movea.l    a5,a3
_wakeupl_4:
[00008b78] 2e13                      move.l     (a3),d7
[00008b7a] be8d                      cmp.l      a5,d7
[00008b7c] 6722                      beq.s      _wakeupl_2
[00008b7e] 7e22                      moveq.l    #34,d7
[00008b80] 5087                      addq.l     #8,d7
[00008b82] 2c13                      move.l     (a3),d6
[00008b84] 9c87                      sub.l      d7,d6
[00008b86] 2846                      movea.l    d6,a4
[00008b88] 2e2c 0004                 move.l     4(a4),d7
[00008b8c] beae 0008                 cmp.l      8(a6),d7
[00008b90] 6606                      bne.s      _wakeupl_3
[00008b92] 2e8c                      move.l     a4,(a7)
[00008b94] 4eba faf8                 jsr        _schwake(pc)
_wakeupl_3:
[00008b98] 43ec 002a                 lea.l      42(a4),a1
[00008b9c] 2649                      movea.l    a1,a3
[00008b9e] 60d8                      bra.s      _wakeupl_4
_wakeupl_2:
[00008ba0] 2e15                      move.l     (a5),d7
[00008ba2] be8d                      cmp.l      a5,d7
[00008ba4] 6602                      bne.s      _wakeupl_1
[00008ba6] 4295                      clr.l      (a5)
_wakeupl_1:
[00008ba8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008bac] 4e5e                      unlk       a6
[00008bae] 4e75                      rts

_wchan:
[00008bb0] 4e56 0000                 link       a6,#0
[00008bb4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00008bb8] 2a6e 000c                 movea.l    12(a6),a5
[00008bbc] 4a95                      tst.l      (a5)
[00008bbe] 6726                      beq.s      _wchan_1
[00008bc0] 264d                      movea.l    a5,a3
_wchan_4:
[00008bc2] 2e13                      move.l     (a3),d7
[00008bc4] be8d                      cmp.l      a5,d7
[00008bc6] 671e                      beq.s      _wchan_1
[00008bc8] 7e22                      moveq.l    #34,d7
[00008bca] 5087                      addq.l     #8,d7
[00008bcc] 2c13                      move.l     (a3),d6
[00008bce] 9c87                      sub.l      d7,d6
[00008bd0] 2846                      movea.l    d6,a4
[00008bd2] b9ee 0008                 cmpa.l     8(a6),a4
[00008bd6] 6606                      bne.s      _wchan_2
[00008bd8] 2e2c 0004                 move.l     4(a4),d7
[00008bdc] 600a                      bra.s      _wchan_3
_wchan_2:
[00008bde] 43ec 002a                 lea.l      42(a4),a1
[00008be2] 2649                      movea.l    a1,a3
[00008be4] 60dc                      bra.s      _wchan_4
_wchan_1:
[00008be6] 7e00                      moveq.l    #0,d7
_wchan_3:
[00008be8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00008bec] 4e5e                      unlk       a6
[00008bee] 4e75                      rts

_ager:
[00008bf0] 4e56 fffc                 link       a6,#-4
[00008bf4] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00008bf8] 2a2e 0008                 move.l     8(a6),d5
[00008bfc] 0c79 0002 0000 b50e       cmpi.w     #$0002,_nrun
[00008c04] 6d00 00b6                 blt        _ager_1
[00008c08] 2279 0000 0000            movea.l    _pu,a1
[00008c0e] 2a69 0010                 movea.l    16(a1),a5
[00008c12] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[00008c18] 6600 00a2                 bne        _ager_1
[00008c1c] 7e00                      moveq.l    #0,d7
[00008c1e] 1e2d 0041                 move.b     65(a5),d7
[00008c22] ba87                      cmp.l      d7,d5
[00008c24] 6c08                      bge.s      _ager_2
[00008c26] 9b2d 0041                 sub.b      d5,65(a5)
[00008c2a] 6000 0090                 bra        _ager_1
_ager_2:
[00008c2e] 4a2d 0041                 tst.b      65(a5)
[00008c32] 660e                      bne.s      _ager_3
[00008c34] 2e8d                      move.l     a5,(a7)
[00008c36] 4eb9 0000 849a            jsr        _quantum
[00008c3c] 1b47 0041                 move.b     d7,65(a5)
[00008c40] 607a                      bra.s      _ager_1
_ager_3:
[00008c42] 4878 0001                 pea.l      ($00000001).w
[00008c46] 4878 0001                 pea.l      ($00000001).w
[00008c4a] 2f0d                      move.l     a5,-(a7)
[00008c4c] 4eb9 0000 84f6            jsr        _revpri
[00008c52] 4fef 000c                 lea.l      12(a7),a7
[00008c56] 2a79 0000 b518            movea.l    _runlist,a5
[00008c5c] 42b9 0000 b518            clr.l      _runlist
[00008c62] 4279 0000 b50e            clr.w      _nrun
_ager_6:
[00008c68] 2e0d                      move.l     a5,d7
[00008c6a] 6748                      beq.s      _ager_4
[00008c6c] 1b7c 0002 0011            move.b     #$02,17(a5)
[00008c72] 2d6d 002a fffc            move.l     42(a5),-4(a6)
[00008c78] 2279 0000 0000            movea.l    _pu,a1
[00008c7e] 2e29 0010                 move.l     16(a1),d7
[00008c82] be8d                      cmp.l      a5,d7
[00008c84] 671c                      beq.s      _ager_5
[00008c86] 4297                      clr.l      (a7)
[00008c88] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00008c8c] 2f0d                      move.l     a5,-(a7)
[00008c8e] 4eb9 0000 84f6            jsr        _revpri
[00008c94] 508f                      addq.l     #8,a7
[00008c96] 422d 0041                 clr.b      65(a5)
[00008c9a] 6006                      bra.s      _ager_5
_ager_7:
[00008c9c] 2a6e fffc                 movea.l    -4(a6),a5
[00008ca0] 60c6                      bra.s      _ager_6
_ager_5:
[00008ca2] 0c2d 0003 0011            cmpi.b     #$03,17(a5)
[00008ca8] 67f2                      beq.s      _ager_7
[00008caa] 2e8d                      move.l     a5,(a7)
[00008cac] 4eb9 0000 85c6            jsr        _runproc
[00008cb2] 60e8                      bra.s      _ager_7
_ager_4:
[00008cb4] 7001                      moveq.l    #1,d0
[00008cb6] 23c0 0000 b4fc            move.l     d0,_hiproc
_ager_1:
[00008cbc] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00008cc0] 4e5e                      unlk       a6
[00008cc2] 4e75                      rts

_contain:
[00008cc4] 4e56 0000                 link       a6,#0
[00008cc8] 2e2e 0008                 move.l     8(a6),d7
[00008ccc] beae 0010                 cmp.l      16(a6),d7
[00008cd0] 6218                      bhi.s      _contain_1
[00008cd2] 2e2e 0010                 move.l     16(a6),d7
[00008cd6] deae 0014                 add.l      20(a6),d7
[00008cda] 2c2e 0008                 move.l     8(a6),d6
[00008cde] dcae 000c                 add.l      12(a6),d6
[00008ce2] be86                      cmp.l      d6,d7
[00008ce4] 6204                      bhi.s      _contain_1
[00008ce6] 7e01                      moveq.l    #1,d7
[00008ce8] 6002                      bra.s      _contain_2
_contain_1:
[00008cea] 7e00                      moveq.l    #0,d7
_contain_2:
[00008cec] 4e5e                      unlk       a6
[00008cee] 4e75                      rts

_iotick:
[00008cf0] 4e56 fffc                 link       a6,#-4
[00008cf4] 4ab9 0000 b598            tst.l      _ticking
[00008cfa] 6668                      bne.s      _iotick_1
[00008cfc] 2eae 0008                 move.l     8(a6),(a7)
[00008d00] 4878 0005                 pea.l      ($00000005).w
[00008d04] 4eb9 0000 0000            jsr        a~lmul
[00008d0a] 2e17                      move.l     (a7),d7
[00008d0c] df79 0000 b674            add.w      d7,$000163E2
[00008d12] 3e39 0000 b596            move.w     _schrate,d7
[00008d18] be79 0000 b674            cmp.w      $000163E2,d7
[00008d1e] 6e44                      bgt.s      _iotick_1
[00008d20] 3e39 0000 b674            move.w     $000163E2,d7
[00008d26] 48c7                      ext.l      d7
[00008d28] 2e87                      move.l     d7,(a7)
[00008d2a] 3e39 0000 b596            move.w     _schrate,d7
[00008d30] 48c7                      ext.l      d7
[00008d32] 2f07                      move.l     d7,-(a7)
[00008d34] 4eb9 0000 0000            jsr        a~ldiv
[00008d3a] 2e17                      move.l     (a7),d7
[00008d3c] 23c7 0000 b58e            move.l     d7,$000162FC
[00008d42] 2ebc 0000 b586            move.l     #_agercb,(a7)
[00008d48] 4eb9 0000 4f8a            jsr        _trapout
[00008d4e] 3039 0000 b674            move.w     $000163E2,d0
[00008d54] 48c0                      ext.l      d0
[00008d56] 81f9 0000 b596            divs.w     _schrate,d0
[00008d5c] 4840                      swap       d0
[00008d5e] 33c0 0000 b674            move.w     d0,$000163E2
_iotick_1:
[00008d64] 4e5e                      unlk       a6
[00008d66] 4e75                      rts

_olap:
[00008d68] 4e56 0000                 link       a6,#0
[00008d6c] 2e2e 0010                 move.l     16(a6),d7
[00008d70] deae 0014                 add.l      20(a6),d7
[00008d74] 2c2e 0008                 move.l     8(a6),d6
[00008d78] bc87                      cmp.l      d7,d6
[00008d7a] 6414                      bcc.s      _olap_1
[00008d7c] 2e2e 0008                 move.l     8(a6),d7
[00008d80] deae 000c                 add.l      12(a6),d7
[00008d84] 2c2e 0010                 move.l     16(a6),d6
[00008d88] bc87                      cmp.l      d7,d6
[00008d8a] 6404                      bcc.s      _olap_1
[00008d8c] 7e01                      moveq.l    #1,d7
[00008d8e] 6002                      bra.s      _olap_2
_olap_1:
[00008d90] 7e00                      moveq.l    #0,d7
_olap_2:
[00008d92] 4e5e                      unlk       a6
[00008d94] 4e75                      rts

_profile:
[00008d96] 4e56 fffe                 link       a6,#-2
[00008d9a] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00008d9e] 2a2e 0008                 move.l     8(a6),d5
[00008da2] 2e39 0000 0000            move.l     _pu,d7
[00008da8] 0687 0000 0120            addi.l     #$00000120,d7
[00008dae] 2a47                      movea.l    d7,a5
[00008db0] 282d 000c                 move.l     12(a5),d4
[00008db4] baad 0008                 cmp.l      8(a5),d5
[00008db8] 6516                      bcs.s      _profile_1
[00008dba] 9aad 0008                 sub.l      8(a5),d5
_profile_3:
[00008dbe] 4a84                      tst.l      d4
[00008dc0] 6f06                      ble.s      _profile_2
[00008dc2] e28d                      lsr.l      #1,d5
[00008dc4] e384                      asl.l      #1,d4
[00008dc6] 60f6                      bra.s      _profile_3
_profile_2:
[00008dc8] 2e2d 0004                 move.l     4(a5),d7
[00008dcc] be85                      cmp.l      d5,d7
[00008dce] 6208                      bhi.s      _profile_4
_profile_1:
[00008dd0] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00008dd4] 4e5e                      unlk       a6
[00008dd6] 4e75                      rts
_profile_4:
[00008dd8] 2e05                      move.l     d5,d7
[00008dda] 0887 0000                 bclr       #0,d7
[00008dde] de95                      add.l      (a5),d7
[00008de0] 2a07                      move.l     d7,d5
[00008de2] 4878 0002                 pea.l      ($00000002).w
[00008de6] 486e fffe                 pea.l      -2(a6)
[00008dea] 2f05                      move.l     d5,-(a7)
[00008dec] 4eb9 0000 0000            jsr        _inbuf
[00008df2] 4fef 000c                 lea.l      12(a7),a7
[00008df6] 2e2e 000c                 move.l     12(a6),d7
[00008dfa] df6e fffe                 add.w      d7,-2(a6)
[00008dfe] 4878 0002                 pea.l      ($00000002).w
[00008e02] 2f05                      move.l     d5,-(a7)
[00008e04] 486e fffe                 pea.l      -2(a6)
[00008e08] 4eb9 0000 0000            jsr        _outbuf
[00008e0e] 4fef 000c                 lea.l      12(a7),a7
[00008e12] 60bc                      bra.s      _profile_1

_salloc:
[00008e14] 4e56 0000                 link       a6,#0
[00008e18] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00008e1c] 2a2e 0008                 move.l     8(a6),d5
[00008e20] 226e 000c                 movea.l    12(a6),a1
[00008e24] 2a51                      movea.l    (a1),a5
_salloc_2:
[00008e26] 2e0d                      move.l     a5,d7
[00008e28] 670e                      beq.s      _salloc_1
[00008e2a] 7e00                      moveq.l    #0,d7
[00008e2c] 3e2d 0004                 move.w     4(a5),d7
[00008e30] be85                      cmp.l      d5,d7
[00008e32] 6c04                      bge.s      _salloc_1
[00008e34] 2a55                      movea.l    (a5),a5
[00008e36] 60ee                      bra.s      _salloc_2
_salloc_1:
[00008e38] 2e0d                      move.l     a5,d7
[00008e3a] 6704                      beq.s      _salloc_3
[00008e3c] 4a85                      tst.l      d5
[00008e3e] 660c                      bne.s      _salloc_4
_salloc_3:
[00008e40] 7800                      moveq.l    #0,d4
_salloc_6:
[00008e42] 2e04                      move.l     d4,d7
[00008e44] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00008e48] 4e5e                      unlk       a6
[00008e4a] 4e75                      rts
_salloc_4:
[00008e4c] 7800                      moveq.l    #0,d4
[00008e4e] 382d 0006                 move.w     6(a5),d4
[00008e52] 9b6d 0004                 sub.w      d5,4(a5)
[00008e56] 6706                      beq.s      _salloc_5
[00008e58] db6d 0006                 add.w      d5,6(a5)
[00008e5c] 60e4                      bra.s      _salloc_6
_salloc_5:
[00008e5e] 2eae 000c                 move.l     12(a6),(a7)
[00008e62] 2f0d                      move.l     a5,-(a7)
[00008e64] 4eb9 0000 8f48            jsr        _sfrelst
[00008e6a] 588f                      addq.l     #4,a7
[00008e6c] 60d4                      bra.s      _salloc_6

_sfree:
[00008e6e] 4e56 0000                 link       a6,#0
[00008e72] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00008e76] 2a2e 0008                 move.l     8(a6),d5
[00008e7a] 99cc                      suba.l     a4,a4
[00008e7c] 226e 0010                 movea.l    16(a6),a1
[00008e80] 2a51                      movea.l    (a1),a5
_sfree_2:
[00008e82] 2e0d                      move.l     a5,d7
[00008e84] 6712                      beq.s      _sfree_1
[00008e86] 7e00                      moveq.l    #0,d7
[00008e88] 3e2d 0006                 move.w     6(a5),d7
[00008e8c] beae 000c                 cmp.l      12(a6),d7
[00008e90] 6c06                      bge.s      _sfree_1
[00008e92] 284d                      movea.l    a5,a4
[00008e94] 2a55                      movea.l    (a5),a5
[00008e96] 60ea                      bra.s      _sfree_2
_sfree_1:
[00008e98] 4a85                      tst.l      d5
[00008e9a] 6700 00a4                 beq        _sfree_3
[00008e9e] 2e0c                      move.l     a4,d7
[00008ea0] 6746                      beq.s      _sfree_4
[00008ea2] 7e00                      moveq.l    #0,d7
[00008ea4] 3e2c 0004                 move.w     4(a4),d7
[00008ea8] 7c00                      moveq.l    #0,d6
[00008eaa] 3c2c 0006                 move.w     6(a4),d6
[00008eae] de86                      add.l      d6,d7
[00008eb0] beae 000c                 cmp.l      12(a6),d7
[00008eb4] 6632                      bne.s      _sfree_4
[00008eb6] db6c 0004                 add.w      d5,4(a4)
[00008eba] 2e0d                      move.l     a5,d7
[00008ebc] 6700 0082                 beq        _sfree_3
[00008ec0] 2e05                      move.l     d5,d7
[00008ec2] deae 000c                 add.l      12(a6),d7
[00008ec6] 7c00                      moveq.l    #0,d6
[00008ec8] 3c2d 0006                 move.w     6(a5),d6
[00008ecc] be86                      cmp.l      d6,d7
[00008ece] 6670                      bne.s      _sfree_3
[00008ed0] 3e2d 0004                 move.w     4(a5),d7
[00008ed4] df6c 0004                 add.w      d7,4(a4)
[00008ed8] 2eae 0010                 move.l     16(a6),(a7)
[00008edc] 2f0d                      move.l     a5,-(a7)
[00008ede] 4eb9 0000 8f48            jsr        _sfrelst
[00008ee4] 588f                      addq.l     #4,a7
[00008ee6] 6058                      bra.s      _sfree_3
_sfree_4:
[00008ee8] 2e0d                      move.l     a5,d7
[00008eea] 671a                      beq.s      _sfree_5
[00008eec] 2e05                      move.l     d5,d7
[00008eee] deae 000c                 add.l      12(a6),d7
[00008ef2] 7c00                      moveq.l    #0,d6
[00008ef4] 3c2d 0006                 move.w     6(a5),d6
[00008ef8] be86                      cmp.l      d6,d7
[00008efa] 660a                      bne.s      _sfree_5
[00008efc] db6d 0004                 add.w      d5,4(a5)
[00008f00] 9b6d 0006                 sub.w      d5,6(a5)
[00008f04] 603a                      bra.s      _sfree_3
_sfree_5:
[00008f06] 2e8d                      move.l     a5,(a7)
[00008f08] 4878 0008                 pea.l      ($00000008).w
[00008f0c] 4eb9 0000 00f6            jsr        _alloc
[00008f12] 588f                      addq.l     #4,a7
[00008f14] 2a47                      movea.l    d7,a5
[00008f16] 2e0d                      move.l     a5,d7
[00008f18] 660e                      bne.s      _sfree_6
[00008f1a] 2ebc 0000 b676            move.l     #$000163E4,(a7)
[00008f20] 4eb9 0000 20d6            jsr        _putfmt
[00008f26] 6018                      bra.s      _sfree_3
_sfree_6:
[00008f28] 2e0c                      move.l     a4,d7
[00008f2a] 6704                      beq.s      _sfree_7
[00008f2c] 288d                      move.l     a5,(a4)
[00008f2e] 6006                      bra.s      _sfree_8
_sfree_7:
[00008f30] 226e 0010                 movea.l    16(a6),a1
[00008f34] 228d                      move.l     a5,(a1)
_sfree_8:
[00008f36] 3b45 0004                 move.w     d5,4(a5)
[00008f3a] 3b6e 000e 0006            move.w     14(a6),6(a5)
_sfree_3:
[00008f40] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00008f44] 4e5e                      unlk       a6
[00008f46] 4e75                      rts

_sfrelst:
[00008f48] 4e56 fffc                 link       a6,#-4
[00008f4c] 2eae 000c                 move.l     12(a6),(a7)
[00008f50] 2f2e 0008                 move.l     8(a6),-(a7)
[00008f54] 4878 0008                 pea.l      ($00000008).w
[00008f58] 4eb9 0000 0138            jsr        _frelst
[00008f5e] 508f                      addq.l     #8,a7
[00008f60] 4e5e                      unlk       a6
[00008f62] 4e75                      rts

_srealloc:
[00008f64] 4e56 0000                 link       a6,#0
[00008f68] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00008f6c] 226e 0010                 movea.l    16(a6),a1
[00008f70] 2a51                      movea.l    (a1),a5
_srealloc_2:
[00008f72] 2e0d                      move.l     a5,d7
[00008f74] 6728                      beq.s      _srealloc_1
[00008f76] 2eae 000c                 move.l     12(a6),(a7)
[00008f7a] 2f2e 0008                 move.l     8(a6),-(a7)
[00008f7e] 7e00                      moveq.l    #0,d7
[00008f80] 3e2d 0004                 move.w     4(a5),d7
[00008f84] 2f07                      move.l     d7,-(a7)
[00008f86] 7e00                      moveq.l    #0,d7
[00008f88] 3e2d 0006                 move.w     6(a5),d7
[00008f8c] 2f07                      move.l     d7,-(a7)
[00008f8e] 4eba fd34                 jsr        _contain(pc)
[00008f92] 4fef 000c                 lea.l      12(a7),a7
[00008f96] 4a87                      tst.l      d7
[00008f98] 6604                      bne.s      _srealloc_1
[00008f9a] 2a55                      movea.l    (a5),a5
[00008f9c] 60d4                      bra.s      _srealloc_2
_srealloc_1:
[00008f9e] 2e0d                      move.l     a5,d7
[00008fa0] 6604                      bne.s      _srealloc_3
[00008fa2] 7e00                      moveq.l    #0,d7
[00008fa4] 6060                      bra.s      _srealloc_4
_srealloc_3:
[00008fa6] 2e2e 0008                 move.l     8(a6),d7
[00008faa] 7c00                      moveq.l    #0,d6
[00008fac] 3c2d 0006                 move.w     6(a5),d6
[00008fb0] 9e86                      sub.l      d6,d7
[00008fb2] 2a07                      move.l     d7,d5
[00008fb4] 7e00                      moveq.l    #0,d7
[00008fb6] 3e2d 0004                 move.w     4(a5),d7
[00008fba] 9eae 000c                 sub.l      12(a6),d7
[00008fbe] 2807                      move.l     d7,d4
[00008fc0] 2eae 0010                 move.l     16(a6),(a7)
[00008fc4] 2f0d                      move.l     a5,-(a7)
[00008fc6] 4eba ff80                 jsr        _sfrelst(pc)
[00008fca] 588f                      addq.l     #4,a7
[00008fcc] 4a85                      tst.l      d5
[00008fce] 6714                      beq.s      _srealloc_5
[00008fd0] 2eae 0010                 move.l     16(a6),(a7)
[00008fd4] 2e2e 0008                 move.l     8(a6),d7
[00008fd8] 9e85                      sub.l      d5,d7
[00008fda] 2f07                      move.l     d7,-(a7)
[00008fdc] 2f05                      move.l     d5,-(a7)
[00008fde] 4eba fe8e                 jsr        _sfree(pc)
[00008fe2] 508f                      addq.l     #8,a7
_srealloc_5:
[00008fe4] ba84                      cmp.l      d4,d5
[00008fe6] 6c1a                      bge.s      _srealloc_6
[00008fe8] 2eae 0010                 move.l     16(a6),(a7)
[00008fec] 2e2e 000c                 move.l     12(a6),d7
[00008ff0] deae 0008                 add.l      8(a6),d7
[00008ff4] 2f07                      move.l     d7,-(a7)
[00008ff6] 2e04                      move.l     d4,d7
[00008ff8] 9e85                      sub.l      d5,d7
[00008ffa] 2f07                      move.l     d7,-(a7)
[00008ffc] 4eba fe70                 jsr        _sfree(pc)
[00009000] 508f                      addq.l     #8,a7
_srealloc_6:
[00009002] 2e2e 0008                 move.l     8(a6),d7
_srealloc_4:
[00009006] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000900a] 4e5e                      unlk       a6
[0000900c] 4e75                      rts

_tick:
[0000900e] 4e56 fffc                 link       a6,#-4
[00009012] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009016] 2279 0000 0000            movea.l    _pu,a1
[0000901c] 2669 0010                 movea.l    16(a1),a3
[00009020] 7001                      moveq.l    #1,d0
[00009022] 23c0 0000 b598            move.l     d0,_ticking
[00009028] 2e2e 0010                 move.l     16(a6),d7
[0000902c] 9f79 0000 b5b4            sub.w      d7,$00016322
[00009032] 4aae 000c                 tst.l      12(a6)
[00009036] 664e                      bne.s      _tick_1
[00009038] 2a7c 0000 b5ac            movea.l    #_cout,a5
_tick_3:
[0000903e] 4a95                      tst.l      (a5)
[00009040] 671c                      beq.s      _tick_2
[00009042] 4a6d 0008                 tst.w      8(a5)
[00009046] 6e16                      bgt.s      _tick_2
[00009048] 2ead 0004                 move.l     4(a5),(a7)
[0000904c] 2255                      movea.l    (a5),a1
[0000904e] 4e91                      jsr        (a1)
[00009050] 3e2d 0008                 move.w     8(a5),d7
[00009054] df6d 0012                 add.w      d7,18(a5)
[00009058] 4bed 000a                 lea.l      10(a5),a5
[0000905c] 60e0                      bra.s      _tick_3
_tick_2:
[0000905e] bbfc 0000 b5ac            cmpa.l     #_cout,a5
[00009064] 6720                      beq.s      _tick_1
[00009066] 287c 0000 b5ac            movea.l    #_cout,a4
_tick_4:
[0000906c] 2895                      move.l     (a5),(a4)
[0000906e] 6716                      beq.s      _tick_1
[00009070] 296d 0004 0004            move.l     4(a5),4(a4)
[00009076] 396d 0008 0008            move.w     8(a5),8(a4)
[0000907c] 4bed 000a                 lea.l      10(a5),a5
[00009080] 49ec 000a                 lea.l      10(a4),a4
[00009084] 60e6                      bra.s      _tick_4
_tick_1:
[00009086] 0c79 0001 0000 b50e       cmpi.w     #$0001,_nrun
[0000908e] 6f5c                      ble.s      _tick_5
[00009090] 2e2e 0010                 move.l     16(a6),d7
[00009094] df79 0000 b680            add.w      d7,$000163EE
[0000909a] 3e39 0000 b596            move.w     _schrate,d7
[000090a0] be79 0000 b680            cmp.w      $000163EE,d7
[000090a6] 6e44                      bgt.s      _tick_5
[000090a8] 3e39 0000 b680            move.w     $000163EE,d7
[000090ae] 48c7                      ext.l      d7
[000090b0] 2e87                      move.l     d7,(a7)
[000090b2] 3e39 0000 b596            move.w     _schrate,d7
[000090b8] 48c7                      ext.l      d7
[000090ba] 2f07                      move.l     d7,-(a7)
[000090bc] 4eb9 0000 0000            jsr        a~ldiv
[000090c2] 2e17                      move.l     (a7),d7
[000090c4] 23c7 0000 b58e            move.l     d7,$000162FC
[000090ca] 2ebc 0000 b586            move.l     #_agercb,(a7)
[000090d0] 4eb9 0000 4f8a            jsr        _trapout
[000090d6] 3039 0000 b680            move.w     $000163EE,d0
[000090dc] 48c0                      ext.l      d0
[000090de] 81f9 0000 b596            divs.w     _schrate,d0
[000090e4] 4840                      swap       d0
[000090e6] 33c0 0000 b680            move.w     d0,$000163EE
_tick_5:
[000090ec] 2e2e 0010                 move.l     16(a6),d7
[000090f0] df79 0000 b67c            add.w      d7,$000163EA
[000090f6] 0c79 0005 0000 b67c       cmpi.w     #$0005,$000163EA
[000090fe] 6d00 00fe                 blt        _tick_6
[00009102] 3e39 0000 b67c            move.w     $000163EA,d7
[00009108] 48c7                      ext.l      d7
[0000910a] 2e87                      move.l     d7,(a7)
[0000910c] 4878 0005                 pea.l      ($00000005).w
[00009110] 4eb9 0000 0000            jsr        a~ldiv
[00009116] 2e17                      move.l     (a7),d7
[00009118] 3d47 fffe                 move.w     d7,-2(a6)
[0000911c] 3039 0000 b67c            move.w     $000163EA,d0
[00009122] 48c0                      ext.l      d0
[00009124] 81fc 0005                 divs.w     #$0005,d0
[00009128] 4840                      swap       d0
[0000912a] 33c0 0000 b67c            move.w     d0,$000163EA
[00009130] 4aae 0008                 tst.l      8(a6)
[00009134] 6618                      bne.s      _tick_7
[00009136] 2e39 0000 0000            move.l     _pu,d7
[0000913c] 2247                      movea.l    d7,a1
[0000913e] 43e9 0110                 lea.l      272(a1),a1
[00009142] 3e2e fffe                 move.w     -2(a6),d7
[00009146] 48c7                      ext.l      d7
[00009148] dfa9 0004                 add.l      d7,4(a1)
[0000914c] 6034                      bra.s      _tick_8
_tick_7:
[0000914e] 2279 0000 0000            movea.l    _pu,a1
[00009154] 3e2e fffe                 move.w     -2(a6),d7
[00009158] 48c7                      ext.l      d7
[0000915a] dfa9 0110                 add.l      d7,272(a1)
[0000915e] 2e39 0000 0000            move.l     _pu,d7
[00009164] 2247                      movea.l    d7,a1
[00009166] 43e9 0120                 lea.l      288(a1),a1
[0000916a] 4aa9 000c                 tst.l      12(a1)
[0000916e] 6712                      beq.s      _tick_8
[00009170] 3e2e fffe                 move.w     -2(a6),d7
[00009174] 48c7                      ext.l      d7
[00009176] 2e87                      move.l     d7,(a7)
[00009178] 2f2e 0014                 move.l     20(a6),-(a7)
[0000917c] 4eba fc18                 jsr        _profile(pc)
[00009180] 588f                      addq.l     #4,a7
_tick_8:
[00009182] 3e2e fffe                 move.w     -2(a6),d7
[00009186] df79 0000 b67e            add.w      d7,$000163EC
[0000918c] 0c79 003c 0000 b67e       cmpi.w     #$003C,$000163EC
[00009194] 6d68                      blt.s      _tick_6
[00009196] 3e39 0000 b67e            move.w     $000163EC,d7
[0000919c] 48c7                      ext.l      d7
[0000919e] 2e87                      move.l     d7,(a7)
[000091a0] 4878 003c                 pea.l      ($0000003C).w
[000091a4] 4eb9 0000 0000            jsr        a~ldiv
[000091aa] 2e17                      move.l     (a7),d7
[000091ac] 3d47 fffc                 move.w     d7,-4(a6)
[000091b0] 3039 0000 b67e            move.w     $000163EC,d0
[000091b6] 48c0                      ext.l      d0
[000091b8] 81fc 003c                 divs.w     #$003C,d0
[000091bc] 4840                      swap       d0
[000091be] 33c0 0000 b67e            move.w     d0,$000163EC
[000091c4] 3e2e fffc                 move.w     -4(a6),d7
[000091c8] 48c7                      ext.l      d7
[000091ca] dfb9 0000 b59c            add.l      d7,_time
[000091d0] 4ab9 0000 b5a0            tst.l      _timeleft
[000091d6] 6726                      beq.s      _tick_6
[000091d8] 3e2e fffc                 move.w     -4(a6),d7
[000091dc] 48c7                      ext.l      d7
[000091de] dfb9 0000 b582            add.l      d7,$000162F0
[000091e4] 2e39 0000 b5a0            move.l     _timeleft,d7
[000091ea] beb9 0000 b582            cmp.l      $000162F0,d7
[000091f0] 620c                      bhi.s      _tick_6
[000091f2] 2ebc 0000 b576            move.l     #_alarmcb,(a7)
[000091f8] 4eb9 0000 4f8a            jsr        _trapout
_tick_6:
[000091fe] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009202] 4e5e                      unlk       a6
[00009204] 4e75                      rts

_timeout:
[00009206] 4e56 fffc                 link       a6,#-4
[0000920a] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000920e] 2a2e 0010                 move.l     16(a6),d5
[00009212] 4eb9 0000 0000            jsr        _spl7
[00009218] 3d47 fffc                 move.w     d7,-4(a6)
[0000921c] 2e85                      move.l     d5,(a7)
[0000921e] 4878 0005                 pea.l      ($00000005).w
[00009222] 4eb9 0000 0000            jsr        a~lmul
[00009228] 2a17                      move.l     (a7),d5
[0000922a] 2a7c 0000 b5ac            movea.l    #_cout,a5
[00009230] 3d7c 0013 fffe            move.w     #$0013,-2(a6)
_timeout_2:
[00009236] 536e fffe                 subq.w     #1,-2(a6)
[0000923a] 6d1c                      blt.s      _timeout_1
[0000923c] 4a95                      tst.l      (a5)
[0000923e] 6718                      beq.s      _timeout_1
[00009240] 3e2d 0008                 move.w     8(a5),d7
[00009244] 48c7                      ext.l      d7
[00009246] be85                      cmp.l      d5,d7
[00009248] 6e0e                      bgt.s      _timeout_1
[0000924a] 3e2d 0008                 move.w     8(a5),d7
[0000924e] 48c7                      ext.l      d7
[00009250] 9a87                      sub.l      d7,d5
[00009252] 4bed 000a                 lea.l      10(a5),a5
[00009256] 60de                      bra.s      _timeout_2
_timeout_1:
[00009258] 9b6d 0008                 sub.w      d5,8(a5)
[0000925c] 4a6e fffe                 tst.w      -2(a6)
[00009260] 6c0e                      bge.s      _timeout_3
[00009262] 2ebc 0000 b682            move.l     #$000163F0,(a7)
[00009268] 4eb9 0000 0000            jsr        _panic
[0000926e] 6034                      bra.s      _timeout_4
_timeout_3:
[00009270] 284d                      movea.l    a5,a4
_timeout_6:
[00009272] 4a94                      tst.l      (a4)
[00009274] 6706                      beq.s      _timeout_5
[00009276] 49ec 000a                 lea.l      10(a4),a4
[0000927a] 60f6                      bra.s      _timeout_6
_timeout_5:
[0000927c] bbcc                      cmpa.l     a4,a5
[0000927e] 6216                      bhi.s      _timeout_7
[00009280] 2954 000a                 move.l     (a4),10(a4)
[00009284] 296c 0004 000e            move.l     4(a4),14(a4)
[0000928a] 396c 0008 0012            move.w     8(a4),18(a4)
[00009290] 49ec fff6                 lea.l      -10(a4),a4
[00009294] 60e6                      bra.s      _timeout_5
_timeout_7:
[00009296] 2aae 0008                 move.l     8(a6),(a5)
[0000929a] 2b6e 000c 0004            move.l     12(a6),4(a5)
[000092a0] 3b45 0008                 move.w     d5,8(a5)
_timeout_4:
[000092a4] 3e2e fffc                 move.w     -4(a6),d7
[000092a8] 48c7                      ext.l      d7
[000092aa] 2e87                      move.l     d7,(a7)
[000092ac] 4eb9 0000 0000            jsr        _spl
[000092b2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000092b6] 4e5e                      unlk       a6
[000092b8] 4e75                      rts

_wakalrm:
[000092ba] 4e56 fffc                 link       a6,#-4
[000092be] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[000092c2] 2a6e 0008                 movea.l    8(a6),a5
[000092c6] 2a2e 000c                 move.l     12(a6),d5
[000092ca] 2e0d                      move.l     a5,d7
[000092cc] 674c                      beq.s      _wakalrm_1
[000092ce] 2d6d 0032 fffc            move.l     50(a5),-4(a6)
[000092d4] 670a                      beq.s      _wakalrm_2
[000092d6] 2e39 0000 b582            move.l     $000162F0,d7
[000092dc] 9fae fffc                 sub.l      d7,-4(a6)
_wakalrm_2:
[000092e0] 4eb9 0000 0000            jsr        _spl7
[000092e6] 2807                      move.l     d7,d4
[000092e8] 4a85                      tst.l      d5
[000092ea] 671c                      beq.s      _wakalrm_3
[000092ec] 4ab9 0000 b5a0            tst.l      _timeleft
[000092f2] 670e                      beq.s      _wakalrm_4
[000092f4] dab9 0000 b582            add.l      $000162F0,d5
[000092fa] bab9 0000 b5a0            cmp.l      _timeleft,d5
[00009300] 6406                      bcc.s      _wakalrm_3
_wakalrm_4:
[00009302] 23c5 0000 b5a0            move.l     d5,_timeleft
_wakalrm_3:
[00009308] 2e84                      move.l     d4,(a7)
[0000930a] 4eb9 0000 0000            jsr        _spl
[00009310] 2b45 0032                 move.l     d5,50(a5)
[00009314] 2e2e fffc                 move.l     -4(a6),d7
[00009318] 606c                      bra.s      _wakalrm_5
_wakalrm_1:
[0000931a] 42b9 0000 b5a0            clr.l      _timeleft
[00009320] 42b9 0000 b582            clr.l      $000162F0
[00009326] 2a79 0000 b514            movea.l    _plist,a5
_wakalrm_9:
[0000932c] 2e0d                      move.l     a5,d7
[0000932e] 6750                      beq.s      _wakalrm_6
[00009330] 4aad 0032                 tst.l      50(a5)
[00009334] 6708                      beq.s      _wakalrm_7
[00009336] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[0000933c] 6604                      bne.s      _wakalrm_8
_wakalrm_7:
[0000933e] 2a55                      movea.l    (a5),a5
[00009340] 60ea                      bra.s      _wakalrm_9
_wakalrm_8:
[00009342] 2e2d 0032                 move.l     50(a5),d7
[00009346] be85                      cmp.l      d5,d7
[00009348] 6214                      bhi.s      _wakalrm_10
[0000934a] 42ad 0032                 clr.l      50(a5)
[0000934e] 4878 000e                 pea.l      ($0000000E).w
[00009352] 2f0d                      move.l     a5,-(a7)
[00009354] 4eb9 0000 86ce            jsr        _sendsig
[0000935a] 508f                      addq.l     #8,a7
[0000935c] 60e0                      bra.s      _wakalrm_7
_wakalrm_10:
[0000935e] 9bad 0032                 sub.l      d5,50(a5)
[00009362] 4ab9 0000 b5a0            tst.l      _timeleft
[00009368] 670c                      beq.s      _wakalrm_11
[0000936a] 2e2d 0032                 move.l     50(a5),d7
[0000936e] beb9 0000 b5a0            cmp.l      _timeleft,d7
[00009374] 64c8                      bcc.s      _wakalrm_7
_wakalrm_11:
[00009376] 23ed 0032 0000 b5a0       move.l     50(a5),_timeleft
[0000937e] 60be                      bra.s      _wakalrm_7
_wakalrm_6:
[00009380] 2e39 0000 b5a0            move.l     _timeleft,d7
_wakalrm_5:
[00009386] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[0000938a] 4e5e                      unlk       a6
[0000938c] 4e75                      rts

__sytimes:
[0000938e] 4e56 fff4                 link       a6,#-12
[00009392] 48e7 8004                 movem.l    d0/a5,-(a7)
[00009396] 2a79 0000 0000            movea.l    _pu,a5
[0000939c] 3d6d 0112 fff4            move.w     274(a5),-12(a6)
[000093a2] 3d6d 0116 fff6            move.w     278(a5),-10(a6)
[000093a8] 2d6d 0118 fff8            move.l     280(a5),-8(a6)
[000093ae] 2d6d 011c fffc            move.l     284(a5),-4(a6)
[000093b4] 4878 000c                 pea.l      ($0000000C).w
[000093b8] 226e 0008                 movea.l    8(a6),a1
[000093bc] 2f11                      move.l     (a1),-(a7)
[000093be] 486e fff4                 pea.l      -12(a6)
[000093c2] 4eb9 0000 0000            jsr        _outbuf
[000093c8] 4fef 000c                 lea.l      12(a7),a7
[000093cc] 4a87                      tst.l      d7
[000093ce] 6706                      beq.s      __sytimes_1
[000093d0] 1b7c 000e 0142            move.b     #$0E,322(a5)
__sytimes_1:
[000093d6] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000093da] 4e5e                      unlk       a6
[000093dc] 4e75                      rts

_syalarm:
[000093de] 4e56 0000                 link       a6,#0
[000093e2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000093e6] 2a6e 0008                 movea.l    8(a6),a5
[000093ea] 2879 0000 0000            movea.l    _pu,a4
[000093f0] 4ab9 0000 b598            tst.l      _ticking
[000093f6] 6712                      beq.s      _syalarm_1
[000093f8] 2e95                      move.l     (a5),(a7)
[000093fa] 2f2c 0010                 move.l     16(a4),-(a7)
[000093fe] 4eb9 0000 92ba            jsr        _wakalrm
[00009404] 588f                      addq.l     #4,a7
[00009406] 2a87                      move.l     d7,(a5)
[00009408] 6006                      bra.s      _syalarm_2
_syalarm_1:
[0000940a] 197c 0013 0142            move.b     #$13,322(a4)
_syalarm_2:
[00009410] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00009414] 4e5e                      unlk       a6
[00009416] 4e75                      rts

_sygcsw:
[00009418] 4e56 0000                 link       a6,#0
[0000941c] 4eb9 0000 0000            jsr        _csw
[00009422] 226e 0008                 movea.l    8(a6),a1
[00009426] 2287                      move.l     d7,(a1)
[00009428] 4e5e                      unlk       a6
[0000942a] 4e75                      rts

_syggid:
[0000942c] 4e56 0000                 link       a6,#0
[00009430] 48e7 8004                 movem.l    d0/a5,-(a7)
[00009434] 2a79 0000 0000            movea.l    _pu,a5
[0000943a] 226e 0008                 movea.l    8(a6),a1
[0000943e] 7e00                      moveq.l    #0,d7
[00009440] 1e2d 0131                 move.b     305(a5),d7
[00009444] e187                      asl.l      #8,d7
[00009446] 7c00                      moveq.l    #0,d6
[00009448] 1c2d 0133                 move.b     307(a5),d6
[0000944c] 8e86                      or.l       d6,d7
[0000944e] 2287                      move.l     d7,(a1)
[00009450] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00009454] 4e5e                      unlk       a6
[00009456] 4e75                      rts

_sygpid:
[00009458] 4e56 0000                 link       a6,#0
[0000945c] 226e 0008                 movea.l    8(a6),a1
[00009460] 2479 0000 0000            movea.l    _pu,a2
[00009466] 246a 0010                 movea.l    16(a2),a2
[0000946a] 3e2a 001c                 move.w     28(a2),d7
[0000946e] 48c7                      ext.l      d7
[00009470] 2287                      move.l     d7,(a1)
[00009472] 4e5e                      unlk       a6
[00009474] 4e75                      rts

_sygppid:
[00009476] 4e56 0000                 link       a6,#0
[0000947a] 2f0d                      move.l     a5,-(a7)
[0000947c] 226e 0008                 movea.l    8(a6),a1
[00009480] 2479 0000 0000            movea.l    _pu,a2
[00009486] 4bf8 0022                 lea.l      ($00000022).w,a5
[0000948a] dbea 0010                 adda.l     16(a2),a5
[0000948e] 3e2d 001c                 move.w     28(a5),d7
[00009492] 48c7                      ext.l      d7
[00009494] 2287                      move.l     d7,(a1)
[00009496] 2a5f                      movea.l    (a7)+,a5
[00009498] 4e5e                      unlk       a6
[0000949a] 4e75                      rts

_sygtime:
[0000949c] 4e56 0000                 link       a6,#0
[000094a0] 226e 0008                 movea.l    8(a6),a1
[000094a4] 22b9 0000 b59c            move.l     _time,(a1)
[000094aa] 4e5e                      unlk       a6
[000094ac] 4e75                      rts

_syguid:
[000094ae] 4e56 0000                 link       a6,#0
[000094b2] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000094b6] 2a6e 0008                 movea.l    8(a6),a5
[000094ba] 2879 0000 0000            movea.l    _pu,a4
[000094c0] 7e00                      moveq.l    #0,d7
[000094c2] 1e2c 0130                 move.b     304(a4),d7
[000094c6] e187                      asl.l      #8,d7
[000094c8] 7c00                      moveq.l    #0,d6
[000094ca] 1c2c 0132                 move.b     306(a4),d6
[000094ce] 8e86                      or.l       d6,d7
[000094d0] 2a87                      move.l     d7,(a5)
[000094d2] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000094d6] 4e5e                      unlk       a6
[000094d8] 4e75                      rts

_sykill:
[000094da] 4e56 fff8                 link       a6,#-8
[000094de] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000094e2] 2879 0000 0000            movea.l    _pu,a4
[000094e8] 226e 0008                 movea.l    8(a6),a1
[000094ec] 0ca9 0000 0012 0004       cmpi.l     #$00000012,4(a1)
[000094f4] 650e                      bcs.s      _sykill_1
[000094f6] 197c 0016 0142            move.b     #$16,322(a4)
[000094fc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00009500] 4e5e                      unlk       a6
[00009502] 4e75                      rts
_sykill_1:
[00009504] 226e 0008                 movea.l    8(a6),a1
[00009508] 2a11                      move.l     (a1),d5
[0000950a] 660e                      bne.s      _sykill_2
[0000950c] 226c 0010                 movea.l    16(a4),a1
[00009510] 3e29 001e                 move.w     30(a1),d7
[00009514] 48c7                      ext.l      d7
[00009516] 4487                      neg.l      d7
[00009518] 2a07                      move.l     d7,d5
_sykill_2:
[0000951a] 42ae fffc                 clr.l      -4(a6)
[0000951e] 42ae fff8                 clr.l      -8(a6)
[00009522] 2a79 0000 b514            movea.l    _plist,a5
_sykill_5:
[00009528] 2e0d                      move.l     a5,d7
[0000952a] 6700 0092                 beq        _sykill_3
[0000952e] 3e2d 001c                 move.w     28(a5),d7
[00009532] 48c7                      ext.l      d7
[00009534] ba87                      cmp.l      d7,d5
[00009536] 671a                      beq.s      _sykill_4
[00009538] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[0000953e] 6712                      beq.s      _sykill_4
[00009540] 2e05                      move.l     d5,d7
[00009542] 4487                      neg.l      d7
[00009544] 3c2d 001e                 move.w     30(a5),d6
[00009548] 48c6                      ext.l      d6
[0000954a] be86                      cmp.l      d6,d7
[0000954c] 6704                      beq.s      _sykill_4
_sykill_7:
[0000954e] 2a55                      movea.l    (a5),a5
[00009550] 60d6                      bra.s      _sykill_5
_sykill_4:
[00009552] 7001                      moveq.l    #1,d0
[00009554] 2d40 fffc                 move.l     d0,-4(a6)
[00009558] 4a2c 0130                 tst.b      304(a4)
[0000955c] 6718                      beq.s      _sykill_6
[0000955e] bbec 0010                 cmpa.l     16(a4),a5
[00009562] 6712                      beq.s      _sykill_6
[00009564] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[0000956a] 67e2                      beq.s      _sykill_7
[0000956c] 1e2c 0130                 move.b     304(a4),d7
[00009570] be2d 0040                 cmp.b      64(a5),d7
[00009574] 66d8                      bne.s      _sykill_7
_sykill_6:
[00009576] 7001                      moveq.l    #1,d0
[00009578] 2d40 fff8                 move.l     d0,-8(a6)
[0000957c] 226e 0008                 movea.l    8(a6),a1
[00009580] 4aa9 0004                 tst.l      4(a1)
[00009584] 67c8                      beq.s      _sykill_7
[00009586] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[0000958c] 6714                      beq.s      _sykill_8
[0000958e] 226e 0008                 movea.l    8(a6),a1
[00009592] 2ea9 0004                 move.l     4(a1),(a7)
[00009596] 2f0d                      move.l     a5,-(a7)
[00009598] 4eb9 0000 86ce            jsr        _sendsig
[0000959e] 588f                      addq.l     #4,a7
[000095a0] 60ac                      bra.s      _sykill_7
_sykill_8:
[000095a2] 082d 0001 0010            btst       #1,16(a5)
[000095a8] 67a4                      beq.s      _sykill_7
[000095aa] 08ad 0001 0010            bclr       #1,16(a5)
[000095b0] 526d 002c                 addq.w     #1,44(a5)
[000095b4] 2e8d                      move.l     a5,(a7)
[000095b6] 4eb9 0000 81c8            jsr        _txtexit
[000095bc] 6090                      bra.s      _sykill_7
_sykill_3:
[000095be] 4aae fff8                 tst.l      -8(a6)
[000095c2] 6610                      bne.s      _sykill_9
[000095c4] 4aae fffc                 tst.l      -4(a6)
[000095c8] 6604                      bne.s      _sykill_10
[000095ca] 7e03                      moveq.l    #3,d7
[000095cc] 6002                      bra.s      _sykill_11
_sykill_10:
[000095ce] 7e01                      moveq.l    #1,d7
_sykill_11:
[000095d0] 1947 0142                 move.b     d7,322(a4)
_sykill_9:
[000095d4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000095d8] 4e5e                      unlk       a6
[000095da] 4e75                      rts

_synice:
[000095dc] 4e56 fffe                 link       a6,#-2
[000095e0] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000095e4] 2279 0000 0000            movea.l    _pu,a1
[000095ea] 2a69 0010                 movea.l    16(a1),a5
[000095ee] 226e 0008                 movea.l    8(a6),a1
[000095f2] 1d69 0003 ffff            move.b     3(a1),-1(a6)
[000095f8] 1a2e ffff                 move.b     -1(a6),d5
[000095fc] 4885                      ext.w      d5
[000095fe] 48c5                      ext.l      d5
[00009600] 4a85                      tst.l      d5
[00009602] 6c0e                      bge.s      _synice_1
[00009604] 4eb9 0000 2600            jsr        _isuper
[0000960a] 4a87                      tst.l      d7
[0000960c] 6604                      bne.s      _synice_1
[0000960e] 7a00                      moveq.l    #0,d5
[00009610] 600a                      bra.s      _synice_2
_synice_1:
[00009612] 0c85 0000 0014            cmpi.l     #$00000014,d5
[00009618] 6f02                      ble.s      _synice_2
[0000961a] 7a14                      moveq.l    #20,d5
_synice_2:
[0000961c] 1b45 0013                 move.b     d5,19(a5)
[00009620] 0c85 ffff ffec            cmpi.l     #$FFFFFFEC,d5
[00009626] 6e08                      bgt.s      _synice_3
[00009628] 08ed 0003 0010            bset       #3,16(a5)
[0000962e] 600a                      bra.s      _synice_4
_synice_3:
[00009630] 4a85                      tst.l      d5
[00009632] 6f06                      ble.s      _synice_4
[00009634] 08ad 0003 0010            bclr       #3,16(a5)
_synice_4:
[0000963a] 4878 0001                 pea.l      ($00000001).w
[0000963e] 2e05                      move.l     d5,d7
[00009640] 5a87                      addq.l     #5,d7
[00009642] 1c2d 0012                 move.b     18(a5),d6
[00009646] 4886                      ext.w      d6
[00009648] 48c6                      ext.l      d6
[0000964a] 9e86                      sub.l      d6,d7
[0000964c] 2f07                      move.l     d7,-(a7)
[0000964e] 2f0d                      move.l     a5,-(a7)
[00009650] 4eb9 0000 84f6            jsr        _revpri
[00009656] 4fef 000c                 lea.l      12(a7),a7
[0000965a] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000965e] 4e5e                      unlk       a6
[00009660] 4e75                      rts

_synone:
[00009662] 2279 0000 0000            movea.l    _pu,a1
[00009668] 137c 0023 0142            move.b     #$23,322(a1)
[0000966e] 4e75                      rts

_sypause:
[00009670] 4878 0007                 pea.l      ($00000007).w
[00009674] 2f3c 0000 b68a            move.l     #$000163F8,-(a7)
[0000967a] 4eb9 0000 8844            jsr        _sleep
[00009680] 508f                      addq.l     #8,a7
[00009682] 4e75                      rts

_sypgrp:
[00009684] 4e56 0000                 link       a6,#0
[00009688] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000968c] 2279 0000 0000            movea.l    _pu,a1
[00009692] 2a69 0010                 movea.l    16(a1),a5
[00009696] 226e 0008                 movea.l    8(a6),a1
[0000969a] 4a91                      tst.l      (a1)
[0000969c] 6706                      beq.s      _sypgrp_1
[0000969e] 3b6d 001c 001e            move.w     28(a5),30(a5)
_sypgrp_1:
[000096a4] 226e 0008                 movea.l    8(a6),a1
[000096a8] 3e2d 001e                 move.w     30(a5),d7
[000096ac] 48c7                      ext.l      d7
[000096ae] 2287                      move.l     d7,(a1)
[000096b0] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000096b4] 4e5e                      unlk       a6
[000096b6] 4e75                      rts

_syprof:
[000096b8] 4e56 0000                 link       a6,#0
[000096bc] 4878 0010                 pea.l      ($00000010).w
[000096c0] 2e39 0000 0000            move.l     _pu,d7
[000096c6] 2f07                      move.l     d7,-(a7)
[000096c8] 0697 0000 0120            addi.l     #$00000120,(a7)
[000096ce] 2f2e 0008                 move.l     8(a6),-(a7)
[000096d2] 4eb9 0000 2754            jsr        _movbuf
[000096d8] 4fef 000c                 lea.l      12(a7),a7
[000096dc] 4e5e                      unlk       a6
[000096de] 4e75                      rts

_sysgid:
[000096e0] 4e56 0000                 link       a6,#0
[000096e4] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000096e8] 2a6e 0008                 movea.l    8(a6),a5
[000096ec] 2879 0000 0000            movea.l    _pu,a4
[000096f2] 7e00                      moveq.l    #0,d7
[000096f4] 1e2c 0131                 move.b     305(a4),d7
[000096f8] be95                      cmp.l      (a5),d7
[000096fa] 6714                      beq.s      _sysgid_1
[000096fc] 7e00                      moveq.l    #0,d7
[000096fe] 1e2c 0133                 move.b     307(a4),d7
[00009702] be95                      cmp.l      (a5),d7
[00009704] 670a                      beq.s      _sysgid_1
[00009706] 4eb9 0000 2600            jsr        _isuper
[0000970c] 4a87                      tst.l      d7
[0000970e] 670c                      beq.s      _sysgid_2
_sysgid_1:
[00009710] 196d 0003 0131            move.b     3(a5),305(a4)
[00009716] 196d 0003 0133            move.b     3(a5),307(a4)
_sysgid_2:
[0000971c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00009720] 4e5e                      unlk       a6
[00009722] 4e75                      rts

_sysig:
[00009724] 4e56 fffc                 link       a6,#-4
[00009728] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[0000972c] 226e 0008                 movea.l    8(a6),a1
[00009730] 2a11                      move.l     (a1),d5
[00009732] 2a79 0000 0000            movea.l    _pu,a5
[00009738] 286d 0010                 movea.l    16(a5),a4
[0000973c] 226e 0008                 movea.l    8(a6),a1
[00009740] 2d69 0004 fffc            move.l     4(a1),-4(a6)
[00009746] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[0000974c] 6614                      bne.s      _sysig_1
[0000974e] 4aad 00c4                 tst.l      196(a5)
[00009752] 660e                      bne.s      _sysig_1
[00009754] 2b6e fffc 00c4            move.l     -4(a6),196(a5)
[0000975a] 226e 0008                 movea.l    8(a6),a1
[0000975e] 4291                      clr.l      (a1)
[00009760] 601c                      bra.s      _sysig_2
_sysig_1:
[00009762] 4a85                      tst.l      d5
[00009764] 6f10                      ble.s      _sysig_3
[00009766] 0c85 0000 0012            cmpi.l     #$00000012,d5
[0000976c] 6c08                      bge.s      _sysig_3
[0000976e] 0c85 0000 0009            cmpi.l     #$00000009,d5
[00009774] 6610                      bne.s      _sysig_4
_sysig_3:
[00009776] 226e 0008                 movea.l    8(a6),a1
[0000977a] 70ff                      moveq.l    #-1,d0
[0000977c] 2280                      move.l     d0,(a1)
_sysig_2:
[0000977e] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[00009782] 4e5e                      unlk       a6
[00009784] 4e75                      rts
_sysig_4:
[00009786] 226e 0008                 movea.l    8(a6),a1
[0000978a] 2e05                      move.l     d5,d7
[0000978c] e587                      asl.l      #2,d7
[0000978e] 2447                      movea.l    d7,a2
[00009790] 47ed 00c8                 lea.l      200(a5),a3
[00009794] 22b2 b800                 move.l     0(a2,a3.l),(a1)
[00009798] 2e05                      move.l     d5,d7
[0000979a] e587                      asl.l      #2,d7
[0000979c] 2247                      movea.l    d7,a1
[0000979e] 45ed 00c8                 lea.l      200(a5),a2
[000097a2] 23ae fffc a800            move.l     -4(a6),0(a1,a2.l)
[000097a8] 0cae 0000 0001 fffc       cmpi.l     #$00000001,-4(a6)
[000097b0] 670c                      beq.s      _sysig_5
[000097b2] 7e01                      moveq.l    #1,d7
[000097b4] eba7                      asl.l      d5,d7
[000097b6] 4687                      not.l      d7
[000097b8] cfac 003a                 and.l      d7,58(a4)
[000097bc] 60c0                      bra.s      _sysig_2
_sysig_5:
[000097be] 7e01                      moveq.l    #1,d7
[000097c0] eba7                      asl.l      d5,d7
[000097c2] 8fac 003a                 or.l       d7,58(a4)
[000097c6] 7e00                      moveq.l    #0,d7
[000097c8] 1e2c 0042                 move.b     66(a4),d7
[000097cc] be85                      cmp.l      d5,d7
[000097ce] 66ae                      bne.s      _sysig_2
[000097d0] 422c 0042                 clr.b      66(a4)
[000097d4] 60a8                      bra.s      _sysig_2

_sysleep:
[000097d6] 4e56 fff8                 link       a6,#-8
[000097da] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[000097de] 2a6e 0008                 movea.l    8(a6),a5
[000097e2] 2879 0000 0000            movea.l    _pu,a4
[000097e8] 266c 0010                 movea.l    16(a4),a3
[000097ec] 2d6b 003a fff8            move.l     58(a3),-8(a6)
[000097f2] 2a15                      move.l     (a5),d5
[000097f4] 6700 009e                 beq        _sysleep_1
[000097f8] 42ae fffc                 clr.l      -4(a6)
[000097fc] 486e fffc                 pea.l      -4(a6)
[00009800] 4eba fbdc                 jsr        _syalarm(pc)
[00009804] 588f                      addq.l     #4,a7
[00009806] 4aae fffc                 tst.l      -4(a6)
[0000980a] 6712                      beq.s      _sysleep_2
[0000980c] baae fffc                 cmp.l      -4(a6),d5
[00009810] 6404                      bcc.s      _sysleep_3
[00009812] 2e05                      move.l     d5,d7
[00009814] 6004                      bra.s      _sysleep_4
_sysleep_3:
[00009816] 2e2e fffc                 move.l     -4(a6),d7
_sysleep_4:
[0000981a] 2807                      move.l     d7,d4
[0000981c] 6002                      bra.s      _sysleep_5
_sysleep_2:
[0000981e] 2805                      move.l     d5,d4
_sysleep_5:
[00009820] 2a84                      move.l     d4,(a5)
[00009822] 2eac 0008                 move.l     8(a4),(a7)
[00009826] 4eb9 0000 0000            jsr        _setjmp
[0000982c] 4a87                      tst.l      d7
[0000982e] 661c                      bne.s      _sysleep_6
[00009830] 2e8d                      move.l     a5,(a7)
[00009832] 4eba fbaa                 jsr        _syalarm(pc)
[00009836] 4a2c 0142                 tst.b      322(a4)
[0000983a] 6704                      beq.s      _sysleep_7
[0000983c] 2a85                      move.l     d5,(a5)
[0000983e] 6054                      bra.s      _sysleep_1
_sysleep_7:
[00009840] 08ab 0006 003c            bclr       #6,60(a3)
[00009846] 4eba fe28                 jsr        _sypause(pc)
[0000984a] 6048                      bra.s      _sysleep_1
_sysleep_6:
[0000984c] 276e fff8 003a            move.l     -8(a6),58(a3)
[00009852] 4295                      clr.l      (a5)
[00009854] 2e8d                      move.l     a5,(a7)
[00009856] 4eba fb86                 jsr        _syalarm(pc)
[0000985a] 9895                      sub.l      (a5),d4
[0000985c] b8ae fffc                 cmp.l      -4(a6),d4
[00009860] 640e                      bcc.s      _sysleep_8
[00009862] 2e2e fffc                 move.l     -4(a6),d7
[00009866] 9e84                      sub.l      d4,d7
[00009868] 2a87                      move.l     d7,(a5)
[0000986a] 2e8d                      move.l     a5,(a7)
[0000986c] 4eba fb70                 jsr        _syalarm(pc)
_sysleep_8:
[00009870] ba84                      cmp.l      d4,d5
[00009872] 6212                      bhi.s      _sysleep_9
[00009874] baae fffc                 cmp.l      -4(a6),d5
[00009878] 670c                      beq.s      _sysleep_9
[0000987a] 0c2b 000e 0042            cmpi.b     #$0E,66(a3)
[00009880] 6604                      bne.s      _sysleep_9
[00009882] 422b 0042                 clr.b      66(a3)
_sysleep_9:
[00009886] b885                      cmp.l      d5,d4
[00009888] 6406                      bcc.s      _sysleep_10
[0000988a] 2e05                      move.l     d5,d7
[0000988c] 9e84                      sub.l      d4,d7
[0000988e] 6002                      bra.s      _sysleep_11
_sysleep_10:
[00009890] 7e00                      moveq.l    #0,d7
_sysleep_11:
[00009892] 2a87                      move.l     d7,(a5)
_sysleep_1:
[00009894] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00009898] 4e5e                      unlk       a6
[0000989a] 4e75                      rts

_systime:
[0000989c] 4e56 0000                 link       a6,#0
[000098a0] 4eb9 0000 2600            jsr        _isuper
[000098a6] 4a87                      tst.l      d7
[000098a8] 670a                      beq.s      _systime_1
[000098aa] 226e 0008                 movea.l    8(a6),a1
[000098ae] 23d1 0000 b59c            move.l     (a1),_time
_systime_1:
[000098b4] 4e5e                      unlk       a6
[000098b6] 4e75                      rts

_sysuid:
[000098b8] 4e56 0000                 link       a6,#0
[000098bc] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000098c0] 2a6e 0008                 movea.l    8(a6),a5
[000098c4] 2879 0000 0000            movea.l    _pu,a4
[000098ca] 7e00                      moveq.l    #0,d7
[000098cc] 1e2c 0130                 move.b     304(a4),d7
[000098d0] be95                      cmp.l      (a5),d7
[000098d2] 6714                      beq.s      _sysuid_1
[000098d4] 7e00                      moveq.l    #0,d7
[000098d6] 1e2c 0132                 move.b     306(a4),d7
[000098da] be95                      cmp.l      (a5),d7
[000098dc] 670a                      beq.s      _sysuid_1
[000098de] 4eb9 0000 2600            jsr        _isuper
[000098e4] 4a87                      tst.l      d7
[000098e6] 671a                      beq.s      _sysuid_2
_sysuid_1:
[000098e8] 43f8 0022                 lea.l      ($00000022).w,a1
[000098ec] d3ec 0010                 adda.l     16(a4),a1
[000098f0] 136d 0003 001e            move.b     3(a5),30(a1)
[000098f6] 196d 0003 0130            move.b     3(a5),304(a4)
[000098fc] 196d 0003 0132            move.b     3(a5),306(a4)
_sysuid_2:
[00009902] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00009906] 4e5e                      unlk       a6
[00009908] 4e75                      rts

_sytimes:
[0000990a] 4e56 0000                 link       a6,#0
[0000990e] 4878 0010                 pea.l      ($00000010).w
[00009912] 226e 0008                 movea.l    8(a6),a1
[00009916] 2f11                      move.l     (a1),-(a7)
[00009918] 2e39 0000 0000            move.l     _pu,d7
[0000991e] 2f07                      move.l     d7,-(a7)
[00009920] 0697 0000 0110            addi.l     #$00000110,(a7)
[00009926] 4eb9 0000 0000            jsr        _outbuf
[0000992c] 4fef 000c                 lea.l      12(a7),a7
[00009930] 4a87                      tst.l      d7
[00009932] 670c                      beq.s      _sytimes_1
[00009934] 2279 0000 0000            movea.l    _pu,a1
[0000993a] 137c 000e 0142            move.b     #$0E,322(a1)
_sytimes_1:
[00009940] 4e5e                      unlk       a6
[00009942] 4e75                      rts

_syuname:
[00009944] 4e56 0000                 link       a6,#0
[00009948] 4878 0028                 pea.l      ($00000028).w
[0000994c] 226e 0008                 movea.l    8(a6),a1
[00009950] 2f11                      move.l     (a1),-(a7)
[00009952] 2f3c 0000 0000            move.l     #_sysname,-(a7)
[00009958] 4eb9 0000 0000            jsr        _outbuf
[0000995e] 4fef 000c                 lea.l      12(a7),a7
[00009962] 4a87                      tst.l      d7
[00009964] 670c                      beq.s      _syuname_1
[00009966] 4878 000e                 pea.l      ($0000000E).w
[0000996a] 4eb9 0000 2868            jsr        _uerror
[00009970] 588f                      addq.l     #4,a7
_syuname_1:
[00009972] 4e5e                      unlk       a6
[00009974] 4e75                      rts

_sywait:
[00009976] 4e56 0000                 link       a6,#0
[0000997a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000997e] 2879 0000 0000            movea.l    _pu,a4
_sywait_3:
[00009984] 43f8 0022                 lea.l      ($00000022).w,a1
[00009988] d3ec 0010                 adda.l     16(a4),a1
[0000998c] 2669 0004                 movea.l    4(a1),a3
[00009990] 2e0b                      move.l     a3,d7
[00009992] 6752                      beq.s      _sywait_1
[00009994] 226e 0008                 movea.l    8(a6),a1
[00009998] 32ab 0012                 move.w     18(a3),(a1)
[0000999c] 226e 0008                 movea.l    8(a6),a1
[000099a0] 336b 0010 0002            move.w     16(a3),2(a1)
[000099a6] 2e2b 0008                 move.l     8(a3),d7
[000099aa] dfac 011c                 add.l      d7,284(a4)
[000099ae] 2e2b 0004                 move.l     4(a3),d7
[000099b2] dfac 0118                 add.l      d7,280(a4)
[000099b6] 2e93                      move.l     (a3),(a7)
[000099b8] 2f0b                      move.l     a3,-(a7)
[000099ba] 4878 001c                 pea.l      ($0000001C).w
[000099be] 4eb9 0000 0114            jsr        _free
[000099c4] 508f                      addq.l     #8,a7
[000099c6] 43f8 0022                 lea.l      ($00000022).w,a1
[000099ca] d3ec 0010                 adda.l     16(a4),a1
[000099ce] 2347 0004                 move.l     d7,4(a1)
[000099d2] 6040                      bra.s      _sywait_2
_sywait_7:
[000099d4] 4878 0008                 pea.l      ($00000008).w
[000099d8] 2f2c 0010                 move.l     16(a4),-(a7)
[000099dc] 4eb9 0000 8844            jsr        _sleep
[000099e2] 508f                      addq.l     #8,a7
[000099e4] 609e                      bra.s      _sywait_3
_sywait_1:
[000099e6] 2a79 0000 b514            movea.l    _plist,a5
_sywait_6:
[000099ec] 2e0d                      move.l     a5,d7
[000099ee] 671a                      beq.s      _sywait_4
[000099f0] 0c2d 0005 0011            cmpi.b     #$05,17(a5)
[000099f6] 670e                      beq.s      _sywait_5
[000099f8] 226c 0010                 movea.l    16(a4),a1
[000099fc] 3e29 001c                 move.w     28(a1),d7
[00009a00] be6d 003e                 cmp.w      62(a5),d7
[00009a04] 6704                      beq.s      _sywait_4
_sywait_5:
[00009a06] 2a55                      movea.l    (a5),a5
[00009a08] 60e2                      bra.s      _sywait_6
_sywait_4:
[00009a0a] 2e0d                      move.l     a5,d7
[00009a0c] 66c6                      bne.s      _sywait_7
[00009a0e] 197c 000a 0142            move.b     #$0A,322(a4)
_sywait_2:
[00009a14] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009a18] 4e5e                      unlk       a6
[00009a1a] 4e75                      rts

_syclose:
[00009a1c] 4e56 0000                 link       a6,#0
[00009a20] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00009a24] 226e 0008                 movea.l    8(a6),a1
[00009a28] 2a11                      move.l     (a1),d5
[00009a2a] 2e85                      move.l     d5,(a7)
[00009a2c] 4eb9 0000 2710            jsr        _mapfd
[00009a32] 2a47                      movea.l    d7,a5
[00009a34] 2e0d                      move.l     a5,d7
[00009a36] 671a                      beq.s      _syclose_1
[00009a38] 43f8 0044                 lea.l      ($00000044).w,a1
[00009a3c] d3f9 0000 0000            adda.l     _pu,a1
[00009a42] 2e05                      move.l     d5,d7
[00009a44] e587                      asl.l      #2,d7
[00009a46] 42b1 7800                 clr.l      0(a1,d7.l)
[00009a4a] 2e8d                      move.l     a5,(a7)
[00009a4c] 4eb9 0000 2200            jsr        _closef
_syclose_1:
[00009a52] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00009a56] 4e5e                      unlk       a6
[00009a58] 4e75                      rts

_sydup:
[00009a5a] 4e56 fffc                 link       a6,#-4
[00009a5e] 4297                      clr.l      (a7)
[00009a60] 2f2e 0008                 move.l     8(a6),-(a7)
[00009a64] 4eb9 0000 232c            jsr        _dup
[00009a6a] 588f                      addq.l     #4,a7
[00009a6c] 4e5e                      unlk       a6
[00009a6e] 4e75                      rts

_syfcntl:
[00009a70] 4e56 fff6                 link       a6,#-10
[00009a74] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009a78] 2a6e 0008                 movea.l    8(a6),a5
[00009a7c] 2679 0000 0000            movea.l    _pu,a3
[00009a82] 3d6d 0002 fffa            move.w     2(a5),-6(a6)
[00009a88] 42ae fffc                 clr.l      -4(a6)
[00009a8c] 3e2e fffa                 move.w     -6(a6),d7
[00009a90] 48c7                      ext.l      d7
[00009a92] 2e87                      move.l     d7,(a7)
[00009a94] 4eb9 0000 2710            jsr        _mapfd
[00009a9a] 2847                      movea.l    d7,a4
[00009a9c] 2e0c                      move.l     a4,d7
[00009a9e] 6700 00ba                 beq        _syfcntl_1
[00009aa2] 2e2d 0004                 move.l     4(a5),d7
[00009aa6] 41f9 0000 b68c            lea.l      $000163FA,a0
[00009aac] 4ef9 0000 0000            jmp        a~jtab
[00009ab2] 4247                      clr.w      d7
[00009ab4] 1e2c 0008                 move.b     8(a4),d7
[00009ab8] 3747 013a                 move.w     d7,314(a3)
[00009abc] 2ead 0008                 move.l     8(a5),(a7)
[00009ac0] 2f2d 0004                 move.l     4(a5),-(a7)
[00009ac4] 2f0c                      move.l     a4,-(a7)
[00009ac6] 4eb9 0000 4762            jsr        _lockf
[00009acc] 508f                      addq.l     #8,a7
[00009ace] 1747 0142                 move.b     d7,322(a3)
[00009ad2] 6000 0086                 bra        _syfcntl_1
[00009ad6] 2ead 0008                 move.l     8(a5),(a7)
[00009ada] 2f0d                      move.l     a5,-(a7)
[00009adc] 4eb9 0000 232c            jsr        _dup
[00009ae2] 588f                      addq.l     #4,a7
[00009ae4] 6074                      bra.s      _syfcntl_1
[00009ae6] 7001                      moveq.l    #1,d0
[00009ae8] 2d40 fffc                 move.l     d0,-4(a6)
[00009aec] 7e01                      moveq.l    #1,d7
[00009aee] 3c2e fffa                 move.w     -6(a6),d6
[00009af2] eda7                      asl.l      d6,d7
[00009af4] 2d47 fff6                 move.l     d7,-10(a6)
[00009af8] 2e2b 0040                 move.l     64(a3),d7
[00009afc] ceae fff6                 and.l      -10(a6),d7
[00009b00] 6704                      beq.s      _syfcntl_2
[00009b02] 7e01                      moveq.l    #1,d7
[00009b04] 6002                      bra.s      _syfcntl_3
_syfcntl_2:
[00009b06] 7e00                      moveq.l    #0,d7
_syfcntl_3:
[00009b08] 2a87                      move.l     d7,(a5)
[00009b0a] 4aae fffc                 tst.l      -4(a6)
[00009b0e] 674a                      beq.s      _syfcntl_1
[00009b10] 082d 0000 000b            btst       #0,11(a5)
[00009b16] 670a                      beq.s      _syfcntl_4
[00009b18] 2e2e fff6                 move.l     -10(a6),d7
[00009b1c] 8fab 0040                 or.l       d7,64(a3)
[00009b20] 6038                      bra.s      _syfcntl_1
_syfcntl_4:
[00009b22] 2e2e fff6                 move.l     -10(a6),d7
[00009b26] 4687                      not.l      d7
[00009b28] cfab 0040                 and.l      d7,64(a3)
[00009b2c] 602c                      bra.s      _syfcntl_1
[00009b2e] 7001                      moveq.l    #1,d0
[00009b30] 2d40 fffc                 move.l     d0,-4(a6)
[00009b34] 7e00                      moveq.l    #0,d7
[00009b36] 1e2c 0008                 move.b     8(a4),d7
[00009b3a] 5387                      subq.l     #1,d7
[00009b3c] 2a87                      move.l     d7,(a5)
[00009b3e] 4aae fffc                 tst.l      -4(a6)
[00009b42] 6716                      beq.s      _syfcntl_1
[00009b44] 7ee3                      moveq.l    #-29,d7
[00009b46] 7c00                      moveq.l    #0,d6
[00009b48] 1c2c 0008                 move.b     8(a4),d6
[00009b4c] ce86                      and.l      d6,d7
[00009b4e] 7c1c                      moveq.l    #28,d6
[00009b50] ccad 0008                 and.l      8(a5),d6
[00009b54] 8e86                      or.l       d6,d7
[00009b56] 1947 0008                 move.b     d7,8(a4)
_syfcntl_1:
[00009b5a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009b5e] 4e5e                      unlk       a6
[00009b60] 4e75                      rts

_syfstat:
[00009b62] 4e56 0000                 link       a6,#0
[00009b66] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00009b6a] 2a6e 0008                 movea.l    8(a6),a5
[00009b6e] 2e95                      move.l     (a5),(a7)
[00009b70] 4eb9 0000 2710            jsr        _mapfd
[00009b76] 2847                      movea.l    d7,a4
[00009b78] 2e0c                      move.l     a4,d7
[00009b7a] 672a                      beq.s      _syfstat_1
[00009b7c] 2ead 0004                 move.l     4(a5),(a7)
[00009b80] 2254                      movea.l    (a4),a1
[00009b82] 7e00                      moveq.l    #0,d7
[00009b84] 3e29 0018                 move.w     24(a1),d7
[00009b88] 2f07                      move.l     d7,-(a7)
[00009b8a] 2254                      movea.l    (a4),a1
[00009b8c] 7e00                      moveq.l    #0,d7
[00009b8e] 3e29 0016                 move.w     22(a1),d7
[00009b92] 2f07                      move.l     d7,-(a7)
[00009b94] 4eb9 0000 2dd8            jsr        _geti
[00009b9a] 508f                      addq.l     #8,a7
[00009b9c] 2f07                      move.l     d7,-(a7)
[00009b9e] 4eb9 0000 2f58            jsr        _getstat
[00009ba4] 588f                      addq.l     #4,a7
_syfstat_1:
[00009ba6] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00009baa] 4e5e                      unlk       a6
[00009bac] 4e75                      rts

_sygtty:
[00009bae] 4e56 0000                 link       a6,#0
[00009bb2] 4878 0001                 pea.l      ($00000001).w
[00009bb6] 2f2e 0008                 move.l     8(a6),-(a7)
[00009bba] 4eb9 0000 5c9a            jsr        _setget
[00009bc0] 508f                      addq.l     #8,a7
[00009bc2] 4e5e                      unlk       a6
[00009bc4] 4e75                      rts

_syioctl:
[00009bc6] 4e56 0000                 link       a6,#0
[00009bca] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00009bce] 2a6e 0008                 movea.l    8(a6),a5
[00009bd2] 2a2d 0004                 move.l     4(a5),d5
[00009bd6] 2b6d 0008 0004            move.l     8(a5),4(a5)
[00009bdc] 2e85                      move.l     d5,(a7)
[00009bde] 2f0d                      move.l     a5,-(a7)
[00009be0] 4eb9 0000 5c9a            jsr        _setget
[00009be6] 588f                      addq.l     #4,a7
[00009be8] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00009bec] 4e5e                      unlk       a6
[00009bee] 4e75                      rts

_sylseek:
[00009bf0] 4e56 0000                 link       a6,#0
[00009bf4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009bf8] 2a6e 0008                 movea.l    8(a6),a5
[00009bfc] 2679 0000 0000            movea.l    _pu,a3
[00009c02] 2e95                      move.l     (a5),(a7)
[00009c04] 4eb9 0000 2710            jsr        _mapfd
[00009c0a] 2847                      movea.l    d7,a4
[00009c0c] 2e0c                      move.l     a4,d7
[00009c0e] 6734                      beq.s      _sylseek_1
[00009c10] 082c 0007 0008            btst       #7,8(a4)
[00009c16] 6626                      bne.s      _sylseek_2
[00009c18] 0cad 0000 0001 0008       cmpi.l     #$00000001,8(a5)
[00009c20] 662a                      bne.s      _sylseek_3
[00009c22] 4aad 0004                 tst.l      4(a5)
[00009c26] 6624                      bne.s      _sylseek_3
[00009c28] 2254                      movea.l    (a4),a1
[00009c2a] 7e00                      moveq.l    #0,d7
[00009c2c] 3e29 001a                 move.w     26(a1),d7
[00009c30] 0287 0000 6000            andi.l     #$00006000,d7
[00009c36] 0c87 0000 2000            cmpi.l     #$00002000,d7
[00009c3c] 660e                      bne.s      _sylseek_3
_sylseek_2:
[00009c3e] 177c 001d 0142            move.b     #$1D,322(a3)
_sylseek_1:
[00009c44] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009c48] 4e5e                      unlk       a6
[00009c4a] 4e75                      rts
_sylseek_3:
[00009c4c] 2ead 0008                 move.l     8(a5),(a7)
[00009c50] 2f2d 0004                 move.l     4(a5),-(a7)
[00009c54] 2f0c                      move.l     a4,-(a7)
[00009c56] 4eb9 0000 5c46            jsr        _seekp
[00009c5c] 508f                      addq.l     #8,a7
[00009c5e] 2a87                      move.l     d7,(a5)
[00009c60] 2955 0004                 move.l     (a5),4(a4)
[00009c64] 60de                      bra.s      _sylseek_1

_sync:
[00009c66] 48e7 8004                 movem.l    d0/a5,-(a7)
[00009c6a] 4ab9 0000 b6b4            tst.l      $00016422
[00009c70] 6656                      bne.s      _sync_1
[00009c72] 7001                      moveq.l    #1,d0
[00009c74] 23c0 0000 b6b4            move.l     d0,$00016422
[00009c7a] 2a79 0000 b0e8            movea.l    _ilist,a5
_sync_4:
[00009c80] 2e0d                      move.l     a5,d7
[00009c82] 6722                      beq.s      _sync_2
[00009c84] 082d 0001 000d            btst       #1,13(a5)
[00009c8a] 6616                      bne.s      _sync_3
[00009c8c] 08ed 0001 000d            bset       #1,13(a5)
[00009c92] 2e8d                      move.l     a5,(a7)
[00009c94] 4eb9 0000 388e            jsr        _updi
[00009c9a] 2e8d                      move.l     a5,(a7)
[00009c9c] 4eb9 0000 278c            jsr        _reli
_sync_3:
[00009ca2] 2a55                      movea.l    (a5),a5
[00009ca4] 60da                      bra.s      _sync_4
_sync_2:
[00009ca6] 4297                      clr.l      (a7)
[00009ca8] 42a7                      clr.l      -(a7)
[00009caa] 4eb9 0000 0416            jsr        _buflush
[00009cb0] 588f                      addq.l     #4,a7
[00009cb2] 4a87                      tst.l      d7
[00009cb4] 660c                      bne.s      _sync_5
[00009cb6] 4878 0010                 pea.l      ($00000010).w
[00009cba] 4eb9 0000 2868            jsr        _uerror
[00009cc0] 588f                      addq.l     #4,a7
_sync_5:
[00009cc2] 42b9 0000 b6b4            clr.l      $00016422
_sync_1:
[00009cc8] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00009ccc] 4e75                      rts

_sypipe:
[00009cce] 4e56 0000                 link       a6,#0
[00009cd2] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009cd6] 7e00                      moveq.l    #0,d7
[00009cd8] 3e39 0000 0000            move.w     _pipedev,d7
[00009cde] 2e87                      move.l     d7,(a7)
[00009ce0] 4eb9 0000 248c            jsr        _getmount
[00009ce6] 4a87                      tst.l      d7
[00009ce8] 6610                      bne.s      _sypipe_1
[00009cea] 4878 0006                 pea.l      ($00000006).w
[00009cee] 4eb9 0000 2868            jsr        _uerror
[00009cf4] 588f                      addq.l     #4,a7
[00009cf6] 6000 00a4                 bra        _sypipe_2
_sypipe_1:
[00009cfa] 7e00                      moveq.l    #0,d7
[00009cfc] 3e39 0000 0000            move.w     _pipedev,d7
[00009d02] 2e87                      move.l     d7,(a7)
[00009d04] 4eb9 0000 3238            jsr        _newi
[00009d0a] 2647                      movea.l    d7,a3
[00009d0c] 2e0b                      move.l     a3,d7
[00009d0e] 6700 008c                 beq        _sypipe_2
[00009d12] 2eae 0008                 move.l     8(a6),(a7)
[00009d16] 4eb9 0000 2418            jsr        _getfd
[00009d1c] 2a47                      movea.l    d7,a5
[00009d1e] 2e0d                      move.l     a5,d7
[00009d20] 660a                      bne.s      _sypipe_3
[00009d22] 2e8b                      move.l     a3,(a7)
[00009d24] 4eb9 0000 3540            jsr        _puti
[00009d2a] 6070                      bra.s      _sypipe_2
_sypipe_3:
[00009d2c] 2e2e 0008                 move.l     8(a6),d7
[00009d30] 2f07                      move.l     d7,-(a7)
[00009d32] 5497                      addq.l     #2,(a7)
[00009d34] 4eb9 0000 2418            jsr        _getfd
[00009d3a] 588f                      addq.l     #4,a7
[00009d3c] 2847                      movea.l    d7,a4
[00009d3e] 2e0c                      move.l     a4,d7
[00009d40] 6632                      bne.s      _sypipe_4
[00009d42] 2e8b                      move.l     a3,(a7)
[00009d44] 4eb9 0000 3540            jsr        _puti
[00009d4a] 4297                      clr.l      (a7)
[00009d4c] 2f0d                      move.l     a5,-(a7)
[00009d4e] 4878 000a                 pea.l      ($0000000A).w
[00009d52] 4eb9 0000 0114            jsr        _free
[00009d58] 508f                      addq.l     #8,a7
[00009d5a] 43f8 0044                 lea.l      ($00000044).w,a1
[00009d5e] d3f9 0000 0000            adda.l     _pu,a1
[00009d64] 246e 0008                 movea.l    8(a6),a2
[00009d68] 3e12                      move.w     (a2),d7
[00009d6a] 48c7                      ext.l      d7
[00009d6c] e587                      asl.l      #2,d7
[00009d6e] 42b1 7800                 clr.l      0(a1,d7.l)
[00009d72] 6028                      bra.s      _sypipe_2
_sypipe_4:
[00009d74] 377c 0040 000c            move.w     #$0040,12(a3)
[00009d7a] 377c 0002 000e            move.w     #$0002,14(a3)
[00009d80] 377c 0001 0012            move.w     #$0001,18(a3)
[00009d86] 377c 8000 001a            move.w     #$8000,26(a3)
[00009d8c] 1b7c 0081 0008            move.b     #$81,8(a5)
[00009d92] 2a8b                      move.l     a3,(a5)
[00009d94] 197c 0082 0008            move.b     #$82,8(a4)
[00009d9a] 288b                      move.l     a3,(a4)
_sypipe_2:
[00009d9c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009da0] 4e5e                      unlk       a6
[00009da2] 4e75                      rts

_syread:
[00009da4] 4e56 0000                 link       a6,#0
[00009da8] 4878 0001                 pea.l      ($00000001).w
[00009dac] 2f2e 0008                 move.l     8(a6),-(a7)
[00009db0] 4eb9 0000 5644            jsr        _rdwr
[00009db6] 508f                      addq.l     #8,a7
[00009db8] 4e5e                      unlk       a6
[00009dba] 4e75                      rts

_syseek:
[00009dbc] 4e56 0000                 link       a6,#0
[00009dc0] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00009dc4] 2a6e 0008                 movea.l    8(a6),a5
[00009dc8] 2a2d 0004                 move.l     4(a5),d5
[00009dcc] 2e95                      move.l     (a5),(a7)
[00009dce] 4eb9 0000 2710            jsr        _mapfd
[00009dd4] 2847                      movea.l    d7,a4
[00009dd6] 2e0c                      move.l     a4,d7
[00009dd8] 672c                      beq.s      _syseek_1
[00009dda] 082c 0007 0008            btst       #7,8(a4)
[00009de0] 670e                      beq.s      _syseek_2
[00009de2] 2279 0000 0000            movea.l    _pu,a1
[00009de8] 137c 001d 0142            move.b     #$1D,322(a1)
[00009dee] 6016                      bra.s      _syseek_1
_syseek_2:
[00009df0] 2ead 0008                 move.l     8(a5),(a7)
[00009df4] 2f2d 0004                 move.l     4(a5),-(a7)
[00009df8] 2f0c                      move.l     a4,-(a7)
[00009dfa] 4eb9 0000 5c46            jsr        _seekp
[00009e00] 508f                      addq.l     #8,a7
[00009e02] 2947 0004                 move.l     d7,4(a4)
_syseek_1:
[00009e06] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00009e0a] 4e5e                      unlk       a6
[00009e0c] 4e75                      rts

_systty:
[00009e0e] 4e56 fffc                 link       a6,#-4
[00009e12] 4297                      clr.l      (a7)
[00009e14] 2f2e 0008                 move.l     8(a6),-(a7)
[00009e18] 4eb9 0000 5c9a            jsr        _setget
[00009e1e] 588f                      addq.l     #4,a7
[00009e20] 4e5e                      unlk       a6
[00009e22] 4e75                      rts

_syumask:
[00009e24] 4e56 fffa                 link       a6,#-6
[00009e28] 2279 0000 0000            movea.l    _pu,a1
[00009e2e] 3d69 013c fffe            move.w     316(a1),-2(a6)
[00009e34] 2279 0000 0000            movea.l    _pu,a1
[00009e3a] 246e 0008                 movea.l    8(a6),a2
[00009e3e] 2e12                      move.l     (a2),d7
[00009e40] 0287 0000 01ff            andi.l     #$000001FF,d7
[00009e46] 3347 013c                 move.w     d7,316(a1)
[00009e4a] 226e 0008                 movea.l    8(a6),a1
[00009e4e] 7e00                      moveq.l    #0,d7
[00009e50] 3e2e fffe                 move.w     -2(a6),d7
[00009e54] 2287                      move.l     d7,(a1)
[00009e56] 4e5e                      unlk       a6
[00009e58] 4e75                      rts

_syustat:
[00009e5a] 4e56 fffc                 link       a6,#-4
[00009e5e] 2eae 0008                 move.l     8(a6),(a7)
[00009e62] 4eb9 0000 399a            jsr        _ustat
[00009e68] 4e5e                      unlk       a6
[00009e6a] 4e75                      rts

_sywrite:
[00009e6c] 4e56 0000                 link       a6,#0
[00009e70] 4878 0002                 pea.l      ($00000002).w
[00009e74] 2f2e 0008                 move.l     8(a6),-(a7)
[00009e78] 4eb9 0000 5644            jsr        _rdwr
[00009e7e] 508f                      addq.l     #8,a7
[00009e80] 4e5e                      unlk       a6
[00009e82] 4e75                      rts

_nopreemp:
[00009e84] 7e01                      moveq.l    #1,d7
[00009e86] 7c00                      moveq.l    #0,d6
[00009e88] 1c39 0000 0000            move.b     _syslock,d6
[00009e8e] ce86                      and.l      d6,d7
[00009e90] 4e75                      rts

_preemp:
[00009e92] 08b9 0000 0000 0000       bclr       #0,_syslock
[00009e9a] 4e75                      rts

_sylock:
[00009e9c] 4e56 fffa                 link       a6,#-6
[00009ea0] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00009ea4] 2a6e 0008                 movea.l    8(a6),a5
[00009ea8] 2879 0000 0000            movea.l    _pu,a4
[00009eae] 2e0d                      move.l     a5,d7
[00009eb0] 661c                      bne.s      _sylock_1
[00009eb2] 4239 0000 b6f4            clr.b      $00016462
[00009eb8] 2ebc 0000 b6f0            move.l     #$0001645E,(a7)
[00009ebe] 2f3c 0000 b6f4            move.l     #$00016462,-(a7)
[00009ec4] 4eb9 0000 8b66            jsr        _wakeupl
[00009eca] 588f                      addq.l     #4,a7
[00009ecc] 605e                      bra.s      _sylock_2
_sylock_1:
[00009ece] 0c95 0000 0003            cmpi.l     #$00000003,(a5)
[00009ed4] 6530                      bcs.s      _sylock_3
[00009ed6] 4878 0001                 pea.l      ($00000001).w
[00009eda] 2f2d 0004                 move.l     4(a5),-(a7)
[00009ede] 4eb9 0000 0000            jsr        _chkbuf
[00009ee4] 508f                      addq.l     #8,a7
[00009ee6] 4a87                      tst.l      d7
[00009ee8] 6714                      beq.s      _sylock_4
[00009eea] 43ee fffb                 lea.l      -5(a6),a1
[00009eee] 2649                      movea.l    a1,a3
[00009ef0] 2ead 0004                 move.l     4(a5),(a7)
[00009ef4] 4eb9 0000 0000            jsr        _inbyte
[00009efa] 1687                      move.b     d7,(a3)
[00009efc] 6028                      bra.s      _sylock_5
_sylock_4:
[00009efe] 197c 000d 0142            move.b     #$0D,322(a4)
[00009f04] 6020                      bra.s      _sylock_5
_sylock_3:
[00009f06] 2e2d 0004                 move.l     4(a5),d7
[00009f0a] beb9 0000 0000            cmp.l      _nsyslock,d7
[00009f10] 640e                      bcc.s      _sylock_6
[00009f12] 2e3c 0000 0000            move.l     #_syslock,d7
[00009f18] dead 0004                 add.l      4(a5),d7
[00009f1c] 2647                      movea.l    d7,a3
[00009f1e] 6006                      bra.s      _sylock_5
_sylock_6:
[00009f20] 197c 0016 0142            move.b     #$16,322(a4)
_sylock_5:
[00009f26] 4a2c 0142                 tst.b      322(a4)
[00009f2a] 6708                      beq.s      _sylock_7
_sylock_2:
[00009f2c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00009f30] 4e5e                      unlk       a6
[00009f32] 4e75                      rts
_sylock_7:
[00009f34] 2e15                      move.l     (a5),d7
[00009f36] 41f9 0000 b6f6            lea.l      $00016464,a0
[00009f3c] 4ef9 0000 0000            jmp        a~jtab
[00009f42] 4eb9 0000 2600            jsr        _isuper
[00009f48] 4a87                      tst.l      d7
[00009f4a] 6700 00f8                 beq        _sylock_8
[00009f4e] 2e39 0000 b59c            move.l     _time,d7
[00009f54] dead 000c                 add.l      12(a5),d7
[00009f58] 2d47 fffc                 move.l     d7,-4(a6)
_sylock_12:
[00009f5c] 2e2d 0008                 move.l     8(a5),d7
[00009f60] e08f                      lsr.l      #8,d7
[00009f62] 7c00                      moveq.l    #0,d6
[00009f64] 1c13                      move.b     (a3),d6
[00009f66] ce86                      and.l      d6,d7
[00009f68] 6762                      beq.s      _sylock_9
[00009f6a] 4aad 000c                 tst.l      12(a5)
[00009f6e] 670c                      beq.s      _sylock_10
[00009f70] 2e2e fffc                 move.l     -4(a6),d7
[00009f74] beb9 0000 b59c            cmp.l      _time,d7
[00009f7a] 6f50                      ble.s      _sylock_9
_sylock_10:
[00009f7c] 4a39 0000 b6f4            tst.b      $00016462
[00009f82] 661a                      bne.s      _sylock_11
[00009f84] 4878 003c                 pea.l      ($0000003C).w
[00009f88] 2f3c 0000 b6e4            move.l     #_lockcb,-(a7)
[00009f8e] 4eb9 0000 4f0e            jsr        _clkout
[00009f94] 508f                      addq.l     #8,a7
[00009f96] 13fc 0001 0000 b6f4       move.b     #$01,$00016462
_sylock_11:
[00009f9e] 2ebc 0000 b6f0            move.l     #$0001645E,(a7)
[00009fa4] 4878 0007                 pea.l      ($00000007).w
[00009fa8] 2f3c 0000 b6f4            move.l     #$00016462,-(a7)
[00009fae] 4eb9 0000 8862            jsr        _sleepl
[00009fb4] 508f                      addq.l     #8,a7
[00009fb6] 43ee fffb                 lea.l      -5(a6),a1
[00009fba] b7c9                      cmpa.l     a1,a3
[00009fbc] 669e                      bne.s      _sylock_12
[00009fbe] 2ead 0004                 move.l     4(a5),(a7)
[00009fc2] 4eb9 0000 0000            jsr        _inbyte
[00009fc8] 1687                      move.b     d7,(a3)
[00009fca] 6090                      bra.s      _sylock_12
_sylock_9:
[00009fcc] 2e2d 0008                 move.l     8(a5),d7
[00009fd0] e08f                      lsr.l      #8,d7
[00009fd2] 7c00                      moveq.l    #0,d6
[00009fd4] 1c13                      move.b     (a3),d6
[00009fd6] ce86                      and.l      d6,d7
[00009fd8] 2a87                      move.l     d7,(a5)
[00009fda] 6668                      bne.s      _sylock_8
[00009fdc] 2e2d 0008                 move.l     8(a5),d7
[00009fe0] 8f13                      or.b       d7,(a3)
[00009fe2] 43ee fffb                 lea.l      -5(a6),a1
[00009fe6] b7c9                      cmpa.l     a1,a3
[00009fe8] 665a                      bne.s      _sylock_8
[00009fea] 7e00                      moveq.l    #0,d7
[00009fec] 1e13                      move.b     (a3),d7
[00009fee] 2e87                      move.l     d7,(a7)
[00009ff0] 2f2d 0004                 move.l     4(a5),-(a7)
[00009ff4] 4eb9 0000 0000            jsr        _outbyte
[00009ffa] 588f                      addq.l     #4,a7
[00009ffc] 6046                      bra.s      _sylock_8
[00009ffe] 4eb9 0000 2600            jsr        _isuper
[0000a004] 4a87                      tst.l      d7
[0000a006] 673c                      beq.s      _sylock_8
[0000a008] 2e2d 0008                 move.l     8(a5),d7
[0000a00c] 4687                      not.l      d7
[0000a00e] cf13                      and.b      d7,(a3)
[0000a010] 2ebc 0000 b6f0            move.l     #$0001645E,(a7)
[0000a016] 2f3c 0000 b6f4            move.l     #$00016462,-(a7)
[0000a01c] 4eb9 0000 8b66            jsr        _wakeupl
[0000a022] 588f                      addq.l     #4,a7
[0000a024] 43ee fffb                 lea.l      -5(a6),a1
[0000a028] b7c9                      cmpa.l     a1,a3
[0000a02a] 6612                      bne.s      _sylock_13
[0000a02c] 7e00                      moveq.l    #0,d7
[0000a02e] 1e13                      move.b     (a3),d7
[0000a030] 2e87                      move.l     d7,(a7)
[0000a032] 2f2d 0004                 move.l     4(a5),-(a7)
[0000a036] 4eb9 0000 0000            jsr        _outbyte
[0000a03c] 588f                      addq.l     #4,a7
_sylock_13:
[0000a03e] 7e00                      moveq.l    #0,d7
[0000a040] 1e13                      move.b     (a3),d7
[0000a042] 2a87                      move.l     d7,(a5)
_sylock_8:
[0000a044] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a048] 4e5e                      unlk       a6
[0000a04a] 4e75                      rts

_syaccess:
[0000a04c] 4e56 fffc                 link       a6,#-4
[0000a050] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a054] 2a6e 0008                 movea.l    8(a6),a5
[0000a058] 2879 0000 0000            movea.l    _pu,a4
[0000a05e] 1d6c 0130 fffd            move.b     304(a4),-3(a6)
[0000a064] 196c 0132 0130            move.b     306(a4),304(a4)
[0000a06a] 1d6c 0131 fffc            move.b     305(a4),-4(a6)
[0000a070] 196c 0133 0131            move.b     307(a4),305(a4)
[0000a076] 7ef8                      moveq.l    #-8,d7
[0000a078] cead 0004                 and.l      4(a5),d7
[0000a07c] 670e                      beq.s      _syaccess_1
[0000a07e] 4878 0016                 pea.l      ($00000016).w
[0000a082] 4eb9 0000 2868            jsr        _uerror
[0000a088] 588f                      addq.l     #4,a7
[0000a08a] 6058                      bra.s      _syaccess_2
_syaccess_1:
[0000a08c] 4297                      clr.l      (a7)
[0000a08e] 2f15                      move.l     (a5),-(a7)
[0000a090] 4eb9 0000 3ebe            jsr        _findi
[0000a096] 588f                      addq.l     #4,a7
[0000a098] 2647                      movea.l    d7,a3
[0000a09a] 2e0b                      move.l     a3,d7
[0000a09c] 6746                      beq.s      _syaccess_2
[0000a09e] 3d7c 0004 fffe            move.w     #$0004,-2(a6)
_syaccess_5:
[0000a0a4] 4a6e fffe                 tst.w      -2(a6)
[0000a0a8] 672e                      beq.s      _syaccess_3
[0000a0aa] 3e2e fffe                 move.w     -2(a6),d7
[0000a0ae] ce6d 0006                 and.w      6(a5),d7
[0000a0b2] 0287 0000 ffff            andi.l     #$0000FFFF,d7
[0000a0b8] 6718                      beq.s      _syaccess_4
[0000a0ba] 7e00                      moveq.l    #0,d7
[0000a0bc] 3e2e fffe                 move.w     -2(a6),d7
[0000a0c0] ed87                      asl.l      #6,d7
[0000a0c2] 2e87                      move.l     d7,(a7)
[0000a0c4] 2f0b                      move.l     a3,-(a7)
[0000a0c6] 4eb9 0000 2532            jsr        _isacc
[0000a0cc] 588f                      addq.l     #4,a7
[0000a0ce] 4a87                      tst.l      d7
[0000a0d0] 6706                      beq.s      _syaccess_3
_syaccess_4:
[0000a0d2] e2ee fffe                 lsr.w      -2(a6)
[0000a0d6] 60cc                      bra.s      _syaccess_5
_syaccess_3:
[0000a0d8] 4297                      clr.l      (a7)
[0000a0da] 2f0b                      move.l     a3,-(a7)
[0000a0dc] 4eb9 0000 3540            jsr        _puti
[0000a0e2] 588f                      addq.l     #4,a7
_syaccess_2:
[0000a0e4] 196e fffd 0130            move.b     -3(a6),304(a4)
[0000a0ea] 196e fffc 0131            move.b     -4(a6),305(a4)
[0000a0f0] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a0f4] 4e5e                      unlk       a6
[0000a0f6] 4e75                      rts

_sycd:
[0000a0f8] 4e56 fffc                 link       a6,#-4
[0000a0fc] 7e34                      moveq.l    #52,d7
[0000a0fe] deb9 0000 0000            add.l      _pu,d7
[0000a104] 2e87                      move.l     d7,(a7)
[0000a106] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a10a] 4eb9 0000 3b96            jsr        _cdir
[0000a110] 588f                      addq.l     #4,a7
[0000a112] 4e5e                      unlk       a6
[0000a114] 4e75                      rts

_sychmod:
[0000a116] 4e56 fffc                 link       a6,#-4
[0000a11a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a11e] 2a6e 0008                 movea.l    8(a6),a5
[0000a122] 2679 0000 0000            movea.l    _pu,a3
[0000a128] 4297                      clr.l      (a7)
[0000a12a] 2f15                      move.l     (a5),-(a7)
[0000a12c] 4eb9 0000 3ebe            jsr        _findi
[0000a132] 588f                      addq.l     #4,a7
[0000a134] 2847                      movea.l    d7,a4
[0000a136] 2e0c                      move.l     a4,d7
[0000a138] 6608                      bne.s      _sychmod_1
[0000a13a] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a13e] 4e5e                      unlk       a6
[0000a140] 4e75                      rts
_sychmod_1:
[0000a142] 1e2b 0130                 move.b     304(a3),d7
[0000a146] be2c 001d                 cmp.b      29(a4),d7
[0000a14a] 670e                      beq.s      _sychmod_2
[0000a14c] 4a2b 0130                 tst.b      304(a3)
[0000a150] 6708                      beq.s      _sychmod_2
[0000a152] 177c 0001 0142            move.b     #$01,322(a3)
[0000a158] 6052                      bra.s      _sychmod_3
_sychmod_2:
[0000a15a] 3d7c 0fff fffe            move.w     #$0FFF,-2(a6)
[0000a160] 1e2b 0131                 move.b     305(a3),d7
[0000a164] be2c 001e                 cmp.b      30(a4),d7
[0000a168] 670c                      beq.s      _sychmod_4
[0000a16a] 4a2b 0130                 tst.b      304(a3)
[0000a16e] 6706                      beq.s      _sychmod_4
[0000a170] 08ae 0002 fffe            bclr       #2,-2(a6)
_sychmod_4:
[0000a176] 7e00                      moveq.l    #0,d7
[0000a178] 3e2e fffe                 move.w     -2(a6),d7
[0000a17c] 2e87                      move.l     d7,(a7)
[0000a17e] 2f2d 0004                 move.l     4(a5),-(a7)
[0000a182] 7e00                      moveq.l    #0,d7
[0000a184] 3e2c 001a                 move.w     26(a4),d7
[0000a188] 2f07                      move.l     d7,-(a7)
[0000a18a] 4eb9 0000 3c1c            jsr        _chkmode
[0000a190] 508f                      addq.l     #8,a7
[0000a192] 3d47 fffc                 move.w     d7,-4(a6)
[0000a196] 3e2e fffc                 move.w     -4(a6),d7
[0000a19a] be6c 001a                 cmp.w      26(a4),d7
[0000a19e] 670c                      beq.s      _sychmod_3
[0000a1a0] 396e fffc 001a            move.w     -4(a6),26(a4)
[0000a1a6] 08ec 0000 000d            bset       #0,13(a4)
_sychmod_3:
[0000a1ac] 4878 0001                 pea.l      ($00000001).w
[0000a1b0] 2f0c                      move.l     a4,-(a7)
[0000a1b2] 4eb9 0000 3540            jsr        _puti
[0000a1b8] 508f                      addq.l     #8,a7
[0000a1ba] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a1be] 4e5e                      unlk       a6
[0000a1c0] 4e75                      rts

_sychown:
[0000a1c2] 4e56 0000                 link       a6,#0
[0000a1c6] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a1ca] 2a6e 0008                 movea.l    8(a6),a5
[0000a1ce] 2679 0000 0000            movea.l    _pu,a3
[0000a1d4] 4297                      clr.l      (a7)
[0000a1d6] 2f15                      move.l     (a5),-(a7)
[0000a1d8] 4eb9 0000 3ebe            jsr        _findi
[0000a1de] 588f                      addq.l     #4,a7
[0000a1e0] 2847                      movea.l    d7,a4
[0000a1e2] 2e0c                      move.l     a4,d7
[0000a1e4] 6748                      beq.s      _sychown_1
[0000a1e6] 1e2b 0130                 move.b     304(a3),d7
[0000a1ea] be2c 001d                 cmp.b      29(a4),d7
[0000a1ee] 670e                      beq.s      _sychown_2
[0000a1f0] 4a2b 0130                 tst.b      304(a3)
[0000a1f4] 6708                      beq.s      _sychown_2
[0000a1f6] 177c 0001 0142            move.b     #$01,322(a3)
[0000a1fc] 6022                      bra.s      _sychown_3
_sychown_2:
[0000a1fe] 196d 0007 001d            move.b     7(a5),29(a4)
[0000a204] 2e2d 0004                 move.l     4(a5),d7
[0000a208] e08f                      lsr.l      #8,d7
[0000a20a] 1947 001e                 move.b     d7,30(a4)
[0000a20e] 4a2b 0130                 tst.b      304(a3)
[0000a212] 6706                      beq.s      _sychown_4
[0000a214] 026c f3ff 001a            andi.w     #$F3FF,26(a4)
_sychown_4:
[0000a21a] 08ec 0000 000d            bset       #0,13(a4)
_sychown_3:
[0000a220] 4878 0001                 pea.l      ($00000001).w
[0000a224] 2f0c                      move.l     a4,-(a7)
[0000a226] 4eb9 0000 3540            jsr        _puti
[0000a22c] 508f                      addq.l     #8,a7
_sychown_1:
[0000a22e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a232] 4e5e                      unlk       a6
[0000a234] 4e75                      rts

_sycr:
[0000a236] 4e56 fffc                 link       a6,#-4
[0000a23a] 4eb9 0000 2600            jsr        _isuper
[0000a240] 4a87                      tst.l      d7
[0000a242] 6716                      beq.s      _sycr_1
[0000a244] 7e38                      moveq.l    #56,d7
[0000a246] deb9 0000 0000            add.l      _pu,d7
[0000a24c] 2e87                      move.l     d7,(a7)
[0000a24e] 2f2e 0008                 move.l     8(a6),-(a7)
[0000a252] 4eb9 0000 3b96            jsr        _cdir
[0000a258] 588f                      addq.l     #4,a7
_sycr_1:
[0000a25a] 4e5e                      unlk       a6
[0000a25c] 4e75                      rts

_sycreat:
[0000a25e] 4e56 0000                 link       a6,#0
[0000a262] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000a266] 2a6e 0008                 movea.l    8(a6),a5
[0000a26a] 2ead 0004                 move.l     4(a5),(a7)
[0000a26e] 4878 0302                 pea.l      ($00000302).w
[0000a272] 2f15                      move.l     (a5),-(a7)
[0000a274] 4eb9 0000 3cbc            jsr        _crop
[0000a27a] 508f                      addq.l     #8,a7
[0000a27c] 2a87                      move.l     d7,(a5)
[0000a27e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000a282] 4e5e                      unlk       a6
[0000a284] 4e75                      rts

_sylink:
[0000a286] 4e56 fff8                 link       a6,#-8
[0000a28a] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a28e] 2a6e 0008                 movea.l    8(a6),a5
[0000a292] 2679 0000 0000            movea.l    _pu,a3
[0000a298] 4297                      clr.l      (a7)
[0000a29a] 2f15                      move.l     (a5),-(a7)
[0000a29c] 4eb9 0000 3ebe            jsr        _findi
[0000a2a2] 588f                      addq.l     #4,a7
[0000a2a4] 2847                      movea.l    d7,a4
[0000a2a6] 2e0c                      move.l     a4,d7
[0000a2a8] 6774                      beq.s      _sylink_1
[0000a2aa] 2e8c                      move.l     a4,(a7)
[0000a2ac] 4eb9 0000 278c            jsr        _reli
[0000a2b2] 4878 0001                 pea.l      ($00000001).w
[0000a2b6] 2f2d 0004                 move.l     4(a5),-(a7)
[0000a2ba] 4eb9 0000 3ebe            jsr        _findi
[0000a2c0] 508f                      addq.l     #8,a7
[0000a2c2] 2d47 fff8                 move.l     d7,-8(a6)
[0000a2c6] 675e                      beq.s      _sylink_2
[0000a2c8] 2e8c                      move.l     a4,(a7)
[0000a2ca] 4eb9 0000 25da            jsr        _isdir
[0000a2d0] 4a87                      tst.l      d7
[0000a2d2] 671c                      beq.s      _sylink_3
[0000a2d4] 226e fff8                 movea.l    -8(a6),a1
[0000a2d8] 3e29 0018                 move.w     24(a1),d7
[0000a2dc] be6c 0018                 cmp.w      24(a4),d7
[0000a2e0] 660e                      bne.s      _sylink_3
[0000a2e2] 226e fff8                 movea.l    -8(a6),a1
[0000a2e6] 3e29 0016                 move.w     22(a1),d7
[0000a2ea] be6c 0016                 cmp.w      22(a4),d7
[0000a2ee] 6706                      beq.s      _sylink_4
_sylink_3:
[0000a2f0] 177c 0011 0142            move.b     #$11,322(a3)
_sylink_4:
[0000a2f6] 4297                      clr.l      (a7)
[0000a2f8] 2f2e fff8                 move.l     -8(a6),-(a7)
[0000a2fc] 4eb9 0000 3540            jsr        _puti
[0000a302] 588f                      addq.l     #4,a7
[0000a304] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a308] 2f0c                      move.l     a4,-(a7)
[0000a30a] 4eb9 0000 2646            jsr        _locki
[0000a310] 508f                      addq.l     #8,a7
[0000a312] 4297                      clr.l      (a7)
[0000a314] 2f0c                      move.l     a4,-(a7)
[0000a316] 4eb9 0000 3540            jsr        _puti
[0000a31c] 588f                      addq.l     #4,a7
_sylink_1:
[0000a31e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a322] 4e5e                      unlk       a6
[0000a324] 4e75                      rts
_sylink_2:
[0000a326] 4a2b 0142                 tst.b      322(a3)
[0000a32a] 6706                      beq.s      _sylink_5
[0000a32c] 42ae fffc                 clr.l      -4(a6)
[0000a330] 6006                      bra.s      _sylink_6
_sylink_5:
[0000a332] 2d6b 003c fffc            move.l     60(a3),-4(a6)
_sylink_6:
[0000a338] 2e2e fffc                 move.l     -4(a6),d7
[0000a33c] be8c                      cmp.l      a4,d7
[0000a33e] 670e                      beq.s      _sylink_7
[0000a340] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a344] 2f0c                      move.l     a4,-(a7)
[0000a346] 4eb9 0000 2646            jsr        _locki
[0000a34c] 508f                      addq.l     #8,a7
_sylink_7:
[0000a34e] 2e8c                      move.l     a4,(a7)
[0000a350] 4eb9 0000 25da            jsr        _isdir
[0000a356] 4a87                      tst.l      d7
[0000a358] 670a                      beq.s      _sylink_8
[0000a35a] 4eb9 0000 2600            jsr        _isuper
[0000a360] 4a87                      tst.l      d7
[0000a362] 672a                      beq.s      _sylink_9
_sylink_8:
[0000a364] 226b 003c                 movea.l    60(a3),a1
[0000a368] 3e29 0016                 move.w     22(a1),d7
[0000a36c] be6c 0016                 cmp.w      22(a4),d7
[0000a370] 6708                      beq.s      _sylink_10
[0000a372] 177c 0012 0142            move.b     #$12,322(a3)
[0000a378] 6014                      bra.s      _sylink_9
_sylink_10:
[0000a37a] 4aae fffc                 tst.l      -4(a6)
[0000a37e] 670e                      beq.s      _sylink_9
[0000a380] 4878 0001                 pea.l      ($00000001).w
[0000a384] 2f0c                      move.l     a4,-(a7)
[0000a386] 4eb9 0000 4448            jsr        _wlink
[0000a38c] 508f                      addq.l     #8,a7
_sylink_9:
[0000a38e] 4297                      clr.l      (a7)
[0000a390] 2f0c                      move.l     a4,-(a7)
[0000a392] 4eb9 0000 3540            jsr        _puti
[0000a398] 588f                      addq.l     #4,a7
[0000a39a] 2e2e fffc                 move.l     -4(a6),d7
[0000a39e] be8c                      cmp.l      a4,d7
[0000a3a0] 6610                      bne.s      _sylink_11
[0000a3a2] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a3a6] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000a3aa] 4eb9 0000 2646            jsr        _locki
[0000a3b0] 508f                      addq.l     #8,a7
_sylink_11:
[0000a3b2] 4aae fffc                 tst.l      -4(a6)
[0000a3b6] 6710                      beq.s      _sylink_12
[0000a3b8] 4878 0001                 pea.l      ($00000001).w
[0000a3bc] 2f2e fffc                 move.l     -4(a6),-(a7)
[0000a3c0] 4eb9 0000 3540            jsr        _puti
[0000a3c6] 508f                      addq.l     #8,a7
_sylink_12:
[0000a3c8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a3cc] 4e5e                      unlk       a6
[0000a3ce] 4e75                      rts

_symknod:
[0000a3d0] 4e56 0000                 link       a6,#0
[0000a3d4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a3d8] 2a6e 0008                 movea.l    8(a6),a5
[0000a3dc] 2679 0000 0000            movea.l    _pu,a3
[0000a3e2] 7e00                      moveq.l    #0,d7
[0000a3e4] 3e2b 013c                 move.w     316(a3),d7
[0000a3e8] 08c7 000f                 bset       #15,d7
[0000a3ec] 08c7 000c                 bset       #12,d7
[0000a3f0] 4687                      not.l      d7
[0000a3f2] cfad 0004                 and.l      d7,4(a5)
[0000a3f6] 3e2d 0006                 move.w     6(a5),d7
[0000a3fa] 0807 000d                 btst       #13,d7
[0000a3fe] 670a                      beq.s      _symknod_1
[0000a400] 4eb9 0000 2600            jsr        _isuper
[0000a406] 4a87                      tst.l      d7
[0000a408] 6732                      beq.s      _symknod_2
_symknod_1:
[0000a40a] 4878 0001                 pea.l      ($00000001).w
[0000a40e] 2f15                      move.l     (a5),-(a7)
[0000a410] 4eb9 0000 3ebe            jsr        _findi
[0000a416] 508f                      addq.l     #8,a7
[0000a418] 2847                      movea.l    d7,a4
[0000a41a] 2e0c                      move.l     a4,d7
[0000a41c] 6708                      beq.s      _symknod_3
[0000a41e] 177c 0011 0142            move.b     #$11,322(a3)
[0000a424] 601e                      bra.s      _symknod_4
_symknod_3:
[0000a426] 4a2b 0142                 tst.b      322(a3)
[0000a42a] 6610                      bne.s      _symknod_2
[0000a42c] 2ead 0004                 move.l     4(a5),(a7)
[0000a430] 4eb9 0000 4202            jsr        _makei
[0000a436] 2847                      movea.l    d7,a4
[0000a438] 2e0c                      move.l     a4,d7
[0000a43a] 6608                      bne.s      _symknod_4
_symknod_2:
[0000a43c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a440] 4e5e                      unlk       a6
[0000a442] 4e75                      rts
_symknod_4:
[0000a444] 082c 0005 001a            btst       #5,26(a4)
[0000a44a] 6712                      beq.s      _symknod_5
[0000a44c] 4a2b 0142                 tst.b      322(a3)
[0000a450] 660c                      bne.s      _symknod_5
[0000a452] 396d 000a 0022            move.w     10(a5),34(a4)
[0000a458] 08ec 0000 000d            bset       #0,13(a4)
_symknod_5:
[0000a45e] 4878 0001                 pea.l      ($00000001).w
[0000a462] 2f0c                      move.l     a4,-(a7)
[0000a464] 4eb9 0000 3540            jsr        _puti
[0000a46a] 508f                      addq.l     #8,a7
[0000a46c] 60ce                      bra.s      _symknod_2

_symount:
[0000a46e] 4e56 fffe                 link       a6,#-2
[0000a472] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a476] 2a6e 0008                 movea.l    8(a6),a5
[0000a47a] 4eb9 0000 2600            jsr        _isuper
[0000a480] 4a87                      tst.l      d7
[0000a482] 6700 00da                 beq        _symount_1
[0000a486] 2e95                      move.l     (a5),(a7)
[0000a488] 4eb9 0000 0c3a            jsr        _mountdev
[0000a48e] 3d47 fffe                 move.w     d7,-2(a6)
[0000a492] 6700 00ca                 beq        _symount_1
[0000a496] 4297                      clr.l      (a7)
[0000a498] 2f2d 0004                 move.l     4(a5),-(a7)
[0000a49c] 4eb9 0000 3ebe            jsr        _findi
[0000a4a2] 588f                      addq.l     #4,a7
[0000a4a4] 2847                      movea.l    d7,a4
[0000a4a6] 2e0c                      move.l     a4,d7
[0000a4a8] 6700 00b4                 beq        _symount_1
[0000a4ac] 3e2c 000e                 move.w     14(a4),d7
[0000a4b0] 0c47 0001                 cmpi.w     #$0001,d7
[0000a4b4] 6652                      bne.s      _symount_2
[0000a4b6] 7e00                      moveq.l    #0,d7
[0000a4b8] 3e2e fffe                 move.w     -2(a6),d7
[0000a4bc] 2e87                      move.l     d7,(a7)
[0000a4be] 4eb9 0000 248c            jsr        _getmount
[0000a4c4] 4a87                      tst.l      d7
[0000a4c6] 6640                      bne.s      _symount_2
[0000a4c8] 4878 6000                 pea.l      ($00006000).w
[0000a4cc] 4aad 0008                 tst.l      8(a5)
[0000a4d0] 6704                      beq.s      _symount_3
[0000a4d2] 7e01                      moveq.l    #1,d7
[0000a4d4] 6002                      bra.s      _symount_4
_symount_3:
[0000a4d6] 7e03                      moveq.l    #3,d7
_symount_4:
[0000a4d8] 2f07                      move.l     d7,-(a7)
[0000a4da] 7e00                      moveq.l    #0,d7
[0000a4dc] 3e2e fffe                 move.w     -2(a6),d7
[0000a4e0] 2f07                      move.l     d7,-(a7)
[0000a4e2] 4eb9 0000 0cc0            jsr        _opendev
[0000a4e8] 4fef 000c                 lea.l      12(a7),a7
[0000a4ec] 4a87                      tst.l      d7
[0000a4ee] 6718                      beq.s      _symount_2
[0000a4f0] 2eb9 0000 b0ec            move.l     _mlist,(a7)
[0000a4f6] 4878 0010                 pea.l      ($00000010).w
[0000a4fa] 4eb9 0000 00f6            jsr        _alloc
[0000a500] 588f                      addq.l     #4,a7
[0000a502] 2647                      movea.l    d7,a3
[0000a504] 2e0b                      move.l     a3,d7
[0000a506] 661a                      bne.s      _symount_5
_symount_2:
[0000a508] 2279 0000 0000            movea.l    _pu,a1
[0000a50e] 137c 0010 0142            move.b     #$10,322(a1)
[0000a514] 4297                      clr.l      (a7)
[0000a516] 2f0c                      move.l     a4,-(a7)
[0000a518] 4eb9 0000 3540            jsr        _puti
[0000a51e] 588f                      addq.l     #4,a7
[0000a520] 603c                      bra.s      _symount_1
_symount_5:
[0000a522] 376e fffe 0008            move.w     -2(a6),8(a3)
[0000a528] 2279 0000 0000            movea.l    _pu,a1
[0000a52e] 3769 013e 000a            move.w     318(a1),10(a3)
[0000a534] 2279 0000 0000            movea.l    _pu,a1
[0000a53a] 3769 0140 000c            move.w     320(a1),12(a3)
[0000a540] 176d 000b 000e            move.b     11(a5),14(a3)
[0000a546] 274c 0004                 move.l     a4,4(a3)
[0000a54a] 23cb 0000 b0ec            move.l     a3,_mlist
[0000a550] 08ec 0002 000d            bset       #2,13(a4)
[0000a556] 2e8c                      move.l     a4,(a7)
[0000a558] 4eb9 0000 278c            jsr        _reli
_symount_1:
[0000a55e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a562] 4e5e                      unlk       a6
[0000a564] 4e75                      rts

_syopen:
[0000a566] 4e56 0000                 link       a6,#0
[0000a56a] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000a56e] 2a6e 0008                 movea.l    8(a6),a5
[0000a572] 2ead 0008                 move.l     8(a5),(a7)
[0000a576] 2e2d 0004                 move.l     4(a5),d7
[0000a57a] 2f07                      move.l     d7,-(a7)
[0000a57c] 5297                      addq.l     #1,(a7)
[0000a57e] 2f15                      move.l     (a5),-(a7)
[0000a580] 4eb9 0000 3cbc            jsr        _crop
[0000a586] 508f                      addq.l     #8,a7
[0000a588] 2a87                      move.l     d7,(a5)
[0000a58a] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000a58e] 4e5e                      unlk       a6
[0000a590] 4e75                      rts

_systat:
[0000a592] 4e56 0000                 link       a6,#0
[0000a596] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000a59a] 2a6e 0008                 movea.l    8(a6),a5
[0000a59e] 4297                      clr.l      (a7)
[0000a5a0] 2f15                      move.l     (a5),-(a7)
[0000a5a2] 4eb9 0000 3ebe            jsr        _findi
[0000a5a8] 588f                      addq.l     #4,a7
[0000a5aa] 2847                      movea.l    d7,a4
[0000a5ac] 2e0c                      move.l     a4,d7
[0000a5ae] 670e                      beq.s      _systat_1
[0000a5b0] 2ead 0004                 move.l     4(a5),(a7)
[0000a5b4] 2f0c                      move.l     a4,-(a7)
[0000a5b6] 4eb9 0000 2f58            jsr        _getstat
[0000a5bc] 588f                      addq.l     #4,a7
_systat_1:
[0000a5be] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000a5c2] 4e5e                      unlk       a6
[0000a5c4] 4e75                      rts

_syulink:
[0000a5c6] 4e56 0000                 link       a6,#0
[0000a5ca] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a5ce] 2679 0000 0000            movea.l    _pu,a3
[0000a5d4] 4878 0002                 pea.l      ($00000002).w
[0000a5d8] 226e 0008                 movea.l    8(a6),a1
[0000a5dc] 2f11                      move.l     (a1),-(a7)
[0000a5de] 4eb9 0000 3ebe            jsr        _findi
[0000a5e4] 508f                      addq.l     #8,a7
[0000a5e6] 2a47                      movea.l    d7,a5
[0000a5e8] 2e0d                      move.l     a5,d7
[0000a5ea] 6608                      bne.s      _syulink_1
[0000a5ec] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a5f0] 4e5e                      unlk       a6
[0000a5f2] 4e75                      rts
_syulink_1:
[0000a5f4] 7e00                      moveq.l    #0,d7
[0000a5f6] 3e2b 0154                 move.w     340(a3),d7
[0000a5fa] 2e87                      move.l     d7,(a7)
[0000a5fc] 7e00                      moveq.l    #0,d7
[0000a5fe] 3e2d 0016                 move.w     22(a5),d7
[0000a602] 2f07                      move.l     d7,-(a7)
[0000a604] 4eb9 0000 31fc            jsr        _loci
[0000a60a] 588f                      addq.l     #4,a7
[0000a60c] 2847                      movea.l    d7,a4
[0000a60e] b9cd                      cmpa.l     a5,a4
[0000a610] 6702                      beq.s      _syulink_2
[0000a612] 99cc                      suba.l     a4,a4
_syulink_2:
[0000a614] 2e0c                      move.l     a4,d7
[0000a616] 661e                      bne.s      _syulink_3
[0000a618] 7e00                      moveq.l    #0,d7
[0000a61a] 3e2b 0154                 move.w     340(a3),d7
[0000a61e] 2e87                      move.l     d7,(a7)
[0000a620] 7e00                      moveq.l    #0,d7
[0000a622] 3e2d 0016                 move.w     22(a5),d7
[0000a626] 2f07                      move.l     d7,-(a7)
[0000a628] 4eb9 0000 2dd8            jsr        _geti
[0000a62e] 588f                      addq.l     #4,a7
[0000a630] 2847                      movea.l    d7,a4
[0000a632] 2e0c                      move.l     a4,d7
[0000a634] 6740                      beq.s      _syulink_4
_syulink_3:
[0000a636] 3e2d 0016                 move.w     22(a5),d7
[0000a63a] be6c 0016                 cmp.w      22(a4),d7
[0000a63e] 670e                      beq.s      _syulink_5
[0000a640] 4878 0012                 pea.l      ($00000012).w
[0000a644] 4eb9 0000 2868            jsr        _uerror
[0000a64a] 588f                      addq.l     #4,a7
[0000a64c] 6002                      bra.s      _syulink_6
_syulink_5:
[0000a64e] 7e00                      moveq.l    #0,d7
_syulink_6:
[0000a650] 4a87                      tst.l      d7
[0000a652] 6622                      bne.s      _syulink_4
[0000a654] 2e8c                      move.l     a4,(a7)
[0000a656] 4eb9 0000 25da            jsr        _isdir
[0000a65c] 4a87                      tst.l      d7
[0000a65e] 670a                      beq.s      _syulink_7
[0000a660] 4eb9 0000 2600            jsr        _isuper
[0000a666] 4a87                      tst.l      d7
[0000a668] 670c                      beq.s      _syulink_4
_syulink_7:
[0000a66a] 4297                      clr.l      (a7)
[0000a66c] 2f0c                      move.l     a4,-(a7)
[0000a66e] 4eb9 0000 4448            jsr        _wlink
[0000a674] 588f                      addq.l     #4,a7
_syulink_4:
[0000a676] 2e0c                      move.l     a4,d7
[0000a678] 6710                      beq.s      _syulink_8
[0000a67a] b9cd                      cmpa.l     a5,a4
[0000a67c] 670c                      beq.s      _syulink_8
[0000a67e] 4297                      clr.l      (a7)
[0000a680] 2f0c                      move.l     a4,-(a7)
[0000a682] 4eb9 0000 3540            jsr        _puti
[0000a688] 588f                      addq.l     #4,a7
_syulink_8:
[0000a68a] 4878 0001                 pea.l      ($00000001).w
[0000a68e] 2f0d                      move.l     a5,-(a7)
[0000a690] 4eb9 0000 3540            jsr        _puti
[0000a696] 508f                      addq.l     #8,a7
[0000a698] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a69c] 4e5e                      unlk       a6
[0000a69e] 4e75                      rts

_syumount:
[0000a6a0] 4e56 0000                 link       a6,#0
[0000a6a4] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a6a8] 226e 0008                 movea.l    8(a6),a1
[0000a6ac] 2e91                      move.l     (a1),(a7)
[0000a6ae] 4eb9 0000 0c3a            jsr        _mountdev
[0000a6b4] 2a07                      move.l     d7,d5
[0000a6b6] 670e                      beq.s      _syumount_1
[0000a6b8] 2e85                      move.l     d5,(a7)
[0000a6ba] 4eb9 0000 248c            jsr        _getmount
[0000a6c0] 2847                      movea.l    d7,a4
[0000a6c2] 2e0c                      move.l     a4,d7
[0000a6c4] 660e                      bne.s      _syumount_2
_syumount_1:
[0000a6c6] 2279 0000 0000            movea.l    _pu,a1
[0000a6cc] 137c 0016 0142            move.b     #$16,322(a1)
_syumount_9:
[0000a6d2] 6020                      bra.s      _syumount_3
_syumount_2:
[0000a6d4] 2a79 0000 b0e8            movea.l    _ilist,a5
_syumount_6:
[0000a6da] 2e0d                      move.l     a5,d7
[0000a6dc] 6722                      beq.s      _syumount_4
[0000a6de] 7e00                      moveq.l    #0,d7
[0000a6e0] 3e2d 0016                 move.w     22(a5),d7
[0000a6e4] be85                      cmp.l      d5,d7
[0000a6e6] 6614                      bne.s      _syumount_5
[0000a6e8] 2279 0000 0000            movea.l    _pu,a1
[0000a6ee] 137c 0010 0142            move.b     #$10,322(a1)
_syumount_3:
[0000a6f4] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a6f8] 4e5e                      unlk       a6
[0000a6fa] 4e75                      rts
_syumount_5:
[0000a6fc] 2a55                      movea.l    (a5),a5
[0000a6fe] 60da                      bra.s      _syumount_6
_syumount_4:
[0000a700] 4878 6000                 pea.l      ($00006000).w
[0000a704] 4a2c 000e                 tst.b      14(a4)
[0000a708] 6604                      bne.s      _syumount_7
[0000a70a] 7e01                      moveq.l    #1,d7
[0000a70c] 6002                      bra.s      _syumount_8
_syumount_7:
[0000a70e] 7e00                      moveq.l    #0,d7
_syumount_8:
[0000a710] 2f07                      move.l     d7,-(a7)
[0000a712] 2f05                      move.l     d5,-(a7)
[0000a714] 4eb9 0000 0ab2            jsr        _closed
[0000a71a] 4fef 000c                 lea.l      12(a7),a7
[0000a71e] 2a6c 0004                 movea.l    4(a4),a5
[0000a722] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a726] 2f0d                      move.l     a5,-(a7)
[0000a728] 4eb9 0000 2646            jsr        _locki
[0000a72e] 508f                      addq.l     #8,a7
[0000a730] 08ad 0002 000d            bclr       #2,13(a5)
[0000a736] 4297                      clr.l      (a7)
[0000a738] 2f0d                      move.l     a5,-(a7)
[0000a73a] 4eb9 0000 3540            jsr        _puti
[0000a740] 588f                      addq.l     #4,a7
[0000a742] 2ebc 0000 b0ec            move.l     #_mlist,(a7)
[0000a748] 2f0c                      move.l     a4,-(a7)
[0000a74a] 4878 0010                 pea.l      ($00000010).w
[0000a74e] 4eb9 0000 0138            jsr        _frelst
[0000a754] 508f                      addq.l     #8,a7
[0000a756] 6000 ff7a                 bra        _syumount_9

_syutime:
[0000a75a] 4e56 fffc                 link       a6,#-4
[0000a75e] 2eae 0008                 move.l     8(a6),(a7)
[0000a762] 4eb9 0000 3ac4            jsr        _utime
[0000a768] 4e5e                      unlk       a6
[0000a76a] 4e75                      rts

_sysbrk:
[0000a76c] 4e56 0000                 link       a6,#0
[0000a770] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000a774] 2a6e 0008                 movea.l    8(a6),a5
[0000a778] 2a15                      move.l     (a5),d5
[0000a77a] 2879 0000 0000            movea.l    _pu,a4
[0000a780] 2aac 0014                 move.l     20(a4),(a5)
[0000a784] 0c85 ffff ffff            cmpi.l     #$FFFFFFFF,d5
[0000a78a] 6740                      beq.s      _sysbrk_1
[0000a78c] 7e00                      moveq.l    #0,d7
[0000a78e] 5487                      addq.l     #2,d7
[0000a790] 5387                      subq.l     #1,d7
[0000a792] de85                      add.l      d5,d7
[0000a794] 7c00                      moveq.l    #0,d6
[0000a796] 5486                      addq.l     #2,d6
[0000a798] 5386                      subq.l     #1,d6
[0000a79a] 4686                      not.l      d6
[0000a79c] ce86                      and.l      d6,d7
[0000a79e] 2a07                      move.l     d7,d5
[0000a7a0] 2eb9 0000 0000            move.l     _hi_chk,(a7)
[0000a7a6] 2f05                      move.l     d5,-(a7)
[0000a7a8] 4eb9 0000 0000            jsr        _stkchk
[0000a7ae] 588f                      addq.l     #4,a7
[0000a7b0] 4a87                      tst.l      d7
[0000a7b2] 6612                      bne.s      _sysbrk_2
[0000a7b4] baac 0020                 cmp.l      32(a4),d5
[0000a7b8] 650c                      bcs.s      _sysbrk_2
[0000a7ba] 2e2c 0020                 move.l     32(a4),d7
[0000a7be] deac 0024                 add.l      36(a4),d7
[0000a7c2] be85                      cmp.l      d5,d7
[0000a7c4] 640e                      bcc.s      _sysbrk_3
_sysbrk_2:
[0000a7c6] 197c 0001 0142            move.b     #$01,322(a4)
_sysbrk_1:
[0000a7cc] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000a7d0] 4e5e                      unlk       a6
[0000a7d2] 4e75                      rts
_sysbrk_3:
[0000a7d4] 2945 0014                 move.l     d5,20(a4)
[0000a7d8] 2e15                      move.l     (a5),d7
[0000a7da] be85                      cmp.l      d5,d7
[0000a7dc] 64ee                      bcc.s      _sysbrk_1
[0000a7de] 2e05                      move.l     d5,d7
[0000a7e0] 9e95                      sub.l      (a5),d7
[0000a7e2] 2e87                      move.l     d7,(a7)
[0000a7e4] 2f15                      move.l     (a5),-(a7)
[0000a7e6] 4eb9 0000 0000            jsr        _clrmem
[0000a7ec] 588f                      addq.l     #4,a7
[0000a7ee] 60dc                      bra.s      _sysbrk_1

_syexit:
[0000a7f0] 4e56 ffde                 link       a6,#-34
[0000a7f4] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000a7f8] 2879 0000 0000            movea.l    _pu,a4
[0000a7fe] 266c 0010                 movea.l    16(a4),a3
[0000a802] 4aae 0008                 tst.l      8(a6)
[0000a806] 670a                      beq.s      _syexit_1
[0000a808] 226e 0008                 movea.l    8(a6),a1
[0000a80c] 2e11                      move.l     (a1),d7
[0000a80e] e187                      asl.l      #8,d7
[0000a810] 6004                      bra.s      _syexit_2
_syexit_1:
[0000a812] 2e2e 000c                 move.l     12(a6),d7
_syexit_2:
[0000a816] 3d47 fff8                 move.w     d7,-8(a6)
[0000a81a] 08ab 0003 0010            bclr       #3,16(a3)
[0000a820] 70ff                      moveq.l    #-1,d0
[0000a822] 2740 003a                 move.l     d0,58(a3)
[0000a826] 422b 0042                 clr.b      66(a3)
_syexit_4:
[0000a82a] 4aab 0026                 tst.l      38(a3)
[0000a82e] 6718                      beq.s      _syexit_3
[0000a830] 486b 0026                 pea.l      38(a3)
[0000a834] 2f2b 0026                 move.l     38(a3),-(a7)
[0000a838] 4878 001c                 pea.l      ($0000001C).w
[0000a83c] 4eb9 0000 0138            jsr        _frelst
[0000a842] 4fef 000c                 lea.l      12(a7),a7
[0000a846] 60e2                      bra.s      _syexit_4
_syexit_3:
[0000a848] 43ec 0044                 lea.l      68(a4),a1
[0000a84c] 2d49 fff4                 move.l     a1,-12(a6)
[0000a850] 3d7c 0020 fffa            move.w     #$0020,-6(a6)
_syexit_7:
[0000a856] 536e fffa                 subq.w     #1,-6(a6)
[0000a85a] 6d20                      blt.s      _syexit_5
[0000a85c] 226e fff4                 movea.l    -12(a6),a1
[0000a860] 4a91                      tst.l      (a1)
[0000a862] 670c                      beq.s      _syexit_6
[0000a864] 226e fff4                 movea.l    -12(a6),a1
[0000a868] 2e91                      move.l     (a1),(a7)
[0000a86a] 4eb9 0000 2200            jsr        _closef
_syexit_6:
[0000a870] 226e fff4                 movea.l    -12(a6),a1
[0000a874] 4291                      clr.l      (a1)
[0000a876] 58ae fff4                 addq.l     #4,-12(a6)
[0000a87a] 60da                      bra.s      _syexit_7
_syexit_5:
[0000a87c] 4eb9 0000 9e92            jsr        _preemp
[0000a882] 0c6b 0001 001c            cmpi.w     #$0001,28(a3)
[0000a888] 6600 0122                 bne        _syexit_8
[0000a88c] 2eab 0022                 move.l     34(a3),(a7)
[0000a890] 4eb9 0000 81c8            jsr        _txtexit
[0000a896] 42ab 0022                 clr.l      34(a3)
[0000a89a] 4ab9 0000 0000            tst.l      _mmupres
[0000a8a0] 670c                      beq.s      _syexit_9
[0000a8a2] 42ac 0018                 clr.l      24(a4)
[0000a8a6] 08ab 0004 0010            bclr       #4,16(a3)
[0000a8ac] 6018                      bra.s      _syexit_10
_syexit_9:
[0000a8ae] 7e00                      moveq.l    #0,d7
[0000a8b0] 3e2b 0008                 move.w     8(a3),d7
[0000a8b4] 3c39 0000 0000            move.w     _xmemshft,d6
[0000a8ba] eda7                      asl.l      d6,d7
[0000a8bc] 2947 0018                 move.l     d7,24(a4)
[0000a8c0] 08eb 0004 0010            bset       #4,16(a3)
_syexit_10:
[0000a8c6] 296c 0018 0020            move.l     24(a4),32(a4)
[0000a8cc] 2e3c 0000 0000            move.l     #_p1end,d7
[0000a8d2] 0487 0000 0000            subi.l     #_p1boot,d7
[0000a8d8] deac 0018                 add.l      24(a4),d7
[0000a8dc] 2947 0014                 move.l     d7,20(a4)
[0000a8e0] 2eb9 0000 0000            move.l     _p1size,(a7)
[0000a8e6] 4eb9 0000 0000            jsr        _mapsize
[0000a8ec] 3c39 0000 0000            move.w     _xmemshft,d6
[0000a8f2] eda7                      asl.l      d6,d7
[0000a8f4] 2947 0024                 move.l     d7,36(a4)
[0000a8f8] 42ac 001c                 clr.l      28(a4)
[0000a8fc] 2eb9 0000 0000            move.l     _p1size,(a7)
[0000a902] 4eb9 0000 0000            jsr        _mapsize
[0000a908] deb9 0000 0000            add.l      _usize,d7
[0000a90e] 2e87                      move.l     d7,(a7)
[0000a910] 2f0b                      move.l     a3,-(a7)
[0000a912] 4eb9 0000 7822            jsr        _freemem
[0000a918] 588f                      addq.l     #4,a7
[0000a91a] 2eac 0018                 move.l     24(a4),(a7)
[0000a91e] 2e2c 0020                 move.l     32(a4),d7
[0000a922] deac 0024                 add.l      36(a4),d7
[0000a926] 2f07                      move.l     d7,-(a7)
[0000a928] 7e00                      moveq.l    #0,d7
[0000a92a] 3e2b 0008                 move.w     8(a3),d7
[0000a92e] 7c00                      moveq.l    #0,d6
[0000a930] 3c2b 000a                 move.w     10(a3),d6
[0000a934] de86                      add.l      d6,d7
[0000a936] 9eb9 0000 0000            sub.l      _usize,d7
[0000a93c] 2f07                      move.l     d7,-(a7)
[0000a93e] 4eb9 0000 0000            jsr        _uinit
[0000a944] 508f                      addq.l     #8,a7
[0000a946] 2847                      movea.l    d7,a4
[0000a948] 2e3c 0000 0000            move.l     #_p1end,d7
[0000a94e] 0487 0000 0000            subi.l     #_p1boot,d7
[0000a954] 2e87                      move.l     d7,(a7)
[0000a956] 2f2c 0018                 move.l     24(a4),-(a7)
[0000a95a] 2f3c 0000 0000            move.l     #_p1boot,-(a7)
[0000a960] 4eb9 0000 0000            jsr        _outbuf
[0000a966] 508f                      addq.l     #8,a7
[0000a968] 422b 0040                 clr.b      64(a3)
[0000a96c] 422c 0130                 clr.b      304(a4)
[0000a970] 422c 0131                 clr.b      305(a4)
[0000a974] 422c 0132                 clr.b      306(a4)
[0000a978] 422c 0133                 clr.b      307(a4)
[0000a97c] 43ec 00c8                 lea.l      200(a4),a1
[0000a980] 2d49 ffe6                 move.l     a1,-26(a6)
[0000a984] 3d7c 0012 fffa            move.w     #$0012,-6(a6)
_syexit_12:
[0000a98a] 536e fffa                 subq.w     #1,-6(a6)
[0000a98e] 6d0c                      blt.s      _syexit_11
[0000a990] 226e ffe6                 movea.l    -26(a6),a1
[0000a994] 4211                      clr.b      (a1)
[0000a996] 52ae ffe6                 addq.l     #1,-26(a6)
[0000a99a] 60ee                      bra.s      _syexit_12
_syexit_11:
[0000a99c] 42ab 003a                 clr.l      58(a3)
[0000a9a0] 426b 0020                 clr.w      32(a3)
[0000a9a4] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000a9a8] 4e5e                      unlk       a6
[0000a9aa] 4e75                      rts
_syexit_8:
[0000a9ac] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a9b0] 2f2c 0034                 move.l     52(a4),-(a7)
[0000a9b4] 4eb9 0000 2646            jsr        _locki
[0000a9ba] 508f                      addq.l     #8,a7
[0000a9bc] 4297                      clr.l      (a7)
[0000a9be] 2f2c 0034                 move.l     52(a4),-(a7)
[0000a9c2] 4eb9 0000 3540            jsr        _puti
[0000a9c8] 588f                      addq.l     #4,a7
[0000a9ca] 4878 fffe                 pea.l      ($FFFFFFFE).w
[0000a9ce] 2f2c 0038                 move.l     56(a4),-(a7)
[0000a9d2] 4eb9 0000 2646            jsr        _locki
[0000a9d8] 508f                      addq.l     #8,a7
[0000a9da] 4297                      clr.l      (a7)
[0000a9dc] 2f2c 0038                 move.l     56(a4),-(a7)
[0000a9e0] 4eb9 0000 3540            jsr        _puti
[0000a9e6] 588f                      addq.l     #4,a7
[0000a9e8] 2a79 0000 b514            movea.l    _plist,a5
_syexit_14:
[0000a9ee] 2e0d                      move.l     a5,d7
[0000a9f0] 670e                      beq.s      _syexit_13
[0000a9f2] 3e2b 003e                 move.w     62(a3),d7
[0000a9f6] be6d 001c                 cmp.w      28(a5),d7
[0000a9fa] 6704                      beq.s      _syexit_13
[0000a9fc] 2a55                      movea.l    (a5),a5
[0000a9fe] 60ee                      bra.s      _syexit_14
_syexit_13:
[0000aa00] 3d6b 001c fff2            move.w     28(a3),-14(a6)
[0000aa06] 2d6b 0036 fffc            move.l     54(a3),-4(a6)
[0000aa0c] 4878 0008                 pea.l      ($00000008).w
[0000aa10] 486e ffea                 pea.l      -22(a6)
[0000aa14] 486b 0014                 pea.l      20(a3)
[0000aa18] 4eb9 0000 2754            jsr        _movbuf
[0000aa1e] 4fef 000c                 lea.l      12(a7),a7
[0000aa22] 4eb9 0000 0000            jsr        _mapclr
[0000aa28] 2eab 0022                 move.l     34(a3),(a7)
[0000aa2c] 4eb9 0000 81c8            jsr        _txtexit
[0000aa32] 42ab 0022                 clr.l      34(a3)
[0000aa36] 4878 0006                 pea.l      ($00000006).w
[0000aa3a] 2f0b                      move.l     a3,-(a7)
[0000aa3c] 4eb9 0000 835a            jsr        _offrun
[0000aa42] 508f                      addq.l     #8,a7
[0000aa44] 4297                      clr.l      (a7)
[0000aa46] 2f0b                      move.l     a3,-(a7)
[0000aa48] 4eb9 0000 7822            jsr        _freemem
[0000aa4e] 588f                      addq.l     #4,a7
[0000aa50] 297c 0000 0000 0010       move.l     #_proc0,16(a4)
[0000aa58] 4279 0000 0000            clr.w      _curbase
[0000aa5e] 2e0d                      move.l     a5,d7
[0000aa60] 6700 00c4                 beq        _syexit_15
[0000aa64] 43ed 0026                 lea.l      38(a5),a1
[0000aa68] 2d49 ffe2                 move.l     a1,-30(a6)
_syexit_17:
[0000aa6c] 226e ffe2                 movea.l    -30(a6),a1
[0000aa70] 2d51 ffde                 move.l     (a1),-34(a6)
[0000aa74] 6708                      beq.s      _syexit_16
[0000aa76] 2d6e ffde ffe2            move.l     -34(a6),-30(a6)
[0000aa7c] 60ee                      bra.s      _syexit_17
_syexit_16:
[0000aa7e] 4297                      clr.l      (a7)
[0000aa80] 4878 001c                 pea.l      ($0000001C).w
[0000aa84] 4eb9 0000 00f6            jsr        _alloc
[0000aa8a] 588f                      addq.l     #4,a7
[0000aa8c] 226e ffe2                 movea.l    -30(a6),a1
[0000aa90] 2287                      move.l     d7,(a1)
[0000aa92] 6764                      beq.s      _syexit_18
[0000aa94] 226e ffe2                 movea.l    -30(a6),a1
[0000aa98] 2251                      movea.l    (a1),a1
[0000aa9a] 336e fff2 0012            move.w     -14(a6),18(a1)
[0000aaa0] 226e ffe2                 movea.l    -30(a6),a1
[0000aaa4] 2251                      movea.l    (a1),a1
[0000aaa6] 336e fff8 0010            move.w     -8(a6),16(a1)
[0000aaac] 226e ffe2                 movea.l    -30(a6),a1
[0000aab0] 2251                      movea.l    (a1),a1
[0000aab2] 2e2c 011c                 move.l     284(a4),d7
[0000aab6] deac 0114                 add.l      276(a4),d7
[0000aaba] 2347 0008                 move.l     d7,8(a1)
[0000aabe] 226e ffe2                 movea.l    -30(a6),a1
[0000aac2] 2251                      movea.l    (a1),a1
[0000aac4] 2e2c 0118                 move.l     280(a4),d7
[0000aac8] deac 0110                 add.l      272(a4),d7
[0000aacc] 2347 0004                 move.l     d7,4(a1)
[0000aad0] 226e ffe2                 movea.l    -30(a6),a1
[0000aad4] 2251                      movea.l    (a1),a1
[0000aad6] 236e fffc 000c            move.l     -4(a6),12(a1)
[0000aadc] 4878 0008                 pea.l      ($00000008).w
[0000aae0] 226e ffe2                 movea.l    -30(a6),a1
[0000aae4] 7e14                      moveq.l    #20,d7
[0000aae6] de91                      add.l      (a1),d7
[0000aae8] 2f07                      move.l     d7,-(a7)
[0000aaea] 486e ffea                 pea.l      -22(a6)
[0000aaee] 4eb9 0000 2754            jsr        _movbuf
[0000aaf4] 4fef 000c                 lea.l      12(a7),a7
_syexit_18:
[0000aaf8] 0c2d 0004 0011            cmpi.b     #$04,17(a5)
[0000aafe] 6612                      bne.s      _syexit_19
[0000ab00] 2e2d 0004                 move.l     4(a5),d7
[0000ab04] be8d                      cmp.l      a5,d7
[0000ab06] 660a                      bne.s      _syexit_19
[0000ab08] 2e8d                      move.l     a5,(a7)
[0000ab0a] 4eb9 0000 8b4c            jsr        _wakeup
[0000ab10] 6014                      bra.s      _syexit_15
_syexit_19:
[0000ab12] 0c2d 0007 0011            cmpi.b     #$07,17(a5)
[0000ab18] 660c                      bne.s      _syexit_15
[0000ab1a] 2ebc 0000 b500            move.l     #_outproc,(a7)
[0000ab20] 4eb9 0000 7b76            jsr        _schp0
_syexit_15:
[0000ab26] 4eb9 0000 8974            jsr        _switchp
[0000ab2c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000ab30] 4e5e                      unlk       a6
[0000ab32] 4e75                      rts

_syfork:
[0000ab34] 4e56 fffc                 link       a6,#-4
[0000ab38] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[0000ab3c] 2879 0000 0000            movea.l    _pu,a4
[0000ab42] 266c 0010                 movea.l    16(a4),a3
[0000ab46] 4878 0001                 pea.l      ($00000001).w
[0000ab4a] 4eb9 0000 8206            jsr        _makep
[0000ab50] 588f                      addq.l     #4,a7
[0000ab52] 2a47                      movea.l    d7,a5
[0000ab54] 2e0d                      move.l     a5,d7
[0000ab56] 6608                      bne.s      _syfork_1
[0000ab58] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000ab5c] 4e5e                      unlk       a6
[0000ab5e] 4e75                      rts
_syfork_1:
[0000ab60] 4eb9 0000 7ff0            jsr        _swbuy
[0000ab66] 08eb 0003 0010            bset       #3,16(a3)
[0000ab6c] 08ad 0004 0010            bclr       #4,16(a5)
[0000ab72] 42ae fffc                 clr.l      -4(a6)
_syfork_3:
[0000ab76] 2eb9 0000 0000            move.l     _usize,(a7)
[0000ab7c] 2f3c 0000 b5a4            move.l     #_memlist,-(a7)
[0000ab82] 7e00                      moveq.l    #0,d7
[0000ab84] 3e2d 000a                 move.w     10(a5),d7
[0000ab88] 2f07                      move.l     d7,-(a7)
[0000ab8a] 4eb9 0000 0000            jsr        _memalloc
[0000ab90] 508f                      addq.l     #8,a7
[0000ab92] 3b47 0008                 move.w     d7,8(a5)
[0000ab96] 6614                      bne.s      _syfork_2
[0000ab98] 2e8d                      move.l     a5,(a7)
[0000ab9a] 4eb9 0000 8094            jsr        _throwout
[0000aba0] 4a87                      tst.l      d7
[0000aba2] 6708                      beq.s      _syfork_2
[0000aba4] 7001                      moveq.l    #1,d0
[0000aba6] 2d40 fffc                 move.l     d0,-4(a6)
[0000abaa] 60ca                      bra.s      _syfork_3
_syfork_2:
[0000abac] 4eb9 0000 8022            jsr        _swsell
[0000abb2] 08ab 0003 0010            bclr       #3,16(a3)
[0000abb8] 4aae fffc                 tst.l      -4(a6)
[0000abbc] 670c                      beq.s      _syfork_4
[0000abbe] 2ebc 0000 b500            move.l     #_outproc,(a7)
[0000abc4] 4eb9 0000 7b76            jsr        _schp0
_syfork_4:
[0000abca] 4a6d 0008                 tst.w      8(a5)
[0000abce] 670a                      beq.s      _syfork_5
[0000abd0] 082b 0004 0010            btst       #4,16(a3)
[0000abd6] 6700 0118                 beq        _syfork_6
_syfork_5:
[0000abda] 082b 0004 0010            btst       #4,16(a3)
[0000abe0] 6706                      beq.s      _syfork_7
[0000abe2] 08ed 0004 0010            bset       #4,16(a5)
_syfork_7:
[0000abe8] 226e 0008                 movea.l    8(a6),a1
[0000abec] 3e2d 001c                 move.w     28(a5),d7
[0000abf0] 48c7                      ext.l      d7
[0000abf2] 2287                      move.l     d7,(a1)
[0000abf4] 2eac 000c                 move.l     12(a4),(a7)
[0000abf8] 4eb9 0000 0000            jsr        _setjmp
[0000abfe] 4a87                      tst.l      d7
[0000ac00] 6708                      beq.s      _syfork_8
[0000ac02] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000ac06] 4e5e                      unlk       a6
[0000ac08] 4e75                      rts
_syfork_8:
[0000ac0a] 4a6d 0008                 tst.w      8(a5)
[0000ac0e] 676a                      beq.s      _syfork_9
[0000ac10] 2ebc 0000 0000            move.l     #_proc0,(a7)
[0000ac16] 4eb9 0000 8764            jsr        _setpu
[0000ac1c] 4eb9 0000 0000            jsr        _uout
[0000ac22] 7e00                      moveq.l    #0,d7
[0000ac24] 3e2d 000a                 move.w     10(a5),d7
[0000ac28] 2e87                      move.l     d7,(a7)
[0000ac2a] 7e00                      moveq.l    #0,d7
[0000ac2c] 3e2d 0008                 move.w     8(a5),d7
[0000ac30] 2f07                      move.l     d7,-(a7)
[0000ac32] 7e00                      moveq.l    #0,d7
[0000ac34] 3e2b 0008                 move.w     8(a3),d7
[0000ac38] 2f07                      move.l     d7,-(a7)
[0000ac3a] 4eb9 0000 0000            jsr        _memcopy
[0000ac40] 508f                      addq.l     #8,a7
[0000ac42] 4878 0007                 pea.l      ($00000007).w
[0000ac46] 2f0b                      move.l     a3,-(a7)
[0000ac48] 4eb9 0000 835a            jsr        _offrun
[0000ac4e] 508f                      addq.l     #8,a7
[0000ac50] 7e00                      moveq.l    #0,d7
[0000ac52] 3e2b 0008                 move.w     8(a3),d7
[0000ac56] 2747 0004                 move.l     d7,4(a3)
[0000ac5a] 376d 0008 0008            move.w     8(a5),8(a3)
[0000ac60] 3b6b 0006 0008            move.w     6(a3),8(a5)
[0000ac66] 4aab 0022                 tst.l      34(a3)
[0000ac6a] 6746                      beq.s      _syfork_10
[0000ac6c] 43f8 0022                 lea.l      ($00000022).w,a1
[0000ac70] d3eb 0022                 adda.l     34(a3),a1
[0000ac74] 5269 000a                 addq.w     #1,10(a1)
[0000ac78] 6038                      bra.s      _syfork_10
_syfork_9:
[0000ac7a] 4eb9 0000 7ff0            jsr        _swbuy
[0000ac80] 4eb9 0000 0000            jsr        _uout
[0000ac86] 2e8b                      move.l     a3,(a7)
[0000ac88] 4eb9 0000 7d70            jsr        _swapout
[0000ac8e] 4eb9 0000 8022            jsr        _swsell
[0000ac94] 3b6b 0008 0008            move.w     8(a3),8(a5)
[0000ac9a] 2ebc 0000 b500            move.l     #_outproc,(a7)
[0000aca0] 4eb9 0000 7b76            jsr        _schp0
[0000aca6] 2ebc 0000 0000            move.l     #_proc0,(a7)
[0000acac] 4eb9 0000 8764            jsr        _setpu
_syfork_10:
[0000acb2] 2e8d                      move.l     a5,(a7)
[0000acb4] 4eb9 0000 85c6            jsr        _runproc
[0000acba] 08eb 0001 0010            bset       #1,16(a3)
_syfork_12:
[0000acc0] 294d 0010                 move.l     a5,16(a4)
[0000acc4] 2e8d                      move.l     a5,(a7)
[0000acc6] 4eb9 0000 8764            jsr        _setpu
[0000accc] 08ed 0007 0010            bset       #7,16(a5)
[0000acd2] 08ad 0003 0010            bclr       #3,16(a5)
[0000acd8] 226e 0008                 movea.l    8(a6),a1
[0000acdc] 4291                      clr.l      (a1)
[0000acde] 42ac 0114                 clr.l      276(a4)
[0000ace2] 42ac 0110                 clr.l      272(a4)
[0000ace6] 42ac 011c                 clr.l      284(a4)
[0000acea] 42ac 0118                 clr.l      280(a4)
[0000acee] 6076                      bra.s      _syfork_11
_syfork_6:
[0000acf0] 2eac 0004                 move.l     4(a4),(a7)
[0000acf4] 4eb9 0000 0000            jsr        _setjmp
[0000acfa] 4a87                      tst.l      d7
[0000acfc] 66c2                      bne.s      _syfork_12
[0000acfe] 294d 0010                 move.l     a5,16(a4)
[0000ad02] 2ebc 0000 0000            move.l     #_proc0,(a7)
[0000ad08] 4eb9 0000 8764            jsr        _setpu
[0000ad0e] 4eb9 0000 0000            jsr        _uout
[0000ad14] 7e00                      moveq.l    #0,d7
[0000ad16] 3e2d 000a                 move.w     10(a5),d7
[0000ad1a] 2e87                      move.l     d7,(a7)
[0000ad1c] 7e00                      moveq.l    #0,d7
[0000ad1e] 3e2d 0008                 move.w     8(a5),d7
[0000ad22] 2f07                      move.l     d7,-(a7)
[0000ad24] 7e00                      moveq.l    #0,d7
[0000ad26] 3e2b 0008                 move.w     8(a3),d7
[0000ad2a] 2f07                      move.l     d7,-(a7)
[0000ad2c] 4eb9 0000 0000            jsr        _memcopy
[0000ad32] 508f                      addq.l     #8,a7
[0000ad34] 294b 0010                 move.l     a3,16(a4)
[0000ad38] 2e8b                      move.l     a3,(a7)
[0000ad3a] 4eb9 0000 8764            jsr        _setpu
[0000ad40] 2e8d                      move.l     a5,(a7)
[0000ad42] 4eb9 0000 85c6            jsr        _runproc
[0000ad48] 226e 0008                 movea.l    8(a6),a1
[0000ad4c] 3e2d 001c                 move.w     28(a5),d7
[0000ad50] 48c7                      ext.l      d7
[0000ad52] 2287                      move.l     d7,(a1)
[0000ad54] 4aab 0022                 tst.l      34(a3)
[0000ad58] 670c                      beq.s      _syfork_11
[0000ad5a] 43f8 0022                 lea.l      ($00000022).w,a1
[0000ad5e] d3eb 0022                 adda.l     34(a3),a1
[0000ad62] 5269 000a                 addq.w     #1,10(a1)
_syfork_11:
[0000ad66] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000ad6a] 4e5e                      unlk       a6
[0000ad6c] 4e75                      rts

	.data
[0000ad6e]                           dc.b $00
[0000ad6f]                           dc.b $00
[0000ad70]                           dc.b $00
[0000ad71]                           dc.b $00
[0000ad72]                           dc.b $00
[0000ad73]                           dc.b $00
[0000ad74]                           dc.b $00
[0000ad75]                           dc.b $00
[0000ad76]                           dc.w $ffff
[0000ad78]                           dc.w $ffff
[0000ad7a]                           dc.b $00
[0000ad7b]                           dc.b $00
[0000ad7c]                           dc.b $00
[0000ad7d]                           dc.b $0a
[0000ad7e]                           dc.b $00
[0000ad7f]                           dc.b $00
[0000ad80]                           dc.b $00
[0000ad81]                           dc.b $00
[0000ad82]                           dc.b $00
[0000ad83]                           dc.b $00
[0000ad84]                           dc.b $00
[0000ad85]                           dc.b $00
[0000ad86]                           dc.b $00
[0000ad87]                           dc.b $00
[0000ad88]                           dc.b $00
[0000ad89]                           dc.b $00
[0000ad8a]                           dc.b $00
[0000ad8b]                           dc.b $00
[0000ad8c]                           dc.b $00
[0000ad8d]                           dc.b $00
[0000ad8e]                           dc.b $00
[0000ad8f]                           dc.b $00
[0000ad90]                           dc.b $00
[0000ad91]                           dc.b $00
[0000ad92]                           dc.b $00
[0000ad93]                           dc.b $00
[0000ad94]                           dc.b $00
[0000ad95]                           dc.b $00
[0000ad96]                           dc.b $00
[0000ad97]                           dc.b $00
[0000ad98]                           dc.b $00
[0000ad99]                           dc.b $00
[0000ad9a]                           dc.b $00
[0000ad9b]                           dc.b $00
[0000ad9c]                           dc.b $00
[0000ad9d]                           dc.b $00
[0000ad9e]                           dc.b $00
[0000ad9f]                           dc.b $00
[0000ada0]                           dc.b $00
[0000ada1]                           dc.b $00
[0000ada2]                           dc.b $00
[0000ada3]                           dc.b $00
[0000ada4]                           dc.b $00
[0000ada5]                           dc.b $00
[0000ada6]                           dc.b $00
[0000ada7]                           dc.b $00
[0000ada8]                           dc.b $00
[0000ada9]                           dc.b $00
[0000adaa]                           dc.b $00
[0000adab]                           dc.b $00
[0000adac]                           dc.b $00
[0000adad]                           dc.b $00
[0000adae]                           dc.b $00
[0000adaf]                           dc.b $00
[0000adb0]                           dc.b $00
[0000adb1]                           dc.b $00
[0000adb2]                           dc.b $00
[0000adb3]                           dc.b $00
[0000adb4]                           dc.b $00
[0000adb5]                           dc.b $00
[0000adb6]                           dc.b $00
[0000adb7]                           dc.b $00
[0000adb8]                           dc.b $00
[0000adb9]                           dc.b $00
[0000adba]                           dc.b $00
[0000adbb]                           dc.b $00
[0000adbc]                           dc.b $00
[0000adbd]                           dc.b $00
[0000adbe]                           dc.b $00
[0000adbf]                           dc.b $00
[0000adc0]                           dc.b $00
[0000adc1]                           dc.b $00
[0000adc2]                           dc.b $00
[0000adc3]                           dc.b $00
[0000adc4]                           dc.b $00
[0000adc5]                           dc.b $00
[0000adc6]                           dc.b $00
[0000adc7]                           dc.b $00
[0000adc8]                           dc.b $00
[0000adc9]                           dc.b $00
[0000adca]                           dc.b $00
[0000adcb]                           dc.b $00
[0000adcc]                           dc.b $00
[0000adcd]                           dc.b $00
[0000adce]                           dc.b 'out of heap!',$0a,0
[0000addc]                           dc.b $00
[0000addd]                           dc.b $00
[0000adde]                           dc.b $00
[0000addf]                           dc.b $00
[0000ade0]                           dc.b 'blkdev',0
[0000ade7]                           dc.b $00
[0000ade8]                           dc.b $00
[0000ade9]                           dc.b $00
[0000adea]                           dc.b $00
[0000adeb]                           dc.b $00
[0000adec]                           dc.b 'ABDERTVWCNMU',0
[0000adf9]                           dc.b ' %p ',0
[0000adfe]                           dc.b '#%i',$0a,0
[0000ae03]                           dc.b $00
[0000ae04]                           dc.b $00
[0000ae05]                           dc.b $00
[0000ae06]                           dc.b $00
[0000ae07]                           dc.b $00
[0000ae08]                           dc.b $00
[0000ae09]                           dc.b $00
[0000ae0a]                           dc.b $00
[0000ae0b]                           dc.b $02
[0000ae0c] 00000b0e                  dc.l $00000b0e ; no symbol found
[0000ae10]                           dc.b $00
[0000ae11]                           dc.b $00
[0000ae12]                           dc.w $2000
[0000ae14] 00000ade                  dc.l $00000ade ; no symbol found
[0000ae18]                           dc.b $00
[0000ae19]                           dc.b $00
[0000ae1a]                           dc.w $6000
[0000ae1c] 00000b36                  dc.l $00000b36 ; no symbol found
[0000ae20]                           dc.b $00
[0000ae21]                           dc.b $00
[0000ae22]                           dc.b $00
[0000ae23]                           dc.b $00
[0000ae24]                           dc.b $00
[0000ae25]                           dc.b $00
[0000ae26]                           dc.b $00
[0000ae27]                           dc.b $02
[0000ae28] 00000d22                  dc.l $00000d22 ; no symbol found
[0000ae2c]                           dc.b $00
[0000ae2d]                           dc.b $00
[0000ae2e]                           dc.w $2000
[0000ae30] 00000cec                  dc.l $00000cec ; no symbol found
[0000ae34]                           dc.b $00
[0000ae35]                           dc.b $00
[0000ae36]                           dc.w $6000
[0000ae38] 00000d56                  dc.l $00000d56 ; no symbol found
[0000ae3c] 0000ae3c                  dc.l $0000ae3c ; no symbol found
[0000ae40] 0000ae40                  dc.l $0000ae40 ; no symbol found
[0000ae44]                           dc.b $00
[0000ae45]                           dc.b $00
[0000ae46]                           dc.b $00
[0000ae47]                           dc.b $00
[0000ae48]                           dc.b $00
[0000ae49]                           dc.b $00
[0000ae4a]                           dc.b $00
[0000ae4b]                           dc.b $00
[0000ae4c]                           dc.b $00
[0000ae4d]                           dc.b $00
[0000ae4e]                           dc.w $0909
[0000ae50]                           dc.w $0815
[0000ae52]                           dc.b $00
[0000ae53]                           dc.b $1a
[0000ae54]                           dc.w $0100
[0000ae56]                           dc.b $00
[0000ae57]                           dc.b $39
[0000ae58]                           dc.w $7f00
[0000ae5a]                           dc.w $0400
[0000ae5c]                           dc.b $00
[0000ae5d]                           dc.b $00
[0000ae5e]                           dc.b $00
[0000ae5f]                           dc.b $00
[0000ae60]                           dc.b $00
[0000ae61]                           dc.b $00
[0000ae62]                           dc.b $00
[0000ae63]                           dc.b $00
[0000ae64]                           dc.b $00
[0000ae65]                           dc.b $00
[0000ae66]                           dc.b $00
[0000ae67]                           dc.b $00
[0000ae68]                           dc.b $00
[0000ae69]                           dc.b $00
[0000ae6a]                           dc.b $00
[0000ae6b]                           dc.b $00
[0000ae6c]                           dc.b $00
[0000ae6d]                           dc.b $00
[0000ae6e]                           dc.b $00
[0000ae6f]                           dc.b $00
[0000ae70]                           dc.b $00
[0000ae71]                           dc.b $00
[0000ae72]                           dc.b $00
[0000ae73]                           dc.b $00
[0000ae74]                           dc.b $00
[0000ae75]                           dc.b $00
[0000ae76]                           dc.b $00
[0000ae77]                           dc.b $00
[0000ae78]                           dc.b $00
[0000ae79]                           dc.b $00
[0000ae7a]                           dc.b $00
[0000ae7b]                           dc.b $00
[0000ae7c]                           dc.b $00
[0000ae7d]                           dc.b $00
[0000ae7e]                           dc.b $00
[0000ae7f]                           dc.b $00
[0000ae80]                           dc.b $00
[0000ae81]                           dc.b $00
[0000ae82]                           dc.b $00
[0000ae83]                           dc.b $00
[0000ae84]                           dc.b $00
[0000ae85]                           dc.b $00
[0000ae86]                           dc.b $00
[0000ae87]                           dc.b $00
[0000ae88]                           dc.b $00
[0000ae89]                           dc.b $00
[0000ae8a] 000012c0                  dc.l $000012c0 ; no symbol found
[0000ae8e]                           dc.b $00
[0000ae8f]                           dc.b $00
[0000ae90]                           dc.b $00
[0000ae91]                           dc.b $00
[0000ae92]                           dc.b $00
[0000ae93]                           dc.b $00
[0000ae94]                           dc.b $00
[0000ae95]                           dc.b $00
[0000ae96]                           dc.w $40c0
[0000ae98]                           dc.w $c040
[0000ae9a]                           dc.w $c040
[0000ae9c]                           dc.w $40c0
[0000ae9e]                           dc.w $c142
[0000aea0]                           dc.w $43c4
[0000aea2]                           dc.w $44c5
[0000aea4]                           dc.w $c040
[0000aea6]                           dc.w $c040
[0000aea8]                           dc.w $40c0
[0000aeaa]                           dc.w $40c0
[0000aeac]                           dc.w $c040
[0000aeae]                           dc.w $40c0
[0000aeb0]                           dc.w $c040
[0000aeb2]                           dc.w $c040
[0000aeb4]                           dc.w $40c0
[0000aeb6]                           dc.w $803c
[0000aeb8]                           dc.b $00
[0000aeb9]                           dc.b $80
[0000aeba]                           dc.b $00
[0000aebb]                           dc.b $80
[0000aebc]                           dc.w $8020
[0000aebe]                           dc.w $3bbd
[0000aec0]                           dc.w $8000
[0000aec2]                           dc.w $8000
[0000aec4]                           dc.b $00
[0000aec5]                           dc.b $80
[0000aec6]                           dc.b $00
[0000aec7]                           dc.b $80
[0000aec8]                           dc.w $8000
[0000aeca]                           dc.w $8000
[0000aecc]                           dc.b $00
[0000aecd]                           dc.b $80
[0000aece]                           dc.w $8000
[0000aed0]                           dc.b $00
[0000aed1]                           dc.b $80
[0000aed2]                           dc.b $00
[0000aed3]                           dc.b $80
[0000aed4]                           dc.w $8000
[0000aed6]                           dc.w $8000
[0000aed8]                           dc.b $00
[0000aed9]                           dc.b $80
[0000aeda]                           dc.b $00
[0000aedb]                           dc.b $80
[0000aedc]                           dc.w $8000
[0000aede]                           dc.b $00
[0000aedf]                           dc.b $80
[0000aee0]                           dc.w $8000
[0000aee2]                           dc.w $8000
[0000aee4]                           dc.b $00
[0000aee5]                           dc.b $80
[0000aee6]                           dc.b $00
[0000aee7]                           dc.b $80
[0000aee8]                           dc.w $8000
[0000aeea]                           dc.w $8000
[0000aeec]                           dc.b $00
[0000aeed]                           dc.b $80
[0000aeee]                           dc.w $8000
[0000aef0]                           dc.b $00
[0000aef1]                           dc.b $80
[0000aef2]                           dc.b $00
[0000aef3]                           dc.b $80
[0000aef4]                           dc.w $be00
[0000aef6]                           dc.b $00
[0000aef7]                           dc.b $81
[0000aef8]                           dc.w $8203
[0000aefa]                           dc.w $8405
[0000aefc]                           dc.w $0687
[0000aefe]                           dc.w $8809
[0000af00]                           dc.w $0a8b
[0000af02]                           dc.w $0c8d
[0000af04]                           dc.w $8e0f
[0000af06]                           dc.w $9011
[0000af08]                           dc.w $1293
[0000af0a]                           dc.w $1495
[0000af0c]                           dc.w $9617
[0000af0e]                           dc.w $1899
[0000af10]                           dc.w $9a00
[0000af12]                           dc.w $8000
[0000af14]                           dc.b $00
[0000af15]                           dc.b $c0
[0000af16]                           dc.b $00
[0000af17]                           dc.b $00
[0000af18]                           dc.b $00
[0000af19]                           dc.b $00
[0000af1a]                           dc.b $00
[0000af1b]                           dc.b $00
[0000af1c]                           dc.b $00
[0000af1d]                           dc.b $00
[0000af1e]                           dc.b '{(|!})~^`',$27,0
[0000af29]                           dc.b $00
[0000af2a]                           dc.b $00
[0000af2b]                           dc.b $00
[0000af2c]                           dc.b $00
[0000af2d]                           dc.b $00
[0000af2e]                           dc.b $00
[0000af2f]                           dc.b $00
[0000af30]                           dc.b $00
[0000af31]                           dc.b $04
[0000af32] 000013ac                  dc.l $000013ac ; no symbol found
[0000af36]                           dc.b $00
[0000af37]                           dc.b $00
[0000af38]                           dc.b $00
[0000af39]                           dc.b $11
[0000af3a] 000013b6                  dc.l $000013b6 ; no symbol found
[0000af3e]                           dc.b $00
[0000af3f]                           dc.b $00
[0000af40]                           dc.b $00
[0000af41]                           dc.b $13
[0000af42] 000013c4                  dc.l $000013c4 ; no symbol found
[0000af46]                           dc.b $00
[0000af47]                           dc.b $00
[0000af48]                           dc.b $00
[0000af49]                           dc.b $1c
[0000af4a] 000013cc                  dc.l $000013cc ; no symbol found
[0000af4e]                           dc.b $00
[0000af4f]                           dc.b $00
[0000af50]                           dc.b $00
[0000af51]                           dc.b $7f
[0000af52] 000013d4                  dc.l $000013d4 ; no symbol found
[0000af56]                           dc.b $00
[0000af57]                           dc.b $00
[0000af58]                           dc.b $00
[0000af59]                           dc.b $00
[0000af5a]                           dc.b $00
[0000af5b]                           dc.b $00
[0000af5c]                           dc.b $00
[0000af5d]                           dc.b $08
[0000af5e] 0000145e                  dc.l $0000145e ; no symbol found
[0000af62]                           dc.b $00
[0000af63]                           dc.b $00
[0000af64]                           dc.b $00
[0000af65]                           dc.b $04
[0000af66] 0000145e                  dc.l $0000145e ; no symbol found
[0000af6a]                           dc.b $00
[0000af6b]                           dc.b $00
[0000af6c]                           dc.b $00
[0000af6d]                           dc.b $0a
[0000af6e] 00001464                  dc.l $00001464 ; no symbol found
[0000af72]                           dc.b $00
[0000af73]                           dc.b $00
[0000af74]                           dc.b $00
[0000af75]                           dc.b $0d
[0000af76] 0000147e                  dc.l $0000147e ; no symbol found
[0000af7a]                           dc.b $00
[0000af7b]                           dc.b $00
[0000af7c]                           dc.b $00
[0000af7d]                           dc.b $11
[0000af7e] 00001488                  dc.l $00001488 ; no symbol found
[0000af82]                           dc.b $00
[0000af83]                           dc.b $00
[0000af84]                           dc.b $00
[0000af85]                           dc.b $13
[0000af86] 00001496                  dc.l $00001496 ; no symbol found
[0000af8a]                           dc.b $00
[0000af8b]                           dc.b $00
[0000af8c]                           dc.b $00
[0000af8d]                           dc.b $1c
[0000af8e] 00001472                  dc.l $00001472 ; no symbol found
[0000af92]                           dc.b $00
[0000af93]                           dc.b $00
[0000af94]                           dc.b $00
[0000af95]                           dc.b $5c
[0000af96] 0000149e                  dc.l $0000149e ; no symbol found
[0000af9a]                           dc.b $00
[0000af9b]                           dc.b $00
[0000af9c]                           dc.b $00
[0000af9d]                           dc.b $7f
[0000af9e] 000014a6                  dc.l $000014a6 ; no symbol found
[0000afa2]                           dc.b $00
[0000afa3]                           dc.b $00
[0000afa4]                           dc.b $00
[0000afa5]                           dc.b $00
[0000afa6]                           dc.b $00
[0000afa7]                           dc.b $00
[0000afa8]                           dc.b $00
[0000afa9]                           dc.b $02
[0000afaa] 0000179e                  dc.l $0000179e ; no symbol found
[0000afae]                           dc.b $00
[0000afaf]                           dc.b $00
[0000afb0]                           dc.b $00
[0000afb1]                           dc.b $09
[0000afb2] 000017d4                  dc.l $000017d4 ; no symbol found
[0000afb6]                           dc.b $00
[0000afb7]                           dc.b $00
[0000afb8]                           dc.b $00
[0000afb9]                           dc.b $0a
[0000afba] 000017ea                  dc.l $000017ea ; no symbol found
[0000afbe]                           dc.b $00
[0000afbf]                           dc.b $00
[0000afc0]                           dc.b $00
[0000afc1]                           dc.b $06
[0000afc2]                           dc.b $00
[0000afc3]                           dc.b $00
[0000afc4]                           dc.b $00
[0000afc5]                           dc.b $40
[0000afc6] 0000187c                  dc.l $0000187c ; no symbol found
[0000afca] 00001884                  dc.l $00001884 ; no symbol found
[0000afce] 00001890                  dc.l $00001890 ; no symbol found
[0000afd2] 000018a2                  dc.l $000018a2 ; no symbol found
[0000afd6] 000018a8                  dc.l $000018a8 ; no symbol found
[0000afda] 000018a2                  dc.l $000018a2 ; no symbol found
[0000afde]                           dc.b $00
[0000afdf]                           dc.b $00
[0000afe0]                           dc.b $00
[0000afe1]                           dc.b $00
[0000afe2]                           dc.b $00
[0000afe3]                           dc.b $00
[0000afe4]                           dc.b $00
[0000afe5]                           dc.b $00
[0000afe6] 000018aa                  dc.l $000018aa ; no symbol found
[0000afea]                           dc.b $00
[0000afeb]                           dc.b $08
[0000afec]                           dc.w $0c0c
[0000afee]                           dc.w $400c
[0000aff0]                           dc.b $00
[0000aff1]                           dc.b $00
[0000aff2]                           dc.w $0c08
[0000aff4]                           dc.w $0608
[0000aff6]                           dc.w $0a00
[0000aff8]                           dc.w $1d26
[0000affa]                           dc.b $00
[0000affb]                           dc.b $04
[0000affc]                           dc.b $00
[0000affd]                           dc.b $00
[0000affe]                           dc.b $00
[0000afff]                           dc.b $01
[0000b000]                           dc.b $00
[0000b001]                           dc.b $7f
[0000b002]                           dc.w $1c08
[0000b004]                           dc.w $1504
[0000b006]                           dc.b $00
[0000b007]                           dc.b $00
[0000b008]                           dc.b $00
[0000b009]                           dc.b $00
[0000b00a]                           dc.b $00
[0000b00b]                           dc.b $00
[0000b00c]                           dc.b $00
[0000b00d]                           dc.b $11
[0000b00e]                           dc.b $00
[0000b00f]                           dc.b $00
[0000b010]                           dc.b $00
[0000b011]                           dc.b $00
[0000b012] 00001b2e                  dc.l $00001b2e ; no symbol found
[0000b016] 00001ac2                  dc.l $00001ac2 ; no symbol found
[0000b01a] 00001cc2                  dc.l $00001cc2 ; no symbol found
[0000b01e] 00001c0e                  dc.l $00001c0e ; no symbol found
[0000b022] 00001c06                  dc.l $00001c06 ; no symbol found
[0000b026] 00001bfe                  dc.l $00001bfe ; no symbol found
[0000b02a] 00001bb6                  dc.l $00001bb6 ; no symbol found
[0000b02e] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b032] 00001d50                  dc.l $00001d50 ; no symbol found
[0000b036] 00001d6c                  dc.l $00001d6c ; no symbol found
[0000b03a] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b03e] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b042] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b046] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b04a] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b04e] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b052] 00001bbe                  dc.l $00001bbe ; no symbol found
[0000b056]                           dc.b $00
[0000b057]                           dc.b $00
[0000b058]                           dc.b $00
[0000b059]                           dc.b $00
[0000b05a]                           dc.b $00
[0000b05b]                           dc.b $00
[0000b05c]                           dc.b $00
[0000b05d]                           dc.b $00
[0000b05e] 00001d74                  dc.l $00001d74 ; no symbol found
[0000b062]                           dc.b 'writing',0
[0000b06a]                           dc.b 'reading',0
[0000b072]                           dc.b 'error %s block %u on device ',0
[0000b08f]                           dc.b $3a
[0000b090]                           dc.w $2000
[0000b092]                           dc.b '%o %o',0
[0000b098]                           dc.b '%s on device ',0
[0000b0a6]                           dc.w $3078
[0000b0a8]                           dc.b $00
[0000b0a9]                           dc.b $00
[0000b0aa]                           dc.b $00
[0000b0ab]                           dc.b $00
[0000b0ac]                           dc.b $00
[0000b0ad]                           dc.b $00
[0000b0ae]                           dc.b $00
[0000b0af]                           dc.b $00
[0000b0b0]                           dc.b $00
[0000b0b1]                           dc.b $04
[0000b0b2] 000021b4                  dc.l $000021b4 ; no symbol found
[0000b0b6]                           dc.b $00
[0000b0b7]                           dc.b $00
[0000b0b8]                           dc.b $00
[0000b0b9]                           dc.b $68
[0000b0ba] 0000218a                  dc.l $0000218a ; no symbol found
[0000b0be]                           dc.b $00
[0000b0bf]                           dc.b $00
[0000b0c0]                           dc.b $00
[0000b0c1]                           dc.b $69
[0000b0c2] 000021a4                  dc.l $000021a4 ; no symbol found
[0000b0c6]                           dc.b $00
[0000b0c7]                           dc.b $00
[0000b0c8]                           dc.b $00
[0000b0c9]                           dc.b $6f
[0000b0ca] 000021a0                  dc.l $000021a0 ; no symbol found
[0000b0ce]                           dc.b $00
[0000b0cf]                           dc.b $00
[0000b0d0]                           dc.b $00
[0000b0d1]                           dc.b $75
[0000b0d2] 000021c0                  dc.l $000021c0 ; no symbol found
[0000b0d6]                           dc.b '0123456789abcdef',0
[0000b0e7]                           dc.b $00
[0000b0e8]                           dc.b $00
[0000b0e9]                           dc.b $00
[0000b0ea]                           dc.b $00
[0000b0eb]                           dc.b $00
[0000b0ec]                           dc.b $00
[0000b0ed]                           dc.b $00
[0000b0ee]                           dc.b $00
[0000b0ef]                           dc.b $00
[0000b0f0]                           dc.b $00
[0000b0f1]                           dc.b $0d
[0000b0f2]                           dc.w $4abe
[0000b0f4] 00000cb0                  dc.l _nodev
[0000b0f8] 00000cb0                  dc.l _nodev
[0000b0fc] 00000cb0                  dc.l _nodev
[0000b100]                           dc.b $00
[0000b101]                           dc.b $00
[0000b102]                           dc.b $00
[0000b103]                           dc.b $00
[0000b104] 0000b108                  dc.l $0000b108 ; no symbol found
[0000b108]                           dc.b $00
[0000b109]                           dc.b $00
[0000b10a] 00000cb0                  dc.l _nodev
[0000b10e] 00000cb0                  dc.l _nodev
[0000b112] 00000cb0                  dc.l _nodev
[0000b116] 00000cb0                  dc.l _nodev
[0000b11a] 00000cb0                  dc.l _nodev
[0000b11e] 0000b122                  dc.l $0000b122 ; no symbol found
[0000b122]                           dc.b $00
[0000b123]                           dc.b $00
[0000b124] 0000b124                  dc.l $0000b124 ; no symbol found
[0000b128] 0000b124                  dc.l $0000b124 ; no symbol found
[0000b12c] 0000b124                  dc.l $0000b124 ; no symbol found
[0000b130] 0000b124                  dc.l $0000b124 ; no symbol found
[0000b134]                           dc.w $0200
[0000b136]                           dc.b $00
[0000b137]                           dc.b $00
[0000b138]                           dc.b $00
[0000b139]                           dc.b $00
[0000b13a]                           dc.b $00
[0000b13b]                           dc.b $00
[0000b13c]                           dc.b $00
[0000b13d]                           dc.b $00
[0000b13e]                           dc.b $00
[0000b13f]                           dc.b $00
[0000b140]                           dc.b $00
[0000b141]                           dc.b $00
[0000b142]                           dc.b $00
[0000b143]                           dc.b $00
[0000b144]                           dc.b $00
[0000b145]                           dc.b $00
[0000b146]                           dc.b $00
[0000b147]                           dc.b $00
[0000b148]                           dc.b $00
[0000b149]                           dc.b $00
[0000b14a]                           dc.b $00
[0000b14b]                           dc.b $00
[0000b14c]                           dc.b $00
[0000b14d]                           dc.b $00
[0000b14e]                           dc.b $00
[0000b14f]                           dc.b $00
[0000b150]                           dc.b $00
[0000b151]                           dc.b $00
[0000b152]                           dc.b $00
[0000b153]                           dc.b $00
[0000b154]                           dc.b $00
[0000b155]                           dc.b $00
[0000b156]                           dc.b $00
[0000b157]                           dc.b $00
[0000b158]                           dc.b $00
[0000b159]                           dc.b $2e
[0000b15a]                           dc.b $00
[0000b15b]                           dc.b $00
[0000b15c]                           dc.b $00
[0000b15d]                           dc.b $00
[0000b15e]                           dc.b $00
[0000b15f]                           dc.b $00
[0000b160]                           dc.b $00
[0000b161]                           dc.b $00
[0000b162]                           dc.b 'bad root',0
[0000b16b]                           dc.b 'mount',0
[0000b171]                           dc.b $00
[0000b172]                           dc.b 'core',0
[0000b177]                           dc.b 'bad count',0
[0000b181]                           dc.b 'no mount',0
[0000b18a]                           dc.b 'bad inode block, inode %i',0
[0000b1a4]                           dc.b 'bad block',0
[0000b1ae]                           dc.b 'no space',0
[0000b1b7]                           dc.b 'no inodes',0
[0000b1c1]                           dc.b 'bad inode',0
[0000b1cb]                           dc.b $00
[0000b1cc]                           dc.b '%p#%i ',0
[0000b1d3]                           dc.b ':%i ',0
[0000b1d8]                           dc.b 'DLMKWXTCFU',0
[0000b1e3]                           dc.b 'ref %i rdref %i nlink %i ',0
[0000b1fd]                           dc.b ' %p',$0a,0
[0000b202]                           dc.b 'PUTI ref 0 and wanted',0
[0000b218]                           dc.b 'cannot update inode %i',$0a,0
[0000b230]                           dc.b $00
[0000b231]                           dc.b $00
[0000b232]                           dc.w $2e00
[0000b234]                           dc.b $00
[0000b235]                           dc.b $00
[0000b236]                           dc.b $00
[0000b237]                           dc.b $00
[0000b238]                           dc.b $00
[0000b239]                           dc.b $00
[0000b23a]                           dc.b $00
[0000b23b]                           dc.b $00
[0000b23c]                           dc.b $00
[0000b23d]                           dc.b $00
[0000b23e]                           dc.b $00
[0000b23f]                           dc.b $00
[0000b240]                           dc.b $00
[0000b241]                           dc.b $00
[0000b242]                           dc.b $00
[0000b243]                           dc.b $00
[0000b244]                           dc.w $ffff
[0000b246]                           dc.w $ffff
[0000b248]                           dc.b $00
[0000b249]                           dc.b $00
[0000b24a]                           dc.b $00
[0000b24b]                           dc.b $00
[0000b24c]                           dc.b $00
[0000b24d]                           dc.b $00
[0000b24e]                           dc.b $00
[0000b24f]                           dc.b $00
[0000b250]                           dc.b $00
[0000b251]                           dc.b $00
[0000b252]                           dc.b $00
[0000b253]                           dc.b $03
[0000b254] 00004808                  dc.l $00004808 ; no symbol found
[0000b258]                           dc.b $00
[0000b259]                           dc.b $00
[0000b25a]                           dc.b $00
[0000b25b]                           dc.b $05
[0000b25c] 00004854                  dc.l $00004854 ; no symbol found
[0000b260]                           dc.b $00
[0000b261]                           dc.b $00
[0000b262]                           dc.b $00
[0000b263]                           dc.b $06
[0000b264] 0000484e                  dc.l $0000484e ; no symbol found
[0000b268]                           dc.b $00
[0000b269]                           dc.b $00
[0000b26a]                           dc.b $00
[0000b26b]                           dc.b $07
[0000b26c] 000048da                  dc.l $000048da ; no symbol found
[0000b270]                           dc.b $00
[0000b271]                           dc.b $00
[0000b272]                           dc.b $00
[0000b273]                           dc.b $00
[0000b274]                           dc.b 'NODEV kmem null ps myps mount inode where bnames cnames zero tty stat',0
[0000b2ba] 00004b48                  dc.l $00004b48 ; no symbol found
[0000b2be] 00004b0a                  dc.l $00004b0a ; no symbol found
[0000b2c2] 00004b9c                  dc.l $00004b9c ; no symbol found
[0000b2c6] 00004dc4                  dc.l $00004dc4 ; no symbol found
[0000b2ca] 00004d72                  dc.l _memsg
[0000b2ce] 0000b274                  dc.l $0000b274 ; no symbol found
[0000b2d2]                           dc.b $00
[0000b2d3]                           dc.b $00
[0000b2d4]                           dc.b $00
[0000b2d5]                           dc.b $0c
[0000b2d6]                           dc.b $00
[0000b2d7]                           dc.b $00
[0000b2d8]                           dc.b $00
[0000b2d9]                           dc.b $01
[0000b2da] 00004bc6                  dc.l $00004bc6 ; no symbol found
[0000b2de] 00004be0                  dc.l $00004be0 ; no symbol found
[0000b2e2] 00004be4                  dc.l $00004be4 ; no symbol found
[0000b2e6] 00004c26                  dc.l $00004c26 ; no symbol found
[0000b2ea] 00004c78                  dc.l $00004c78 ; no symbol found
[0000b2ee] 00004c8e                  dc.l $00004c8e ; no symbol found
[0000b2f2] 00004ca4                  dc.l $00004ca4 ; no symbol found
[0000b2f6] 00004cb4                  dc.l $00004cb4 ; no symbol found
[0000b2fa] 00004cdc                  dc.l $00004cdc ; no symbol found
[0000b2fe] 00004d04                  dc.l $00004d04 ; no symbol found
[0000b302] 00004d12                  dc.l $00004d12 ; no symbol found
[0000b306] 00004d2c                  dc.l $00004d2c ; no symbol found
[0000b30a]                           dc.b $00
[0000b30b]                           dc.b $00
[0000b30c]                           dc.b $00
[0000b30d]                           dc.b $00
[0000b30e]                           dc.b $00
[0000b30f]                           dc.b $00
[0000b310]                           dc.b $00
[0000b311]                           dc.b $00
[0000b312] 00004d64                  dc.l $00004d64 ; no symbol found
[0000b316]                           dc.b $00
[0000b317]                           dc.b $00
[0000b318]                           dc.b $00
[0000b319]                           dc.b $00
[0000b31a]                           dc.b $00
[0000b31b]                           dc.b $00
[0000b31c]                           dc.b $00
[0000b31d]                           dc.b $04
[0000b31e] 00004de8                  dc.l $00004de8 ; no symbol found
[0000b322]                           dc.b $00
[0000b323]                           dc.b $00
[0000b324]                           dc.b $00
[0000b325]                           dc.b $01
[0000b326] 00004e06                  dc.l $00004e06 ; no symbol found
[0000b32a]                           dc.b $00
[0000b32b]                           dc.b $00
[0000b32c]                           dc.b $00
[0000b32d]                           dc.b $02
[0000b32e] 00004e0c                  dc.l $00004e0c ; no symbol found
[0000b332]                           dc.b $00
[0000b333]                           dc.b $00
[0000b334]                           dc.b $00
[0000b335]                           dc.b $0a
[0000b336] 00004e0e                  dc.l $00004e0e ; no symbol found
[0000b33a]                           dc.b $00
[0000b33b]                           dc.b $00
[0000b33c]                           dc.b $00
[0000b33d]                           dc.b $0b
[0000b33e] 00004e28                  dc.l $00004e28 ; no symbol found
[0000b342]                           dc.b $00
[0000b343]                           dc.b $00
[0000b344]                           dc.b $00
[0000b345]                           dc.b $00
[0000b346]                           dc.b $00
[0000b347]                           dc.b $00
[0000b348]                           dc.b $00
[0000b349]                           dc.b $00
[0000b34a]                           dc.b $00
[0000b34b]                           dc.b $00
[0000b34c]                           dc.b $00
[0000b34d]                           dc.b $00
[0000b34e]                           dc.b $00
[0000b34f]                           dc.b $00
[0000b350]                           dc.w $0100
[0000b352]                           dc.b $00
[0000b353]                           dc.b $02
[0000b354]                           dc.b 'not locked in MAPRBL',0
[0000b369]                           dc.b 'not locked in MAPWBL',0
[0000b37e]                           dc.b 'rdwr',0
[0000b383]                           dc.b $00
[0000b384]                           dc.b $00
[0000b385]                           dc.b $00
[0000b386]                           dc.b $00
[0000b387]                           dc.b $00
[0000b388]                           dc.b $00
[0000b389]                           dc.b $00
[0000b38a]                           dc.b $00
[0000b38b]                           dc.b $06
[0000b38c] 000056e0                  dc.l $000056e0 ; no symbol found
[0000b390]                           dc.b $00
[0000b391]                           dc.b $00
[0000b392]                           dc.b $00
[0000b393]                           dc.b $01
[0000b394] 0000572a                  dc.l $0000572a ; no symbol found
[0000b398]                           dc.b $00
[0000b399]                           dc.b $00
[0000b39a]                           dc.b $00
[0000b39b]                           dc.b $02
[0000b39c] 000056ce                  dc.l $000056ce ; no symbol found
[0000b3a0]                           dc.b $00
[0000b3a1]                           dc.b $00
[0000b3a2]                           dc.b $00
[0000b3a3]                           dc.b $41
[0000b3a4] 0000571a                  dc.l $0000571a ; no symbol found
[0000b3a8]                           dc.b $00
[0000b3a9]                           dc.b $00
[0000b3aa]                           dc.b $00
[0000b3ab]                           dc.b $42
[0000b3ac] 00005702                  dc.l $00005702 ; no symbol found
[0000b3b0]                           dc.b $00
[0000b3b1]                           dc.b $00
[0000b3b2]                           dc.b $00
[0000b3b3]                           dc.b $81
[0000b3b4] 0000575e                  dc.l $0000575e ; no symbol found
[0000b3b8]                           dc.b $00
[0000b3b9]                           dc.b $00
[0000b3ba]                           dc.b $00
[0000b3bb]                           dc.b $82
[0000b3bc] 00005776                  dc.l $00005776 ; no symbol found
[0000b3c0]                           dc.b 'not locked in readi',0
[0000b3d4]                           dc.b 'READPHYS size %i count %i loff %i ',0
[0000b3f7]                           dc.b '#%i ncontig %i',$0a,0
[0000b407]                           dc.b 'not locked in WRITEI',0
[0000b41c]                           dc.b $00
[0000b41d]                           dc.b $00
[0000b41e]                           dc.b $00
[0000b41f]                           dc.b $00
[0000b420]                           dc.b $00
[0000b421]                           dc.b $00
[0000b422]                           dc.b $00
[0000b423]                           dc.b $00
[0000b424]                           dc.b $00
[0000b425]                           dc.b $00
[0000b426]                           dc.b $00
[0000b427]                           dc.b $00
[0000b428]                           dc.b $00
[0000b429]                           dc.b $00
[0000b42a]                           dc.b $00
[0000b42b]                           dc.b $00
[0000b42c]                           dc.b $00
[0000b42d]                           dc.b $00
[0000b42e]                           dc.b $00
[0000b42f]                           dc.b $00
[0000b430]                           dc.b $00
[0000b431]                           dc.b $00
[0000b432]                           dc.b $00
[0000b433]                           dc.b $00
[0000b434]                           dc.b $00
[0000b435]                           dc.b $00
[0000b436]                           dc.b $00
[0000b437]                           dc.b $00
[0000b438]                           dc.b $00
[0000b439]                           dc.b $00
[0000b43a]                           dc.b $00
[0000b43b]                           dc.b $00
[0000b43c]                           dc.b $00
[0000b43d]                           dc.b $00
[0000b43e]                           dc.b $00
[0000b43f]                           dc.b $00
[0000b440]                           dc.b $00
[0000b441]                           dc.b $00
[0000b442]                           dc.b $00
[0000b443]                           dc.b $00
[0000b444]                           dc.b $00
[0000b445]                           dc.b $00
[0000b446]                           dc.b $00
[0000b447]                           dc.b $09
[0000b448]                           dc.b $00
[0000b449]                           dc.b $00
[0000b44a]                           dc.b $00
[0000b44b]                           dc.b $00
[0000b44c] 00006856                  dc.l $00006856 ; no symbol found
[0000b450] 00006856                  dc.l $00006856 ; no symbol found
[0000b454] 0000692c                  dc.l $0000692c ; no symbol found
[0000b458] 0000692c                  dc.l $0000692c ; no symbol found
[0000b45c] 00006850                  dc.l $00006850 ; no symbol found
[0000b460] 00006840                  dc.l $00006840 ; no symbol found
[0000b464] 00006912                  dc.l $00006912 ; no symbol found
[0000b468] 00006840                  dc.l $00006840 ; no symbol found
[0000b46c] 00006984                  dc.l $00006984 ; no symbol found
[0000b470]                           dc.b $00
[0000b471]                           dc.b $00
[0000b472]                           dc.b $00
[0000b473]                           dc.b $00
[0000b474]                           dc.b $00
[0000b475]                           dc.b $00
[0000b476]                           dc.b $00
[0000b477]                           dc.b $00
[0000b478] 00006984                  dc.l $00006984 ; no symbol found
[0000b47c]                           dc.b $00
[0000b47d]                           dc.b $00
[0000b47e]                           dc.b $00
[0000b47f]                           dc.b $00
[0000b480]                           dc.b $00
[0000b481]                           dc.b $00
[0000b482]                           dc.b $00
[0000b483]                           dc.b $00
[0000b484]                           dc.b $00
[0000b485]                           dc.b $00
[0000b486]                           dc.b $00
[0000b487]                           dc.b $00
[0000b488]                           dc.b $00
[0000b489]                           dc.b $00
[0000b48a]                           dc.b $00
[0000b48b]                           dc.b $00
[0000b48c]                           dc.b $00
[0000b48d]                           dc.b $00
[0000b48e]                           dc.b $00
[0000b48f]                           dc.b $00
[0000b490]                           dc.b $00
[0000b491]                           dc.b $00
[0000b492]                           dc.b $00
[0000b493]                           dc.b $00
[0000b494]                           dc.b $00
[0000b495]                           dc.b $00
[0000b496]                           dc.b $00
[0000b497]                           dc.b $00
[0000b498]                           dc.b $00
[0000b499]                           dc.b $00
[0000b49a]                           dc.b $00
[0000b49b]                           dc.b $00
[0000b49c]                           dc.b $00
[0000b49d]                           dc.b $00
[0000b49e]                           dc.b $00
[0000b49f]                           dc.b $00
[0000b4a0]                           dc.b $00
[0000b4a1]                           dc.b $00
[0000b4a2]                           dc.b $00
[0000b4a3]                           dc.b $00
[0000b4a4]                           dc.b $00
[0000b4a5]                           dc.b $00
[0000b4a6]                           dc.b $00
[0000b4a7]                           dc.b $00
[0000b4a8]                           dc.b $00
[0000b4a9]                           dc.b $00
[0000b4aa]                           dc.b 'SREALLOC',0
[0000b4b3]                           dc.b $00
[0000b4b4]                           dc.b $00
[0000b4b5]                           dc.b $00
[0000b4b6]                           dc.b $00
[0000b4b7]                           dc.b $00
[0000b4b8]                           dc.b $00
[0000b4b9]                           dc.b $00
[0000b4ba]                           dc.b $00
[0000b4bb]                           dc.b $00
[0000b4bc]                           dc.b $00
[0000b4bd]                           dc.b $00
[0000b4be]                           dc.b $00
[0000b4bf]                           dc.b $00
[0000b4c0]                           dc.b $00
[0000b4c1]                           dc.b $00
[0000b4c2]                           dc.b $00
[0000b4c3]                           dc.b $00
[0000b4c4]                           dc.b $00
[0000b4c5]                           dc.b $00
[0000b4c6]                           dc.b $00
[0000b4c7]                           dc.b $00
[0000b4c8]                           dc.b 'movein',0
[0000b4cf]                           dc.b 'swap read error',0
[0000b4df]                           dc.b 'can',$27,'t swap',0
[0000b4ea]                           dc.b 'swap write error',0
[0000b4fb]                           dc.b $00
[0000b4fc]                           dc.b $00
[0000b4fd]                           dc.b $00
[0000b4fe]                           dc.b $00
[0000b4ff]                           dc.b $00
[0000b500]                           dc.b $00
[0000b501]                           dc.b $00
[0000b502]                           dc.b $00
[0000b503]                           dc.b $00
[0000b504]                           dc.b $00
[0000b505]                           dc.b $00
[0000b506]                           dc.b $00
[0000b507]                           dc.b $00
[0000b508]                           dc.b $00
[0000b509]                           dc.b $19
[0000b50a]                           dc.b $00
[0000b50b]                           dc.b $02
[0000b50c]                           dc.b $00
[0000b50d]                           dc.b $ff
[0000b50e]                           dc.b $00
[0000b50f]                           dc.b $00
[0000b510] 0000b510                  dc.l $0000b510 ; no symbol found
[0000b514]                           dc.b $00
[0000b515]                           dc.b $00
[0000b516]                           dc.b $00
[0000b517]                           dc.b $00
[0000b518]                           dc.b $00
[0000b519]                           dc.b $00
[0000b51a]                           dc.b $00
[0000b51b]                           dc.b $00
[0000b51c]                           dc.b $00
[0000b51d]                           dc.b $00
[0000b51e]                           dc.b $00
[0000b51f]                           dc.b $00
[0000b520] 0000b524                  dc.l $0000b524 ; no symbol found
[0000b524]                           dc.b $00
[0000b525]                           dc.b $00
[0000b526]                           dc.b $00
[0000b527]                           dc.b $00
[0000b528]                           dc.w $1df8
[0000b52a]                           dc.b $00
[0000b52b]                           dc.b $00
[0000b52c]                           dc.b 'OFFRUN!',$0a,0
[0000b535]                           dc.b 'off run list',$0a,0
[0000b543]                           dc.b 'neg nrun',$0a,0
[0000b54d]                           dc.b 'RUNPROC!',$0a,0
[0000b557]                           dc.b $00
[0000b558]                           dc.w $ffff
[0000b55a]                           dc.b 'user deleted: pid %i (%s)',$0a,0
[0000b575]                           dc.b $00
[0000b576]                           dc.b $00
[0000b577]                           dc.b $00
[0000b578]                           dc.b $00
[0000b579]                           dc.b $00
[0000b57a] 000092ba                  dc.l _wakalrm
[0000b57e]                           dc.b $00
[0000b57f]                           dc.b $00
[0000b580]                           dc.b $00
[0000b581]                           dc.b $00
[0000b582]                           dc.b $00
[0000b583]                           dc.b $00
[0000b584]                           dc.b $00
[0000b585]                           dc.b $00
[0000b586]                           dc.b $00
[0000b587]                           dc.b $00
[0000b588]                           dc.b $00
[0000b589]                           dc.b $00
[0000b58a] 00008bf0                  dc.l _ager
[0000b58e]                           dc.b $00
[0000b58f]                           dc.b $00
[0000b590]                           dc.b $00
[0000b591]                           dc.b $00
[0000b592]                           dc.b $00
[0000b593]                           dc.b $00
[0000b594]                           dc.b $00
[0000b595]                           dc.b $00
[0000b596]                           dc.b $00
[0000b597]                           dc.b $1e
[0000b598]                           dc.b $00
[0000b599]                           dc.b $00
[0000b59a]                           dc.b $00
[0000b59b]                           dc.b $00
[0000b59c]                           dc.w $165d
[0000b59e]                           dc.w $ad61
[0000b5a0]                           dc.b $00
[0000b5a1]                           dc.b $00
[0000b5a2]                           dc.b $00
[0000b5a3]                           dc.b $00
[0000b5a4]                           dc.b $00
[0000b5a5]                           dc.b $00
[0000b5a6]                           dc.b $00
[0000b5a7]                           dc.b $00
[0000b5a8]                           dc.b $00
[0000b5a9]                           dc.b $00
[0000b5aa]                           dc.b $00
[0000b5ab]                           dc.b $00
[0000b5ac]                           dc.b $00
[0000b5ad]                           dc.b $00
[0000b5ae]                           dc.b $00
[0000b5af]                           dc.b $00
[0000b5b0]                           dc.b $00
[0000b5b1]                           dc.b $00
[0000b5b2]                           dc.b $00
[0000b5b3]                           dc.b $00
[0000b5b4]                           dc.b $00
[0000b5b5]                           dc.b $00
[0000b5b6]                           dc.b $00
[0000b5b7]                           dc.b $00
[0000b5b8]                           dc.b $00
[0000b5b9]                           dc.b $00
[0000b5ba]                           dc.b $00
[0000b5bb]                           dc.b $00
[0000b5bc]                           dc.b $00
[0000b5bd]                           dc.b $00
[0000b5be]                           dc.b $00
[0000b5bf]                           dc.b $00
[0000b5c0]                           dc.b $00
[0000b5c1]                           dc.b $00
[0000b5c2]                           dc.b $00
[0000b5c3]                           dc.b $00
[0000b5c4]                           dc.b $00
[0000b5c5]                           dc.b $00
[0000b5c6]                           dc.b $00
[0000b5c7]                           dc.b $00
[0000b5c8]                           dc.b $00
[0000b5c9]                           dc.b $00
[0000b5ca]                           dc.b $00
[0000b5cb]                           dc.b $00
[0000b5cc]                           dc.b $00
[0000b5cd]                           dc.b $00
[0000b5ce]                           dc.b $00
[0000b5cf]                           dc.b $00
[0000b5d0]                           dc.b $00
[0000b5d1]                           dc.b $00
[0000b5d2]                           dc.b $00
[0000b5d3]                           dc.b $00
[0000b5d4]                           dc.b $00
[0000b5d5]                           dc.b $00
[0000b5d6]                           dc.b $00
[0000b5d7]                           dc.b $00
[0000b5d8]                           dc.b $00
[0000b5d9]                           dc.b $00
[0000b5da]                           dc.b $00
[0000b5db]                           dc.b $00
[0000b5dc]                           dc.b $00
[0000b5dd]                           dc.b $00
[0000b5de]                           dc.b $00
[0000b5df]                           dc.b $00
[0000b5e0]                           dc.b $00
[0000b5e1]                           dc.b $00
[0000b5e2]                           dc.b $00
[0000b5e3]                           dc.b $00
[0000b5e4]                           dc.b $00
[0000b5e5]                           dc.b $00
[0000b5e6]                           dc.b $00
[0000b5e7]                           dc.b $00
[0000b5e8]                           dc.b $00
[0000b5e9]                           dc.b $00
[0000b5ea]                           dc.b $00
[0000b5eb]                           dc.b $00
[0000b5ec]                           dc.b $00
[0000b5ed]                           dc.b $00
[0000b5ee]                           dc.b $00
[0000b5ef]                           dc.b $00
[0000b5f0]                           dc.b $00
[0000b5f1]                           dc.b $00
[0000b5f2]                           dc.b $00
[0000b5f3]                           dc.b $00
[0000b5f4]                           dc.b $00
[0000b5f5]                           dc.b $00
[0000b5f6]                           dc.b $00
[0000b5f7]                           dc.b $00
[0000b5f8]                           dc.b $00
[0000b5f9]                           dc.b $00
[0000b5fa]                           dc.b $00
[0000b5fb]                           dc.b $00
[0000b5fc]                           dc.b $00
[0000b5fd]                           dc.b $00
[0000b5fe]                           dc.b $00
[0000b5ff]                           dc.b $00
[0000b600]                           dc.b $00
[0000b601]                           dc.b $00
[0000b602]                           dc.b $00
[0000b603]                           dc.b $00
[0000b604]                           dc.b $00
[0000b605]                           dc.b $00
[0000b606]                           dc.b $00
[0000b607]                           dc.b $00
[0000b608]                           dc.b $00
[0000b609]                           dc.b $00
[0000b60a]                           dc.b $00
[0000b60b]                           dc.b $00
[0000b60c]                           dc.b $00
[0000b60d]                           dc.b $00
[0000b60e]                           dc.b $00
[0000b60f]                           dc.b $00
[0000b610]                           dc.b $00
[0000b611]                           dc.b $00
[0000b612]                           dc.b $00
[0000b613]                           dc.b $00
[0000b614]                           dc.b $00
[0000b615]                           dc.b $00
[0000b616]                           dc.b $00
[0000b617]                           dc.b $00
[0000b618]                           dc.b $00
[0000b619]                           dc.b $00
[0000b61a]                           dc.b $00
[0000b61b]                           dc.b $00
[0000b61c]                           dc.b $00
[0000b61d]                           dc.b $00
[0000b61e]                           dc.b $00
[0000b61f]                           dc.b $00
[0000b620]                           dc.b $00
[0000b621]                           dc.b $00
[0000b622]                           dc.b $00
[0000b623]                           dc.b $00
[0000b624]                           dc.b $00
[0000b625]                           dc.b $00
[0000b626]                           dc.b $00
[0000b627]                           dc.b $00
[0000b628]                           dc.b $00
[0000b629]                           dc.b $00
[0000b62a]                           dc.b $00
[0000b62b]                           dc.b $00
[0000b62c]                           dc.b $00
[0000b62d]                           dc.b $00
[0000b62e]                           dc.b $00
[0000b62f]                           dc.b $00
[0000b630]                           dc.b $00
[0000b631]                           dc.b $00
[0000b632]                           dc.b $00
[0000b633]                           dc.b $00
[0000b634]                           dc.b $00
[0000b635]                           dc.b $00
[0000b636]                           dc.b $00
[0000b637]                           dc.b $00
[0000b638]                           dc.b $00
[0000b639]                           dc.b $00
[0000b63a]                           dc.b $00
[0000b63b]                           dc.b $00
[0000b63c]                           dc.b $00
[0000b63d]                           dc.b $00
[0000b63e]                           dc.b $00
[0000b63f]                           dc.b $00
[0000b640]                           dc.b $00
[0000b641]                           dc.b $00
[0000b642]                           dc.b $00
[0000b643]                           dc.b $00
[0000b644]                           dc.b $00
[0000b645]                           dc.b $00
[0000b646]                           dc.b $00
[0000b647]                           dc.b $00
[0000b648]                           dc.b $00
[0000b649]                           dc.b $00
[0000b64a]                           dc.b $00
[0000b64b]                           dc.b $00
[0000b64c]                           dc.b $00
[0000b64d]                           dc.b $00
[0000b64e]                           dc.b $00
[0000b64f]                           dc.b $00
[0000b650]                           dc.b $00
[0000b651]                           dc.b $00
[0000b652]                           dc.b $00
[0000b653]                           dc.b $00
[0000b654]                           dc.b $00
[0000b655]                           dc.b $00
[0000b656]                           dc.b $00
[0000b657]                           dc.b $00
[0000b658]                           dc.b $00
[0000b659]                           dc.b $00
[0000b65a]                           dc.b $00
[0000b65b]                           dc.b $00
[0000b65c]                           dc.b $00
[0000b65d]                           dc.b $00
[0000b65e]                           dc.b $00
[0000b65f]                           dc.b $00
[0000b660]                           dc.b $00
[0000b661]                           dc.b $00
[0000b662]                           dc.b $00
[0000b663]                           dc.b $00
[0000b664]                           dc.b $00
[0000b665]                           dc.b $00
[0000b666]                           dc.b $00
[0000b667]                           dc.b $00
[0000b668]                           dc.b $00
[0000b669]                           dc.b $00
[0000b66a]                           dc.b $00
[0000b66b]                           dc.b $00
[0000b66c]                           dc.b $00
[0000b66d]                           dc.b $00
[0000b66e]                           dc.b $00
[0000b66f]                           dc.b $00
[0000b670]                           dc.b $00
[0000b671]                           dc.b $00
[0000b672]                           dc.b $00
[0000b673]                           dc.b $00
[0000b674]                           dc.b $00
[0000b675]                           dc.b $00
[0000b676]                           dc.b 'MAP!',$0a,0
[0000b67c]                           dc.b $00
[0000b67d]                           dc.b $00
[0000b67e]                           dc.b $00
[0000b67f]                           dc.b $00
[0000b680]                           dc.b $00
[0000b681]                           dc.b $00
[0000b682]                           dc.b 'timeout',0
[0000b68a]                           dc.b $00
[0000b68b]                           dc.b $00
[0000b68c]                           dc.b $00
[0000b68d]                           dc.b $00
[0000b68e]                           dc.b $00
[0000b68f]                           dc.b $05
[0000b690]                           dc.b $00
[0000b691]                           dc.b $00
[0000b692]                           dc.b $00
[0000b693]                           dc.b $00
[0000b694] 00009ad6                  dc.l $00009ad6 ; no symbol found
[0000b698] 00009aec                  dc.l $00009aec ; no symbol found
[0000b69c] 00009ae6                  dc.l $00009ae6 ; no symbol found
[0000b6a0] 00009b34                  dc.l $00009b34 ; no symbol found
[0000b6a4] 00009b2e                  dc.l $00009b2e ; no symbol found
[0000b6a8]                           dc.b $00
[0000b6a9]                           dc.b $00
[0000b6aa]                           dc.b $00
[0000b6ab]                           dc.b $00
[0000b6ac]                           dc.b $00
[0000b6ad]                           dc.b $00
[0000b6ae]                           dc.b $00
[0000b6af]                           dc.b $00
[0000b6b0] 00009ab2                  dc.l $00009ab2 ; no symbol found
[0000b6b4]                           dc.b $00
[0000b6b5]                           dc.b $00
[0000b6b6]                           dc.b $00
[0000b6b7]                           dc.b $00
[0000b6b8]                           dc.b $00
[0000b6b9]                           dc.b $00
[0000b6ba]                           dc.b $00
[0000b6bb]                           dc.b $00
[0000b6bc]                           dc.b $00
[0000b6bd]                           dc.b $00
[0000b6be]                           dc.b $00
[0000b6bf]                           dc.b $00
[0000b6c0]                           dc.b $00
[0000b6c1]                           dc.b $00
[0000b6c2]                           dc.b $00
[0000b6c3]                           dc.b $00
[0000b6c4]                           dc.b $00
[0000b6c5]                           dc.b $00
[0000b6c6]                           dc.b $00
[0000b6c7]                           dc.b $00
[0000b6c8]                           dc.b $00
[0000b6c9]                           dc.b $00
[0000b6ca]                           dc.b $00
[0000b6cb]                           dc.b $00
[0000b6cc]                           dc.b $00
[0000b6cd]                           dc.b $00
[0000b6ce]                           dc.b $00
[0000b6cf]                           dc.b $00
[0000b6d0]                           dc.b $00
[0000b6d1]                           dc.b $00
[0000b6d2]                           dc.b $00
[0000b6d3]                           dc.b $00
[0000b6d4]                           dc.b $00
[0000b6d5]                           dc.b $00
[0000b6d6]                           dc.b $00
[0000b6d7]                           dc.b $00
[0000b6d8]                           dc.b $00
[0000b6d9]                           dc.b $00
[0000b6da]                           dc.b $00
[0000b6db]                           dc.b $00
[0000b6dc]                           dc.b $00
[0000b6dd]                           dc.b $00
[0000b6de]                           dc.b $00
[0000b6df]                           dc.b $00
[0000b6e0]                           dc.w $ffff
[0000b6e2]                           dc.w $ffff
[0000b6e4]                           dc.b $00
[0000b6e5]                           dc.b $00
[0000b6e6]                           dc.b $00
[0000b6e7]                           dc.b $00
[0000b6e8] 00009e9c                  dc.l _sylock
[0000b6ec]                           dc.b $00
[0000b6ed]                           dc.b $00
[0000b6ee]                           dc.b $00
[0000b6ef]                           dc.b $00
[0000b6f0]                           dc.b $00
[0000b6f1]                           dc.b $00
[0000b6f2]                           dc.b $00
[0000b6f3]                           dc.b $00
[0000b6f4]                           dc.b $00
[0000b6f5]                           dc.b $00
[0000b6f6]                           dc.b $00
[0000b6f7]                           dc.b $00
[0000b6f8]                           dc.b $00
[0000b6f9]                           dc.b $05
[0000b6fa]                           dc.b $00
[0000b6fb]                           dc.b $00
[0000b6fc]                           dc.b $00
[0000b6fd]                           dc.b $00
[0000b6fe] 00009f42                  dc.l $00009f42 ; no symbol found
[0000b702] 00009ffe                  dc.l $00009ffe ; no symbol found
[0000b706] 0000a03e                  dc.l $0000a03e ; no symbol found
[0000b70a] 00009f4e                  dc.l $00009f4e ; no symbol found
[0000b70e] 0000a008                  dc.l $0000a008 ; no symbol found
[0000b712]                           dc.b $00
[0000b713]                           dc.b $00
[0000b714]                           dc.b $00
[0000b715]                           dc.b $00
[0000b716]                           dc.b $00
[0000b717]                           dc.b $00
[0000b718]                           dc.b $00
[0000b719]                           dc.b $00
[0000b71a] 0000a03e                  dc.l $0000a03e ; no symbol found
;
         U _spl
         U _spl7
         U _biops
         U _panic
         U _spl0
         U _blkdevs
         U _nblkdev
         U _rahead
         U _putch
         U _chrdevs
         U _nchrdev
         U a~jtab
         U _ttyps
         U _outbuf
         U _inbuf
         U _out_lo
         U _xsetch
         U _in_xon
         U _out_hi
         U _xfetch
         U _in_max
         U _in_lim
         U _in_xoff
         U a~uldiv
         U a~ulmod
         U _outbyte
         U _inbyte
         U _pu
         U _tflip
         U _nbufs
         U _nclist
         U _rootdev
         U _swapdev
         U _pipedev
         U _rootro
         U _physbias
         U _iflip
         U _coremode
         U _bflip
         U _coreout
         U _where
         U _ssbyte
         U _gsbyte
         U _physio
         U _maxpipe
         U _xaspc
         U _xusrsvc
         U _xamagic
         U _sharetext
         U _xpage
         U _sepid
         U _outword
         U _inword
         U _setjmp
         U _absok
         U _xreloc
         U _memalloc
         U _mmupres
         U _xamask
         U _contig
         U _clrmem
         U _setumap
         U _xtrns
         U _addsum
         U _swpfree
         U _xmagic
         U _mapsize
         U _addlum
         U _maxargs
         U _xmemall
         U _usize
         U _xmemshft
         U _stdheap
         U _uinit
         U _ufork
         U _swpalloc
         U _curbase
         U _xmask
         U _memfree
         U _uout
         U _swap
         U _memcopy
         U _sig_chk
         U _onentry
         U _idloop
         U _longjmp
         U _u0
         U _proc0
         U _setpu1
         U a~lmul
         U a~ldiv
         U _csw
         U _sysname
         U _syslock
         U _nsyslock
         U _chkbuf
         U _p1size
         U _p1end
         U _p1boot
         U _stkchk
         U _mapclr
         U _hi_chk
000000f6 T _alloc
00000114 T _free
00000138 T _frelst
0000015c T _halloc
0000022a T _hfree
000002c6 T _hfrelst
0000031a T _hinit
00000358 T _bbuy
00000390 T _brelse
000003f4 T _bsell
00000416 T _buflush
000004ca T _clrbuf
000004f4 T _getblk
00000682 T _errget
000006ac T _iodone
000006e0 T _locb
00000780 T _locctig
0000080e T _printb
00000890 T _rdstrat
000008fe T _readab
0000095c T _readb
0000097c T _sleepb
000009a4 T _unfree
000009ca T _waitio
00000a0c T _wakeb
00000a3e T _writb
00000a82 T _writdb
00000ab2 T _closed
00000b3e T _deq
00000b76 T _enq
00000ba6 T _enqelev
00000c18 T _getaddr
00000c28 T _getdev
00000c3a T _mountdev
00000cb0 T _nodev
00000cbe T _nulldev
00000cc0 T _opendev
00000d70 T _readev
00000d9a T _wridev
00000dc4 T _deqc
00000e9e T _enqc
00000f3a T _popc
0000116c T _flush
00001188 T _flushi
000011f2 T _flusho
0000124c T _rdoff
00001358 T _ttin
000016f4 T _ttinit
0000175a T _ttout
000018f0 T _ttread
00001a6e T _ttrstart
00001a8e T _ttset
00001d98 T _ttwake
00001dde T _ttwrite
00001ee8 T _wdrain
00001f38 T _wflush
00001f58 T _deverr
00001ff4 T _ioerror
00002016 T _putderr
0000204c T _putdnm
000020d6 T _putfmt
0000216c T _putnum
00002200 T _closef
0000230e T _curpid
00002320 T _curproc
0000232c T _dup
00002374 T _dupfiles
000023ae T _error
000023c0 T _fetch
00002418 T _getfd
0000248c T _getmount
000024be T _getuf
00002500 T _iobase
0000250c T _iocount
00002518 T _ioflag
00002526 T _ioseek
00002532 T _isacc
000025da T _isdir
00002600 T _isuper
00002622 T _itols
00002646 T _locki
00002686 T _lsize
000026ac T _lstou
000026d8 T _maxu
000026f4 T _minu
00002710 T _mapfd
00002754 T _movbuf
00002778 T _nodelay
0000278c T _reli
000027be T _setbase
000027d6 T _setch
00002838 T _setcount
00002850 T _setseek
00002868 T _uerror
00002890 T _lo_init
00002892 T _blk_init
00002962 T _chq_init
0000299c T _ino_init
00002aaa T _hi_init
00002aac T _core
00002b8e T _freebl
00002d3e T _getsb
00002dd8 T _geti
00002f58 T _getstat
00003036 T _goodbl
00003084 T _grow
000031b4 T _iboff
000031dc T _ireadb
000031fc T _loci
00003238 T _newi
00003470 T _printi
00003540 T _puti
00003686 T _putsb
000036f2 T _sflip
00003746 T _trunci
0000388e T _updi
0000399a T _ustat
00003ac4 T _utime
00003b64 T _zeroi
00003b96 T _cdir
00003c1c T _chkmode
00003cbc T _crop
00003ebe T _findi
00004132 T _initdir
000041a2 T _isdot
000041ce T _isdotdot
00004202 T _makei
00004298 T _scndir
00004420 T _wdecnlink
00004448 T _wlink
00004762 T _lockf
000048e4 T _lolap
0000494e T _unlock
00004a56 T _waitlock
00004d72 T _memsg
00004f0e T _clkout
00004f2c T _dounits
00004f8a T _trapout
00004fe4 T _growind
000050a8 T _maprbl
00005332 T _mapwbl
000054e2 T _movio
00005552 T _openfifo
00005644 T _rdwr
000057a2 T _readi
00005aaa T _readp
00005b4e T _readphys
00005c46 T _seekp
00005c9a T _setget
00005d44 T _sleepp
00005d72 T _wakep
00005d9a T _writei
00005f22 T _writep
00006058 T _exsell
00006098 T _syenv
00006446 T _syexec
00006466 T _xchk
0000673a T _xgargs
00006a0e T _xgbyte
00006a54 T _xhdr
00006c94 T _xlink
0000712e T _xload
000073b6 T _xpargs
00007580 T _xredirect
000075aa T _xreset
00007822 T _freemem
00007930 T _getin
00007a6c T _getmem
00007ae0 T _movein
00007b76 T _schp0
00007bb2 T _schswap
00007c90 T _swapin
00007d70 T _swapout
00007e10 T _swapp
00007ff0 T _swbuy
00008022 T _swsell
00008044 T _swppri
00008094 T _throwout
000081c8 T _txtexit
000081f4 T _baduser
00008206 T _makep
00008314 T _newpid
0000835a T _offrun
000083c8 T _onplist
000083f4 T _prsig
0000849a T _quantum
000084f6 T _revpri
000085c6 T _runproc
0000868e T _schwake
000086ce T _sendsig
00008728 T _setlock
00008764 T _setpu
000087a6 T _settyp
00008808 T _signal
00008844 T _sleep
00008862 T _sleepl
00008974 T _switchp
00008b0c T _unsleepl
00008b4c T _wakeup
00008b66 T _wakeupl
00008bb0 T _wchan
00008bf0 T _ager
00008cc4 T _contain
00008cf0 T _iotick
00008d68 T _olap
00008d96 T _profile
00008e14 T _salloc
00008e6e T _sfree
00008f48 T _sfrelst
00008f64 T _srealloc
0000900e T _tick
00009206 T _timeout
000092ba T _wakalrm
0000938e T __sytimes
000093de T _syalarm
00009418 T _sygcsw
0000942c T _syggid
00009458 T _sygpid
00009476 T _sygppid
0000949c T _sygtime
000094ae T _syguid
000094da T _sykill
000095dc T _synice
00009662 T _synone
00009670 T _sypause
00009684 T _sypgrp
000096b8 T _syprof
000096e0 T _sysgid
00009724 T _sysig
000097d6 T _sysleep
0000989c T _systime
000098b8 T _sysuid
0000990a T _sytimes
00009944 T _syuname
00009976 T _sywait
00009a1c T _syclose
00009a5a T _sydup
00009a70 T _syfcntl
00009b62 T _syfstat
00009bae T _sygtty
00009bc6 T _syioctl
00009bf0 T _sylseek
00009c66 T _sync
00009cce T _sypipe
00009da4 T _syread
00009dbc T _syseek
00009e0e T _systty
00009e24 T _syumask
00009e5a T _syustat
00009e6c T _sywrite
00009e84 T _nopreemp
00009e92 T _preemp
00009e9c T _sylock
0000a04c T _syaccess
0000a0f8 T _sycd
0000a116 T _sychmod
0000a1c2 T _sychown
0000a236 T _sycr
0000a25e T _sycreat
0000a286 T _sylink
0000a3d0 T _symknod
0000a46e T _symount
0000a566 T _syopen
0000a592 T _systat
0000a5c6 T _syulink
0000a6a0 T _syumount
0000a75a T _syutime
0000a76c T _sysbrk
0000a7f0 T _syexit
0000ab34 T _syfork
00015baa D _clist
00015bae D _pclist
00015bb2 D _nclost
00015bbc D __i_tty
00015c04 D _cmaptab
00015e56 D _ilist
00015e5a D _mlist
00015e5e D ___resvers
00015e62 D _nobdev
00015e78 D _nocdev
00015e92 D _blist
00015ec0 D _pbufs
00015ec4 D _bufsiz
00015ec8 D _nbufres
00015ecc D _buffers
00015f39 D _callno
00015fb2 D _maxlock
00015fb6 D _nlock
00015fe2 D _nmmem
00016028 D _memcdev
000160b0 D _onfirst
000160b4 D _onlast
000160b8 D _onflag
000160ba D _Drdwr
000160be D _maxctig
000160c0 D _minctig
0001618a D _exproc
0001618e D _exbase
00016226 D _p0st
0001622a D _swflag
0001622e D _swlist
00016232 D _p0px
0001626a D _hiproc
0001626e D _outproc
00016272 D _swpwait
00016276 D _hipri
00016278 D _minquan
0001627a D _maxquan
0001627c D _nrun
0001627e D _wakelist
00016282 D _plist
00016286 D _runlist
0001628a D _waitlist
0001628e D _psignal
00016294 D _coresig
000162e4 D _alarmcb
000162f4 D _agercb
00016304 D _schrate
00016306 D _ticking
0001630a D _time
0001630e D _timeleft
00016312 D _memlist
00016316 D _slist
0001631a D _cout
00016426 D _stat_lo
0001642a D _nlocb
0001642e D _nlocbh
00016432 D _nlocbs
00016436 D _nlocbm
0001643a D _nreadi
0001643e D _nread0
00016442 D _nread1
00016446 D _nreadn
0001644a D _nreadp
0001644e D _stat_hi
00016452 D _lockcb
;
; a.out Relocations:
0000007c: 00000000
000000ac: 00000000
000000b4: 00000000
000000c2: 00000000
000000fc: 0000ad6e
0000010a: 00000000
0000011a: 0000ad6e
0000012c: 00000000
0000013e: 0000ad6e
00000150: 00000000
00000216: 0000ad6e
0000021c: 00000000
000002e0: 00000000 _spl7
000002f4: 00000000 _spl
0000035e: 0000ad6e
00000376: 0000ad6e
0000037c: 00000000
00000386: 0000ad6e
000003a0: 00000000
000003a6: 0000ad6e
000003ac: 00000000
000003c0: 00000000 _biops
000003c8: 00000000 _spl
000003d8: 0000ad6e
000003de: 00000000
000003e8: 00000000 _spl
000003fa: 0000ad6e
00000402: 0000ad6e
00000408: 00000000
0000040e: 0000ad6e
00000428: 00000000 _biops
00000430: 00000000 _spl
00000436: 0000ad6e
0000043c: 0000ad6e
00000498: 0000ad6e
000004a0: 00000000 _spl0
000004b4: 00000000
000004bc: 00000000
000004c2: 00000000 _spl0
000004de: 00000000
00000512: 0000ad6e
0000051a: 00000000 _nblkdev
00000528: 00000000 _blkdevs
00000536: 0000ad6e
0000053c: 00000000 _panic
00000542: 00000000 _spl0
00000548: 0000ad6e
00000550: 00000000
00000556: 0000ad6e
0000055e: 00000000
00000576: 00000000
00000582: 00000000 _biops
0000058a: 00000000 _spl
000005a2: 0000ad6e
000005ae: 00000000
000005be: 00000000
000005c4: 00000000 _spl0
000005d4: 0000ad6e
000005da: 0000ad6e
000005e2: 0000ad6e
000005e8: 00000000
000005f2: 0000ad6e
000005f8: 00000000
00000608: 00000000 _spl0
00000610: 00000000
00000674: 00000000 _spl0
0000069c: 00000000
000006d2: 00000000
000006fa: 00000000 _blkdevs
00000706: 0000ad6e
0000070c: 0000ad6e
0000072e: 0000ad6e
00000758: 0000ad6e
0000075e: 0000ad6e
00000764: 0000ad6e
00000778: 0000ad6e
0000079e: 00000000 _blkdevs
000007f0: 00000000
00000834: 0000ad6e
00000846: 00000000 _putch
00000854: 0000ad6e
0000085a: 00000000
0000086c: 00000000
0000087c: 0000ad6e
00000882: 00000000
000008d8: 00000000 _blkdevs
00000924: 00000000 _rahead
00000950: 00000000
00000974: 00000000
0000098c: 0000ad6e
0000099a: 00000000
000009b6: 00000000
000009da: 00000000 _biops
000009e2: 00000000 _spl
000009f8: 00000000 _spl0
00000a28: 0000ad6e
00000a30: 00000000
00000a6e: 00000000 _blkdevs
00000ad4: 0000ad6e
00000ada: 00000000 a~jtab
00000ae8: 00000000
00000afe: 00000000 _blkdevs
00000b14: 00000000
00000b28: 00000000 _chrdevs
00000c4a: 00000000
00000c7e: 00000000 _nblkdev
00000c8c: 00000000
00000c9c: 00000000
00000cb6: 00000000
00000ce2: 0000ad6e
00000ce8: 00000000 a~jtab
00000cee: 00000000 _nblkdev
00000cfc: 00000000
00000d14: 00000000 _blkdevs
00000d24: 00000000 _nchrdev
00000d32: 00000000
00000d4a: 00000000 _chrdevs
00000d5a: 00000000
00000d8a: 00000000 _chrdevs
00000db4: 00000000 _chrdevs
00000dd0: 00000000 _ttyps
00000dd8: 00000000 _spl
00000df2: 00000000 _spl
00000e20: 0000ad6e
00000e28: 0000ad6e
00000e2e: 00000000
00000e34: 0000ad6e
00000e3a: 0000ad6e
00000e64: 0000ad6e
00000e6c: 0000ad6e
00000e72: 00000000
00000e78: 0000ad6e
00000e7e: 0000ad6e
00000e8c: 00000000 _spl
00000eaa: 00000000 _ttyps
00000eb2: 00000000 _spl
00000ed0: 0000ad6e
00000ede: 00000000 _spl
00000ee4: 0000ad6e
00000eee: 0000ad6e
00000ef4: 0000ad6e
00000f2c: 00000000 _spl
00000f46: 00000000 _ttyps
00000f4e: 00000000 _spl
00000f94: 0000ad6e
00000f9c: 0000ad6e
00000fa2: 00000000
00000fa8: 0000ad6e
00000fae: 0000ad6e
00000fbc: 0000ad6e
00000fcc: 0000ad6e
00000fd2: 0000ad6e
00000fd8: 0000ad6e
00000fe2: 0000ad6e
00000fe8: 0000ad6e
00000ff0: 0000ad6e
00000ffc: 0000ad6e
00001004: 0000ad6e
0000100a: 00000000
00001010: 0000ad6e
00001016: 0000ad6e
00001024: 0000ad6e
0000102a: 0000ad6e
00001038: 00000000 _spl
0000105e: 00000000
0000106c: 00000000
0000107a: 00000000
000010be: 00000000
000010d6: 00000000
00001122: 00000000
00001176: 00000000
00001180: 00000000
00001198: 00000000 _ttyps
000011a0: 00000000 _spl
000011b4: 00000000
000011cc: 00000000
000011d4: 00000000 _spl
000011da: 0000ad6e
000011e4: 00000000
00001202: 00000000 _ttyps
0000120a: 00000000 _spl
0000121e: 00000000
0000122e: 00000000 _spl
00001234: 0000ad6e
0000123e: 00000000
00001258: 00000000 _ttyps
00001260: 00000000 _spl
00001268: 0000ad6e
00001274: 0000ad6e
00001298: 0000ad6e
000012a0: 0000ad6e
000012b4: 00000000 _spl
000012c6: 0000ad6e
000012ce: 0000ad6e
00001318: 0000ad6e
00001322: 00000000
0000132c: 0000ad6e
00001332: 0000ad6e
0000133e: 0000ad6e
00001344: 00000000
0000134e: 0000ad6e
000013a2: 0000ad6e
000013a8: 00000000 a~jtab
00001440: 00000000 _in_max
00001454: 0000ad6e
0000145a: 00000000 a~jtab
000014de: 0000ad6e
00001540: 00000000
0000156c: 00000000
000015a0: 00000000
000015c8: 00000000 _in_xoff
000015e2: 00000000
00001604: 00000000 _in_lim
00001618: 00000000
00001660: 0000ad6e
0000166a: 00000000
00001690: 00000000
000016d8: 00000000
0000170e: 00000000
00001720: 00000000
00001730: 0000ad6e
00001736: 00000000
00001782: 00000000
00001794: 0000ad6e
0000179a: 00000000 a~jtab
000017b2: 00000000
000017f4: 0000ad6e
00001852: 00000000
0000185e: 0000ad6e
00001872: 0000ad6e
00001878: 00000000 a~jtab
000018b8: 0000ad6e
000018ca: 0000ad6e
000018e8: 00000000
00001900: 00000000 _ttyps
00001908: 00000000 _spl
00001922: 00000000
00001928: 00000000 _spl0
0000194c: 0000ad6e
00001954: 0000ad6e
00001958: 0000ad6e
00001962: 0000ad6e
00001968: 00000000
00001976: 0000ad6e
0000197e: 0000ad6e
0000198c: 00000000
000019a0: 00000000 _ttyps
000019a8: 00000000 _spl
000019b4: 0000ad6e
000019c0: 00000000
000019ea: 00000000
00001a26: 00000000 _spl0
00001a2e: 00000000 _xsetch
00001a4a: 00000000 _ttyps
00001a52: 00000000 _spl
00001a5c: 00000000
00001a62: 00000000 _spl0
00001a9c: 00000000
00001ab8: 0000ad6e
00001abe: 00000000 a~jtab
00001ac6: 00000000 _ttyps
00001ace: 00000000 _spl
00001afc: 00000000
00001b12: 00000000 _spl
00001b22: 00000000 _outbuf
00001b3a: 00000000 _inbuf
00001b46: 00000000 _ttyps
00001b4e: 00000000 _spl
00001b68: 00000000
00001b8a: 00000000
00001bae: 00000000 _spl
00001bba: 00000000
00001bd4: 00000000 _ttyps
00001bdc: 00000000 _spl
00001bf6: 00000000 _spl
00001c02: 00000000
00001c0a: 00000000
00001c1a: 00000000 _inbuf
00001c26: 00000000 _ttyps
00001c2e: 00000000 _spl
00001cba: 00000000 _spl
00001ccc: 0000ad6e
00001cd2: 00000000
00001d46: 00000000 _outbuf
00001d70: 00000000
00001db8: 00000000 _out_lo
00001dc6: 0000ad6e
00001dd0: 00000000
00001df6: 00000000 _xfetch
00001e02: 00000000 _ttyps
00001e0a: 00000000 _spl
00001e10: 0000ad6e
00001e1a: 0000ad6e
00001e20: 00000000
00001e2a: 00000000 _out_hi
00001e3e: 00000000 _out_hi
00001e50: 0000ad6e
00001e5c: 00000000
00001e66: 00000000 _spl0
00001e7c: 00000000 _ttyps
00001e84: 00000000 _spl
00001e92: 00000000 _spl0
00001eb8: 00000000 _in_xon
00001ec8: 00000000
00001ef8: 00000000 _ttyps
00001f00: 00000000 _spl
00001f14: 0000ad6e
00001f20: 00000000
00001f2c: 00000000 _spl
00001f7a: 0000ad6e
00001f82: 0000ad6e
00001f8a: 0000ad6e
00001f90: 00000000
00001faa: 00000000
00001fb2: 0000ad6e
00001fb8: 00000000
00001fd8: 00000000
00001fe6: 00000000 _putch
00002002: 0000ad6e
00002020: 0000ad6e
00002026: 00000000
00002036: 00000000
00002042: 00000000 _putch
00002078: 00000000 _chrdevs
00002096: 00000000 _blkdevs
000020c8: 00000000 _putch
00002104: 00000000 _putch
00002154: 00000000 _putch
00002164: 00000000
00002180: 0000ad6e
00002186: 00000000 a~jtab
00002194: 00000000 _putch
000021aa: 00000000 _putch
000021b6: 0000ad6e
000021c6: 00000000 a~uldiv
000021e0: 00000000 a~ulmod
000021e8: 0000ad6e
000021f4: 00000000 _putch
0000221e: 00000000
00002246: 00000000
00002296: 00000000
000022ba: 00000000
000022c8: 00000000
000022d8: 00000000
00002300: 00000000
00002310: 00000000 _pu
00002322: 00000000 _pu
0000233c: 00000000
0000234c: 00000000
0000235a: 00000000 _pu
0000237a: 00000000 _pu
000023b8: 00000000 _panic
000023c6: 00000000 _pu
000023ec: 00000000 _inbyte
00002426: 00000000
00002436: 00000000
00002448: 00000000
00002456: 00000000 _pu
00002464: 00000000 _pu
0000249a: 0000ad6e
000024cc: 00000000 _pu
00002502: 00000000 _pu
0000250e: 00000000 _pu
0000251a: 00000000 _pu
00002528: 00000000 _pu
00002544: 00000000 _pu
00002606: 00000000 _pu
0000266c: 00000000
0000271e: 00000000 _pu
0000277a: 00000000 _pu
000027a8: 00000000
000027c4: 00000000 _pu
000027e0: 00000000 _pu
00002808: 00000000 _outbyte
0000283e: 00000000 _pu
00002856: 00000000 _pu
00002874: 00000000 _pu
00002880: 00000000 _pu
0000289c: 00000000 _nbufs
000028a4: 0000ad6e
000028aa: 00000000 _nbufs
000028b0: 0000ad6e
000028b6: 0000ad6e
000028e2: 00000000 _physbias
000028fe: 0000ad6e
00002904: 00000000
00002910: 00000000
0000291a: 00000000
0000292e: 00000000 _nblkdev
0000293e: 00000000 _blkdevs
0000296a: 0000ad6e
00002976: 00000000 _nclist
00002980: 0000ad6e
000029ac: 00000000 _rootdev
000029b4: 00000000
000029be: 00000000 _swapdev
000029d0: 00000000 _swapdev
000029d8: 00000000
000029e2: 00000000 _pipedev
000029f4: 00000000 _pipedev
000029fc: 00000000
00002a0c: 00000000 _rootdev
00002a14: 00000000
00002a20: 00000000
00002a2a: 0000ad6e
00002a30: 00000000 _panic
00002a36: 0000ad6e
00002a40: 00000000
00002a4e: 0000ad6e
00002a54: 00000000 _panic
00002a5a: 0000ad6e
00002a66: 00000000 _rootdev
00002a6e: 00000000 _rootdev
00002a7c: 00000000 _rootro
00002a86: 00000000
00002a92: 00000000 _tflip
00002a98: 0000ad6e
00002aa0: 00000000
00002ab6: 00000000 _pu
00002ac8: 00000000 _coremode
00002ade: 0000ad6e
00002ae4: 00000000
00002afc: 00000000 _coremode
00002b08: 00000000
00002b1a: 00000000
00002b2c: 00000000
00002b3a: 00000000
00002b48: 00000000
00002b6a: 00000000
00002b7a: 00000000 _coreout
00002b86: 00000000
00002ba4: 00000000
00002bb0: 00000000
00002bee: 00000000
00002bfe: 00000000
00002c38: 00000000
00002c56: 00000000
00002c90: 00000000
00002ca6: 00000000
00002cba: 00000000
00002cc8: 00000000
00002cda: 00000000
00002ce4: 00000000 _bflip
00002cf4: 00000000
00002d32: 00000000
00002d4a: 00000000
00002d58: 00000000
00002d6c: 00000000
00002d72: 00000000
00002d7e: 00000000
00002d88: 00000000
00002da8: 0000ad6e
00002dae: 00000000
00002db8: 00000000
00002dc0: 00000000
00002dc6: 00000000
00002dea: 00000000
00002e04: 00000000
00002e18: 00000000
00002e24: 00000000
00002e42: 0000ad6e
00002e5c: 0000ad6e
00002e62: 00000000 _panic
00002e7e: 00000000
00002e88: 0000ad6e
00002e92: 00000000
00002ea4: 00000000
00002eb0: 0000ad6e
00002ee6: 00000000
00002efa: 00000000
00002f04: 00000000 _iflip
00002f0e: 00000000
00002f24: 0000ad6e
00002f2c: 00000000
00002f3e: 00000000
00002f76: 00000000
00002f8a: 00000000
00002f9a: 00000000 _tflip
00002fa8: 00000000 _tflip
00002fce: 00000000
00002fec: 00000000
00003002: 00000000 _outbuf
00003014: 00000000
0000301e: 00000000
00003028: 00000000
0000306a: 0000ad6e
00003070: 00000000
000030b2: 00000000
00003108: 00000000
0000311c: 00000000
00003126: 00000000
00003138: 00000000 _bflip
0000314a: 00000000
0000315a: 00000000
0000316a: 00000000
00003172: 00000000
00003186: 0000ad6e
0000318c: 00000000
00003198: 00000000
000031a6: 00000000
000031c2: 00000000
000031f2: 00000000
00003206: 0000ad6e
00003246: 00000000
00003266: 00000000
0000327c: 00000000
0000328c: 00000000 _pu
0000330c: 00000000
00003326: 00000000
00003372: 00000000
00003388: 0000ad6e
0000338e: 00000000
0000339a: 00000000
000033ae: 00000000 _pu
000033f4: 0000ad6e
000033fa: 00000000
00003440: 00000000
00003454: 00000000
00003462: 00000000
0000347e: 0000ad6e
0000348a: 00000000
00003496: 0000ad6e
0000349c: 00000000
000034ae: 00000000
000034be: 0000ad6e
000034c4: 00000000
000034e4: 0000ad6e
000034f6: 00000000 _putch
00003518: 0000ad6e
0000351e: 00000000
0000352c: 0000ad6e
00003532: 00000000
00003570: 00000000
00003594: 00000000
000035c8: 00000000
000035da: 00000000
000035e2: 00000000
000035fc: 0000ad6e
00003608: 00000000
00003620: 00000000
0000362a: 0000ad6e
00003656: 00000000
00003662: 00000000
00003678: 00000000
0000369a: 00000000
000036aa: 0000ad6e
000036b4: 00000000
000036c2: 00000000
000036d6: 00000000
000036dc: 00000000
000036ec: 00000000
0000370e: 00000000 _bflip
00003728: 00000000 _tflip
00003736: 00000000
000037b0: 00000000
000037d0: 00000000
000037e0: 00000000
0000380c: 00000000
0000381e: 00000000
0000387c: 00000000
000038c0: 00000000
000038f8: 0000ad6e
00003900: 00000000
0000390a: 00000000
00003930: 00000000 _iflip
00003940: 0000ad6e
00003946: 00000000 _tflip
0000395c: 00000000 _tflip
00003976: 0000ad6e
0000397c: 00000000 _tflip
00003988: 00000000
000039b2: 00000000
000039d2: 00000000
000039e2: 00000000
00003a00: 00000000
00003a1e: 00000000
00003a34: 00000000 _rootdev
00003a3c: 00000000 _rootdev
00003a8a: 00000000 _outbuf
00003a9c: 00000000
00003ab4: 00000000
00003ad2: 00000000 _pu
00003adc: 00000000
00003b14: 00000000 _inbuf
00003b26: 00000000
00003b32: 0000ad6e
00003ba4: 00000000 _pu
00003bb2: 00000000
00003bc2: 00000000
00003bd2: 00000000
00003be8: 00000000
00003bfa: 00000000
00003c06: 00000000
00003c12: 00000000
00003c2a: 00000000 _pu
00003cca: 00000000 _pu
00003ce6: 00000000
00003d1e: 00000000
00003d60: 00000000
00003d7e: 00000000
00003d96: 00000000
00003dba: 00000000
00003dd2: 00000000
00003de0: 00000000
00003df0: 00000000
00003dfa: 00000000
00003e40: 00000000
00003e68: 00000000
00003ea2: 00000000
00003eae: 00000000
00003ec8: 00000000 _pu
00003eea: 00000000
00003f16: 00000000
00003f26: 00000000
00003f60: 00000000
00003f76: 00000000
00003fbe: 00000000
00003fee: 00000000
00003ff8: 00000000
00004032: 00000000
00004040: 00000000
00004060: 00000000
00004074: 00000000
00004096: 00000000
000040ae: 00000000
000040e0: 00000000
0000410e: 00000000
00004122: 00000000
00004144: 00000000 _pu
0000415a: 0000ad6e
00004160: 00000000
00004170: 00000000
00004194: 00000000
000041a8: 00000000 _pu
000041d4: 00000000 _pu
0000420c: 00000000 _pu
0000421e: 00000000
00004252: 00000000
0000427e: 00000000
00004288: 00000000
000042a6: 00000000 _pu
0000430c: 00000000
0000431e: 00000000
0000433a: 00000000
0000434a: 00000000
000043e2: 00000000
000043f8: 00000000
00004456: 00000000 _pu
00004484: 00000000
000044c4: 00000000
000044de: 00000000
00004534: 00000000
00004644: 0000ad6e
0000464c: 00000000
0000465c: 00000000
00004666: 0000ad6e
000046aa: 0000ad6e
000046b0: 0000ad6e
000046be: 00000000
000046d0: 00000000
000046da: 00000000
000046ea: 0000ad6e
0000470c: 00000000
00004726: 0000ad6e
00004730: 00000000
0000473e: 00000000
0000474e: 00000000
0000477e: 00000000 _inbuf
000047a4: 00000000
000047fe: 0000ad6e
00004804: 00000000 a~jtab
00004842: 00000000 _outbuf
0000487c: 00000000
000048c6: 0000ad6e
000048d2: 00000000
000048de: 00000000
00004976: 00000000
000049c0: 0000ad6e
000049c8: 00000000
000049d8: 00000000
000049e2: 0000ad6e
00004a84: 00000000
00004ad2: 0000ad6e
00004ade: 00000000
00004af0: 00000000
00004b2a: 00000000 _pu
00004b3c: 00000000
00004b60: 00000000 _pu
00004b76: 00000000
00004b90: 00000000
00004ba6: 00000000 _pu
00004bac: 0000ad6e
00004bbc: 0000ad6e
00004bc2: 00000000 a~jtab
00004bcc: 00000000 _gsbyte
00004bd4: 00000000
00004be6: 0000ad6e
00004bf8: 00000000
00004c16: 00000000
00004c28: 0000ad6e
00004c4c: 00000000
00004c6a: 00000000
00004c7e: 0000ad6e
00004c84: 00000000
00004c94: 0000ad6e
00004c9a: 00000000
00004ca6: 00000000 _where
00004cac: 00000000
00004cb8: 00000000 _nblkdev
00004cc8: 00000000 _blkdevs
00004cd4: 00000000
00004ce0: 00000000 _nchrdev
00004cf0: 00000000 _chrdevs
00004cfc: 00000000
00004d08: 00000000
00004d14: 00000000 _pu
00004d26: 00000000
00004d2e: 0000ad6e
00004d34: 0000ad6e
00004d3a: 0000ad6e
00004d40: 0000ad6e
00004d46: 0000ad6e
00004d54: 00000000
00004d8a: 00000000 _pu
00004db2: 00000000 _chrdevs
00004dce: 00000000 _pu
00004dde: 0000ad6e
00004de4: 00000000 a~jtab
00004dea: 00000000
00004dfe: 00000000 _ssbyte
00004e10: 00000000 _pu
00004e22: 00000000
00004e3c: 00000000 _pu
00004e46: 0000ad6e
00004e4c: 0000ad6e
00004e58: 00000000
00004f1c: 00000000
00004f22: 00000000
00004f32: 00000000 _spl7
00004f3a: 0000ad6e
00004f40: 0000ad6e
00004f46: 0000ad6e
00004f4c: 0000ad6e
00004f64: 00000000 _spl0
00004f7c: 00000000 _spl
00004f98: 00000000 _spl7
00004fac: 0000ad6e
00004fb4: 0000ad6e
00004fbe: 0000ad6e
00004fc4: 0000ad6e
00004fcc: 0000ad6e
00004fd6: 00000000 _spl
0000500e: 00000000
0000501a: 00000000
0000502a: 00000000
00005036: 00000000
00005048: 00000000
00005060: 00000000
00005074: 00000000
00005086: 00000000
00005090: 00000000
000050be: 0000ad6e
000050c6: 00000000
000050e0: 00000000
000050ee: 0000ad6e
000050f6: 00000000
00005200: 00000000
00005218: 00000000
0000522a: 00000000
00005238: 00000000
0000525e: 00000000
0000527e: 00000000
00005288: 00000000 _bflip
00005304: 00000000 _bflip
00005310: 00000000
00005316: 00000000 _pu
00005348: 0000ad6e
00005350: 00000000
00005366: 00000000 _pu
000053a4: 00000000
000053ce: 00000000
000053ee: 00000000
00005416: 00000000
00005426: 00000000
00005442: 00000000
00005486: 00000000
000054ec: 00000000 _pu
00005504: 00000000
000055b0: 00000000
000055c4: 00000000
000055d8: 00000000
000055ee: 00000000
000055fe: 00000000
00005622: 00000000
0000562e: 00000000
0000564e: 00000000 _pu
0000565a: 00000000
000056c4: 0000ad6e
000056ca: 00000000 a~jtab
000056d8: 00000000
000056e8: 00000000
000056f2: 00000000
000056fa: 00000000
00005712: 00000000
00005724: 00000000
00005732: 00000000
00005744: 00000000
00005750: 00000000
00005758: 00000000
0000576e: 00000000
00005778: 0000ad6e
0000577e: 00000000 _panic
000057b0: 00000000 _pu
000057be: 0000ad6e
000057c6: 00000000
000057ce: 0000ad6e
000057e2: 0000ad6e
000057f4: 0000ad6e
00005802: 0000ad6e
00005842: 00000000
0000588a: 00000000
000058f8: 00000000
00005920: 0000ad6e
00005968: 00000000
00005976: 00000000
0000599e: 00000000
000059c4: 00000000
000059de: 0000ad6e
00005a18: 00000000
00005a64: 00000000
00005a70: 00000000 _outbuf
00005a80: 00000000
00005a9a: 00000000
00005ab8: 00000000 _pu
00005ac4: 00000000
00005aec: 00000000
00005af6: 00000000
00005b26: 00000000
00005b48: 00000000
00005b58: 00000000 _pu
00005b62: 00000000
00005ba0: 0000ad6e
00005bb4: 0000ad6e
00005bba: 00000000
00005bca: 00000000
00005bda: 0000ad6e
00005be0: 00000000
00005c02: 00000000 _blkdevs
00005c0e: 00000000 _physio
00005c82: 00000000
00005caa: 00000000
00005cd2: 00000000
00005cdc: 00000000 _pu
00005ce8: 00000000 _pu
00005cf4: 00000000 _pu
00005cfe: 00000000 _pu
00005d2e: 00000000 _chrdevs
00005d62: 00000000
00005d8c: 00000000
00005da8: 00000000 _pu
00005db6: 0000ad6e
00005dbe: 00000000
00005e00: 00000000
00005e6c: 00000000
00005e86: 00000000
00005e98: 00000000 _inbuf
00005ea4: 00000000
00005ec6: 00000000
00005ede: 00000000
00005eea: 00000000
00005ef8: 00000000
00005f30: 00000000 _pu
00005f4c: 00000000
00005f5e: 00000000
00005f72: 00000000
00005f80: 00000000 _maxpipe
00005f86: 00000000
00005f8e: 00000000 _maxpipe
00005faa: 00000000 _maxpipe
00005fba: 00000000
00005fe0: 00000000
00005ffa: 00000000
0000601e: 0000ad6e
00006028: 0000ad6e
00006032: 0000ad6e
00006038: 00000000
00006042: 00000000 _pu
0000604a: 0000ad6e
00006052: 0000ad6e
0000605e: 00000000 _pu
00006068: 0000ad6e
00006070: 0000ad6e
00006078: 0000ad6e
0000607e: 00000000
00006084: 0000ad6e
0000608a: 0000ad6e
00006090: 0000ad6e
000060a2: 00000000 _pu
000060b4: 00000000
000060f2: 00000000 _inbuf
00006110: 00000000
00006120: 00000000
00006152: 00000000
0000616c: 00000000
00006180: 0000ad6e
0000618a: 00000000
000061ae: 00000000
000061bc: 00000000 _pu
000061c6: 00000000 _setjmp
000061ee: 0000ad6e
000061f6: 0000ad6e
000061fe: 00000000 _ufork
00006206: 0000ad6e
00006212: 00000000
00006234: 0000ad6e
0000623c: 00000000 _usize
0000624c: 0000ad6e
00006252: 00000000
00006270: 00000000
0000628e: 0000ad6e
00006294: 00000000 _curbase
000062a2: 0000ad6e
000062aa: 00000000 _uinit
000062bc: 00000000
000062e2: 00000000 _usize
000062e8: 0000ad6e
000062fe: 00000000 _memfree
00006308: 0000ad6e
0000630e: 00000000 _curbase
0000631c: 0000ad6e
00006324: 00000000 _uinit
0000632e: 0000ad6e
00006334: 00000000
00006340: 00000000
00006348: 00000000
0000636a: 00000000 _usize
00006372: 00000000 _uinit
0000637c: 0000ad6e
00006382: 00000000
0000638e: 00000000
000063b4: 00000000 _usize
000063bc: 00000000 _uinit
000063e4: 00000000
000063ea: 00000000
000063f6: 00000000
00006404: 00000000
0000641e: 0000ad6e
00006434: 00000000
00006470: 00000000 _pu
000064de: 00000000 _xmemall
000064e6: 00000000 _xmemshft
000064f6: 00000000 _mapsize
0000651c: 00000000 _xmemall
00006524: 00000000 _xmemshft
00006534: 00000000 _mapsize
0000653a: 00000000 _usize
00006554: 00000000 _contig
0000656e: 00000000 _contig
0000657a: 00000000 _contig
00006588: 00000000 _xmemshft
00006594: 00000000 _xaspc
0000659c: 00000000 _sepid
000065e2: 00000000 _xmemall
000065f8: 00000000 _xmemall
00006600: 00000000 _xmemshft
00006610: 00000000 _mapsize
00006616: 00000000 _usize
00006630: 00000000 _contig
0000663c: 00000000 _xmemall
0000664e: 00000000 _usize
00006654: 00000000 _xmemshft
0000667e: 00000000 _contig
00006688: 00000000 _xaspc
0000669c: 00000000 _xaspc
000066b6: 00000000
000066c4: 00000000 _sepid
000066ea: 00000000
00006744: 00000000 _pu
0000674c: 00000000
00006754: 00000000
00006778: 00000000
000067ba: 00000000 _inbyte
000067ca: 00000000 _inword
00006804: 00000000 _inbyte
00006836: 0000ad6e
0000683c: 00000000 a~jtab
00006862: 00000000 _inword
00006878: 00000000
0000687e: 00000000
00006886: 00000000 _pipedev
0000688e: 00000000
0000689a: 00000000 _pipedev
000068a2: 00000000
000068ea: 00000000
000068fe: 00000000
00006918: 00000000
00006932: 00000000
0000693c: 00000000 _maxargs
00006960: 00000000
00006978: 00000000
00006990: 00000000
0000699c: 00000000
000069aa: 00000000
000069d8: 00000000
000069e8: 00000000 _pipedev
000069f0: 00000000
000069fa: 00000000 _pu
00006a18: 00000000 _inbyte
00006a30: 00000000
00006a3e: 00000000 _pu
00006a5e: 00000000 _pu
00006a80: 00000000
00006a8a: 00000000 _xtrns
00006a96: 00000000 _mmupres
00006aa6: 00000000 _xamask
00006ab0: 00000000 _xamagic
00006aca: 00000000 _xmask
00006ad4: 00000000 _xmagic
00006af6: 00000000 _xreloc
00006b06: 00000000 _sharetext
00006b20: 00000000 _xpage
00006b3a: 00000000 _absok
00006b8c: 00000000 _stdheap
00006bb6: 00000000 _pu
00006bd2: 00000000
00006c06: 00000000
00006c18: 00000000
00006c42: 00000000
00006c56: 0000ad6e
00006c68: 00000000 _blkdevs
00006c74: 00000000 _physio
00006c88: 00000000
00006c9e: 00000000 _pu
00006cd8: 00000000
00006cf0: 00000000
00006cfe: 00000000 _tflip
00006d0a: 00000000
00006d10: 0000ad6e
00006d66: 00000000
00006d7e: 00000000
00006dd0: 0000ad6e
00006dee: 00000000 _swpfree
00006dfe: 00000000 _usize
00006e04: 0000ad6e
00006e1a: 00000000 _swpfree
00006e32: 0000ad6e
00006e3c: 00000000 _swpalloc
00006e48: 00000000 _usize
00006e4e: 0000ad6e
00006e58: 00000000 _swpalloc
00006e7a: 0000ad6e
00006e8c: 00000000 _swpfree
00006e9c: 0000ad6e
00006eb2: 00000000
00006ec4: 0000ad6e
00006ee2: 00000000
00006eee: 0000ad6e
00006ef4: 00000000 _panic
00006f0e: 00000000
00006f1a: 00000000
00006f44: 0000ad6e
00006f62: 00000000 _memfree
00006f78: 00000000
00006f82: 00000000
00006f90: 00000000 _usize
00006f96: 0000ad6e
00006fb4: 00000000 _memfree
00006fc4: 0000ad6e
00006fcc: 00000000 _usize
00006fd2: 0000ad6e
00006fe8: 00000000 _memfree
00007008: 00000000
00007022: 0000ad6e
0000702c: 00000000 _memalloc
00007072: 00000000 _swapdev
0000708e: 00000000 _spl7
00007094: 0000ad6e
0000709a: 0000ad6e
000070a0: 00000000 _spl0
000070a6: 00000000 _usize
000070ac: 0000ad6e
000070b6: 00000000 _memalloc
000070d8: 0000ad6e
000070ea: 00000000 _memfree
00007138: 00000000 _pu
000071ba: 00000000
00007204: 00000000
00007214: 00000000 _setumap
0000723c: 00000000 _xusrsvc
00007272: 00000000
000072b2: 00000000
000072be: 00000000 _setumap
00007300: 00000000 _clrmem
00007310: 00000000
00007376: 00000000
000073c0: 00000000 _pu
000073f0: 0000ad6e
000073f6: 00000000 _outbuf
00007424: 00000000
0000742e: 00000000 _outbuf
0000743a: 00000000
00007440: 00000000
0000745a: 00000000
00007466: 00000000
0000747c: 00000000 _outword
000074ac: 00000000 _outword
000074ba: 00000000 _inbyte
000074ce: 00000000 _outword
000074ea: 00000000
000074f4: 00000000 _pu
00007506: 00000000 _inbuf
00007522: 00000000 _pu
00007530: 00000000
00007552: 00000000
00007594: 00000000
000075a0: 00000000
000075b8: 00000000 _pu
000075e2: 00000000
0000763a: 00000000
000076b8: 00000000
000076c0: 00000000
000076ce: 00000000 _pu
000076ea: 00000000 _pu
00007748: 00000000 _pu
00007774: 00000000 _addlum
00007788: 00000000 _addlum
0000779e: 00000000 _addlum
000077be: 00000000 _addsum
000077d2: 00000000 _addsum
000077e8: 00000000 _addsum
000077fc: 00000000 _pu
00007810: 00000000
00007816: 00000000
00007840: 00000000 _usize
00007850: 0000ad6e
0000785a: 00000000
0000786c: 0000ad6e
00007872: 00000000
00007880: 0000ad6e
00007896: 00000000 _memfree
000078ac: 0000ad6e
000078b4: 00000000 _memalloc
000078c8: 0000ad6e
000078de: 00000000 _swpfree
000078f4: 0000ad6e
000078fc: 00000000 _swpalloc
00007916: 0000ad6e
00007922: 00000000
0000798a: 00000000
0000799c: 00000000
000079b4: 00000000
000079da: 00000000
000079f2: 00000000
00007a14: 00000000 _usize
00007a1a: 0000ad6e
00007a2c: 00000000 _memfree
00007a48: 0000ad6e
00007a5a: 00000000 _memfree
00007a82: 0000ad6e
00007aa6: 00000000
00007abc: 00000000 _usize
00007ac4: 0000ad6e
00007ad2: 00000000 _memalloc
00007af2: 0000ad6e
00007b04: 00000000
00007b34: 0000ad6e
00007b3a: 00000000 _panic
00007b54: 00000000 _memcopy
00007b68: 00000000
00007b98: 0000ad6e
00007b9e: 0000ad6e
00007ba4: 00000000
00007bfa: 00000000 _usize
00007c02: 00000000 _curbase
00007c0c: 0000ad6e
00007c12: 00000000 _curbase
00007c1a: 00000000 _uout
00007c20: 00000000 _curbase
00007c30: 00000000
00007c3a: 00000000
00007c48: 00000000 _usize
00007c50: 0000ad6e
00007c66: 00000000 _memfree
00007c84: 00000000
00007caa: 0000ad6e
00007cc0: 00000000
00007ce8: 00000000 _usize
00007cf8: 00000000 _usize
00007d02: 0000ad6e
00007d0a: 00000000 _memcopy
00007d2a: 00000000 _swap
00007d38: 0000ad6e
00007d3e: 00000000 _panic
00007d7e: 00000000 _swapdev
00007d86: 0000ad6e
00007d8c: 00000000 _panic
00007dea: 00000000 _swap
00007df8: 0000ad6e
00007dfe: 00000000 _panic
00007e16: 00000000 _spl0
00007e1e: 0000ad6e
00007e24: 00000000
00007e2c: 0000ad6e
00007e34: 0000ad6e
00007e3c: 0000ad6e
00007e4a: 0000ad6e
00007e52: 0000ad6e
00007e58: 0000ad6e
00007e80: 0000ad6e
00007e88: 0000ad6e
00007e8e: 0000ad6e
00007e9c: 00000000
00007ed2: 0000ad6e
00007ed8: 0000ad6e
00007ede: 00000000
00007ef2: 0000ad6e
00007efe: 0000ad6e
00007f04: 00000000
00007f0a: 0000ad6e
00007f10: 0000ad6e
00007f1a: 0000ad6e
00007f20: 00000000
00007f2a: 0000ad6e
00007f32: 0000ad6e
00007f38: 00000000
00007f44: 0000ad6e
00007f6e: 0000ad6e
00007f76: 00000000
00007f8a: 0000ad6e
00007f90: 0000ad6e
00007fa0: 0000ad6e
00007fa6: 00000000
00007fac: 0000ad6e
00007fb2: 0000ad6e
00007fb8: 0000ad6e
00007fc2: 0000ad6e
00007fc8: 00000000
00007fd2: 0000ad6e
00007fda: 0000ad6e
00007fe2: 0000ad6e
00007fe8: 00000000
00007ff6: 0000ad6e
00007ffe: 0000ad6e
00008008: 0000ad6e
0000800e: 00000000
0000801a: 0000ad6e
00008028: 0000ad6e
0000802e: 0000ad6e
00008034: 0000ad6e
0000803a: 00000000
000080b2: 0000ad6e
0000814a: 00000000
000081f6: 00000000 _curbase
000081fc: 00000000 _u0
00008200: 00000000 _pu
00008218: 00000000
0000822c: 00000000 _usize
00008232: 0000ad6e
00008238: 00000000 _pu
0000824a: 00000000 _swpalloc
00008262: 00000000
0000826a: 00000000 _pu
00008286: 00000000 _pu
00008292: 00000000
0000829c: 00000000
000082dc: 00000000 _spl7
000082e2: 0000ad6e
000082e8: 0000ad6e
000082ee: 00000000 _spl0
000082f4: 00000000
0000831a: 0000ad6e
00008320: 0000ad6e
0000832a: 0000ad6e
00008330: 0000ad6e
0000833e: 0000ad6e
0000834e: 0000ad6e
00008370: 0000ad6e
00008376: 00000000
0000837e: 0000ad6e
0000838e: 0000ad6e
00008394: 00000000 _panic
000083a4: 0000ad6e
000083ac: 0000ad6e
000083b2: 00000000 _panic
000083d6: 0000ad6e
000083fe: 00000000 _pu
00008446: 00000000 _sig_chk
0000845c: 00000000 _onentry
0000846a: 0000ad6e
00008478: 00000000
0000848c: 00000000
000084cc: 0000ad6e
000084d8: 0000ad6e
000084e8: 0000ad6e
00008586: 00000000
000085b4: 0000ad6e
000085ba: 00000000
000085dc: 0000ad6e
000085e2: 00000000
00008606: 0000ad6e
00008626: 00000000 _spl7
00008640: 0000ad6e
00008646: 00000000 _spl0
00008666: 0000ad6e
0000866c: 00000000
00008678: 0000ad6e
00008682: 0000ad6e
0000869c: 00000000 _spl7
000086aa: 0000ad6e
000086b2: 0000ad6e
000086ba: 0000ad6e
000086c2: 00000000 _spl
00008732: 00000000 _pu
0000876e: 00000000 _proc0
00008778: 00000000 _setpu1
00008796: 00000000 _usize
0000879e: 00000000 _setpu1
000087b0: 00000000 _pu
000087d0: 00000000 _pu
000087de: 0000ad6e
000087f0: 0000ad6e
000087fc: 0000ad6e
00008818: 0000ad6e
0000884a: 0000ad6e
00008858: 00000000
00008870: 00000000 _pu
00008880: 0000ad6e
000088f2: 0000ad6e
000088f8: 00000000
000088fe: 00000000 _spl7
00008922: 00000000 _spl0
00008928: 00000000
00008948: 00000000 _spl
00008954: 0000ad6e
0000895e: 00000000 _pu
00008968: 00000000 _longjmp
0000897a: 00000000 _pu
00008984: 00000000 _spl0
0000898a: 00000000 _pu
00008994: 00000000 _setjmp
000089a4: 0000ad6e
000089ac: 00000000
000089b2: 00000000 _proc0
000089be: 0000ad6e
000089c4: 0000ad6e
000089ca: 0000ad6e
000089d0: 0000ad6e
000089d8: 00000000 _spl7
000089de: 0000ad6e
000089e6: 0000ad6e
000089ec: 00000000 _spl0
000089f4: 00000000
00008a02: 0000ad6e
00008a0a: 00000000
00008a10: 0000ad6e
00008a34: 00000000
00008a54: 00000000 _pu
00008a66: 0000ad6e
00008a72: 0000ad6e
00008a86: 00000000 _pu
00008a90: 00000000 _longjmp
00008aa4: 0000ad6e
00008aaa: 00000000
00008ab4: 00000000
00008aca: 00000000
00008ad2: 00000000 _spl7
00008ad8: 0000ad6e
00008ae0: 0000ad6e
00008ae8: 00000000 _idloop
00008aee: 00000000 _spl0
00008af8: 00000000 _pu
00008b02: 00000000 _longjmp
00008b2c: 00000000 _spl7
00008b3c: 00000000 _spl0
00008b52: 0000ad6e
00008b5c: 00000000
00008c00: 0000ad6e
00008c0a: 00000000 _pu
00008c38: 00000000
00008c4e: 00000000
00008c58: 0000ad6e
00008c5e: 0000ad6e
00008c64: 0000ad6e
00008c7a: 00000000 _pu
00008c90: 00000000
00008cae: 00000000
00008cb8: 0000ad6e
00008cf6: 0000ad6e
00008d06: 00000000 a~lmul
00008d0e: 0000ad6e
00008d14: 0000ad6e
00008d1a: 0000ad6e
00008d22: 0000ad6e
00008d2c: 0000ad6e
00008d36: 00000000 a~ldiv
00008d3e: 0000ad6e
00008d44: 0000ad6e
00008d4a: 00000000
00008d50: 0000ad6e
00008d58: 0000ad6e
00008d60: 0000ad6e
00008da4: 00000000 _pu
00008dee: 00000000 _inbuf
00008e0a: 00000000 _outbuf
00008e66: 00000000
00008ee0: 00000000
00008f0e: 00000000
00008f1c: 0000ad6e
00008f22: 00000000
00008f5a: 00000000
00009018: 00000000 _pu
00009024: 0000ad6e
0000902e: 0000ad6e
0000903a: 0000ad6e
00009060: 0000ad6e
00009068: 0000ad6e
0000908a: 0000ad6e
00009096: 0000ad6e
0000909c: 0000ad6e
000090a2: 0000ad6e
000090aa: 0000ad6e
000090b4: 0000ad6e
000090be: 00000000 a~ldiv
000090c6: 0000ad6e
000090cc: 0000ad6e
000090d2: 00000000
000090d8: 0000ad6e
000090e0: 0000ad6e
000090e8: 0000ad6e
000090f2: 0000ad6e
000090fa: 0000ad6e
00009104: 0000ad6e
00009112: 00000000 a~ldiv
0000911e: 0000ad6e
0000912c: 0000ad6e
00009138: 00000000 _pu
00009150: 00000000 _pu
00009160: 00000000 _pu
00009188: 0000ad6e
00009190: 0000ad6e
00009198: 0000ad6e
000091a6: 00000000 a~ldiv
000091b2: 0000ad6e
000091c0: 0000ad6e
000091cc: 0000ad6e
000091d2: 0000ad6e
000091e0: 0000ad6e
000091e6: 0000ad6e
000091ec: 0000ad6e
000091f4: 0000ad6e
000091fa: 00000000
00009214: 00000000 _spl7
00009224: 00000000 a~lmul
0000922c: 0000ad6e
00009264: 0000ad6e
0000926a: 00000000 _panic
000092ae: 00000000 _spl
000092d8: 0000ad6e
000092e2: 00000000 _spl7
000092ee: 0000ad6e
000092f6: 0000ad6e
000092fc: 0000ad6e
00009304: 0000ad6e
0000930c: 00000000 _spl
0000931c: 0000ad6e
00009322: 0000ad6e
00009328: 0000ad6e
00009356: 00000000
00009364: 0000ad6e
00009370: 0000ad6e
0000937a: 0000ad6e
00009382: 0000ad6e
00009398: 00000000 _pu
000093c4: 00000000 _outbuf
000093ec: 00000000 _pu
000093f2: 0000ad6e
00009400: 00000000
0000941e: 00000000 _csw
00009436: 00000000 _pu
00009462: 00000000 _pu
00009482: 00000000 _pu
000094a6: 0000ad6e
000094bc: 00000000 _pu
000094e4: 00000000 _pu
00009524: 0000ad6e
0000959a: 00000000
000095b8: 00000000
000095e6: 00000000 _pu
00009606: 00000000
00009652: 00000000
00009664: 00000000 _pu
00009676: 0000ad6e
0000967c: 00000000
0000968e: 00000000 _pu
000096c2: 00000000 _pu
000096d4: 00000000
000096ee: 00000000 _pu
00009708: 00000000
00009734: 00000000 _pu
000097e4: 00000000 _pu
00009828: 00000000 _setjmp
000098a2: 00000000
000098b0: 0000ad6e
000098c6: 00000000 _pu
000098e0: 00000000
0000991a: 00000000 _pu
00009928: 00000000 _outbuf
00009936: 00000000 _pu
00009954: 00000000 _sysname
0000995a: 00000000 _outbuf
0000996c: 00000000
00009980: 00000000 _pu
000099c0: 00000000
000099de: 00000000
000099e8: 0000ad6e
00009a2e: 00000000
00009a3e: 00000000 _pu
00009a4e: 00000000
00009a66: 00000000
00009a7e: 00000000 _pu
00009a96: 00000000
00009aa8: 0000ad6e
00009aae: 00000000 a~jtab
00009ac8: 00000000
00009ade: 00000000
00009b72: 00000000
00009b96: 00000000
00009ba0: 00000000
00009bbc: 00000000
00009be2: 00000000
00009bfe: 00000000 _pu
00009c06: 00000000
00009c58: 00000000
00009c6c: 0000ad6e
00009c76: 0000ad6e
00009c7c: 0000ad6e
00009c96: 00000000
00009c9e: 00000000
00009cac: 00000000
00009cbc: 00000000
00009cc4: 0000ad6e
00009cda: 00000000 _pipedev
00009ce2: 00000000
00009cf0: 00000000
00009cfe: 00000000 _pipedev
00009d06: 00000000
00009d18: 00000000
00009d26: 00000000
00009d36: 00000000
00009d46: 00000000
00009d54: 00000000
00009d60: 00000000 _pu
00009db2: 00000000
00009dd0: 00000000
00009de4: 00000000 _pu
00009dfc: 00000000
00009e1a: 00000000
00009e2a: 00000000 _pu
00009e36: 00000000 _pu
00009e64: 00000000
00009e7a: 00000000
00009e8a: 00000000 _syslock
00009e96: 00000000 _syslock
00009eaa: 00000000 _pu
00009eb4: 0000ad6e
00009eba: 0000ad6e
00009ec0: 0000ad6e
00009ec6: 00000000
00009ee0: 00000000 _chkbuf
00009ef6: 00000000 _inbyte
00009f0c: 00000000 _nsyslock
00009f14: 00000000 _syslock
00009f38: 0000ad6e
00009f3e: 00000000 a~jtab
00009f44: 00000000
00009f50: 0000ad6e
00009f76: 0000ad6e
00009f7e: 0000ad6e
00009f8a: 0000ad6e
00009f90: 00000000
00009f9a: 0000ad6e
00009fa0: 0000ad6e
00009faa: 0000ad6e
00009fb0: 00000000
00009fc4: 00000000 _inbyte
00009ff6: 00000000 _outbyte
0000a000: 00000000
0000a012: 0000ad6e
0000a018: 0000ad6e
0000a01e: 00000000
0000a038: 00000000 _outbyte
0000a05a: 00000000 _pu
0000a084: 00000000
0000a092: 00000000
0000a0c8: 00000000
0000a0de: 00000000
0000a100: 00000000 _pu
0000a10c: 00000000
0000a124: 00000000 _pu
0000a12e: 00000000
0000a18c: 00000000
0000a1b4: 00000000
0000a1d0: 00000000 _pu
0000a1da: 00000000
0000a228: 00000000
0000a23c: 00000000
0000a248: 00000000 _pu
0000a254: 00000000
0000a276: 00000000
0000a294: 00000000 _pu
0000a29e: 00000000
0000a2ae: 00000000
0000a2bc: 00000000
0000a2cc: 00000000
0000a2fe: 00000000
0000a30c: 00000000
0000a318: 00000000
0000a348: 00000000
0000a352: 00000000
0000a35c: 00000000
0000a388: 00000000
0000a394: 00000000
0000a3ac: 00000000
0000a3c2: 00000000
0000a3de: 00000000 _pu
0000a402: 00000000
0000a412: 00000000
0000a432: 00000000
0000a466: 00000000
0000a47c: 00000000
0000a48a: 00000000
0000a49e: 00000000
0000a4c0: 00000000
0000a4e4: 00000000
0000a4f2: 0000ad6e
0000a4fc: 00000000
0000a50a: 00000000 _pu
0000a51a: 00000000
0000a52a: 00000000 _pu
0000a536: 00000000 _pu
0000a54c: 0000ad6e
0000a55a: 00000000
0000a582: 00000000
0000a5a4: 00000000
0000a5b8: 00000000
0000a5d0: 00000000 _pu
0000a5e0: 00000000
0000a606: 00000000
0000a62a: 00000000
0000a646: 00000000
0000a658: 00000000
0000a662: 00000000
0000a670: 00000000
0000a684: 00000000
0000a692: 00000000
0000a6b0: 00000000
0000a6bc: 00000000
0000a6c8: 00000000 _pu
0000a6d6: 0000ad6e
0000a6ea: 00000000 _pu
0000a716: 00000000
0000a72a: 00000000
0000a73c: 00000000
0000a744: 0000ad6e
0000a750: 00000000
0000a764: 00000000
0000a77c: 00000000 _pu
0000a7a2: 00000000 _hi_chk
0000a7aa: 00000000 _stkchk
0000a7e8: 00000000 _clrmem
0000a7fa: 00000000 _pu
0000a83e: 00000000
0000a86c: 00000000
0000a87e: 00000000
0000a892: 00000000
0000a89c: 00000000 _mmupres
0000a8b6: 00000000 _xmemshft
0000a8ce: 00000000 _p1end
0000a8d4: 00000000 _p1boot
0000a8e2: 00000000 _p1size
0000a8e8: 00000000 _mapsize
0000a8ee: 00000000 _xmemshft
0000a8fe: 00000000 _p1size
0000a904: 00000000 _mapsize
0000a90a: 00000000 _usize
0000a914: 00000000
0000a938: 00000000 _usize
0000a940: 00000000 _uinit
0000a94a: 00000000 _p1end
0000a950: 00000000 _p1boot
0000a95c: 00000000 _p1boot
0000a962: 00000000 _outbuf
0000a9b6: 00000000
0000a9c4: 00000000
0000a9d4: 00000000
0000a9e2: 00000000
0000a9ea: 0000ad6e
0000aa1a: 00000000
0000aa24: 00000000 _mapclr
0000aa2e: 00000000
0000aa3e: 00000000
0000aa4a: 00000000
0000aa52: 00000000 _proc0
0000aa5a: 00000000 _curbase
0000aa86: 00000000
0000aaf0: 00000000
0000ab0c: 00000000
0000ab1c: 0000ad6e
0000ab22: 00000000
0000ab28: 00000000
0000ab3e: 00000000 _pu
0000ab4c: 00000000
0000ab62: 00000000
0000ab78: 00000000 _usize
0000ab7e: 0000ad6e
0000ab8c: 00000000 _memalloc
0000ab9c: 00000000
0000abae: 00000000
0000abc0: 0000ad6e
0000abc6: 00000000
0000abfa: 00000000 _setjmp
0000ac12: 00000000 _proc0
0000ac18: 00000000
0000ac1e: 00000000 _uout
0000ac3c: 00000000 _memcopy
0000ac4a: 00000000
0000ac7c: 00000000
0000ac82: 00000000 _uout
0000ac8a: 00000000
0000ac90: 00000000
0000ac9c: 0000ad6e
0000aca2: 00000000
0000aca8: 00000000 _proc0
0000acae: 00000000
0000acb6: 00000000
0000acc8: 00000000
0000acf6: 00000000 _setjmp
0000ad04: 00000000 _proc0
0000ad0a: 00000000
0000ad10: 00000000 _uout
0000ad2e: 00000000 _memcopy
0000ad3c: 00000000
0000ad44: 00000000
0000ae0c: 00000000
0000ae14: 00000000
0000ae1c: 00000000
0000ae28: 00000000
0000ae30: 00000000
0000ae38: 00000000
0000ae3c: 0000ad6e
0000ae40: 0000ad6e
0000ae8a: 00000000
0000af32: 00000000
0000af3a: 00000000
0000af42: 00000000
0000af4a: 00000000
0000af52: 00000000
0000af5e: 00000000
0000af66: 00000000
0000af6e: 00000000
0000af76: 00000000
0000af7e: 00000000
0000af86: 00000000
0000af8e: 00000000
0000af96: 00000000
0000af9e: 00000000
0000afaa: 00000000
0000afb2: 00000000
0000afba: 00000000
0000afc6: 00000000
0000afca: 00000000
0000afce: 00000000
0000afd2: 00000000
0000afd6: 00000000
0000afda: 00000000
0000afe6: 00000000
0000b012: 00000000
0000b016: 00000000
0000b01a: 00000000
0000b01e: 00000000
0000b022: 00000000
0000b026: 00000000
0000b02a: 00000000
0000b02e: 00000000
0000b032: 00000000
0000b036: 00000000
0000b03a: 00000000
0000b03e: 00000000
0000b042: 00000000
0000b046: 00000000
0000b04a: 00000000
0000b04e: 00000000
0000b052: 00000000
0000b05e: 00000000
0000b0b2: 00000000
0000b0ba: 00000000
0000b0c2: 00000000
0000b0ca: 00000000
0000b0d2: 00000000
0000b0f4: 00000000
0000b0f8: 00000000
0000b0fc: 00000000
0000b104: 0000ad6e
0000b10a: 00000000
0000b10e: 00000000
0000b112: 00000000
0000b116: 00000000
0000b11a: 00000000
0000b11e: 0000ad6e
0000b124: 0000ad6e
0000b128: 0000ad6e
0000b12c: 0000ad6e
0000b130: 0000ad6e
0000b254: 00000000
0000b25c: 00000000
0000b264: 00000000
0000b26c: 00000000
0000b2ba: 00000000
0000b2be: 00000000
0000b2c2: 00000000
0000b2c6: 00000000
0000b2ca: 00000000
0000b2ce: 0000ad6e
0000b2da: 00000000
0000b2de: 00000000
0000b2e2: 00000000
0000b2e6: 00000000
0000b2ea: 00000000
0000b2ee: 00000000
0000b2f2: 00000000
0000b2f6: 00000000
0000b2fa: 00000000
0000b2fe: 00000000
0000b302: 00000000
0000b306: 00000000
0000b312: 00000000
0000b31e: 00000000
0000b326: 00000000
0000b32e: 00000000
0000b336: 00000000
0000b33e: 00000000
0000b38c: 00000000
0000b394: 00000000
0000b39c: 00000000
0000b3a4: 00000000
0000b3ac: 00000000
0000b3b4: 00000000
0000b3bc: 00000000
0000b44c: 00000000
0000b450: 00000000
0000b454: 00000000
0000b458: 00000000
0000b45c: 00000000
0000b460: 00000000
0000b464: 00000000
0000b468: 00000000
0000b46c: 00000000
0000b478: 00000000
0000b510: 0000ad6e
0000b520: 0000ad6e
0000b57a: 00000000
0000b58a: 00000000
0000b694: 00000000
0000b698: 00000000
0000b69c: 00000000
0000b6a0: 00000000
0000b6a4: 00000000
0000b6b0: 00000000
0000b6e8: 00000000
0000b6fe: 00000000
0000b702: 00000000
0000b706: 00000000
0000b70a: 00000000
0000b70e: 00000000
0000b71a: 00000000
